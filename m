Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF81C10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 17:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8687E20658
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 17:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yY0k8ZDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCFRXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:23:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60457 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgCFRXo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 12:23:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 890935A940;
        Fri,  6 Mar 2020 12:23:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2YxTC7vybeJ5T9ooFRfbp5ZWqTg=; b=yY0k8Z
        DDyg0CCqLrh+dQhbD7eTnsT3V5mBW3kWyjvVArorhOfEeHm6DEzrXyZjcaG+FbSL
        oiU9zqtVpRUfR3LG6DP7Q26Sijpo01A1PmjwUeLkdklvqrG+9RAGjP/z3nKDeO/1
        KhA0lWI1fUBhtzG5RRWnihn4B3nr0bEQFpiMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aCro7yL4fmrw42QZw4jBsJGYY2V5vpb6
        +7WsfnKe1Zor8bOC7lFw0qqTRoz/a3LYcE5ys3aNfFbQTQSwwyTje3LxqDevbvH5
        hlqY+6cYfyHdcH7UMQKRtBTZ2n7nD1+GSZ9/jSlPI43YdsBhXfIVxEL/F+7Nx9wq
        Lwkab1eUXfw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8175F5A93F;
        Fri,  6 Mar 2020 12:23:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DFB985A93E;
        Fri,  6 Mar 2020 12:23:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] update how-to-maintain-git
References: <xmqqimjl6pvn.fsf@gitster-ct.c.googlers.com>
        <CACg5j262bzzwifXXC3tGu-bbNtojKQe-j1=byaAbrSNo=WtWgg@mail.gmail.com>
        <xmqqpnds5c1v.fsf@gitster-ct.c.googlers.com>
        <CACg5j26uLyyHRx0ouVhUbJ8P20uJgvN4WCqunP5OoXhGyxuadA@mail.gmail.com>
Date:   Fri, 06 Mar 2020 09:23:38 -0800
In-Reply-To: <CACg5j26uLyyHRx0ouVhUbJ8P20uJgvN4WCqunP5OoXhGyxuadA@mail.gmail.com>
        (Heba Waly's message of "Fri, 6 Mar 2020 04:17:36 +1300")
Message-ID: <xmqqzhct2y91.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3884F1A4-5FCF-11EA-800D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some parts of the workflow described in the document has got a bit
stale with the recent toolchain improvements.  Update the procedure
a bit, and also describe the convention used around SQUASH??? fixups.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Periodical maintenance of the document to improve the bus factor ;-)

 Documentation/howto/maintain-git.txt | 53 +++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index ca4378740c..02584c2a4b 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -154,15 +154,17 @@ by doing the following:
    - Anything unobvious that is applicable to 'master' (in other
      words, does not depend on anything that is still in 'next'
      and not in 'master') is applied to a new topic branch that
-     is forked from the tip of 'master'.  This includes both
+     is forked from the tip of 'master' (or the last feature release,
+     which is a bit older than 'master').  This includes both
      enhancements and unobvious fixes to 'master'.  A topic
      branch is named as ai/topic where "ai" is two-letter string
      named after author's initial and "topic" is a descriptive name
      of the topic (in other words, "what's the series is about").
 
    - An unobvious fix meant for 'maint' is applied to a new
-     topic branch that is forked from the tip of 'maint'.  The
-     topic is named as ai/maint-topic.
+     topic branch that is forked from the tip of 'maint' (or the
+     oldest and still relevant maintenance branch).  The
+     topic may named as ai/maint-topic.
 
    - Changes that pertain to an existing topic are applied to
      the branch, but:
@@ -174,24 +176,40 @@ by doing the following:
    - Replacement patches to an existing topic are accepted only
      for commits not in 'next'.
 
-   The above except the "replacement" are all done with:
+   The initial round is done with:
 
      $ git checkout ai/topic ;# or "git checkout -b ai/topic master"
      $ git am -sc3 mailbox
 
-   while patch replacement is often done by:
+   and replacing an existing topic with subsequent round is done with:
 
-     $ git format-patch ai/topic~$n..ai/topic ;# export existing
+     $ git checkout master...ai/topic ;# try to reapply to the same base
+     $ git am -sc3 mailbox
+
+   to prepare the new round on a detached HEAD, and then
+
+     $ git range-diff @{-1}...
+     $ git diff @{-1}
+
+   to double check what changed since the last round, and finally
 
-   then replace some parts with the new patch, and reapplying:
+     $ git checkout -B @{-1}
 
-     $ git checkout ai/topic
-     $ git reset --hard ai/topic~$n
-     $ git am -sc3 -s 000*.txt
+   to conclude (the last step is why a topic already in 'next' is
+   not replaced but updated incrementally).
+
+   Whether it is the initial round or a subsequent round, the topic
+   may not build even in isolation, or may break the build when
+   merged to integration branches due to bugs.  There may already be
+   an obvious and trivial improvements suggested on the list.  The
+   maintainer often adds an extra commit, with "SQUASH???" in its
+   title, to fix things up, before publishing the integration
+   branches to make it usable by other developers for testing.
+   These changes are what the maintainer is not 100% committed to
+   (trivial typofixes etc. are often squashed directly into the
+   patches that needs fixing, without being applied as a separate
+   "SQUASH???" commit), so that they can be removed easily as needed.
 
-   The full test suite is always run for 'maint' and 'master'
-   after patch application; for topic branches the tests are run
-   as time permits.
 
  - Merge maint to master as needed:
 
@@ -371,6 +389,15 @@ Some observations to be made.
    be included in the next feature release.  Being in the
    'master' branch typically is.
 
+ * Due to the nature of "SQUASH???" fix-ups, if the original author
+   agrees with the suggested changes, it is OK to squash them to
+   appropriate patches in the next round (when the suggested change
+   is small enough, the author should not even bother with
+   "Helped-by").  It is also OK to drop them from the next round
+   when the original author does not agree with the suggestion, but
+   the author is expected to say why somewhere in the discussion.
+
+
 
 Appendix
 --------

