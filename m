Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B52E1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 19:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbfHVTWq (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 15:22:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55911 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387485AbfHVTWp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 15:22:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id f72so6706673wmf.5
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 12:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=12aGqy9JIT+wnen5/FZ/VPBJxbDXtBs1IU+DXfZM8xI=;
        b=XZrVY5qBBHHrmgk1zTxn/yBPhdimcUocSWB7JiUwHWnl1vRs5xnWreTXgHef8DIaN5
         hau1NTvZlWcj291+CZ3a1w8pTzzjyDCeOz42CKr4tAIp0b2k6h1ktQrvgdKi9H5qFsnh
         qRaxp857NJajEHw2CXuAGwBZOWYGz1ZHJb/bfYKcK75IaxAGin8sGsr/gtIDkEePCZUb
         ucU/5AzyBmHMpSDuPXcTSj4mFBrflzi43mrZH8bOE41VK/xWiHClyLDAS+Rb0j/02Kkb
         nAtRTlV166VyF5+VloHLa/TPVdJqrzBGhzZor4QWBTOJL/++vUwUnxTxMAcxrYeLrH9r
         FqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=12aGqy9JIT+wnen5/FZ/VPBJxbDXtBs1IU+DXfZM8xI=;
        b=hEQKL22MHPr86sv3BJX4vzW74T9F1oIvOB/GiblZQ/zIFQmg5ubjebxTjpRR7sulte
         AkTpQ2H0R+L/SUhvJtCoa7jx8JPXGEPKvq4QfPMDBJJKEBjg+8+4p2/zAdHp/HGnQQx1
         grB52TY8A+Q/mwRUGNFYqU/X75Wf4vogsvrT0yTyWcqHYefi6/ooQDG3K4zDhtgiepDO
         h5dK2YHZwnqE2bSt0w828ataNL0UNip4hp9j0jklAm/6/FYBLdKDnWUisPNwJ9UawGNT
         4fC0jCgbD2YnQOJFbwhqYdecrEN5zdCEYOy9Dx0kSmBcSEvWnX+iNx/QIKgELjTVSEm0
         RGCw==
X-Gm-Message-State: APjAAAULq3twe2fqEWJ4LTqWificWHKUu/WwWaN1uRAn5S5vVCQDu1Ff
        VYBgD0RhHc2FB1rZtQ2mj7h+ag77
X-Google-Smtp-Source: APXvYqw2sKHbyjZ2ONh5+ziDl45k11GpbteIhUgXoCe1U0PM/RUfi7jWUmB6Fpw3E+GK1enIEH4jmA==
X-Received: by 2002:a1c:c5c4:: with SMTP id v187mr760693wmf.30.1566501763188;
        Thu, 22 Aug 2019 12:22:43 -0700 (PDT)
Received: from localhost ([2.31.128.175])
        by smtp.gmail.com with ESMTPSA id i5sm1029720wrn.48.2019.08.22.12.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Aug 2019 12:22:42 -0700 (PDT)
Date:   Thu, 22 Aug 2019 20:22:40 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, johannes.schindelin@gmx.de,
        larsxschneider@gmail.com, szeder.dev@gmail.com,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] t0021: make sure clean filter runs
Message-ID: <20190822192240.GA4077@cat>
References: <20190820065625.128130-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820065625.128130-1-t.gummerer@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t0021.15 one of the things we are checking is that the clean filter
is run when checking out empty-branch.  The clean filter needs to be
run to make sure there are no modifications on the file system for the
test.r file, and thus it isn't dangerous to overwrite it.

However in the current test setup it is not always necessary to run
the clean filter, and thus the test sometimes fails, as debug.log
isn't written.

This happens when test.r has an older mtime than the index itself.
That mtime is also recorded as stat data for test.r in the index, and
based on the heuristic we're using for index entries, git correctly
assumes this file is up-to-date.

Usually this test succeeds because the mtime of test.r is the same as
the mtime of the index.  In this case test.r is racily clean, so git
actually checks the contents, for which the clean filter is run.

Fix the test by updating the mtime of test.r, so git is forced to
check the contents of the file, and the clean filter is run as the
test expects.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

v2 adds the comment as suggested by Szeder.

Junio: I saw this is marked as "merged to 'next'" in the What's
cooking, so if it got merged already I'm fine with just keeping v1,
but otherwise I think adding the comment would be nice.

 t/t0021-conversion.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index e10f5f787f..c954c709ad 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -390,6 +390,9 @@ test_expect_success PERL 'required process filter should filter data' '
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
 
+		# Make sure that the file appears dirty, so checkout below has to
+		# run the configured filter.
+		touch test.r &&
 		filter_git checkout --quiet --no-progress empty-branch &&
 		cat >expected.log <<-EOF &&
 			START
-- 
2.23.0.rc2.194.ge5444969c9

