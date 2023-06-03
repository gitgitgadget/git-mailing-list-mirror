Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18C0C77B7A
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 17:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjFCR45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jun 2023 13:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFCR44 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2023 13:56:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F89C0
        for <git@vger.kernel.org>; Sat,  3 Jun 2023 10:56:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30c2bd52f82so3347576f8f.3
        for <git@vger.kernel.org>; Sat, 03 Jun 2023 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685815013; x=1688407013;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yTXG/N7eS7c3eyqz1iO/hgf4JqyMyhbRSY7Q8PmdXRI=;
        b=ImiGPBNYIVominJVcPr6PEGB0dbW2gd7XG7QZian6KYrACRwIBYgzyszZsMBiHN0nF
         2LgZguvxJ5xL0JM7gawNB5PwZZhQMhjwqc5zm7TLKWcnD/FPqaUi4U0CV+exy4rdKOYX
         3Xzg45+OECuA70Bx5IqzNBlguUjh12RDyVPf8H7LLeUGnasj6KlsnyMeEkH7B81U2L7j
         c7rnoiIoDZpwFJMK7sBmVNnyX9W06uH0hsGHXN3mrs5UneQ20b6d90Bya3Mo9+Jmm9/1
         /vfs74Y+6xqEeNv6EL/Vr7OcGJXQ+Axrn6JjjqbNIFt1Go+p4+N6fmTNcFeCHlVo/JaA
         kSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685815013; x=1688407013;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTXG/N7eS7c3eyqz1iO/hgf4JqyMyhbRSY7Q8PmdXRI=;
        b=I6wst/I/vkKMIw7nnKQIXSQnfNGNotMkDwj8Xm6sLqF67U9Ij4yRf87jHN1YFRJUgJ
         Obl29JGD1+tasg1QUpQdXOXyWtHeCCUSOTIUrFWjzE+SqkJf+FdEp8o3intu2/K2h+n5
         G1IVAkJ58QTbF+r6ogVqGvz2P1MRfMyR/dy6fnzUA8X9j/wtAOZYbCoPk+wZcdPts6jC
         Ybs82sfQbJ8s/Aj3rUl7XcEC9BqzM8PbJ/c59vDIluFG6hSiELRvTjzyzwRwaBbk9t+E
         WfPgGRialJrBPL1OkQJMfJ6Ja92wTsxvY6XClIQLLT8z0oludVEy82+mB29U/t9RJNCw
         BiBQ==
X-Gm-Message-State: AC+VfDyx+WR3dDYfz2Dblf0xqdZxy1uS2P49ghprZ06AeNh5BM36s1B2
        G9l9GWXZvstjzNeAkaAxGUan+fZjv+A=
X-Google-Smtp-Source: ACHHUZ7D02o1LjkEnuc7wlpKplauLRWrYVFyI2V7Pk1QI9pJ8cm0NEsNo/fXbQ4mYMqXJYDDcs9zTg==
X-Received: by 2002:a5d:508f:0:b0:30a:de3e:9674 with SMTP id a15-20020a5d508f000000b0030ade3e9674mr2391370wrt.57.1685815012618;
        Sat, 03 Jun 2023 10:56:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4-20020a5d4144000000b0030ade1b9400sm5073975wrq.30.2023.06.03.10.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 10:56:52 -0700 (PDT)
Message-Id: <pull.1519.git.git.1685815011553.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 03 Jun 2023 17:56:51 +0000
Subject: [PATCH] cherry-pick: use trailer instead of free-text for `-x`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Allred <allred.sean@gmail.com>

When recording the origin commit during a cherry-pick, the current label
used is not understood by git-interpret-trailers. Standardize onto the
'normal' trailer format that can be reasonably/reliably parsed and used
by external tooling leveraging git-interpret-trailers.

This also somewhat improves the readability of resulting commit messages
in some scenarios where trailers are already in use. Consider the
example already present in cd650a4e (2023-02-12, "recognize '(cherry
picked from ...' as part of s-o-b footer"):

>   Signed-off-by: A U Thor <author@example.com>
>   (cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
>   Signed-off-by: C O Mmitter <committer@example.com>

This will now show as

>   Signed-off-by: A U Thor <author@example.com>
>   Cherry-Picked-From-Commit: da39a3ee5e6b4b0d3255bfef95601890afd80709
>   Signed-off-by: C O Mmitter <committer@example.com>

Most tests are adjusted for the new format. A test is added to
demonstrate that the old free-text format in existing commit data is
still considered part of the trailer block (i.e., the problem fixed by
the above commit has not been re-introduced).

---
    cherry-pick: use trailer instead of free-text for -x

I considered (but did not pursue) a new configuration option for two
reasons:


Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1519%2Fvermiculus%2Fsa%2Fcherry-pick-origin-trailer-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1519/vermiculus/sa/cherry-pick-origin-trailer-v1
Pull-Request: https://github.com/git/git/pull/1519

  1. Without regard to historical data, using a 'real' trailer seems
     inherently better than the current free-text state.

  2. Regarding historical data, adding a user-configurable option
     doesn't make things simpler for systems maintainers; those systems
     still have to handle both formats if they have such a need to begin
     with. As it's still a clear and readable format, end-user
     developers are unlikely to care to change it back.

The maintenance and cognitive costs of a new configuration option are
not worth the minimal benefit it seems it would bring.

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
 sequencer.c                     |  6 ++---
 t/t3510-cherry-pick-sequence.sh | 12 ++++-----
 t/t3511-cherry-pick-x.sh        | 47 +++++++++++++++++++++++----------
 3 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index bceb6abcb6c..410f8469379 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -51,7 +51,7 @@
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
 static const char sign_off_header[] = "Signed-off-by: ";
-static const char cherry_picked_prefix[] = "(cherry picked from commit ";
+static const char cherry_picked_header[] = "Cherry-Picked-From-Commit: ";
 
 GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
 
@@ -2277,9 +2277,9 @@ static int do_pick_commit(struct repository *r,
 			strbuf_complete_line(&msgbuf);
 			if (!has_conforming_footer(&msgbuf, NULL, 0))
 				strbuf_addch(&msgbuf, '\n');
-			strbuf_addstr(&msgbuf, cherry_picked_prefix);
+			strbuf_addstr(&msgbuf, cherry_picked_header);
 			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
-			strbuf_addstr(&msgbuf, ")\n");
+			strbuf_addstr(&msgbuf, "\n");
 		}
 		if (!is_fixup(command))
 			author = get_author(msg.message);
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 3b0fa66c33d..958fa019aed 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -548,10 +548,10 @@ test_expect_success '--continue respects opts' '
 	git cat-file commit HEAD~1 >picked_msg &&
 	git cat-file commit HEAD~2 >unrelatedpick_msg &&
 	git cat-file commit HEAD~3 >initial_msg &&
-	! grep "cherry picked from" initial_msg &&
-	grep "cherry picked from" unrelatedpick_msg &&
-	grep "cherry picked from" picked_msg &&
-	grep "cherry picked from" anotherpick_msg
+	! grep "Cherry-Picked-From-Commit" initial_msg &&
+	grep "Cherry-Picked-From-Commit" unrelatedpick_msg &&
+	grep "Cherry-Picked-From-Commit" picked_msg &&
+	grep "Cherry-Picked-From-Commit" anotherpick_msg
 '
 
 test_expect_success '--continue of single-pick respects -x' '
@@ -562,7 +562,7 @@ test_expect_success '--continue of single-pick respects -x' '
 	git cherry-pick --continue &&
 	test_path_is_missing .git/sequencer &&
 	git cat-file commit HEAD >msg &&
-	grep "cherry picked from" msg
+	grep "Cherry-Picked-From-Commit" msg
 '
 
 test_expect_success '--continue respects -x in first commit in multi-pick' '
@@ -574,7 +574,7 @@ test_expect_success '--continue respects -x in first commit in multi-pick' '
 	test_path_is_missing .git/sequencer &&
 	git cat-file commit HEAD^ >msg &&
 	picked=$(git rev-parse --verify picked) &&
-	grep "cherry picked from.*$picked" msg
+	grep "Cherry-Picked-From-Commit: $picked" msg
 '
 
 test_expect_failure '--signoff is automatically propagated to resolved conflict' '
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index dd5d92ef302..809afba48e1 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -33,6 +33,10 @@ mesg_with_footer_sob="$mesg_with_footer
 Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 
 mesg_with_cherry_footer="$mesg_with_footer_sob
+Cherry-Picked-From-Commit: da39a3ee5e6b4b0d3255bfef95601890afd80709
+Tested-by: C.U. Thor <cuthor@example.com>"
+
+mesg_with_old_cherry_footer="$mesg_with_footer_sob
 (cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
 Tested-by: C.U. Thor <cuthor@example.com>"
 
@@ -68,6 +72,8 @@ test_expect_success setup '
 	git reset --hard initial &&
 	test_commit "$mesg_with_cherry_footer" foo b mesg-with-cherry-footer &&
 	git reset --hard initial &&
+	test_commit "$mesg_with_old_cherry_footer" foo b mesg-with-old-cherry-footer &&
+	git reset --hard initial &&
 	test_config commit.cleanup verbatim &&
 	test_commit "$mesg_unclean" foo b mesg-unclean &&
 	test_unconfig commit.cleanup &&
@@ -82,7 +88,7 @@ test_expect_success 'cherry-pick -x inserts blank line after one line subject' '
 	cat <<-EOF >expect &&
 		$mesg_one_line
 
-		(cherry picked from commit $sha1)
+		Cherry-Picked-From-Commit: $sha1
 	EOF
 	git log -1 --pretty=format:%B >actual &&
 	test_cmp expect actual
@@ -130,7 +136,7 @@ test_expect_success 'cherry-pick -x inserts blank line when conforming footer no
 	cat <<-EOF >expect &&
 		$mesg_no_footer
 
-		(cherry picked from commit $sha1)
+		Cherry-Picked-From-Commit: $sha1
 	EOF
 	git log -1 --pretty=format:%B >actual &&
 	test_cmp expect actual
@@ -155,7 +161,7 @@ test_expect_success 'cherry-pick -x -s inserts blank line when conforming footer
 	cat <<-EOF >expect &&
 		$mesg_no_footer
 
-		(cherry picked from commit $sha1)
+		Cherry-Picked-From-Commit: $sha1
 		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
 	EOF
 	git log -1 --pretty=format:%B >actual &&
@@ -179,7 +185,7 @@ test_expect_success 'cherry-pick -x -s adds sob when last sob doesnt match commi
 	git cherry-pick -x -s mesg-with-footer &&
 	cat <<-EOF >expect &&
 		$mesg_with_footer
-		(cherry picked from commit $sha1)
+		Cherry-Picked-From-Commit: $sha1
 		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
 	EOF
 	git log -1 --pretty=format:%B >actual &&
@@ -202,7 +208,7 @@ test_expect_success 'cherry-pick -x -s adds sob even when trailing sob exists fo
 	git cherry-pick -x -s mesg-with-footer-sob &&
 	cat <<-EOF >expect &&
 		$mesg_with_footer_sob
-		(cherry picked from commit $sha1)
+		Cherry-Picked-From-Commit: $sha1
 		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
 	EOF
 	git log -1 --pretty=format:%B >actual &&
@@ -216,7 +222,7 @@ test_expect_success 'cherry-pick -x handles commits with no NL at end of message
 	git cherry-pick -x $sha1 &&
 	git log -1 --pretty=format:%B >actual &&
 
-	printf "\n(cherry picked from commit %s)\n" $sha1 >>msg &&
+	printf "\nCherry-Picked-From-Commit: %s\n" $sha1 >>msg &&
 	test_cmp msg actual
 '
 
@@ -227,7 +233,7 @@ test_expect_success 'cherry-pick -x handles commits with no footer and no NL at
 	git cherry-pick -x $sha1 &&
 	git log -1 --pretty=format:%B >actual &&
 
-	printf "\n\n(cherry picked from commit %s)\n" $sha1 >>msg &&
+	printf "\n\nCherry-Picked-From-Commit: %s\n" $sha1 >>msg &&
 	test_cmp msg actual
 '
 
@@ -253,19 +259,19 @@ test_expect_success 'cherry-pick -s handles commits with no footer and no NL at
 	test_cmp msg actual
 '
 
-test_expect_success 'cherry-pick -x treats "(cherry picked from..." line as part of footer' '
+test_expect_success 'cherry-pick -x treats "Cherry-Picked-From-Commit" line as part of footer' '
 	pristine_detach initial &&
 	sha1=$(git rev-parse mesg-with-cherry-footer^0) &&
 	git cherry-pick -x mesg-with-cherry-footer &&
 	cat <<-EOF >expect &&
 		$mesg_with_cherry_footer
-		(cherry picked from commit $sha1)
+		Cherry-Picked-From-Commit: $sha1
 	EOF
 	git log -1 --pretty=format:%B >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'cherry-pick -s treats "(cherry picked from..." line as part of footer' '
+test_expect_success 'cherry-pick -s treats "Cherry-Picked-From-Commit" line as part of footer' '
 	pristine_detach initial &&
 	git cherry-pick -s mesg-with-cherry-footer &&
 	cat <<-EOF >expect &&
@@ -276,13 +282,26 @@ test_expect_success 'cherry-pick -s treats "(cherry picked from..." line as part
 	test_cmp expect actual
 '
 
-test_expect_success 'cherry-pick -x -s treats "(cherry picked from..." line as part of footer' '
+test_expect_success 'cherry-pick -x -s treats "Cherry-Picked-From-Commit" line as part of footer' '
 	pristine_detach initial &&
 	sha1=$(git rev-parse mesg-with-cherry-footer^0) &&
 	git cherry-pick -x -s mesg-with-cherry-footer &&
 	cat <<-EOF >expect &&
 		$mesg_with_cherry_footer
-		(cherry picked from commit $sha1)
+		Cherry-Picked-From-Commit: $sha1
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cherry-pick -x -s still treats "(cherry picked from commit.." line as part of footer' '
+	pristine_detach initial &&
+	sha1=$(git rev-parse mesg-with-old-cherry-footer^0) &&
+	git cherry-pick -x -s mesg-with-old-cherry-footer &&
+	cat <<-EOF >expect &&
+		$mesg_with_old_cherry_footer
+		Cherry-Picked-From-Commit: $sha1
 		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
 	EOF
 	git log -1 --pretty=format:%B >actual &&
@@ -303,7 +322,7 @@ test_expect_success 'cherry-pick -x cleans commit message' '
 	pristine_detach initial &&
 	git cherry-pick -x mesg-unclean &&
 	git log -1 --pretty=format:%B >actual &&
-	printf "%s\n(cherry picked from commit %s)\n" \
+	printf "%s\nCherry-Picked-From-Commit: %s\n" \
 		"$mesg_unclean" $(git rev-parse mesg-unclean) |
 			git stripspace >expect &&
 	test_cmp expect actual
@@ -313,7 +332,7 @@ test_expect_success 'cherry-pick -x respects commit.cleanup' '
 	pristine_detach initial &&
 	git -c commit.cleanup=strip cherry-pick -x mesg-unclean &&
 	git log -1 --pretty=format:%B >actual &&
-	printf "%s\n(cherry picked from commit %s)\n" \
+	printf "%s\nCherry-Picked-From-Commit: %s\n" \
 		"$mesg_unclean" $(git rev-parse mesg-unclean) |
 			git stripspace -s >expect &&
 	test_cmp expect actual

base-commit: fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
-- 
gitgitgadget
