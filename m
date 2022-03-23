Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA25C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 21:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbiCWVrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 17:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbiCWVrM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 17:47:12 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0858D69B
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 14:45:40 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e18so1974853ilr.2
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 14:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VBzO9Y2yhIsu6tz10K/YsMmlJk5bLLQ+i/Uv/XCF9xg=;
        b=F1JDoNyFNM/Tj9VrGKjnm8N15KXaxgsmoLiq4z4MnYCXF/cO6u1EaKGRNTwPIKmNoT
         P/SEz13H0+Xc1vDSVZKgJUOGmBitd+GvFwY96QUd7zjCj7VWmqy/Y0jk8jZdkCCzI2Kb
         6XsPRkk4lS9fu5JZ2nmaIwD2G6IVG6TW3YrSY9pB9yDWsI5b7XcpUq1xP7TX0PDhA+bQ
         FO3h7lf59iEKlfXJs2Dg47CCVU2tzyhI+vsm/mIa8fBMfmuTSNmMuLRZqlb4GMeaU1xv
         oxNXspbQQaq8St2VljS3ECkPo8VC13l9kZxvzgnyPgvaDViDeIQODOaDXgD49gN9Lvtn
         2qMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VBzO9Y2yhIsu6tz10K/YsMmlJk5bLLQ+i/Uv/XCF9xg=;
        b=QoylEtAILt07/U3qVJ5UCxVixJijJOKHAL7CCa7DwWm/Lm4sAqyPuhiNXwWTFA594L
         W1JJotTm+ikY2ZMb/BFd1KVs8Ny1ZNqb2q7xG8UziHKwbgl5wd8dm/AkvApm0fsK7Z7H
         IRHMG4M9d8Rwn17gCkWUQlfMSFYx80NQCvmCtRF+JjDoupyFKjHRcRuygGhhJEbrdEWk
         uadLIajhHvUmglbAGQwbaXJrLgqM6lIeO/5EIaZyEzJH35llQpYyGKlqZAg0gi+Uh3/Y
         DQOqWibctZ92VkIa6YMM+sRzglec8zAX8y9s9DaLEOSSHrm+diVcwxeflGzr2mFVYILu
         xupg==
X-Gm-Message-State: AOAM530x8eMlr+sQE0l/Sz3tk1msGvY7jU96xHSKyVGfhFFPg03rs9VO
        S6XTXpeUHyYtFtTaULJ2F8nxNQ==
X-Google-Smtp-Source: ABdhPJwfcTVaIbsS/XmEIsE6Nbpup+Dof3Fyvilvdzz26N7Dq/sSsG+bT1vZAKLe/QEBAzcmt5+h5g==
X-Received: by 2002:a05:6e02:154f:b0:2c7:d5da:f12f with SMTP id j15-20020a056e02154f00b002c7d5daf12fmr1076563ilu.66.1648071939682;
        Wed, 23 Mar 2022 14:45:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g2-20020a056e021e0200b002c82a3f69cesm803808ila.8.2022.03.23.14.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 14:45:39 -0700 (PDT)
Date:   Wed, 23 Mar 2022 17:45:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, chakrabortyabhradeep79@gmail.com
Subject: Re: [PATCH] test-lib-functions: fix test_subcommand_inexact
Message-ID: <YjuVAgjaiqrcT7P1@nand.local>
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
 <540936ba-7287-77fa-9cee-e257ed3c119d@github.com>
 <xmqqmthgu3e6.fsf@gitster.g>
 <e5331972-512a-c498-6a1b-927f21ef9de2@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e5331972-512a-c498-6a1b-927f21ef9de2@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 23, 2022 at 10:55:37AM -0400, Derrick Stolee wrote:
> > So, perhaps #3 ;-)?
>
> I'll default to #3 (do nothing), but if this shows up again
> I'll plan on adding a comment to the helper to be clear on
> how "inexact" the helper really is.

I wonder if we could sidestep the whole issue with
test_subcommand_inexact by testing this behavior by looking at the
contents of the packs themselves.

If we have a kept pack, and then add some new objects, and run "git
repack --write-midx -adb", the new pack should not contain any of the
objects found in the old (kept) pack. And that's the case after this
patch, but was broken before it.

Here's a test which constructs that scenario and then asserts that there
isn't any overlap between the newly created pack and the old, kept pack.

--- 8< ---

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 5922fb5bdd..96812fa226 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -370,9 +370,31 @@ test_expect_success '--write-midx with preferred bitmap tips' '
 '

 test_expect_success '--write-midx -b packs non-kept objects' '
-	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
-		git repack --write-midx -a -b &&
-	test_subcommand_inexact git pack-objects --honor-pack-keep <trace.txt
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+		git repack -ad &&
+
+		find $objdir/pack -name "*.idx" >before &&
+		>$objdir/pack/$(basename $(cat before) .idx).keep &&
+
+		test_commit other &&
+		git repack --write-midx -a -b -d &&
+
+		find $objdir/pack -name "*.idx" | sort >after &&
+
+		git show-index <$(cat before) >old.raw &&
+		git show-index <$(comm -13 before after) >new.raw &&
+
+		cut -d" " -f2 old.raw | sort >old.objects &&
+		cut -d" " -f2 new.raw | sort >new.objects &&
+
+		comm -12 old.objects new.objects >shared.objects &&
+		test_must_be_empty shared.objects
+	)
 '

 test_expect_success TTY '--quiet disables progress' '

--- >8 ---

It does seem a little word-y to me, but I think you could clean it up a
little bit, too. If you want to take that patch, I think we could
reasonably use the above diff as a first patch, and then remove the
declaration of test_subcommand_inexact in a second patch.

(Feel free to forge my s-o-b if you do want to pick that up).

Thanks,
Taylor
