Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070B2E1722
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787603820; cv=none; b=PbCZkBF4OCOMm0SAtPiiAbAPvfn9hhETWoXDaDELEK0/szfK8a90GkXchqunNPaqkDSKxemYUhbG3PxfRGXKUM/dTndlRQVYIaCQZlnStqITWqC3ZEYFS3TnU3x2YdlvttLKLdgHlSkTn0PuMGzLPQA+JeC21hV9k/YJmmrOhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787603820; c=relaxed/simple;
	bh=tSonwRa/hDsADyEvKq67gNWCmYbX1Xyo7AONvJhW6n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJXYhAfYvhuEGX2qZLsFlYQ/ICndfdZ11Rbjyf5Q8hgVtajlrZZIrV4b4ghma+TftVGh4vMOfe2gtsE2bSpZdm7nD4YgWVfs1OReQDmAT85f2re2Y+WF9xtvo7LJ4ZEjRrUQefqxBlbkx/XCDANy6YQJErgcZEDRcqsUSwAEfxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AMMpxyZE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aVk9P3ou; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AMMpxyZE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aVk9P3ou"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 54DDC7A012D;
	Mon, 24 Aug 2026 16:36:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 24 Aug 2026 16:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787603817;
	 x=1787690217; bh=X9Nr9QdMRkWHgiMFOnKMu55x0zLwh6znRRD6vP5en6c=; b=
	AMMpxyZEFOui6BemiAkWXgKj7+nUbi1fXgnl1CH/Yd4tojnOknJ7o+Kv62+PA1sl
	43uMq43nBM/NhczP9l1sJbaBGTkCg2hqSf8zzlZC/6uqeTnOHeWOKIRzxb7VghNS
	U4T5f6EKLfoDf1ZiYTeZaIvBoKcP7VKUKnSLaUS8+TAYr/dW4stbcH1yqK7E934n
	ieJG7Tp9s6civH1iQHr5OUaiuOZW/4IFoxMMtUCKdW/7RPWw44wzxKh6uVL6pO7/
	ka+pRVLkvRNB8wadytvWxjRbHWVZ463GWUq687Chtq1+CfP0zbm5GRRo9fDeOZ6Y
	WkA6oxWinHXbB0s/JX1Frg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787603817; x=
	1787690217; bh=X9Nr9QdMRkWHgiMFOnKMu55x0zLwh6znRRD6vP5en6c=; b=a
	Vk9P3ouDQl2zjUatiEEln/lPL390X7dFTPWOeFLxXCqkVP6xd/NfrHg6DXzRev4f
	/xujCzHsuNyhHZc5/MsaqwRdoItv35JIY8eCauQuonQeZX/fpCWDsAhGXatfU2AM
	BjCTz9YK+CwzwNf7CrnjGtWrzsfZLcFHp9ipReo36l5KjqqQf3uhGuILerftfmtS
	jjd4NZY4twbNmnCSTAxSAtLN01oxCZjnl61jysdR+ue0552mduPKe1mZKWV4q4JY
	qsipecslGNoiAUwrToPmw0fv81DLXJasMBu6GoSwOITQyPLmh1jhj5zOa8RBCXwq
	ez7nkqLJvUTZuwozNKb0A==
X-ME-Sender: <xms:aauMaqecMeNvAlce2iE8S4DRRpzxgyglDXARHhJmLxo46BqmbGfldxE>
    <xme:aauMaqNcZWPFSepgVw0lclkt5rcveIxLqJ81F0eLk9XsbW7yWuVscFZaz4ukHKS3I
    MzHTE7AnZma_OnVqzb-sM-nuNBoeCm-l7FnDt3wVSGlSfhJ3O5Z0Q>
X-ME-Received: <xmr:aauMapLZ71c1C9vi5H2dsuugUZR8MiefTgk7W6vbf9sGBKFJpd2ZD-cW15DDK0pmJReAWdyOxbaKvxZKrWJsir499NVDWXZZGjUUhiBDbcE-sw2IHtLYbdLW9Q>
X-ME-Proxy-Cause: dmFkZTGZw/2zxCYFxB6Ov3l+UAZo7B7N+uW9GbrrrGe3KyxGF4qPC4bWDvQuCrilNJkkiD
    SH8+1uPAeAbku1JDQGJPGg03ICkp1hSNHul0f4VhAFdaHoFLeMJsqRJGhvSafmFk4ueBI5
    L3YOCSTN5773dJ4fjYDvOtEcGNei2yPjpW2d+2aFgcyWgzg04EFiEsLvuCUwHxFgeB2VRi
    I+IQuTRL8HYKk1exnbQojd4tu2ag2+9TFw7oRyKLcFFThWUPTzz2FONY2/GPZQv3WYdMZO
    pUposAkgiFsDiDFBqplB8KHaeiOO3isT+C9zB8T5ppNepbd9pDfRmG/em5CCsx49O9lSCD
    qe80MdKLnS349bdmApDwRWxqI5VhgDBYGBEA+QtpChLLIWRXAmmkfAdJk8B8BoTrL6y0zK
    9Jon2COLlwjOBW52iQ+L/f31gbqLASC37mTT0sWG+ZbkF/Mf2KY/4tYifRgDuJjGPXMWhm
    qfU7G1t/7P34OKp1CV1zDDbWW0X/32BncWdCjqqE1dFMi54VsEWq5kY8bUMLGslNpJ565J
    vU8iRcyfmbQxScArlBEurxDCaqQ5gdV+YZMc5SjR87OJ/5K0OQR7L73oEqKRnawZQvxCjg
    2cR1NGMko+xdMkApMNdm1o9IvB3VIwJfBk4Y2+Uwsk+XhpO/wHX+PJwxxmPA
X-ME-Proxy: <xmx:aauMajEYC0VFTHK60TfgsqQV9TRejLHEpnWYzoB8SBQR7wz-OoJQCA>
    <xmx:aauMapTQZxKBm6N9VnOwO7_qinnzxnwJrBFtx2-5-PmXpcNUZS1MQg>
    <xmx:aauManGyoFk0JNrkfqo-T1lLROsXf4Fo-O4lUkzz11vQ69EoWHiZqA>
    <xmx:aauMat8yfuOsJkCE4Uci4qHH7Pmflk5NV9rzByFx8BTjysXxHSxVMQ>
    <xmx:aauMal0KLc9GvLbWm-G8Y2RmS0fCn8rosVF2y-DoEpnNVgboAL_sGAoi>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 16:36:56 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 3/3] format-patch: learn --[no-]range-diff-notes
Date: Mon, 24 Aug 2026 22:35:44 +0200
Message-ID: <format-patch_learn_--range-diff-notes.c5a@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

git-format-patch(1) passes on the notes behavior that it is using for
the patches to git-range-diff(1). In turn you get the same Git notes
displayed in the range diff as the ones you used to generate the
patches. And that makes sense in most cases.

However, I often make notes between series versions that mostly prepend
to the original. They end up looking like this:

    v3:
    [desc.]
    v2:
    [descr.]
    v1:
    [descr.]

These notes are meant for the git-format-patch(1) output since they
document the iterations. But including them also includes them in the
range diff. And they have nothing useful to say there.

So it would be useful to turn off range diff notes handling with
something like `--no-range-diff-notes`. This could then be turned on
again with `--range-diff-notes`.

An off/on switch is enough for this behavior. However, a bare (no arg)
option (together with the negation) is not consistent with `--[no-]notes
[=<ref>]` and could cause confusion. And we are both conceptually and
literally constructing an argument list to pass on to git-range-diff(1),
which does have the same option format as git-format-patch(1). Moreover,
it is useful to be able to specify exactly what notes you want
git-format-patch(1) and git-range-diff(1) to use.[1] So let’s generalize
it so that you can pass in whatever notes refs you want.

But now we are faced with a problem that `--notes` does not have; how do
we distinguish an empty `struct string_list` meaning these two things?:

• No such options given
• `--no-range-diff-notes`

Well, we can’t. Therefore we need `rdiff_override_notes` to set whenever
any of these options are given.

However, we may also want to turn *off* this override. Just like how we
can countermand any notes ref we pass in:

    --notes=custom --no-notes

To that end, let’s make `--range-diff-notes` when the list of options is
empty special. Then it means: go back to using whatever git-format-
patch(1) wants to use.

Now, `--notes` is a bit special in that it has an optional
argument. Implementing this with a parse-options callback is not
user-friendly; the following does *not* mean what it looks like:

    --parse-option --another-option

Namely, it is not a bare `--parse-option` followed by another
option. Rather, it’s one option:

    --parse-option=--another-option

And we need the bare `--range-diff-notes` form in order to turn off
notes overriding. For that reason, let’s implement these new options in
`revision.c:handle_revision_opt`, just like the `--notes` options are.

† 1: For example, let say we have two notes ref that are used for a
     patch series:

     1. testing. What the user has done to test this iteration.
     2. changelog. The same example from the introduction.

     You could include both notes on the patches but only show `testing` in
     the range diff.

***

Note that using `--creation-factor` without `--range-diff` will cause
the command to die. But this is not the case for `--[no-]range-diff-
notes`. Yes, we could introduce struct member `rdiff_notes_arg_used` or
something in order to detect the same condition. Or turn `rdiff_notes_
override` into a tri-state `int`. But the extra code is not worth that
in my opinion.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (testing):
    CI: https://github.com/LemmingAvalanche/git/actions/runs/32762207178

 Documentation/git-format-patch.adoc |  17 +++++
 builtin/log.c                       |   5 +-
 revision.c                          |  13 ++++
 revision.h                          |   5 ++
 t/t3206-range-diff.sh               | 105 ++++++++++++++++++++++++++++
 5 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 191f64b77d1..e0ba435dfcf 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -378,6 +378,23 @@ case is to show comparison with an older iteration of the same
 topic and the tool should find more correspondence between the two
 sets of patches.
 
+`--range-diff-notes[=<ref>]`::
+`--no-range-diff-notes`::
+	Used with `--range-diff`, tweak what notes to display in the
+	range diff. For example, you can use `--no-range-diff-notes` to
+	turn off all notes in the range diff. The default behavior is
+	to display the same notes in the range diff as on the patches
+	(see `--notes`).
++
+You may want to turn off this notes override after it has been
+activated. Use this sequence to do that:
++
+----
+--no-range-diff-notes --range-diff-notes
+----
++
+Now the range diff is back to displaying the same notes as the patches.
+
 `--notes[=<ref>]`::
 `--no-notes`::
 	Append the notes (see linkgit:git-notes[1]) for the commit
diff --git a/builtin/log.c b/builtin/log.c
index 28a93c45463..de997bc9ab0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1335,7 +1335,10 @@ static int get_notes_refs(struct string_list_item *item, void *arg)
 
 static void get_notes_args(struct rev_info *rev)
 {
-	if (!rev->show_notes) {
+	if (rev->rdiff_override_notes) {
+		if (!rev->rdiff_notes_arg.nr)
+			strvec_push(&rev->rdiff_notes_arg, "--no-notes");
+	} else if (!rev->show_notes) {
 		strvec_push(&rev->rdiff_notes_arg, "--no-notes");
 	} else if (rev->notes_opt.use_default_notes > 0 ||
 		   (rev->notes_opt.use_default_notes == -1 &&
diff --git a/revision.c b/revision.c
index 50dc8b19913..1e21f2861cc 100644
--- a/revision.c
+++ b/revision.c
@@ -2625,6 +2625,19 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->notes_opt.use_default_notes = 1;
 	} else if (!strcmp(arg, "--no-standard-notes")) {
 		revs->notes_opt.use_default_notes = 0;
+	} else if (!strcmp(arg, "--no-range-diff-notes")) {
+		strvec_clear(&revs->rdiff_notes_arg);
+		revs->rdiff_override_notes = 1;
+	} else if (!strcmp(arg, "--range-diff-notes")) {
+		/*
+		 * Allow the user to use '--no-range-diff-notes
+		 * --range-diff-notes' in order to go back to
+		 * using the 'format-patch' notes behavior
+		 */
+		revs->rdiff_override_notes = revs->rdiff_notes_arg.nr;
+	} else if (skip_prefix(arg, "--range-diff-notes=", &optarg)) {
+		strvec_pushf(&revs->rdiff_notes_arg, "--notes=%s", optarg);
+		revs->rdiff_override_notes = 1;
 	} else if (!strcmp(arg, "--oneline")) {
 		revs->verbose_header = 1;
 		get_commit_format("oneline", revs);
diff --git a/revision.h b/revision.h
index 39cca04d9e5..e8dbf774b00 100644
--- a/revision.h
+++ b/revision.h
@@ -351,6 +351,11 @@ struct rev_info {
 	/* range-diff */
 	const char *rdiff1;
 	const char *rdiff2;
+	/*
+	 * whether to use 'rdiff_notes_arg' or inherited
+	 * notes behavior
+	 */
+	bool rdiff_override_notes;
 	struct strvec rdiff_notes_arg;
 	int creation_factor;
 	const char *rdiff_title;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index ef92704de39..db238d0a5a1 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -845,6 +845,111 @@ test_expect_success 'format-patch --range-diff with multiple notes' '
 	test_cmp expect actual
 '
 
+test_expect_success 'format-patch --range-diff --notes=custom --no-range-diff-notes' '
+	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
+	git notes --ref=custom add -m "topic note1" topic &&
+	git notes --ref=custom add -m "unmodified note1" unmodified &&
+	test_when_finished "rm -f 000?-*" &&
+	git format-patch --range-diff=$prev --notes=custom \
+		--no-range-diff-notes --cover-letter \
+		main..unmodified >actual &&
+	test_grep "^Notes (custom):" 0004-* &&
+	test_grep "^Range-diff:" 0000-cover-letter* &&
+	test_grep ! "## Notes (custom) ##" 0000-cover-letter*
+'
+
+test_expect_success 'format-patch --range-diff --range-diff-notes uses --notes behavior' '
+	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
+	git notes --ref=custom add -m "topic note1" topic &&
+	git notes --ref=custom add -m "unmodified note1" unmodified &&
+	test_when_finished "rm -f 000?-*" &&
+	git format-patch --range-diff=$prev --notes=custom \
+		--range-diff-notes --cover-letter \
+		main..unmodified >actual &&
+	test_grep "^Notes (custom):" 0004-* &&
+	test_grep "^Range-diff:" 0000-cover-letter* &&
+	test_grep "## Notes (custom) ##" 0000-cover-letter*
+'
+
+test_expect_success 'format-patch --range-diff --notes=patch --range-diff-notes=rdiff' '
+	test_when_finished "git notes --ref=patch remove topic unmodified || :" &&
+	git notes --ref=patch add -m "only for patch 1" topic &&
+	git notes --ref=patch add -m "only for patch 2" unmodified &&
+	test_when_finished "git notes --ref=rdiff remove topic unmodified || :" &&
+	git notes --ref=rdiff add -m "only for range diff 1" topic &&
+	git notes --ref=rdiff add -m "only for range diff 2" unmodified &&
+	test_when_finished "rm -f 000?-*" &&
+	git format-patch --range-diff=$prev --notes=patch \
+		--range-diff-notes=rdiff --cover-letter \
+		main..unmodified >actual &&
+	test_grep "^Notes (patch):" 0004-* &&
+	test_grep ! "^Notes (rdiff):" 0004-* &&
+	test_grep "^Range-diff:" 0000-cover-letter* &&
+	test_grep "## Notes (rdiff) ##" 0000-cover-letter* &&
+	test_grep ! "## Notes (patch) ##" 0000-cover-letter*
+'
+
+test_expect_success 'format-patch --range-diff --no-range-diff-notes --range-diff-notes uses --notes behavior' '
+	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
+	git notes --ref=custom add -m "topic note1" topic &&
+	git notes --ref=custom add -m "unmodified note1" unmodified &&
+	test_when_finished "rm -f 000?-*" &&
+	git format-patch --range-diff=$prev --notes=custom \
+		--no-range-diff-notes --range-diff-notes --cover-letter \
+		main..unmodified >actual &&
+	test_grep "^Notes (custom):" 0004-* &&
+	test_grep "^Range-diff:" 0000-cover-letter* &&
+	test_grep "## Notes (custom) ##" 0000-cover-letter*
+'
+
+test_expect_success 'format-patch --range-diff --range-diff-notes uses --notes behavior' '
+	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
+	git notes --ref=custom add -m "topic note1" topic &&
+	git notes --ref=custom add -m "unmodified note1" unmodified &&
+	test_when_finished "rm -f 000?-*" &&
+	git format-patch --range-diff=$prev --notes=custom \
+		--range-diff-notes --cover-letter \
+		main..unmodified >actual &&
+	test_grep "^Notes (custom):" 0004-* &&
+	test_grep "^Range-diff:" 0000-cover-letter* &&
+	test_grep "## Notes (custom) ##" 0000-cover-letter*
+'
+
+test_expect_success 'format-patch --range-diff --no-range-diff-notes does not use default notes' '
+	test_when_finished "git notes remove topic unmodified || :" &&
+	git notes add -m "topic note1" topic &&
+	git notes add -m "unmodified note1" unmodified &&
+	test_when_finished "rm -f 000?-*" &&
+	git format-patch --range-diff=$prev \
+		--no-range-diff-notes --cover-letter \
+		main..unmodified >actual &&
+	test_grep ! "^Notes:" 0004-* &&
+	test_grep "^Range-diff:" 0000-cover-letter* &&
+	test_grep ! "## Notes ##" 0000-cover-letter*
+'
+
+test_expect_success 'format-patch --range-diff --no-range-diff-notes on single patch' '
+	test_when_finished "git notes --ref=custom remove HEAD unmodified || :" &&
+	git notes --ref=custom add -m "topic note (custom)" HEAD &&
+	git notes --ref=custom add -m "unmodified note (custom)" unmodified &&
+	git format-patch --notes=custom --range-diff=$prev \
+		--no-range-diff-notes -1 --stdout >actual &&
+	test_grep "Notes (custom):" actual &&
+	test_grep "^Range-diff:" actual &&
+	test_grep ! "## Notes (custom) ##" actual
+'
+
+test_expect_success 'format-patch --range-diff --range-diff-notes=custom on single patch' '
+	test_when_finished "git notes --ref=custom remove HEAD unmodified || :" &&
+	git notes --ref=custom add -m "topic note (custom)" HEAD &&
+	git notes --ref=custom add -m "unmodified note (custom)" unmodified &&
+	git format-patch --no-notes --range-diff=$prev \
+		--range-diff-notes=custom -1 --stdout >actual &&
+	test_grep ! "Notes (custom):" actual &&
+	test_grep "^Range-diff:" actual &&
+	test_grep "## Notes (custom) ##" actual
+'
+
 test_expect_success '--left-only/--right-only' '
 	git switch --orphan left-right &&
 	test_commit first &&
-- 
2.55.0.13.g85d2d65e389

