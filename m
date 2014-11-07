From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 5/5] t3301: Use write_script(), nitpick whitespace
Date: Fri,  7 Nov 2014 10:19:21 +0100
Message-ID: <1415351961-31567-6-git-send-email-johan@herland.net>
References: <1415351961-31567-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 07 10:19:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmfhv-0007O8-Rm
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 10:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbaKGJTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 04:19:49 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:47308 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbaKGJTk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 04:19:40 -0500
Received: by mail-lb0-f177.google.com with SMTP id z12so2274944lbi.8
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 01:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jiYcQvPkxFcCrhWGKFUqePByj0A97/TPY01HJ1xFfS4=;
        b=WVeWKCMLX4XM6pYWE4p520WqQKnZp78CuLpThj+UVbmmlUzRVF3GOem/YWxqyBeInL
         0eLzxMJzaH/AyG38n8NhOPD2o2tFcDj7njx2ACzztY2D+bmyWAPH53SuUiAnDMszuTeY
         wWzEQrxwhPRAHTMxyg9pBkQbyrQiAgVlh32Ap4cEj5I5wq6YvH1G/jz5d7FHfUQwdA2t
         eTslG83qawXPwY5ZQLOwv8TPTdVaBFb07k0G94P//ya4ChkDBB+SdJ1f6ApaV8DG7QlV
         +rO/sotdsozim/J6GZtw9e7aw/I8Q7WJ5rpLp29ckRWABt+Vs7HUDZscO/1l7rU3JGVJ
         Gv0w==
X-Received: by 10.152.22.135 with SMTP id d7mr10073223laf.46.1415351978880;
        Fri, 07 Nov 2014 01:19:38 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id 8sm3081897lav.15.2014.11.07.01.19.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Nov 2014 01:19:37 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
In-Reply-To: <1415351961-31567-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johan Herland <johan@herland.net>
---

Drop this if it's too much churn.

...Johan

 t/t3301-notes.sh | 254 +++++++++++++++++++++++++++----------------------------
 1 file changed, 126 insertions(+), 128 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index f5d8193..80caee0 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -7,13 +7,11 @@ test_description='Test commit notes'
 
 . ./test-lib.sh
 
-cat > fake_editor.sh << \EOF
-#!/bin/sh
-echo "$MSG" > "$1"
-echo "$MSG" >& 2
+write_script fake_editor <<\EOF
+echo "$MSG" >"$1"
+echo "$MSG" >&2
 EOF
-chmod a+x fake_editor.sh
-GIT_EDITOR=./fake_editor.sh
+GIT_EDITOR=./fake_editor
 export GIT_EDITOR
 
 test_expect_success 'cannot annotate non-existing HEAD' '
@@ -21,11 +19,11 @@ test_expect_success 'cannot annotate non-existing HEAD' '
 '
 
 test_expect_success setup '
-	: > a1 &&
+	: >a1 &&
 	git add a1 &&
 	test_tick &&
 	git commit -m 1st &&
-	: > a2 &&
+	: >a2 &&
 	git add a2 &&
 	test_tick &&
 	git commit -m 2nd
@@ -131,7 +129,7 @@ test_expect_success 'can overwrite existing note with "git notes add -f"' '
 	test_must_fail git notes show HEAD^
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 commit 268048bfb8a1fb38e703baceb8ab235421bf80c5
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:14:13 2005 -0700
@@ -144,12 +142,12 @@ EOF
 
 test_expect_success 'show notes' '
 	! (git cat-file commit HEAD | grep b1) &&
-	git log -1 > output &&
+	git log -1 >output &&
 	test_cmp expect output
 '
 
 test_expect_success 'create multi-line notes (setup)' '
-	: > a3 &&
+	: >a3 &&
 	git add a3 &&
 	test_tick &&
 	git commit -m 3rd &&
@@ -158,7 +156,7 @@ c3c3c3c3
 d3d3d3" git notes add
 '
 
-cat > expect-multiline << EOF
+cat >expect-multiline <<EOF
 commit 1584215f1d29c65e99c6c6848626553fdd07fd75
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:15:13 2005 -0700
@@ -171,23 +169,23 @@ Notes:
     d3d3d3
 EOF
 
-printf "\n" >> expect-multiline
-cat expect >> expect-multiline
+printf "\n" >>expect-multiline
+cat expect >>expect-multiline
 
 test_expect_success 'show multi-line notes' '
-	git log -2 > output &&
+	git log -2 >output &&
 	test_cmp expect-multiline output
 '
 test_expect_success 'create -F notes (setup)' '
-	: > a4 &&
+	: >a4 &&
 	git add a4 &&
 	test_tick &&
 	git commit -m 4th &&
-	echo "xyzzy" > note5 &&
+	echo "xyzzy" >note5 &&
 	git notes add -F note5
 '
 
-cat > expect-F << EOF
+cat >expect-F <<EOF
 commit 15023535574ded8b1a89052b32673f84cf9582b8
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:16:13 2005 -0700
@@ -198,22 +196,22 @@ Notes:
     xyzzy
 EOF
 
-printf "\n" >> expect-F
-cat expect-multiline >> expect-F
+printf "\n" >>expect-F
+cat expect-multiline >>expect-F
 
 test_expect_success 'show -F notes' '
-	git log -3 > output &&
+	git log -3 >output &&
 	test_cmp expect-F output
 '
 
 test_expect_success 'Re-adding -F notes without -f fails' '
-	echo "zyxxy" > note5 &&
+	echo "zyxxy" >note5 &&
 	test_must_fail git notes add -F note5 &&
-	git log -3 > output &&
+	git log -3 >output &&
 	test_cmp expect-F output
 '
 
-cat >expect << EOF
+cat >expect <<EOF
 commit 15023535574ded8b1a89052b32673f84cf9582b8
 tree e070e3af51011e47b183c33adf9736736a525709
 parent 1584215f1d29c65e99c6c6848626553fdd07fd75
@@ -305,7 +303,7 @@ test_expect_success 'git log --no-notes resets ref list' '
 '
 
 test_expect_success 'create -m notes (setup)' '
-	: > a5 &&
+	: >a5 &&
 	git add a5 &&
 	test_tick &&
 	git commit -m 5th &&
@@ -315,7 +313,7 @@ baz"
 '
 
 whitespace="    "
-cat > expect-m << EOF
+cat >expect-m <<EOF
 commit bd1753200303d0a0344be813e504253b3d98e74d
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:17:13 2005 -0700
@@ -330,11 +328,11 @@ $whitespace
     baz
 EOF
 
-printf "\n" >> expect-m
-cat expect-F >> expect-m
+printf "\n" >>expect-m
+cat expect-F >>expect-m
 
 test_expect_success 'show -m notes' '
-	git log -4 > output &&
+	git log -4 >output &&
 	test_cmp expect-m output
 '
 
@@ -342,7 +340,7 @@ test_expect_success 'remove note with add -f -F /dev/null (setup)' '
 	git notes add -f -F /dev/null
 '
 
-cat > expect-rm-F << EOF
+cat >expect-rm-F <<EOF
 commit bd1753200303d0a0344be813e504253b3d98e74d
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:17:13 2005 -0700
@@ -350,11 +348,11 @@ Date:   Thu Apr 7 15:17:13 2005 -0700
     5th
 EOF
 
-printf "\n" >> expect-rm-F
-cat expect-F >> expect-rm-F
+printf "\n" >>expect-rm-F
+cat expect-F >>expect-rm-F
 
 test_expect_success 'verify note removal with -F /dev/null' '
-	git log -4 > output &&
+	git log -4 >output &&
 	test_cmp expect-rm-F output &&
 	test_must_fail git notes show
 '
@@ -364,12 +362,12 @@ test_expect_success 'do not create empty note with -m "" (setup)' '
 '
 
 test_expect_success 'verify non-creation of note with -m ""' '
-	git log -4 > output &&
+	git log -4 >output &&
 	test_cmp expect-rm-F output &&
 	test_must_fail git notes show
 '
 
-cat > expect-combine_m_and_F << EOF
+cat >expect-combine_m_and_F <<EOF
 foo
 
 xyzzy
@@ -382,10 +380,10 @@ baz
 EOF
 
 test_expect_success 'create note with combination of -m and -F' '
-	echo "xyzzy" > note_a &&
-	echo "zyxxy" > note_b &&
+	echo "xyzzy" >note_a &&
+	echo "zyxxy" >note_b &&
 	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" &&
-	git notes show > output &&
+	git notes show >output &&
 	test_cmp expect-combine_m_and_F output
 '
 
@@ -394,7 +392,7 @@ test_expect_success 'remove note with "git notes remove" (setup)' '
 	git notes remove
 '
 
-cat > expect-rm-remove << EOF
+cat >expect-rm-remove <<EOF
 commit bd1753200303d0a0344be813e504253b3d98e74d
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:17:13 2005 -0700
@@ -408,24 +406,24 @@ Date:   Thu Apr 7 15:16:13 2005 -0700
     4th
 EOF
 
-printf "\n" >> expect-rm-remove
-cat expect-multiline >> expect-rm-remove
+printf "\n" >>expect-rm-remove
+cat expect-multiline >>expect-rm-remove
 
 test_expect_success 'verify note removal with "git notes remove"' '
-	git log -4 > output &&
+	git log -4 >output &&
 	test_cmp expect-rm-remove output &&
 	test_must_fail git notes show HEAD^
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 c18dc024e14f08d18d14eea0d747ff692d66d6a3 1584215f1d29c65e99c6c6848626553fdd07fd75
 c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061 268048bfb8a1fb38e703baceb8ab235421bf80c5
 EOF
 
 test_expect_success 'removing non-existing note should not create new commit' '
-	git rev-parse --verify refs/notes/commits > before_commit &&
+	git rev-parse --verify refs/notes/commits >before_commit &&
 	test_must_fail git notes remove HEAD^ &&
-	git rev-parse --verify refs/notes/commits > after_commit &&
+	git rev-parse --verify refs/notes/commits >after_commit &&
 	test_cmp before_commit after_commit
 '
 
@@ -505,33 +503,33 @@ test_expect_success 'removing with --stdin --ignore-missing' '
 '
 
 test_expect_success 'list notes with "git notes list"' '
-	git notes list > output &&
+	git notes list >output &&
 	test_cmp expect output
 '
 
 test_expect_success 'list notes with "git notes"' '
-	git notes > output &&
+	git notes >output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 c18dc024e14f08d18d14eea0d747ff692d66d6a3
 EOF
 
 test_expect_success 'list specific note with "git notes list <object>"' '
-	git notes list HEAD^^ > output &&
+	git notes list HEAD^^ >output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 EOF
 
 test_expect_success 'listing non-existing notes fails' '
-	test_must_fail git notes list HEAD > output &&
+	test_must_fail git notes list HEAD >output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 Initial set of notes
 
 More notes appended with git notes append
@@ -540,24 +538,24 @@ EOF
 test_expect_success 'append to existing note with "git notes append"' '
 	git notes add -m "Initial set of notes" &&
 	git notes append -m "More notes appended with git notes append" &&
-	git notes show > output &&
+	git notes show >output &&
 	test_cmp expect output
 '
 
-cat > expect_list << EOF
+cat >expect_list <<EOF
 c18dc024e14f08d18d14eea0d747ff692d66d6a3 1584215f1d29c65e99c6c6848626553fdd07fd75
 c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061 268048bfb8a1fb38e703baceb8ab235421bf80c5
 4b6ad22357cc8a1296720574b8d2fbc22fab0671 bd1753200303d0a0344be813e504253b3d98e74d
 EOF
 
 test_expect_success '"git notes list" does not expand to "git notes list HEAD"' '
-	git notes list > output &&
+	git notes list >output &&
 	test_cmp expect_list output
 '
 
 test_expect_success 'appending empty string does not change existing note' '
 	git notes append -m "" &&
-	git notes show > output &&
+	git notes show >output &&
 	test_cmp expect output
 '
 
@@ -567,7 +565,7 @@ test_expect_success 'git notes append == add when there is no existing note' '
 	git notes append -m "Initial set of notes
 
 More notes appended with git notes append" &&
-	git notes show > output &&
+	git notes show >output &&
 	test_cmp expect output
 '
 
@@ -579,14 +577,14 @@ test_expect_success 'appending empty string to non-existing note does not create
 '
 
 test_expect_success 'create other note on a different notes ref (setup)' '
-	: > a6 &&
+	: >a6 &&
 	git add a6 &&
 	test_tick &&
 	git commit -m 6th &&
 	GIT_NOTES_REF="refs/notes/other" git notes add -m "other note"
 '
 
-cat > expect-other << EOF
+cat >expect-other <<EOF
 commit 387a89921c73d7ed72cd94d179c1c7048ca47756
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:18:13 2005 -0700
@@ -597,7 +595,7 @@ Notes (other):
     other note
 EOF
 
-cat > expect-not-other << EOF
+cat >expect-not-other <<EOF
 commit 387a89921c73d7ed72cd94d179c1c7048ca47756
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:18:13 2005 -0700
@@ -606,27 +604,27 @@ Date:   Thu Apr 7 15:18:13 2005 -0700
 EOF
 
 test_expect_success 'Do not show note on other ref by default' '
-	git log -1 > output &&
+	git log -1 >output &&
 	test_cmp expect-not-other output
 '
 
 test_expect_success 'Do show note when ref is given in GIT_NOTES_REF' '
-	GIT_NOTES_REF="refs/notes/other" git log -1 > output &&
+	GIT_NOTES_REF="refs/notes/other" git log -1 >output &&
 	test_cmp expect-other output
 '
 
 test_expect_success 'Do show note when ref is given in core.notesRef config' '
 	git config core.notesRef "refs/notes/other" &&
-	git log -1 > output &&
+	git log -1 >output &&
 	test_cmp expect-other output
 '
 
 test_expect_success 'Do not show note when core.notesRef is overridden' '
-	GIT_NOTES_REF="refs/notes/wrong" git log -1 > output &&
+	GIT_NOTES_REF="refs/notes/wrong" git log -1 >output &&
 	test_cmp expect-not-other output
 '
 
-cat > expect-both << EOF
+cat >expect-both <<EOF
 commit 387a89921c73d7ed72cd94d179c1c7048ca47756
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:18:13 2005 -0700
@@ -655,14 +653,14 @@ test_expect_success 'Show all notes when notes.displayRef=refs/notes/*' '
 	GIT_NOTES_REF=refs/notes/commits git notes add -m"order test" &&
 	git config --unset core.notesRef &&
 	git config notes.displayRef "refs/notes/*" &&
-	git log -2 > output &&
+	git log -2 >output &&
 	test_cmp expect-both output
 '
 
 test_expect_success 'core.notesRef is implicitly in notes.displayRef' '
 	git config core.notesRef refs/notes/commits &&
 	git config notes.displayRef refs/notes/other &&
-	git log -2 > output &&
+	git log -2 >output &&
 	test_cmp expect-both output
 '
 
@@ -670,11 +668,11 @@ test_expect_success 'notes.displayRef can be given more than once' '
 	git config --unset core.notesRef &&
 	git config notes.displayRef refs/notes/commits &&
 	git config --add notes.displayRef refs/notes/other &&
-	git log -2 > output &&
+	git log -2 >output &&
 	test_cmp expect-both output
 '
 
-cat > expect-both-reversed << EOF
+cat >expect-both-reversed <<EOF
 commit 387a89921c73d7ed72cd94d179c1c7048ca47756
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:18:13 2005 -0700
@@ -692,7 +690,7 @@ test_expect_success 'notes.displayRef respects order' '
 	git config core.notesRef refs/notes/other &&
 	git config --unset-all notes.displayRef &&
 	git config notes.displayRef refs/notes/commits &&
-	git log -1 > output &&
+	git log -1 >output &&
 	test_cmp expect-both-reversed output
 '
 
@@ -700,11 +698,11 @@ test_expect_success 'GIT_NOTES_DISPLAY_REF works' '
 	git config --unset-all core.notesRef &&
 	git config --unset-all notes.displayRef &&
 	GIT_NOTES_DISPLAY_REF=refs/notes/commits:refs/notes/other \
-		git log -2 > output &&
+		git log -2 >output &&
 	test_cmp expect-both output
 '
 
-cat > expect-none << EOF
+cat >expect-none <<EOF
 commit 387a89921c73d7ed72cd94d179c1c7048ca47756
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:18:13 2005 -0700
@@ -720,16 +718,16 @@ EOF
 
 test_expect_success 'GIT_NOTES_DISPLAY_REF overrides config' '
 	git config notes.displayRef "refs/notes/*" &&
-	GIT_NOTES_REF= GIT_NOTES_DISPLAY_REF= git log -2 > output &&
+	GIT_NOTES_REF= GIT_NOTES_DISPLAY_REF= git log -2 >output &&
 	test_cmp expect-none output
 '
 
 test_expect_success '--show-notes=* adds to GIT_NOTES_DISPLAY_REF' '
-	GIT_NOTES_REF= GIT_NOTES_DISPLAY_REF= git log --show-notes=* -2 > output &&
+	GIT_NOTES_REF= GIT_NOTES_DISPLAY_REF= git log --show-notes=* -2 >output &&
 	test_cmp expect-both output
 '
 
-cat > expect-commits << EOF
+cat >expect-commits <<EOF
 commit 387a89921c73d7ed72cd94d179c1c7048ca47756
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:18:13 2005 -0700
@@ -741,41 +739,41 @@ Notes:
 EOF
 
 test_expect_success '--no-standard-notes' '
-	git log --no-standard-notes --show-notes=commits -1 > output &&
+	git log --no-standard-notes --show-notes=commits -1 >output &&
 	test_cmp expect-commits output
 '
 
 test_expect_success '--standard-notes' '
 	git log --no-standard-notes --show-notes=commits \
-		--standard-notes -2 > output &&
+		--standard-notes -2 >output &&
 	test_cmp expect-both output
 '
 
 test_expect_success '--show-notes=ref accumulates' '
 	git log --show-notes=other --show-notes=commits \
-		 --no-standard-notes -1 > output &&
+		 --no-standard-notes -1 >output &&
 	test_cmp expect-both-reversed output
 '
 
 test_expect_success 'Allow notes on non-commits (trees, blobs, tags)' '
 	git config core.notesRef refs/notes/other &&
-	echo "Note on a tree" > expect &&
+	echo "Note on a tree" >expect &&
 	git notes add -m "Note on a tree" HEAD: &&
-	git notes show HEAD: > actual &&
+	git notes show HEAD: >actual &&
 	test_cmp expect actual &&
-	echo "Note on a blob" > expect &&
+	echo "Note on a blob" >expect &&
 	filename=$(git ls-tree --name-only HEAD | head -n1) &&
 	git notes add -m "Note on a blob" HEAD:$filename &&
-	git notes show HEAD:$filename > actual &&
+	git notes show HEAD:$filename >actual &&
 	test_cmp expect actual &&
-	echo "Note on a tag" > expect &&
+	echo "Note on a tag" >expect &&
 	git tag -a -m "This is an annotated tag" foobar HEAD^ &&
 	git notes add -m "Note on a tag" foobar &&
-	git notes show foobar > actual &&
+	git notes show foobar >actual &&
 	test_cmp expect actual
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 commit 2ede89468182a62d0bde2583c736089bcf7d7e92
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:19:13 2005 -0700
@@ -787,18 +785,18 @@ Notes (other):
 EOF
 
 test_expect_success 'create note from other note with "git notes add -C"' '
-	: > a7 &&
+	: >a7 &&
 	git add a7 &&
 	test_tick &&
 	git commit -m 7th &&
 	git notes add -C $(git notes list HEAD^) &&
-	git log -1 > actual &&
+	git log -1 >actual &&
 	test_cmp expect actual &&
 	test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
 '
 
 test_expect_success 'create note from non-existing note with "git notes add -C" fails' '
-	: > a8 &&
+	: >a8 &&
 	git add a8 &&
 	test_tick &&
 	git commit -m 8th &&
@@ -814,7 +812,7 @@ test_expect_success 'create note from non-blob with "git notes add -C" fails' '
 	test_must_fail git notes list HEAD
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 commit 80d796defacd5db327b7a4e50099663902fbdc5c
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:20:13 2005 -0700
@@ -828,12 +826,12 @@ EOF
 test_expect_success 'create note from blob with "git notes add -C" reuses blob id' '
 	blob=$(echo "This is a blob object" | git hash-object -w --stdin) &&
 	git notes add -C $blob &&
-	git log -1 > actual &&
+	git log -1 >actual &&
 	test_cmp expect actual &&
 	test "$(git notes list HEAD)" = "$blob"
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 commit 016e982bad97eacdbda0fcbd7ce5b0ba87c81f1b
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:21:13 2005 -0700
@@ -845,17 +843,17 @@ Notes (other):
 EOF
 
 test_expect_success 'create note from other note with "git notes add -c"' '
-	: > a9 &&
+	: >a9 &&
 	git add a9 &&
 	test_tick &&
 	git commit -m 9th &&
 	MSG="yet another note" git notes add -c $(git notes list HEAD^^) &&
-	git log -1 > actual &&
+	git log -1 >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'create note from non-existing note with "git notes add -c" fails' '
-	: > a10 &&
+	: >a10 &&
 	git add a10 &&
 	test_tick &&
 	git commit -m 10th &&
@@ -863,7 +861,7 @@ test_expect_success 'create note from non-existing note with "git notes add -c"
 	test_must_fail git notes list HEAD
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 commit 016e982bad97eacdbda0fcbd7ce5b0ba87c81f1b
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:21:13 2005 -0700
@@ -878,11 +876,11 @@ EOF
 
 test_expect_success 'append to note from other note with "git notes append -C"' '
 	git notes append -C $(git notes list HEAD^) HEAD^ &&
-	git log -1 HEAD^ > actual &&
+	git log -1 HEAD^ >actual &&
 	test_cmp expect actual
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 commit ffed603236bfa3891c49644257a83598afe8ae5a
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:22:13 2005 -0700
@@ -895,11 +893,11 @@ EOF
 
 test_expect_success 'create note from other note with "git notes append -c"' '
 	MSG="other note" git notes append -c $(git notes list HEAD^) &&
-	git log -1 > actual &&
+	git log -1 >actual &&
 	test_cmp expect actual
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 commit ffed603236bfa3891c49644257a83598afe8ae5a
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:22:13 2005 -0700
@@ -914,11 +912,11 @@ EOF
 
 test_expect_success 'append to note from other note with "git notes append -c"' '
 	MSG="yet another note" git notes append -c $(git notes list HEAD) &&
-	git log -1 > actual &&
+	git log -1 >actual &&
 	test_cmp expect actual
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 commit 6352c5e33dbcab725fe0579be16aa2ba8eb369be
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:23:13 2005 -0700
@@ -932,24 +930,24 @@ $whitespace
 EOF
 
 test_expect_success 'copy note with "git notes copy"' '
-	: > a11 &&
+	: >a11 &&
 	git add a11 &&
 	test_tick &&
 	git commit -m 11th &&
 	git notes copy HEAD^ HEAD &&
-	git log -1 > actual &&
+	git log -1 >actual &&
 	test_cmp expect actual &&
 	test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
 '
 
 test_expect_success 'prevent overwrite with "git notes copy"' '
 	test_must_fail git notes copy HEAD~2 HEAD &&
-	git log -1 > actual &&
+	git log -1 >actual &&
 	test_cmp expect actual &&
 	test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 commit 6352c5e33dbcab725fe0579be16aa2ba8eb369be
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:23:13 2005 -0700
@@ -964,24 +962,24 @@ EOF
 
 test_expect_success 'allow overwrite with "git notes copy -f"' '
 	git notes copy -f HEAD~2 HEAD &&
-	git log -1 > actual &&
+	git log -1 >actual &&
 	test_cmp expect actual &&
 	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)"
 '
 
 test_expect_success 'cannot copy note from object without notes' '
-	: > a12 &&
+	: >a12 &&
 	git add a12 &&
 	test_tick &&
 	git commit -m 12th &&
-	: > a13 &&
+	: >a13 &&
 	git add a13 &&
 	test_tick &&
 	git commit -m 13th &&
 	test_must_fail git notes copy HEAD^ HEAD
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 commit e5d4fb5698d564ab8c73551538ecaf2b0c666185
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:25:13 2005 -0700
@@ -1009,13 +1007,13 @@ test_expect_success 'git notes copy --stdin' '
 	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^); \
 	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
 	git notes copy --stdin &&
-	git log -2 > output &&
+	git log -2 >output &&
 	test_cmp expect output &&
 	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)" &&
 	test "$(git notes list HEAD^)" = "$(git notes list HEAD~3)"
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:27:13 2005 -0700
@@ -1035,11 +1033,11 @@ test_expect_success 'git notes copy --for-rewrite (unconfigured)' '
 	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^); \
 	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
 	git notes copy --for-rewrite=foo &&
-	git log -2 > output &&
+	git log -2 >output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:27:13 2005 -0700
@@ -1069,7 +1067,7 @@ test_expect_success 'git notes copy --for-rewrite (enabled)' '
 	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^); \
 	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
 	git notes copy --for-rewrite=foo &&
-	git log -2 > output &&
+	git log -2 >output &&
 	test_cmp expect output
 '
 
@@ -1077,11 +1075,11 @@ test_expect_success 'git notes copy --for-rewrite (disabled)' '
 	git config notes.rewrite.bar false &&
 	echo $(git rev-parse HEAD~3) $(git rev-parse HEAD) |
 	git notes copy --for-rewrite=bar &&
-	git log -2 > output &&
+	git log -2 >output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:27:13 2005 -0700
@@ -1096,7 +1094,7 @@ test_expect_success 'git notes copy --for-rewrite (overwrite)' '
 	git notes add -f -m"a fresh note" HEAD^ &&
 	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
 	git notes copy --for-rewrite=foo &&
-	git log -1 > output &&
+	git log -1 >output &&
 	test_cmp expect output
 '
 
@@ -1104,11 +1102,11 @@ test_expect_success 'git notes copy --for-rewrite (ignore)' '
 	git config notes.rewriteMode ignore &&
 	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
 	git notes copy --for-rewrite=foo &&
-	git log -1 > output &&
+	git log -1 >output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:27:13 2005 -0700
@@ -1126,11 +1124,11 @@ test_expect_success 'git notes copy --for-rewrite (append)' '
 	git config notes.rewriteMode concatenate &&
 	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
 	git notes copy --for-rewrite=foo &&
-	git log -1 > output &&
+	git log -1 >output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:27:13 2005 -0700
@@ -1153,7 +1151,7 @@ test_expect_success 'git notes copy --for-rewrite (append two to one)' '
 	(echo $(git rev-parse HEAD^) $(git rev-parse HEAD);
 	echo $(git rev-parse HEAD^^) $(git rev-parse HEAD)) |
 	git notes copy --for-rewrite=foo &&
-	git log -1 > output &&
+	git log -1 >output &&
 	test_cmp expect output
 '
 
@@ -1161,11 +1159,11 @@ test_expect_success 'git notes copy --for-rewrite (append empty)' '
 	git notes remove HEAD^ &&
 	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
 	git notes copy --for-rewrite=foo &&
-	git log -1 > output &&
+	git log -1 >output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:27:13 2005 -0700
@@ -1180,11 +1178,11 @@ test_expect_success 'GIT_NOTES_REWRITE_MODE works' '
 	git notes add -f -m"replacement note 1" HEAD^ &&
 	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
 	GIT_NOTES_REWRITE_MODE=overwrite git notes copy --for-rewrite=foo &&
-	git log -1 > output &&
+	git log -1 >output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:27:13 2005 -0700
@@ -1202,7 +1200,7 @@ test_expect_success 'GIT_NOTES_REWRITE_REF works' '
 	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
 	GIT_NOTES_REWRITE_REF=refs/notes/commits:refs/notes/other \
 		git notes copy --for-rewrite=foo &&
-	git log -1 > output &&
+	git log -1 >output &&
 	test_cmp expect output
 '
 
@@ -1211,7 +1209,7 @@ test_expect_success 'GIT_NOTES_REWRITE_REF overrides config' '
 	git notes add -f -m"replacement note 3" HEAD^ &&
 	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
 	GIT_NOTES_REWRITE_REF= git notes copy --for-rewrite=foo &&
-	git log -1 > output &&
+	git log -1 >output &&
 	test_cmp expect output
 '
 
-- 
2.0.0.rc4.501.gdaf83ca
