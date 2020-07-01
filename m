Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5568C433E1
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 04:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2ED206CB
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 04:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZYV//uS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgGAE1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGAE13 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 00:27:29 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECD9C03E97A
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 21:27:29 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t11so8355550qvk.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 21:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sgo7WNu2r3te8+uwmFrMuip8L4ZIsuLTKZ/ygE5LUj0=;
        b=vZYV//uSdYrQn9140lhczlCu36WnqdnvC183t1yON/DYrpAnfWx7zDIZNzFqHUbBd4
         /BtGJOP6+Zrf/01hmAVn4kcUooZwFGc2CF+ms8T82kJDSquQ+k8hLP9zGkQwygbhwOrg
         Abp16u/visSKBzhHVj/4AmRqs8gCMx7qOFu8zurH/Wenpt18k9cSPNJwrn8DcgAee4Jp
         CGV5pMZinB3qg9oIoQ4Y7D7BMUChvUWQkhID0Gz4kmFRxN4aN6P6V9X1DzcK3nwYXRla
         gqkqhH+CcpAQiPu2OTqN1cHRagmModtByDOH91q9ZbzXYENl0qeHlP1tpxTIR1IGnsy4
         sJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgo7WNu2r3te8+uwmFrMuip8L4ZIsuLTKZ/ygE5LUj0=;
        b=OD48/wbW8yy0KTnqXZl+Ruo11+grYNUK0tsQgiCXPSk1wrVGMxGBRaZOQk4o3kMjuM
         l9TVwva3TfZ6dgXR1nv431nX/QVFFC2onQbhx/tY9XrNFvYF2ym9Aj17DZhHsP3CxCZU
         HTy4UVcrB0GeYIdAVeVxEPdpnMLrucCRnaVbhS4nfcrwGvZ25m1WpqFBVt93e+rMWk4B
         l3CbGqA3QoSISNJUgZ1JMkypZVtmReTX2sSJoBRuRedYPNeW4f8TCZJSSCoPsP5VZ2Dx
         K8ne3uC51JNqcwJOsgweFXMmcavWbINBIcjoYEkfLUgB4H34ra3gUABj5wI+EPjfggMH
         k6bg==
X-Gm-Message-State: AOAM530tUAzhRpqe9XuYNpAId2MN9JzoMOJyWhIP6mBlTCwdkrxHooCV
        f/9GWauYEC9dV0BPaTi4iWoa2uDUeiQ=
X-Google-Smtp-Source: ABdhPJyJdkz/V3XH+Kdg3S6zgcFLKdPhoowOKIL4xCngRojN7oC4Rd2cXTcBTkyO0VonlIC0IQSPGg==
X-Received: by 2002:a0c:9e4f:: with SMTP id z15mr22304226qve.119.1593577648186;
        Tue, 30 Jun 2020 21:27:28 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id x13sm4418813qts.57.2020.06.30.21.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 21:27:27 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/5] t5324: reorder `run_with_limited_open_files test_might_fail`
Date:   Wed,  1 Jul 2020 00:27:10 -0400
Message-Id: <9ba997f7c126ed0838ca7a72f33d87f40e173fd8.1593576602.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
In-Reply-To: <cover.1593576601.git.liu.denton@gmail.com>
References: <cover.1593529394.git.liu.denton@gmail.com> <cover.1593576601.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we plan on only allowing `test_might_fail` to work on a
restricted subset of commands, including `git`. Reorder the commands so
that `run_with_limited_open_files` comes before `test_might_fail`. This
way, `test_might_fail` operates on a git command.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5324-split-commit-graph.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 269d0964a3..9b850ea907 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -399,7 +399,7 @@ test_expect_success ULIMIT_FILE_DESCRIPTORS 'handles file descriptor exhaustion'
 		for i in $(test_seq 64)
 		do
 			test_commit $i &&
-			test_might_fail run_with_limited_open_files git commit-graph write \
+			run_with_limited_open_files test_might_fail git commit-graph write \
 				--split=no-merge --reachable || return 1
 		done
 	)
-- 
2.27.0.383.g050319c2ae

