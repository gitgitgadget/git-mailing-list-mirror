Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259D5C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFC860233
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhBWUwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:52:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:42302 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234513AbhBWUvq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:51:46 -0500
Received: (qmail 27422 invoked by uid 109); 23 Feb 2021 20:50:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Feb 2021 20:50:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4332 invoked by uid 111); 23 Feb 2021 20:50:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Feb 2021 15:50:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Feb 2021 15:50:58 -0500
From:   Jeff King <peff@peff.net>
To:     Utku <ugultopu@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Utku Gultopu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] doc: `--date` in `git-commit` accepts approxidates
Message-ID: <YDVqsnLOGUxX3v42@coredump.intra.peff.net>
References: <pull.969.git.git.1614101746491.gitgitgadget@gmail.com>
 <pull.969.v2.git.git.1614106322760.gitgitgadget@gmail.com>
 <YDVSICgBwPLtDNu4@coredump.intra.peff.net>
 <xmqqpn0q1stv.fsf@gitster.g>
 <E2F9E8D8-0862-433D-BD20-BA3139BEC0C3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E2F9E8D8-0862-433D-BD20-BA3139BEC0C3@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 03:24:58PM -0500, Utku wrote:

> In this case, maybe Jeff can submit a patch, since I wouldn't be adding
> anything to what he suggested.

I'm happy to do that to move things along, though really 99% of the work
was in your initially identifying the problem. Here's what I would
suggest (I did steal your hunk to push all of the --date bits down into
that separate paragraph):

-- >8 --
Subject: [PATCH] doc: mention approxidates for git-commit --date

We describe the more strict date formats accepted by GIT_COMMITTER_DATE,
etc, but the --date option also allows the looser approxidate formats,
as well. Unfortunately we don't have a good or complete reference for
this format, but let's at least mention that it _is_ looser, and give a
few examples.

If we ever write separate, more complete date-format documentation, we
should refer to it from here.

Based-on-a-patch-by: Utku Gultopu <ugultopu@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/date-formats.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index f1097fac69..99c455f51c 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -1,10 +1,7 @@
 DATE FORMATS
 ------------
 
-The `GIT_AUTHOR_DATE`, `GIT_COMMITTER_DATE` environment variables
-ifdef::git-commit[]
-and the `--date` option
-endif::git-commit[]
+The `GIT_AUTHOR_DATE` and `GIT_COMMITTER_DATE` environment variables
 support the following date formats:
 
 Git internal format::
@@ -26,3 +23,9 @@ ISO 8601::
 +
 NOTE: In addition, the date part is accepted in the following formats:
 `YYYY.MM.DD`, `MM/DD/YYYY` and `DD.MM.YYYY`.
+
+ifdef::git-commit[]
+In addition to recognizing all date formats above, the `--date` option
+will also try to make sense of other, more human-centric date formats,
+such as relative dates like "yesterday" or "last Friday at noon".
+endif::git-commit[]
-- 
2.30.1.1095.g03347429ea

