Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72A5420986
	for <e@80x24.org>; Wed, 19 Oct 2016 21:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932610AbcJSVE4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 17:04:56 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36433 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756310AbcJSVEz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 17:04:55 -0400
Received: by mail-lf0-f67.google.com with SMTP id b75so4008429lfg.3
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nmqOXRU9WhGjsCJX/WAt2pUkKgMRWDcduBdmUHC39UU=;
        b=co3/0DddLMQo9u6txxd8W7js8FRsQ3XhpuZ+8j0/2zEcMDVu64FOMKHyHZYXCakSAe
         Vd9Aton/4MSZ/ioQckAZkchMTfgkah+Pi+hVwEQEguxQqc5WPV+RXuGS3Q8l6QMAhjRL
         mXiYkNE6CR7stVmIDwvnw6cPtaXy/dHKZ0QZ5noM50UUV0VowLOd4nvc2KudILB34J8j
         1RfFd7hrpeXOMaH39LSFMFTrq+pnmgHGPgpZQXstBksHxJ2c1R7MCndNqXlyKHHiie1Q
         Zp+6g0OcSfEyCpfVr+vlz30iHxerMx17VZDrRaZspfgTb/I22vIOo383dqa/iGMVUrV0
         1egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nmqOXRU9WhGjsCJX/WAt2pUkKgMRWDcduBdmUHC39UU=;
        b=EyP7/nAhV+snORcSIhZZmVCPEGym40JWISyrR4e07nLHN6poqNis4l6hcF+tfURKfO
         8jGmHSRto6O3tx8C2b5iDkQOMevbTjlrdX7mt/ZnA3r65s+5vChFBSZR7e/FT562zMQR
         VRG6aQLNauUFoxwJGVx+ZaHfi+pMgCuhqvOZ25ss6S06zLvG+B/dFZ2uG7dvtZxN5Tm7
         8e65NuS71BErPS+mU8Dpn+FYfWcOT/UyNap3l4g0VZ++TCzEO6y53HYuvAB/tlLjfaLX
         l79urCHLqo7TTSFB8cWoASiPsNuTKLcSLMBGNyjo1XGryx7+hochChWudzxWT+Vod9lz
         mSwA==
X-Gm-Message-State: AA6/9RmzQ9zwqL6Fp7Zy6S/PzC9g/3K+I9B5fdquCj1tzWwsm+TPmMqAnbm2AA3aHYh5Hw==
X-Received: by 10.194.235.103 with SMTP id ul7mr6173459wjc.201.1476911093462;
        Wed, 19 Oct 2016 14:04:53 -0700 (PDT)
Received: from hurricane ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id h10sm72072307wje.48.2016.10.19.14.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Oct 2016 14:04:53 -0700 (PDT)
Date:   Wed, 19 Oct 2016 23:04:51 +0200
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     git@vger.kernel.org
Cc:     jacob.e.keller@intel.com, stefanbeller@gmail.com, peff@peff.net,
        j6t@kdbg.org, jacob.keller@gmail.com
Subject: [PATCH] rev-list: restore the NUL commit separator in --header mode
Message-ID: <20161019210448.aupphybw5qar6mqe@hurricane>
References: <1476908699.26043.9.camel@kaarsemaker.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1476908699.26043.9.camel@kaarsemaker.net>
User-Agent: Mutt/1.6.2-neo (2016-08-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 660e113 (graph: add support for --line-prefix on all graph-aware
output) changed the way commits were shown. Unfortunately this dropped
the NUL between commits in --header mode. Restore the NUL and add a test
for this feature.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 builtin/rev-list.c       | 4 ++++
 t/t6000-rev-list-misc.sh | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 8479f6e..cfa6a7d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -157,6 +157,10 @@ static void show_commit(struct commit *commit, void *data)
 			if (revs->commit_format == CMIT_FMT_ONELINE)
 				putchar('\n');
 		}
+		if (revs->commit_format == CMIT_FMT_RAW) {
+			putchar(info->hdr_termination);
+		}
+
 		strbuf_release(&buf);
 	} else {
 		if (graph_show_remainder(revs->graph))
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 3e752ce..a2acff3 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -100,4 +100,11 @@ test_expect_success '--bisect and --first-parent can not be combined' '
 	test_must_fail git rev-list --bisect --first-parent HEAD
 '
 
+test_expect_success '--header shows a NUL after each commit' '
+	touch expect &&
+	printf "\0" > expect &&
+	git rev-list --header --max-count=1 HEAD | tail -n1 >actual &&
+	test_cmp_bin expect actual
+'
+
 test_done
-- 
2.10.1-449-gab0f84c


-- 
Dennis Kaarsemaker <dennis@kaarsemaker.net>
http://twitter.com/seveas
