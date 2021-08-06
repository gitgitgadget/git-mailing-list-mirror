Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E3AC432BE
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 01:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A806B60FE7
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 01:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbhHFBpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 21:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhHFBpn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 21:45:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6820BC061798
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 18:45:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b1-20020a17090a8001b029017700de3903so10785286pjn.1
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 18:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=efkQqzyjOE6tHIKJvd1Lw1J1/o/JY6uNX+Sq+dPtG3I=;
        b=MBqDha1s3DYwgX3BHO9prbYSQPpz3W6zp6lKMxoKHks0l/A90jN5icwe2yCkIMC4M4
         QhPrX8qg3QzUdv5YAT1C6kitOyZSH3k9f0t6SEcV/qvOMy9Y3uOE2wDgJ9G0vaAdZLC4
         mrQFIxNGyZ3HVOXMcuQMys+wX0Hz2U9MDx3T6rON2KQVEc/GIjv9Kqe2WBnMGn2oRjnO
         Rw9ONzYwsgLUIH991TlzlYE7Oc930jXNZpQKBLI2r5qQkL0oAwxrBlGL/ZCNQ5s0BWDc
         CtfBls+r8DR9V5ssYgA0DnTTNjZsYHA1figBepy/xG8a3UASIdPfqjNHgLvwlhEvscoZ
         dEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=efkQqzyjOE6tHIKJvd1Lw1J1/o/JY6uNX+Sq+dPtG3I=;
        b=Pgog6TlWtU2tpt0bs6pE7chCih7JatqhS7gY2l2hx65qBp+PuEfwoqCid9+kZAd0bW
         Q+zE2aNWCmBsxm69yFn7IIL+P+JMDcSEZTLQq9b5YKlZ3RvZ5mVB5I9+sbjsWpW6d5II
         QaT6QbQVP0iWnkS7oFRegSrY1D+4hjnZyf4yQULWEXTHXDEEzukIcu0jYc2RwxJIDh0u
         SyijXeStkjiva8dwCYpWndngxu+I7kKvxNAxyMxl4AziCbYvLdw/dIwgVyUePGaphgPL
         NNQOQC8XIdQfubpqmRo76E7gmlIRqJblX6kOtYJeA+2zXHeSlbhKpfs+t/+nh6DQ6D5T
         yXKQ==
X-Gm-Message-State: AOAM531KhxhTaf93fR3dYYuo1+SEUCY5/ej7ygdxLGpgPRPHrQey9k8B
        xDbOC6z7hWlVjhyj+l2GPwY=
X-Google-Smtp-Source: ABdhPJwnRKa8GfE3w0/RFJscLtdfEcXCPFSw2rgsL7Brcx9UWcqHLTm/hX287mSL5j6I46DMwEa3+w==
X-Received: by 2002:a17:902:7595:b029:12c:2d46:348d with SMTP id j21-20020a1709027595b029012c2d46348dmr6325137pll.49.1628214326809;
        Thu, 05 Aug 2021 18:45:26 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:6692:d3ab:8eba:ac7c])
        by smtp.gmail.com with ESMTPSA id c2sm9819693pgh.82.2021.08.05.18.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 18:45:26 -0700 (PDT)
Date:   Thu, 5 Aug 2021 18:45:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>,
        Taylor Yu <tlyu@mit.edu>, Joshua Nelson <jyn514@gmail.com>
Subject: [PATCH] Revert 'diff-merges: let "-m" imply "-p"'
Message-ID: <YQyUM2uZdFBX8G0r@google.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210520214703.27323-1-sorganov@gmail.com>
 <20210520214703.27323-11-sorganov@gmail.com>
 <YQtYEftByY8cNMml@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQtYEftByY8cNMml@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit f5bfcc823ba242a46e20fb6f71c9fbf7ebb222fe, which
made "git log -m" imply "--patch" by default.  The logic was that
"-m", which makes diff generation for merges perform a diff against
each parent, has no use unless I am viewing the diff, so we could save
the user some typing by turning on display of the resulting diff
automatically.  That wasn't expected to adversely affect scripts
because scripts would either be using a command like "git diff-tree"
that already emits diffs by default or would be combining -m with a
diff generation option such as --name-status.  By saving typing for
interactive use without adversely affecting scripts in the wild, it
would be a pure improvement.

The problem is that although diff generation options are only relevant
for the displayed diff, a script author can imagine them affecting
path limiting.  For example, I might run

	git log -w --format=%H -- README

hoping to list commits that edited README, excluding whitespace-only
changes.  In fact, a whitespace-only change is not TREESAME so the use
of -w here has no effect (since we don't apply these diff generation
flags to the diff_options struct rev_info::pruning used for this
purpose), but the documentation suggests that it should work

	Suppose you specified foo as the <paths>. We shall call
	commits that modify foo !TREESAME, and the rest TREESAME. (In
	a diff filtered for foo, they look different and equal,
	respectively.)

and a script author who has not tested whitespace-only changes
wouldn't notice.

Similarly, a script author could include

	git log -m --first-parent --format=%H -- README

to filter the first-parent history for commits that modified README.
The -m is a no-op but it reflects the script author's intent.  For
example, until 1e20a407fe2 (stash list: stop passing "-m" to "git
log", 2021-05-21), "git stash list" did this.

As a result, we can't safely change "-m" to imply "-p" without fear of
breaking such scripts.  Restore the previous behavior.

Noticed because Rust's src/bootstrap/bootstrap.py made use of this
same construct: https://github.com/rust-lang/rust/pull/87513.  That
script has been updated to omit the unnecessary "-m" option, but we
can expect other scripts in the wild to have similar expectations.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Joshua Nelson wrote[1]:
> Jonathan Nieder wrote:

>> What happens if someone wants to build an older version of Rust?
>
> For what it's worth, almost no one builds old versions of rust from source
> except for distros, and distros wouldn't ever set download-ci-llvm = true. So
> this shouldn't affect anyone in practice now that we've removed `-m` on master.

Thanks.  With that out of the way, I started thinking more clearly
about the intent behind this use of `-m` and I'm starting to think it
wasn't a typo after all.

As a result, in terms of

>>  a. Revert 'diff-merges: let "-m" imply "-p"'.  This buys us time to
>>     make a more targeted change, make the change more gradually in a
>>     future release, or just stop encouraging use of "-m" in docs.
>>
>>  b. Make "-m" imply "-p", except in some more 'script-ish'
>>     circumstances (e.g. when using log --format with a format string)
>>
>>  c. Go ahead with the change and advertise it in release notes.

now I lean toward (a).  How about this patch?

Thanks,
Jonathan

[1] https://lore.kernel.org/git/CAJ+j++Vj1gY93QuKDhDODXOJGXTiFFEzy0Oew+LWD7a5e7iaTA@mail.gmail.com/

 Documentation/diff-options.txt | 8 ++++----
 diff-merges.c                  | 1 -
 t/t4013-diff-various.sh        | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 0aebe832057..c89d530d3d1 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -49,9 +49,10 @@ ifdef::git-log[]
 --diff-merges=m:::
 -m:::
 	This option makes diff output for merge commits to be shown in
-	the default format. The default format could be changed using
+	the default format. `-m` will produce the output only if `-p`
+	is given as well. The default format could be changed using
 	`log.diffMerges` configuration parameter, which default value
-	is `separate`. `-m` implies `-p`.
+	is `separate`.
 +
 --diff-merges=first-parent:::
 --diff-merges=1:::
@@ -61,8 +62,7 @@ ifdef::git-log[]
 --diff-merges=separate:::
 	This makes merge commits show the full diff with respect to
 	each of the parents. Separate log entry and diff is generated
-	for each parent. This is the format that `-m` produced
-	historically.
+	for each parent.
 +
 --diff-merges=combined:::
 --diff-merges=c:::
diff --git a/diff-merges.c b/diff-merges.c
index 0dfcaa1b11b..d897fd8a293 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -107,7 +107,6 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 
 	if (!strcmp(arg, "-m")) {
 		set_to_default(revs);
-		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
 		revs->merges_imply_patch = 1;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 7fadc985ccc..e561a8e4852 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -455,8 +455,8 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
-test_expect_success 'log -m matches log -m -p' '
-	git log -m -p master >result &&
+test_expect_success 'log -m matches pure log' '
+	git log master >result &&
 	process_diffs result >expected &&
 	git log -m >result &&
 	process_diffs result >actual &&
-- 
2.32.0.605.g8dce9f2422-goog

