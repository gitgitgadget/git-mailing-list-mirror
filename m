Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B429202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 18:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753603AbdJSSLS (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 14:11:18 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:49338 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753499AbdJSSLP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 14:11:15 -0400
Received: by mail-it0-f67.google.com with SMTP id y15so11231011ita.4
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VP2mCQdR3Qiw485NpjRcj8kmTp88cM6USkT2gnIZDH8=;
        b=Gk6OJbiO2aTqygiInN7/fw0+hxhwQqaqzdaEix4BLfMUyIA5Y6gJmv+/VjSl9FKCuU
         p6kIhjtvwv2yvX0kLEP2Zp80AbdfquB/XXtthRlnyK6SdJgMbSbDkNTjaR3LmAPZpZR8
         CgzPUWV3G9IgnPFARsGM7leDAtT5ueA7GPVx0tElymuDZRTDxSNmi9lsVtxPzz00WoQU
         8k8eeb/052hM3yTsKdtAhkuHvx3toHMqWNt+m7xQ2AkeNif0hJjr8S1VJfePijvgEEuF
         RPiTL08KYE0ccpBiXpmjUIxx4Xch0QhpFDYrjLI/iVwAXMNc2jPPZwUkKDp35cX+3UNS
         s5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VP2mCQdR3Qiw485NpjRcj8kmTp88cM6USkT2gnIZDH8=;
        b=au/VVFPBNfKcRCfkec7VlzHAeRuNVvYmiT+oTs3tAWCfqxa8TfTOTKl1IQCSggGRmD
         MrVRWrhLuJXc7DPB8ctsUyf0IiZlywUo0RHzDHLBXWtJz7IF1K7pEcXb5y2BflnB/UZ6
         edfrbBZB7Vw42S036eFL2729CZ5qdzzEJcgwFspyzIas7YDL+Ph2IKonn7HPqDVagHmI
         UDMsgrK8DM7N3CeOY/6CVnxGUUIeiuahqe+VqjJIFnGutedLKS4aCesS9nlHRmWo6w6B
         OvP3wr0zISYPooVUIowjfqXRqy1HpYfn0ltP9m1E+5SDH2DY8CNBviBYIz+qdysUQTq3
         AA5Q==
X-Gm-Message-State: AMCzsaVqX9lMqDEhCKZwV/EjekSV4wHI1JTUrFyl68UMFJ1pfsxnawtI
        whdRlwYR5SlvaZOMwjp1WZzmRg==
X-Google-Smtp-Source: ABhQp+QI23aIuXGfp4btUZH5VfFB18ltQY5ietmY82y08w3rAOgmUxoJhau5cKjYHZgJgK2KxMIFTg==
X-Received: by 10.36.62.3 with SMTP id s3mr3369259its.113.1508436674847;
        Thu, 19 Oct 2017 11:11:14 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c825:6c3d:e3fe:7438])
        by smtp.gmail.com with ESMTPSA id r124sm924276ita.13.2017.10.19.11.11.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 19 Oct 2017 11:11:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     Jens.Lehmann@web.de, bmwill@google.com, git@vger.kernel.org,
        hvoigt@hvoigt.net, jrnieder@gmail.com, sbeller@google.com
Subject: [PATCH 1/2] t5526: check for name/path collision in submodule fetch
Date:   Thu, 19 Oct 2017 11:11:08 -0700
Message-Id: <20171019181109.27792-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <xmqqwp3sj7ov.fsf@gitster.mtv.corp.google.com>
References: <xmqqwp3sj7ov.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This is just to test the corner case we're discussing.
Applies on top of origin/hv/fetch-moved-submodules-on-demand.


 t/t5526-fetch-submodules.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index a552ad4ead..c82d519e06 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -571,6 +571,7 @@ test_expect_success 'fetching submodule into a broken repository' '
 '
 
 test_expect_success "fetch new commits when submodule got renamed" '
+	test_when_finished "rm -rf downstream_rename" &&
 	git clone . downstream_rename &&
 	(
 		cd downstream_rename &&
@@ -605,4 +606,45 @@ test_expect_success "fetch new commits when submodule got renamed" '
 	test_cmp expect actual
 '
 
+test_expect_success "warn on submodule name/path clash, but new commits fetched in renamed" '
+	test_when_finished "rm -rf downstream_rename" &&
+	git clone . downstream_rename &&
+	(
+		cd downstream_rename &&
+		git submodule update --init &&
+# NEEDSWORK: we omitted --recursive for the submodule update here since
+# that does not work. See test 7001 for mv "moving nested submodules"
+# for details. Once that is fixed we should add the --recursive option
+# here.
+		git checkout -b rename &&
+		git mv submodule submodule_renamed &&
+		(
+			cd submodule_renamed &&
+			git checkout -b rename_sub &&
+			echo a >a &&
+			git add a &&
+			git commit -ma &&
+			git push origin rename_sub &&
+			git rev-parse HEAD >../../expect
+		) &&
+		git add submodule_renamed &&
+		git commit -m "update renamed submodule" &&
+		# produce collision, note that we use no submodule command
+		git clone ../submodule submodule &&
+		git add submodule &&
+		git commit -m "have new submodule at old path " &&
+		git push origin rename
+	) &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules=on-demand 2>err &&
+		grep "collides with a submodule named" err &&
+		(
+			cd submodule &&
+			git rev-parse origin/rename_sub >../../actual
+		)
+	) &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.14.0.rc0.3.g6c2e499285

