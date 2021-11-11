Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B23C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E312F610F8
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhKKRu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 12:50:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54166 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhKKRu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 12:50:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27DA3F1056;
        Thu, 11 Nov 2021 12:47:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zf6cj6HqAkH1JLs/v6BReFt/L9jWy/tYxeEHiP
        /WX5k=; b=m1DQcVfmYgcIGluc7+id1cmy5eFE7jzXm9H1Sxh1p6p5F0cWQLhE74
        8olIDPNspCFixTeapRO7/z+pR8t7KECfgjk4iQL67VLHZUZQqVdvhfp1NRaThuMe
        8p+Au6XT4RXQBmFP26MwXvDDvmr72opmnboyaF/XHfMo50tE0tF0w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F1A2F1055;
        Thu, 11 Nov 2021 12:47:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 533A8F1054;
        Thu, 11 Nov 2021 12:47:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] RelNotes: fix a couple of typos for the upcoming release
References: <pull.1073.git.1636526490570.gitgitgadget@gmail.com>
Date:   Thu, 11 Nov 2021 09:47:36 -0800
In-Reply-To: <pull.1073.git.1636526490570.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 10 Nov 2021 06:41:30
        +0000")
Message-ID: <xmqqo86qmvnr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75EF6AC4-4317-11EC-BB93-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     RelNotes: fix a couple of typos for the upcoming release

Thanks.  Relative to -rc2, here is what I have today, taking these
typofixes, and a few topics for regression fixes.

diff --git a/Documentation/RelNotes/2.34.0.txt b/Documentation/RelNotes/2.34.0.txt
index effab2ea4b..7ba2a8cddc 100644
--- a/Documentation/RelNotes/2.34.0.txt
+++ b/Documentation/RelNotes/2.34.0.txt
@@ -77,7 +77,10 @@ UI, Workflows & Features
  * "git fsck" has been taught to report mismatch between expected and
    actual types of an object better.
 
- * Use ssh public crypto for object and push-cert signing.
+ * In addition to GnuPG, ssh public crypto can be used for object and
+   push-cert signing.  Note that this feature cannot be used with
+   ssh-keygen from OpenSSH 8.7, whose support for it is broken.  Avoid
+   using it unless you update to OpenSSH 8.8.
 
  * "git log --grep=string --author=name" learns to highlight hits just
    like "git grep string" does.
@@ -182,7 +185,7 @@ Performance, Internal Implementation, Development Support etc.
  * Prevent "make sparse" from running for the source files that
    haven't been modified.
 
- * The codepath to write a new version of .midx multi-pack index files
+ * The code path to write a new version of .midx multi-pack index files
    has learned to release the mmaped memory holding the current
    version of .midx before removing them from the disk, as some
    platforms do not allow removal of a file that still has mapping.
@@ -260,12 +263,8 @@ Fixes since v2.33
  * The output from "git fast-export", when its anonymization feature
    is in use, showed an annotated tag incorrectly.
 
- * Doc update plus improved error reporting.
-
  * Recent "diff -m" changes broke "gitk", which has been corrected.
 
- * Regression fix.
-
  * The "git apply -3" code path learned not to bother the lower level
    merge machinery when the three-way merge can be trivially resolved
    without the content level merge.  This fixes a regression caused by
@@ -405,9 +404,23 @@ Fixes since v2.33
    (merge 47bfdfb3fd ar/fix-git-pull-no-verify later to maint).
 
  * One CI task based on Fedora image noticed a not-quite-kosher
-   consturct recently, which has been corrected.
+   construct recently, which has been corrected.
    (merge 4b540cf913 vd/pthread-setspecific-g11-fix later to maint).
 
+ * "git pull --ff-only" and "git pull --rebase --ff-only" should make
+   it a no-op to attempt pulling from a remote that is behind us, but
+   instead the command errored out by saying it was impossible to
+   fast-forward, which may technically be true, but not a useful thing
+   to diagnose as an error.  This has been corrected.
+   (merge 361cb52383 jc/fix-pull-ff-only-when-already-up-to-date later to maint).
+
+ * The way Cygwin emulates a unix-domain socket, on top of which the
+   simple-ipc mechanism is implemented, can race with the program on
+   the other side that wants to use the socket, and briefly make it
+   appear as a regular file before lstat(2) starts reporting it as a
+   socket.  We now have a workaround on the side that connects to a
+   unix domain socket.
+
  * Other code cleanup, docfix, build fix, etc.
    (merge f188160be9 ab/bundle-remove-verbose-option later to maint).
    (merge 8c6b4332b4 rs/close-pack-leakfix later to maint).
