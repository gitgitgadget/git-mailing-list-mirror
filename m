Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A78B1F5A2
	for <e@80x24.org>; Fri, 15 Nov 2019 01:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfKOBAq (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:00:46 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45911 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKOBAq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:00:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id w7so3474854plz.12
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=va5s/jFKOWqwfeoMlltpCInP6DHwg4Xyhf0/vxkC7Bo=;
        b=duawqXSHSCPm06ux5AmK4wBcKGEqS7GiurzGvWYevarzXR/mfmoSR6cBXiyE3k2NV9
         ahXiCDYfW39Nbbl+/e3BaOVpuAULw8V20MfzaaQMORgzQmVRhInqBAAOkC2riTaE07SU
         sN7eC9ovGp949LSaB8JaHcV/ex8P5G2s7/CwWagdGfmnntuUJ+FmuHITjnfMjR4/ZTfw
         RZyZ3oK2osHlJzpqJ8sAJp0WkPC0e5ahgPf9o/6KOmvEyCsxUR9jJ8xnbBZTKAwQjFMI
         JKSGP6+mPRJL1/BvMT3Ncx1fmLO3bWdCFfRzGR8KH5p78P4urPyNstcQDNbMiEOx0r3O
         HaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=va5s/jFKOWqwfeoMlltpCInP6DHwg4Xyhf0/vxkC7Bo=;
        b=S51D8ajSscHLI9dQEg32m80PLu9vmWLP6ZQ4F7il8uLoU8/nSqxSyEH1RxkvzlLfQ4
         iOutIl5ogHIhrD7IMyGCEfYWuqVH5QxaDMSGf562grtJw+XLyzhEXbvTEVzyXuPCYjmU
         4l6Hv92NJFIsloGTzkPcVJE/RqtxwCRs0sxhPrp8jB1Q1JXfy51VTiH5tGvCYaKp98IB
         m/tNDib3kaN1UlOG3Gr9mmm0d+NEbvUZxDBP04zwUsLQAhJ02ANsQA3GbUboeFSA8Bkp
         e+Q4T/RuBgw0kkzCGX4uexDEwxSp6kSKIM1KAvTRnIs+HyBr+CIyNBdH086BVD2/EukJ
         6OEA==
X-Gm-Message-State: APjAAAV/avhWN4YiWoXhBGHgtcZa1H2UfB7254L2VMompycpvglKV+iX
        Po26nC20lRF+3au3aBuYRxYWdO3m
X-Google-Smtp-Source: APXvYqxh42ovs83Lt5K0cxFBre7OPopvcpfUSGwkiUlc9Q4+k0sDsage/GBNQYa4WkloN8P+Qk23HQ==
X-Received: by 2002:a17:902:778b:: with SMTP id o11mr12236226pll.66.1573779645038;
        Thu, 14 Nov 2019 17:00:45 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id x29sm8515415pfj.131.2019.11.14.17.00.44
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:00:44 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:00:43 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 05/27] t3600: use test_line_count() where possible
Message-ID: <1767492b81a9dae3e4227f9a1952a081619ff7d3.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we have a helper function that can test the number of lines in a
file that gives better debugging information on failure, use
test_line_count() to test the number of lines.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3600-rm.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 8c8cca5bfb..f6e659b7e9 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -113,9 +113,10 @@ test_expect_success '"rm" command printed' '
 	echo frotz >test-file &&
 	git add test-file &&
 	git commit -m "add file for rm test" &&
-	git rm test-file >rm-output &&
-	test $(grep "^rm " rm-output | wc -l) = 1 &&
-	rm -f test-file rm-output &&
+	git rm test-file >rm-output.raw &&
+	grep "^rm " rm-output.raw >rm-output &&
+	test_line_count = 1 rm-output &&
+	rm -f test-file rm-output.raw rm-output &&
 	git commit -m "remove file from rm test"
 '
 
-- 
2.24.0.399.gf8350c9437

