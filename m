Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD999C33C9E
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 02:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04242080A
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 02:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JfuoktdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgAHCbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:31:41 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:42379 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHCbl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 21:31:41 -0500
Received: by mail-pl1-f201.google.com with SMTP id b5so824529pls.9
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 18:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HD45Uek04/UplOMlyNlPwQjJOlh7gp4Rh96QtJomszM=;
        b=JfuoktdBAFueXOyi/LKKOlOC+t0AAVlpZ13VuGgqf2wyg34AetmMKAywkbq7pRqMYn
         PioaX7/3WFT/VCsBvxUcYLDhDWcaV+XAnD814rWmAvNJyR2xC7YcXg3LXes1bybVVmZE
         hAT9e/hbUZqjw+C+pzyR1FgRjpKly/FvkvB0rC7+xaAkhObNy6jvDNJ10V0hONe/UNp7
         76DvTn0n07IL6HVuuWT1V1AIpAJmjkfDkeIJf/FMzLkjaMWQCS98byXhbVNBsiO3a+tO
         fZVJMUBbR61vxuhjC8ZmixHPpoMdwIj8TlzOO7f1HqIITIvCHJUR/oKLVa0kBJqIMItt
         w1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HD45Uek04/UplOMlyNlPwQjJOlh7gp4Rh96QtJomszM=;
        b=op0WGHymcEulnLaoFN6RCKmylUZ/2q7GsikQnMCiwzualR+nAWyGiCQ1rZg51HyPNM
         fjH1nzobseaHuc1ZP5sRsHVuPbIoxXG3uHT0PdpSJ268VPlA8Ps3WQe/6eQ3F4rX6Nt9
         jqM4nyRVXYpW/ehaD1Zeu8uYwVqX+Nk1iE7QuPdEWKcWqQfXhNqj2MUDqsGPx2IHvFeV
         2gjeus1KyyKPFDAugfDHlyQSw9tfrN9GPnPhOEEJhycqZKjKcgOSBbi/+WS0mm9ayP6z
         KE/DC7EekqOxTmP+qAYPY08X1EkBYFu2tKiFuc2kkbU5UNpf3UtP2reyrZRGJqYX0OLd
         iFbA==
X-Gm-Message-State: APjAAAUYYvg0RhxMn0rQA1wtS3r1paJyImMu1fE0Cdul55bQ98cIhrZF
        VMG0nS+Pf3gEZfV7uqJ9uTsD/JCJH8+LTHViFTq/It5SIG37ilgFCAyJ7L0WEwlkZc2jemK8gVm
        mVTInWGCUAqJqG54VIF7PFN4yqEVV1wthjT8f312CGO1L5e4TrIZJo0NvkK8YLt7DtJcm+TQzQA
        ==
X-Google-Smtp-Source: APXvYqyPHfOW60Rge94pA2vY4eJWCHOdeSrnQndVVmywVJAxjfZ2M09IcdDqkMZqyp9du5Vwx197wJJ13tCFuZi0CIw=
X-Received: by 2002:a63:9d4e:: with SMTP id i75mr2763861pgd.231.1578450699853;
 Tue, 07 Jan 2020 18:31:39 -0800 (PST)
Date:   Tue,  7 Jan 2020 18:31:27 -0800
Message-Id: <20200108023127.219429-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [RFC PATCH] unpack-trees: watch for out-of-range index position
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's possible in a case where the index file contains a tree extension
but no blobs within that tree exist for index_pos_by_traverse_info() to
segfault. If the name_entry passed into index_pos_by_traverse_info() has
no blobs inside, AND is alphabetically later than all blobs currently in
the index file, index_pos_by_traverse_info() will segfault. For example,
an index file which looks something like this:

  aaa#0
  bbb/aaa#0
  [Extensions]
  TREE: zzz

In this example, 'index_name_pos(..., "zzz/", ...)' will return '-4',
indicating that "zzz/" could be inserted at position 3. However, when
the checks which ensure that the insertion position of "zzz/" look for a
blob at that position beginning with "zzz/", the index cache is accessed
out of range, causing a segfault.

This kind of index state is not typically generated during user
operations, and is in fact an edge case of the state being checked for
in the conditional where it was added. However, since the entry for the
BUG() line is ambiguous, tell some additional context to help Git
developers debug the failure later. When we know the name of the dir we
were trying to look up, it becomes possible to examine the index file
in a hex util to determine what went wrong; the position gives a hint
about where to start looking.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
This issue came in via a bugreport from a user who had done some nasty
things like deleting various files in .git/ (and then couldn't remember
how they had done it). The concern was primarily that a segfault is ugly
and scary, and possibly dangerous; I didn't see much problem with
checking for index-out-of-range if the result is a fatal error
regardless.

The index file they shared for reproduction was very similar to the one
that I proposed in the commit message. However, though I had a repo
where I could reproduce, since the user wasn't sure how they had gotten
there I struggled reasoning about how to produce these exact conditions.
It seems like during normal operation the index shouldn't learn about a
tree extension where it doesn't know any blobs (in fact, I've become
irritated before about being unable to stage/commit only directory
structure :) ).

I also didn't find any test cases looking for the BUG() as it exists
now; I guess that's because BUG()s are supposed to be unreachable during
normal operation (or else they'd be a die()). So, it's marked RFC only
because I couldn't think of a way to reliably reproduce or test this
change.

 - Emily

 unpack-trees.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index a75b068d33..d1ac1e179c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -694,9 +694,11 @@ static int index_pos_by_traverse_info(struct name_entry *names,
 	if (pos >= 0)
 		BUG("This is a directory and should not exist in index");
 	pos = -pos - 1;
-	if (!starts_with(o->src_index->cache[pos]->name, name.buf) ||
+	if (pos >= o->src_index->cache_nr ||
+	    !starts_with(o->src_index->cache[pos]->name, name.buf) ||
 	    (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name.buf)))
-		BUG("pos must point at the first entry in this directory");
+		BUG("pos %d doesn't point to the first entry of %s in index",
+		    pos, name.buf);
 	strbuf_release(&name);
 	return pos;
 }
-- 
2.25.0.rc1.283.g88dfdc4193-goog

