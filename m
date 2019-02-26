Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C047420248
	for <e@80x24.org>; Tue, 26 Feb 2019 05:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfBZFS1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 00:18:27 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39990 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfBZFSV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 00:18:21 -0500
Received: by mail-qk1-f194.google.com with SMTP id h28so6868563qkk.7
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 21:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2VBCbEalpvej4pRqRGSoL0+qKiWUvVnXBsb1ZAEVVMg=;
        b=ILfArA5ejuIOfGJQHw7jaLLQSBAdtR32EcKDra299fV3DIlqwkhPNE/7FMxRvtSioe
         vJLSTDgKx8Wa7YkWf1mStBYrwH61W1bG/nCSmDCRO+OriFPhw4u9+1cvy94k08XZZSTW
         H7aVVOn6IrSukzPcE4haN0+fQXNZjkVi8IKmyyvcfVgLXsgvESQHnC4ezyHRIsceNww7
         wlpQP2y//5GjnTPynuH0A/R9uDqBdthDZHOxkdMXE5fIO6aja+O5CmNLeGptahePwPNO
         KpdobxiO23Edr3MKBvUtISE/A407W+khXN9TCRC7hjVg8M3ORgjkJ8bXRfZvfGpxrEC2
         5nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VBCbEalpvej4pRqRGSoL0+qKiWUvVnXBsb1ZAEVVMg=;
        b=Lqni6ZT4Afg4zS02J7dfLgcRWtQpYUxuCQgROmrx5fuoBzOAvwNreWbeFQq3LXkLMn
         blaJwBlrqQIpQNImoBbGf3UzjYx4sNm0cWa5BTPB/bmbm3OwTQYfoHkfaAg5lu1aqTBC
         ToaTHqxAKVsTX4oipxNez5zqMQNNvc8pXOjOMc2Rfds4sfibd5eGFDhDmGVcApn8Hd20
         1XfacyiwtQEe+OdesO1MUg5vAleBSSIu+KdHEGrN0+khOvbFHC2L89OTMJ6qX2LcFdZD
         pFibBM4ZfCGaLeA/9AIe0YSPrURnPc3UZ3t7XkhjdH2yTJmiBXdMCQ4gU3OCVq+QqnMl
         l6Ow==
X-Gm-Message-State: AHQUAubF4Y24YHQfNStZVNlj/0A5/gji+Kvd+0RcM0LuR791ICSJb+93
        MBNM3ypGqlYgbnOhPDm2V6cdQ92cMUs=
X-Google-Smtp-Source: AHgI3Ibb8b7s8CcW80pAx2tGmX5Cfa6QVR4D03JFhUVjmUXVGuodjukB26N9IZ/wslzUySchY00aPA==
X-Received: by 2002:a37:de04:: with SMTP id h4mr15628073qkj.277.1551158299705;
        Mon, 25 Feb 2019 21:18:19 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id k39sm7698738qtb.37.2019.02.25.21.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 21:18:19 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alex Riesen <raa.lkml@gmail.com>
Subject: [WIP RFC PATCH v2 2/5] clone: test for our behavior on odd objects/* content
Date:   Tue, 26 Feb 2019 02:18:01 -0300
Message-Id: <20190226051804.10631-3-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226051804.10631-1-matheus.bernardino@usp.br>
References: <20190226051804.10631-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

We've implicitly supported .git/objects/* content of symlinks since
approximately forever, and when we do a copy of the repo we transfer
those over, but aren't very consistent about other random stuff we
find depending on if it's a "hidden" file or not.

Let's add a test for that, which shouldn't read as an endorsement of
what we're doing now, just asserts current behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5604-clone-reference.sh | 60 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 4320082b1b..6f9c77049e 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -221,4 +221,64 @@ test_expect_success 'clone, dissociate from alternates' '
 	( cd C && git fsck )
 '
 
+test_expect_success SHA1,SYMLINKS 'setup repo with manually symlinked objects/*' '
+	git init S &&
+	(
+		cd S &&
+		test_commit A &&
+		git gc &&
+		test_commit B &&
+		(
+			cd .git/objects &&
+			mv 22/3b7836fb19fdf64ba2d3cd6173c6a283141f78 . &&
+			ln -s ../3b7836fb19fdf64ba2d3cd6173c6a283141f78 22/ &&
+			mv 40 forty &&
+			ln -s forty 40 &&
+			mv pack packs &&
+			ln -s packs pack &&
+			>.some-hidden-file &&
+			>some-file &&
+			mkdir .some-hidden-dir &&
+			>.some-hidden-dir/some-file &&
+			>.some-hidden-dir/.some-dot-file &&
+			mkdir some-dir &&
+			>some-dir/some-file &&
+			>some-dir/.some-dot-file
+		)
+	)
+'
+
+test_expect_success SHA1,SYMLINKS 'clone repo with manually symlinked objects/*' '
+	for option in --local --no-hardlinks --shared --dissociate
+	do
+		git clone $option S S$option || return 1 &&
+		git -C S$option fsck || return 1
+	done &&
+	find S-* -type l | sort >actual &&
+	cat >expected <<-EOF &&
+	S--dissociate/.git/objects/22/3b7836fb19fdf64ba2d3cd6173c6a283141f78
+	S--local/.git/objects/22/3b7836fb19fdf64ba2d3cd6173c6a283141f78
+	EOF
+	test_cmp expected actual &&
+	find S-* -name "*some*" | sort >actual &&
+	cat >expected <<-EOF &&
+	S--dissociate/.git/objects/.some-hidden-file
+	S--dissociate/.git/objects/some-dir
+	S--dissociate/.git/objects/some-dir/.some-dot-file
+	S--dissociate/.git/objects/some-dir/some-file
+	S--dissociate/.git/objects/some-file
+	S--local/.git/objects/.some-hidden-file
+	S--local/.git/objects/some-dir
+	S--local/.git/objects/some-dir/.some-dot-file
+	S--local/.git/objects/some-dir/some-file
+	S--local/.git/objects/some-file
+	S--no-hardlinks/.git/objects/.some-hidden-file
+	S--no-hardlinks/.git/objects/some-dir
+	S--no-hardlinks/.git/objects/some-dir/.some-dot-file
+	S--no-hardlinks/.git/objects/some-dir/some-file
+	S--no-hardlinks/.git/objects/some-file
+	EOF
+	test_cmp expected actual
+'
+
 test_done
-- 
2.20.1

