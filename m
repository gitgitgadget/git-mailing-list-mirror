Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8B6C43219
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 16:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbiKNQwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 11:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbiKNQvn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 11:51:43 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C7F2D7
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 08:51:41 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id y14so29822950ejd.9
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 08:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BWrNvbOPgrkCZ2kYml+lMrANSYBccFOAOHb0dT9mD9w=;
        b=NG2Y/qoaQd+V0fGwdd0nyz7ixm4j3jWVfY57cYq+veCugDtp7guRxavB9r8iWwWUj1
         Re6JMeHLnoqJ6UrEy9FuncLFOFCQMFMaykbXzeqtKlL/fmIvP3rpsAJpWiQ85WVc6L0Q
         /hK/nqVHDs/hh9a4ULWqhQym3NNhKx48GhP39NyLWTrdcLrVcIDclYMnYuOhVs/BlsTv
         LEoKPiILxE1aWWYp4sWoaMswrk1N49z8DGZdvibBPl3US863BcIAiM6+rynltJMkO/AF
         lVAsiAvbhQhzVX3VZltwIv1EOuMmWhsEAH2mHnG5efKg+kvwwn0vS2oagH/QuoaXF6qJ
         fECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BWrNvbOPgrkCZ2kYml+lMrANSYBccFOAOHb0dT9mD9w=;
        b=XPC31itVDLGc7nKPHChiInIop5zQWAZwsSQEUT/Ymzv1U9cwcvF5oMU3a1Wwxdmgr4
         O5Eulb00xdnwJzLNacEBSaiqXTIoFYThMdsfBlrxLVxmTuFldeAQ5EaYp/o20+h82SW8
         6hySAIgPuhNbMeE5NDqNBLB1mhCS8tRi6x6Xg/jmSI/MhRInBB7HoUEjTlCPjC8/4NNH
         P6rz3c2Gy2Y8ENRYMe44PiWHcUvAuR2Bkl6TpVERWC7mVy9oLhJesp1PAGucufsq2Y2K
         htbsh4ANYOf7Z8dExY12ef80oJFcN7GFmWXd72Pwr+fu8B+4rPYxHIGwjDyVSm/eniv6
         Rhhg==
X-Gm-Message-State: ANoB5plyDdEkhoKO7vm+u4nIVXNfwpD4LGoUnD1VbSTwyTwrAElydXXx
        /8Jig1wMmo4yHoVohgs/+TY=
X-Google-Smtp-Source: AA0mqf71xzsDTkgJ//1K+3gUPuH353hwWErGOFMG/gU6xKfKdkj5covI7D1KoH5KMk5hoaM+ICzeAg==
X-Received: by 2002:a17:907:6f1a:b0:78d:981a:d997 with SMTP id sy26-20020a1709076f1a00b0078d981ad997mr11327068ejc.654.1668444699499;
        Mon, 14 Nov 2022 08:51:39 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ky14-20020a170907778e00b0078afe360800sm4347876ejc.199.2022.11.14.08.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:51:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oucgM-003GZw-0n;
        Mon, 14 Nov 2022 17:51:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Date:   Mon, 14 Nov 2022 16:23:24 +0100
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
 <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
 <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
 <221114.86tu31lnwr.gmgdl@evledraar.gmail.com>
 <pss2rp96-qr48-21p4-36on-ns04nnp0944q@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pss2rp96-qr48-21p4-36on-ns04nnp0944q@tzk.qr>
Message-ID: <221114.86pmdplbs5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 14 2022, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Mon, 14 Nov 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> [...] before this we've been assuming that GIT_TEST_CMP is a not-ours
>> binary. I.e. "diff", "cmp" etc. If it is a "that's ours" this change
>> should be changing e.g. '! test_cmp' to 'test_cmp !', as the former
>> would now hide segfaults.
>
> The implied assumption of `test_cmp` is that the command is reliable, i.e.
> we are not expecting to test the code that runs the comparison itself.
>
> Originally, Junio shared your concern that `diff --no-index` might not be
> reliable enough, but that was "a lifetime ago". In
> https://lore.kernel.org/git/xmqqbkrpo9or.fsf@gitster.g/ he hinted that the
> `diff --no-index` code has matured enough to be considered reliable. That
> is far from the endorsement I would wish to have received (it would have
> been nice to see "I consider `git diff --no-index` to be reliable enough
> to serve as `mingw_test_cmp`", for example), but I believe it is the
> clearest statement I will get in that regard.

I don't see a mention of reliability in the original 2007 thread, just
optimization v.s. "cmp". But the list archive seems to only carry the
CL, perhaps it was in that 7/8 or 8/8 patch?

In any case, that's different than what I'm pointing out, which is:

I fully trust "git diff --no-index" these days *in general* to serve as
a "/usr/bin/diff -u" replacement, but *only* as long as it's the
"/usr/bin/git" version of "git diff", and not the "git" we just built
in-tree.

IOW this bit in t/README:

 - Don't use '! git cmd' when you want to make sure the git command
   exits with failure in a controlled way by calling "die()".[...]

So, before this series a test like this on Windows, with
GIT_TEST_CMP=3Dmingw_test_cmp:

	! test_cmp foo bar

Would only succeed if "foo" and "bar" weren't identical, now it'll also
succeed if 'git diff --no-index' happens to segfault on those inputs.

Now, the good thing is that the fallout of this should be relatively
contained in this case. We'd only get those cases sneaking in if it's in
the Windows-only code, as we use "/usr/bin/diff -u" elsewhere.

I think the diff here at the end (on top af master, but you get the
idea) is what you'd need to stop conflating those. Most of it's just
's/! test_cmp/test_cmp !/g'.

The "test_cmp" then learns to distinguish between "a git" command and
"not a git". I guess we could use test_must_fail_acceptable() there to
to make this DWYM...

>> Additionally: We don't *need* this for an initial implementation, but
>> having e.g. one of the Ubuntu CI targets run with "git diff --no-index"
>> would be a nice cherry on top,
>
> Why would this be a nice cherry on top?
>
> From my perspective, it would co-opt unrelated test cases into the task of
> validating `diff --no-index`' correctness.
>
> Such a loss of focus in test cases makes it harder to diagnose, debug and
> fix breakages. And it would mean that a single bug could make gazillions
> of test cases fail. That would be bad practice, of course.

Yeah, probably not worth it. It would illustrate which
--ignore-cr-at-eol is just due to test_cmp v.s. test_cmp_bin semantics
on *nix though. E.g. in addition to the below this makes things pass
without --ignore-cr-at-eol for me (aside from the t0001-init.sh failure
I noted in the v2 feedback):

	diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
	index 7b5423eebda..f2e6b7a078c 100755
	--- a/t/t0061-run-command.sh
	+++ b/t/t0061-run-command.sh
	@@ -72,7 +72,7 @@ test_expect_success 'run_command does not try to execute=
 a directory' '
=09=20
	 	PATH=3D$PWD/bin1:$PWD/bin2:$PATH \
	 		test-tool run-command run-command greet >actual 2>err &&
	-	test_cmp bin2/greet actual &&
	+	test_cmp_bin bin2/greet actual &&
	 	test_must_be_empty err
	 '
=09=20
	@@ -89,7 +89,7 @@ test_expect_success POSIXPERM 'run_command passes over n=
on-executable file' '
=09=20
	 	PATH=3D$PWD/bin1:$PWD/bin2:$PATH \
	 		test-tool run-command run-command greet >actual 2>err &&
	-	test_cmp bin2/greet actual &&
	+	test_cmp_bin bin2/greet actual &&
	 	test_must_be_empty err
	 '
=09=20
	diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
	index 497b62868d4..4001ac24adf 100755
	--- a/t/t4120-apply-popt.sh
	+++ b/t/t4120-apply-popt.sh
	@@ -83,7 +83,7 @@ test_expect_success 'apply (-p2) diff, rename' '
	 	cp file1.saved file1 &&
	 	rm -f file2 &&
	 	git apply -p2 patch.rename &&
	-	test_cmp expected file2
	+	test_cmp_bin expected file2
	 '
=09=20
	 test_done
	diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
	index 5d853225a93..4c64396ed15 100644
	--- a/t/test-lib-functions.sh
	+++ b/t/test-lib-functions.sh
	@@ -1163,9 +1163,9 @@ test_cmp () {
	 		if test -n "$negate"
	 		then
	 			test_expect_code 1 env GIT_DIR=3D/dev/null \
	-					 git diff --no-index --ignore-cr-at-eol -- "$@"
	+					 git diff --no-index -- "$@"
	 		else
	-			GIT_DIR=3D/dev/null git diff --no-index --ignore-cr-at-eol -- "$@"
	+			GIT_DIR=3D/dev/null git diff --no-index -- "$@"
	 		fi
	 	else
	 		if test -n "$negate"


>>  * If we're trusting "git diff --no-index" to run the tests, we could
>>    also get rid of "GIT_TEST_CMP_USE_COPIED_CONTEXT", whose only reason
>>    for existing is to support a system "diff" that doesn't understand
>>    "-u" (squashable diff below)
>
> Be my guest to contribute this once the current patch has made it to
> `next`. But please only then, we have enough friction on the Git mailing
> list and do not need to go out of our way to add more.

Yeah, we can leave the nice-to-haves for later, a "conflates files being
different with segfaults" really should be fixed though. And hopefully
the below helps.

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 1f6b9b08d1d..d26ed200cbf 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -304,7 +304,7 @@ check_access_log() {
 	sort "$1" >"$1".sorted &&
 	strip_access_log >access.log.stripped &&
 	sort access.log.stripped >access.log.sorted &&
-	if ! test_cmp "$1".sorted access.log.sorted
+	if test_cmp ! "$1".sorted access.log.sorted
 	then
 		test_cmp "$1" access.log.stripped
 	fi
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index abecd75e4e4..6e1e6c056ff 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -751,7 +751,7 @@ test_expect_success 'process filter should restart afte=
r unexpected write failur
 		test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
=20
 		# Smudge failed
-		! test_cmp smudge-write-fail.o smudge-write-fail.r &&
+		test_cmp ! smudge-write-fail.o smudge-write-fail.r &&
 		rot13.sh <smudge-write-fail.o >expected &&
 		git cat-file blob :smudge-write-fail.r >actual &&
 		test_cmp expected actual
diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index cd3969e852b..dfab275dbe6 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -14,7 +14,7 @@ test_expect_success 'setup: list of builtins' '
=20
 test_expect_success 'list of txt and help mismatches is sorted' '
 	sort -u "$TEST_DIRECTORY"/t0450/txt-help-mismatches >expect &&
-	if ! test_cmp expect "$TEST_DIRECTORY"/t0450/txt-help-mismatches
+	if test_cmp ! expect "$TEST_DIRECTORY"/t0450/txt-help-mismatches
 	then
 		BUG "please keep the list of txt and help mismatches sorted"
 	fi
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-chec=
kout-compatibility.sh
index 801919009e1..d11980916b0 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1214,7 +1214,7 @@ test_expect_success 'checkout-index with folders' '
 	# entry is a sparse directory.
 	run_on_all test_must_fail git checkout-index -f -- folder1/ &&
 	test_cmp full-checkout-err sparse-checkout-err &&
-	! test_cmp full-checkout-err sparse-index-err &&
+	test_cmp ! full-checkout-err sparse-index-err &&
 	grep "is a sparse directory" sparse-index-err
 '
=20
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index cf58cf025cd..14b6b58f531 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1403,7 +1403,7 @@ test_expect_success 'handle per-worktree refs in refs=
/bisect' '
 	test_must_fail git rev-parse refs/bisect/something &&
 	git update-ref refs/bisect/something HEAD &&
 	git rev-parse refs/bisect/something >main-head &&
-	! test_cmp main-head worktree-head
+	test_cmp ! main-head worktree-head
 '
=20
 test_expect_success 'transaction handles empty commit' '
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 7f605f865b3..dafb7860451 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -778,7 +778,7 @@ test_expect_success SYMLINKS 'git branch -m with symlin=
ked .git/refs' '
=20
 	git -C subdir rev-parse --absolute-git-dir >subdir.dir &&
 	git rev-parse --absolute-git-dir >our.dir &&
-	! test_cmp subdir.dir our.dir &&
+	test_cmp ! subdir.dir our.dir &&
=20
 	git -C subdir log &&
 	git -C subdir branch rename-src &&
diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
index fe72b247164..d2fba236a19 100755
--- a/t/t3207-branch-submodule.sh
+++ b/t/t3207-branch-submodule.sh
@@ -155,7 +155,7 @@ test_expect_success 'should create branches if branch e=
xists and --force is give
 		test_cmp expected actual-new-branch-a &&
 		# assert that branch --force actually moved the sub
 		# branch
-		! test_cmp expected actual-old-branch-a
+		test_cmp ! expected actual-old-branch-a
 	)
 '
=20
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index de1da4673da..3e7ceb27f3c 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2136,8 +2136,8 @@ test_expect_success 'format-patch --base' '
 	awk "{print \"prerequisite-patch-id:\", \$1}" <patch.id.raw >>fail &&
=20
 	signature >>fail &&
-	! test_cmp fail actual1 &&
-	! test_cmp fail actual2
+	test_cmp ! fail actual1 &&
+	test_cmp ! fail actual2
 '
=20
 test_expect_success 'format-patch --base errors out when base commit is in=
 revision list' '
diff --git a/t/t4125-apply-ws-fuzz.sh b/t/t4125-apply-ws-fuzz.sh
index 090987c89b2..d2e61579d0a 100755
--- a/t/t4125-apply-ws-fuzz.sh
+++ b/t/t4125-apply-ws-fuzz.sh
@@ -93,7 +93,7 @@ test_expect_success 'withfix (backward)' '
 	sed -n -e /h/p file-fixed >fixed-tail &&
 	sed -n -e /h/p file >file-tail &&
=20
-	! test_cmp fixed-tail file-tail
+	test_cmp ! fixed-tail file-tail
=20
 '
=20
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index cdad4b68807..8028aa2b712 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -837,7 +837,7 @@ test_expect_success 'am without --committer-date-is-aut=
hor-date' '
 	git cat-file commit HEAD | sed -e "/^\$/q" >head1 &&
 	sed -ne "/^author /s/.*> //p" head1 >at &&
 	sed -ne "/^committer /s/.*> //p" head1 >ct &&
-	! test_cmp at ct
+	test_cmp ! at ct
 '
=20
 # This checks for +0000 because TZ is set to UTC and that should
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index a7fa94ce0a2..edc11213a10 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -74,7 +74,7 @@ test_expect_success 'patch-id detects equality' '
 test_expect_success 'patch-id detects inequality' '
 	get_patch_id main &&
 	get_patch_id notsame &&
-	! test_cmp patch-id_main patch-id_notsame
+	test_cmp ! patch-id_main patch-id_notsame
 '
 test_expect_success 'patch-id detects equality binary' '
 	cat >.gitattributes <<-\EOF &&
@@ -100,7 +100,7 @@ test_expect_success 'patch-id detects inequality binary=
' '
 	EOF
 	get_patch_id main &&
 	get_patch_id notsame &&
-	! test_cmp patch-id_main patch-id_notsame &&
+	test_cmp ! patch-id_main patch-id_notsame &&
 	test_when_finished "rm .gitattributes"
 '
=20
@@ -126,7 +126,7 @@ cmp_patch_id () {
 	if
 		test "$1" =3D "relevant"
 	then
-		! test_cmp patch-id_"$2" patch-id_"$3"
+		test_cmp ! patch-id_"$2" patch-id_"$3"
 	else
 		test_cmp patch-id_"$2" patch-id_"$3"
 	fi
@@ -279,7 +279,7 @@ test_expect_success 'patch-id handles no-nl-at-eof mark=
ers' '
 	test_cmp patch-id_nonl patch-id_withnl &&
 	calc_patch_id nonl-inc-ws --verbatim <nonl &&
 	calc_patch_id withnl-inc-ws --verbatim <withnl &&
-	! test_cmp patch-id_nonl-inc-ws patch-id_withnl-inc-ws
+	test_cmp ! patch-id_nonl-inc-ws patch-id_withnl-inc-ws
 '
=20
 test_expect_success 'patch-id handles diffs with one line of before/after'=
 '
diff --git a/t/t5200-update-server-info.sh b/t/t5200-update-server-info.sh
index ed9dfd624c7..06e4ca7bdca 100755
--- a/t/t5200-update-server-info.sh
+++ b/t/t5200-update-server-info.sh
@@ -26,7 +26,7 @@ test_expect_success 'info/refs is not needlessly overwrit=
ten' '
 test_expect_success 'info/refs can be forced to update' '
 	git update-server-info -f &&
 	test-tool chmtime --get .git/info/refs >b &&
-	! test_cmp a b
+	test_cmp ! a b
 '
=20
 test_expect_success 'info/refs updates when changes are made' '
@@ -36,7 +36,7 @@ test_expect_success 'info/refs updates when changes are m=
ade' '
 	git update-ref refs/heads/foo HEAD &&
 	git update-server-info &&
 	test-tool chmtime --get .git/info/refs >b &&
-	! test_cmp a b
+	test_cmp ! a b
 '
=20
 test_done
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 6d693eef82f..9718f0ab12a 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -400,7 +400,7 @@ test_bitmap_cases () {
 			test-tool bitmap list-commits | sort >bitmaps &&
 			comm -13 bitmaps commits >after &&
=20
-			! test_cmp before after
+			test_cmp ! before after
 		)
 	'
=20
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 0882cbb6e4a..338ccd32fac 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -186,7 +186,7 @@ test_midx_bitmap_cases () {
 			test-tool bitmap list-commits | sort >bitmaps &&
 			comm -13 bitmaps commits >after &&
=20
-			! test_cmp before after
+			test_cmp ! before after
 		)
 	'
=20
@@ -268,7 +268,7 @@ test_midx_bitmap_cases () {
 			test-tool bitmap list-commits | sort >bitmaps &&
 			comm -13 bitmaps commits >after &&
=20
-			! test_cmp before after
+			test_cmp ! before after
 		)
 	'
=20
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 20d063fb9ae..7037335533c 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -111,7 +111,7 @@ test_expect_success 'use "origin" when no remote specif=
ied and multiple found' '
=20
 test_expect_success 'suppress "From <url>" with -q' '
 	git ls-remote -q 2>actual_err &&
-	! test_cmp exp_err actual_err
+	test_cmp ! exp_err actual_err
 '
=20
 test_expect_success 'use branch.<name>.remote if possible' '
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index 3126cfd7e9d..eeef68c9f3d 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -90,7 +90,7 @@ test_expect_success 'by default no tags will be kept upda=
ted' '
 		git for-each-ref refs/tags >../actual
 	) &&
 	git for-each-ref refs/tags >expect &&
-	! test_cmp expect actual &&
+	test_cmp ! expect actual &&
 	test_line_count =3D 2 actual
 '
=20
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 41d0ca00b1c..c927b0d9e62 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -538,7 +538,7 @@ test_expect_success '--abbrev' '
 	sed -e "s/$OID_REGEX/LONG/g" -e "s/$_x05/SHORT/g" <actual3 >fuzzy3 &&
 	test_cmp expect2 fuzzy2 &&
 	test_cmp expect3 fuzzy3 &&
-	! test_cmp actual1 actual2
+	test_cmp ! actual1 actual2
 '
=20
 test_expect_success '%H is not affected by --abbrev-commit' '
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index 523efbecde1..d4819317649 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -24,7 +24,7 @@ verify_expect () {
 	git status --porcelain -- fileA.t fileB.t fileC.t fileD.t >actual &&
 	if test "x$1" =3D 'x!'
 	then
-		! test_cmp expect actual
+		test_cmp ! expect actual
 	else
 		test_cmp expect actual
 	fi
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index eae6a46ef3d..904f91fc4bc 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -451,7 +451,7 @@ test_expect_success 'status from subdirectory should ha=
ve the same SHA1' '
 		git submodule status >output &&
 		awk "{print \$1}" <output >expect2 &&
 		test_cmp expect2 actual2 &&
-		! test_cmp actual actual2
+		test_cmp ! actual actual2
 	)
 '
=20
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 2b7ef6c41a4..fb3d51de13d 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1510,7 +1510,7 @@ test_expect_success '"status.branch=3Dtrue" same as "=
-b"' '
 test_expect_success '"status.branch=3Dtrue" different from "--no-branch"' '
 	git status -s --no-branch  >expected_nobranch &&
 	git -c status.branch=3Dtrue status -s >actual &&
-	! test_cmp expected_nobranch actual
+	test_cmp ! expected_nobranch actual
 '
=20
 test_expect_success '"status.branch=3Dtrue" weaker than "--no-branch"' '
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 7c3f6ed9943..acdf91a77a2 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -1059,7 +1059,7 @@ test_expect_success 'merge --quit' '
 		test_path_is_missing .git/MERGE_MSG &&
 		git rerere status >rerere.after &&
 		test_must_be_empty rerere.after &&
-		! test_cmp rerere.after rerere.before
+		test_cmp ! rerere.after rerere.before
 	)
 '
=20
diff --git a/t/t7606-merge-custom.sh b/t/t7606-merge-custom.sh
index 81fb7c474c1..687dbcc9d23 100755
--- a/t/t7606-merge-custom.sh
+++ b/t/t7606-merge-custom.sh
@@ -55,7 +55,7 @@ test_expect_success 'merge c2 with a custom strategy' '
 	git diff --exit-code c2 HEAD &&
 	git diff --exit-code c2 &&
=20
-	! test_cmp head.old head.new &&
+	test_cmp ! head.old head.new &&
 	test_cmp head.old first-parent &&
 	test_cmp second-parent.expected second-parent &&
 	test_cmp tree.expected tree &&
@@ -81,7 +81,7 @@ test_expect_success 'trivial merge with custom strategy' '
 	git diff --exit-code c3 HEAD &&
 	git diff --exit-code c3 &&
=20
-	! test_cmp head.old head.new &&
+	test_cmp ! head.old head.new &&
 	test_cmp head.old first-parent &&
 	test_cmp second-parent.expected second-parent &&
 	test_cmp tree.expected tree &&
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 5be483bf887..a1d62e8566c 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -365,7 +365,7 @@ test_expect_success '--write-midx with preferred bitmap=
 tips' '
 		test-tool bitmap list-commits | sort >bitmaps &&
 		comm -13 bitmaps commits >after &&
=20
-		! test_cmp before after
+		test_cmp ! before after
 	)
 '
=20
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index b18633dee1b..d8f26d1197b 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -184,10 +184,10 @@ test_expect_success mark_ignored_lines '
 	test_cmp expect actual &&
=20
 	sed -n "3p" blame_raw | cut -c1 >actual &&
-	! test_cmp expect actual &&
+	test_cmp ! expect actual &&
=20
 	sed -n "4p" blame_raw | cut -c1 >actual &&
-	! test_cmp expect actual
+	test_cmp ! expect actual
 '
=20
 # For ignored revs that added 'unblamable' lines and more recent commits c=
hanged
diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommi=
t-concurrent.sh
index 1465156072e..53f240e45cf 100755
--- a/t/t9164-git-svn-dcommit-concurrent.sh
+++ b/t/t9164-git-svn-dcommit-concurrent.sh
@@ -94,7 +94,7 @@ test_expect_success 'check if post-commit hook creates a =
concurrent commit' '
 		echo 1 >> file &&
 		svn_cmd commit -m "changing file" &&
 		svn_cmd up &&
-		! test_cmp auto_updated_file au_file_saved
+		test_cmp ! auto_updated_file au_file_saved
 	)
 '
=20
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymi=
ze.sh
index 77047e250dc..29a2d3a03a7 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -133,7 +133,7 @@ test_expect_success 'idents are shared' '
 	git log --all --format=3D"%cn <%ce>" >committers &&
 	sort -u committers >unique &&
 	test_line_count =3D 1 unique &&
-	! test_cmp authors committers
+	test_cmp ! authors committers
 '
=20
 test_done
diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index 5fe83315ecd..6fdfa7d5855 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -68,7 +68,7 @@ scrub_k_check () {
 	file=3D"$1" &&
 	scrub=3D"$TRASH_DIRECTORY/$file" &&
 	"$PYTHON_PATH" "$TRASH_DIRECTORY/scrub_k.py" <"$git/$file" >"$scrub" &&
-	! test_cmp "$cli/$file" "$scrub" &&
+	test_cmp ! "$cli/$file" "$scrub" &&
 	test_cmp "$git/$file" "$scrub" &&
 	rm "$scrub"
 }
@@ -76,7 +76,7 @@ scrub_ko_check () {
 	file=3D"$1" &&
 	scrub=3D"$TRASH_DIRECTORY/$file" &&
 	"$PYTHON_PATH" "$TRASH_DIRECTORY/scrub_ko.py" <"$git/$file" >"$scrub" &&
-	! test_cmp "$cli/$file" "$scrub" &&
+	test_cmp ! "$cli/$file" "$scrub" &&
 	test_cmp "$git/$file" "$scrub" &&
 	rm "$scrub"
 }
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 796093a7b32..5d853225a93 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1148,8 +1148,33 @@ test_expect_code () {
 # - not all diff versions understand "-u"
=20
 test_cmp () {
-	test "$#" -ne 2 && BUG "2 param"
-	eval "$GIT_TEST_CMP" '"$@"'
+	test "$#" -lt 2 && BUG "2..3 param"
+	test "$#" -gt 3 && BUG "2..3 param"
+
+	local negate=3D
+	if test "$#" =3D 3 && test "$1" =3D "!"
+	then
+		negate=3Dt
+		shift
+	fi
+
+	if test "$GIT_TEST_CMP" =3D "builtin:git-no-index"
+	then
+		if test -n "$negate"
+		then
+			test_expect_code 1 env GIT_DIR=3D/dev/null \
+					 git diff --no-index --ignore-cr-at-eol -- "$@"
+		else
+			GIT_DIR=3D/dev/null git diff --no-index --ignore-cr-at-eol -- "$@"
+		fi
+	else
+		if test -n "$negate"
+		then
+			! "$GIT_TEST_CMP" "$@"
+		else
+			"$GIT_TEST_CMP" "$@"
+		fi
+	fi
 }
=20
 # Check that the given config key has the expected value.
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6db377f68b8..3028283f307 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1721,7 +1721,7 @@ case $uname_s in
 	test_set_prereq SED_STRIPS_CR
 	test_set_prereq GREP_STRIPS_CR
 	test_set_prereq WINDOWS
-	GIT_TEST_CMP=3Dmingw_test_cmp
+	GIT_TEST_CMP=3Dbuiltin:git-no-index
 	;;
 *CYGWIN*)
 	test_set_prereq POSIXPERM
