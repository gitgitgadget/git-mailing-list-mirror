Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDDA448392
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136787; cv=none; b=XlL4MOU/9CA26nIU5ugKNt51VTb7h6aCq2zlMovq3JLGswH2q2xh7QayMNp98mYD5NKNWPQ4N12hb2XXzkGa2ARG0IHO2NyDW1Um2w/Fqm+gYStWC2eZGVh7mkt6+hlVqCr7CmACkUzpJTFY20qa+seedkD/aRDKa6GMrlQkjtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136787; c=relaxed/simple;
	bh=jkm76RSWfk2boRlMhTsm6E1IZQeP3V5bv0OpLaMIrjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1ZsIZxwPTpbfpCfFAV4Bqqn6ug8dlO7pMqot52W15wt0g5HWAohuGrbTY1JpMlemrVC5+5sSctmCnEk66r4C1xh7En/mqoynoVfvru9csGxXZzU12hmVe7tLXDs25Kl4UptoSEHf+OPIqv6CuSZMvyHPQJtTvseKG1es61ov9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ss6m2sMo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tU0RCQFN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ss6m2sMo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tU0RCQFN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 920C414000F2
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 13:59:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 04 Oct 2026 13:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791136779;
	 x=1791223179; bh=vRcFP6UhcvDMsjkjPWWlqbwZQz/z+PHzvdZ4GcLhsmo=; b=
	Ss6m2sMoTjUUZaK1cWqE7sVp3FGvRksIwG8Be5xs/I25Gb7eoyJm6XAnv59NnhFz
	N3zoKtCbWFt6iY1nowRR5XX7nvzhATGIZ16YWOcRa2CkeGSZfjGXBRWLk0IIPG7X
	lClAcB+PZI7gHbL3zXVo2FTcTq/U3WNkf90HJHzHEnw7onMwaXNQP+rHVGeIjR7B
	S8tbjdq/8sLmuIthXr7NtyaZZC+PZtmVNvBdX6UFBOPY2kNQmfDc17NDPr9dQxDF
	1EWBJdosiAV1Kn5Ktdq1QUl9KpyFv6KaiIM2isjNc0xYtZ3P8PNLF7zM+NckwNmX
	yBZwBqt0Zw8WsO0rhc+wIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791136779; x=
	1791223179; bh=vRcFP6UhcvDMsjkjPWWlqbwZQz/z+PHzvdZ4GcLhsmo=; b=t
	U0RCQFNw1YdRVGzoMeS0zkmrN5u0uJYYfm1pnYwsVhz0typlvKUiGoNQ80AQT9Cv
	OXBvt6J4QQXDnxY83tQaz3VgW/MzTnWV9gJ5dWIO2VwrFjIZjNP4qNSq1QKD1oXt
	Fbqpb3a0snQLsR6BrjvbHMJIX1YyTO9IbT7wRaCz0f80sNuY/azu70fQbrRYCiRN
	+XPjciY2Edam7Y13x3YJDOOIBAHICIzv6rM0FWr2DvOa55VFFjwTQeRQXY8qwiWe
	TrylYKAO5eLEmF+C8eyxS7GL62/1bXBk+CfvxXl7XWBBk/BEmA/0vVPraGlUUN/y
	sPDJBv5X/O8oMsPOxIxvA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791136779; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:drAXRIROGfFjaWkbmoOnaFqLdRE0Hi2mWUWQpe1h+RJrb2L
	MKb9x1/VZsYHnqHgNAq6Ff7pDbA7QUUGwyoOMFdAsi8D9tw1j0Qv80kFJUpQTKxz
	exzxBIhFefCwsEYaMwzyxl3S8qRvUoxZfJyWNQcoz8uDYUiKw7J+6WbDtczH8GPy
	IbLeZHRQEJE6OJatIDIuOuSr4m75oCby1HQQpNxiaHWX8OiT3c8iL4nvX8I5nzqM
	gi8dQhLxbEBNaw4te/8S9eg1Ic3K1ynAlbL2ci9L0FHAMp0YWpQorKEEUS6u8iVt
	LbP/ECW36pCUn2Ll4x1qsBEFT+XIdY6/QkaW2eQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2/xnK+1C8RhjDsTaDfaTaKNelHMul7933ACeHsFK9IE=:jkm76RSWfk2boRlMhTsm6E1IZQeP3V5bv0OpLaMIrjU=;
X-ME-Sender: <xms:C5TCamo3prZLvgW-VRmUv6ZKkok1ouN0bSnnJlNMM7GBB9nyB1aSh2k>
    <xme:C5TCarqUdX930Z2S72iZr1bBR6KYJAXw_jCuJ3R3lHGl32i6148jtuxCoGClYJ19c
    phR6fOPbrXEXLyz0GZHupcPPrfUTeGDztcvtXPc3KKe8lwqimwgjK0>
X-ME-Received: <xmr:C5TCagN9Eb42lwq5f4y8hkhcfGd-SRk95Jd-UdImz--3swrx-B9mpio1vC5uy6HdfkJjFg-wdfEOdriHpRopQL3pQneLtRyZ-7w1NXmP3qVCWnDSHHZ4UZs>
X-ME-Proxy-Cause: dmFkZTENFgYuwOe1/FJ1rM5UVm9xDKw8RXCljyKpSOhxLr0JavbT3iwW4UZ+3UsDO4zkjD
    TxGTzqZwXS6/hp5uWZjmZWsA8TeCHaYgjIGzVCl3qm2FwDRVtL51iOj6Qm7l2YGY6HzzpX
    OSL7MVoBWirxPEkEfPKJxTgMMiHP53uRrie+Cxlyi/+/L3Fi+SgdevZImdBn0HsePaleXF
    UQlgCpOpmSMN6GWVeZjT+BWgy3KEgtWiZa1Z+AE7czUjuHX+0XgDqqLpfkQuORDyMBDIrD
    /fhpNdgn04I1ApSwpf6lRnDo7LvFqWf/afAvF3Khy0t2jdtyQgRKRnx+jsnLQrUnPh4iVR
    0KmdSYhi91nS+c/HCxUWW17H0XMBUoP5Retd0qkeOoWu08pa/mJgVLtG78CEE2PZmdb7uV
    2TZy20KhbnSXHviQRo+DcnQZKV5nk2AG7VvMy1/bzFtYqU77SMuanjPTvdyyFEXkHrYZrn
    pLxwzeiGJgGqwiJm/TQSoOPpxyFp7DAmeL6l7Yal/gGNqAxzij2mvg29l0kdM7inRqUhtb
    hu77VKDk5PuZillMkzBLqojdXdgm9EqnAEsK+bpHzfbqJGMTT9rzKWlKuCuZZB0ul/3x99
    URWcbgA01kjYtqCbBNOw/ONYHUBSJG+EHwJkOrD4j0bP1CZTbgXbRlx+FpJA
X-ME-Proxy: <xmx:C5TCakz6plWHmsHxiuIEcPlGBa8xW8PF54xiAjPshtaS3Q2t873InQ>
    <xmx:C5TCahsQStCDWNNc20YeJ9JPDDWjToomdNPe1mDp56V6DyANt58sbg>
    <xmx:C5TCal5re8suZQ6u4RJrkwyNDgy8DpqwOOi4TuBcQbLXfzDZUrIS-Q>
    <xmx:C5TCaoQ-loyoXFVTuFdUONPtiwHBPK0IR4bTQJ1WxhihynTs3p15Zg>
    <xmx:C5TCavvkrgnaWRLYFYvLHz3ALgrI5aJpPE5ZVf70TtEuc0AgpqDdYMNs>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Oct 2026 13:59:38 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 2/2] format-patch: learn --[no-]range-diff-notes
Date: Sun,  4 Oct 2026 19:58:35 +0200
Message-ID: <V5_format-patch_learn_--range-diff-notes.d6d@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <V5_CV_format-patch_learn_--range-diff-notes.d6b@m5gid.xyz>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz> <V5_CV_format-patch_learn_--range-diff-notes.d6b@m5gid.xyz>
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

Let’s teach git-format-patch(1) `--[no-]range-diff-notes` so that we
can pass in different notes refs to the range diff, or just turn them
off entirely.

In addition to storing the list of notes, we also need a boolean
`override` to distinguish these two cases:

1. No such options were given and empty list (use `--notes`)
2. Options were given and empty list (`--no-...` given; don’t use notes)

Unlike `--creation-factor`, `--[no-]range-diff-notes` does not error out
when used without `--range-diff`. This flexibility accommodates
workflows where users might configure default options in aliases or
wrapper scripts, allowing `--range-diff` to be toggled independently.

Add two tests here for the single-patch case, i.e. the case where the
range diff is on the patch and not in the cover letter. These are meant
as regression tests based on my encounter with single-patch range diff
notes handling bug.[1]

† 1: 155986b4 (format-patch: handle range-diff on notes correctly for
     single patches, 2025-09-25)

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v5:
    • Msg: Shorten paragraph about “why not error out like
      --creation-factor...” while keeping the exact same
      information.[1] Now the commit message fits on one screen for
      me! (1080p)
      🔗 1: https://lore.kernel.org/git/xmqqqzi5touh.fsf@gitster.g/
    • Msg: ... Also drop the thematic breaks (***). I think the
      paragraphs flow well enough now to the point that they are not
      needed.
    
    ---
    
    v4:
    • Msg: Trim all the expository fat, which only loses the footnote
      about “what if you had a changelog and testing notes” (in terms
      of “real substance”) as a trade for getting to the point quite
      quickly (relatively speaking)[1]
      🔗 1: https://lore.kernel.org/git/30249b7b-b6f7-4065-9a83-db93d69ad0f1@app.fastmail.com/#t
    • An obvious refactor: call `parse_opt_string_list` instead of
      manually inlining it along with a comment saying “we inlined
      it”[1]
    • Trim the fat from the doc. Straightforward explanation: use this to get
      `<ref>` instead. Use multiple times for more refs. `--no-...` to
      turn off. Lifted from the proposal by Junio with some
      modifications (use `<ref>` to more tersely discuss “a different
      notes ref”)[1]
    • Msg: credit help
    • `clang-format` on `rdiff_notes_cb`
    
    🔗 1: https://lore.kernel.org/git/xmqqy0cgvwpi.fsf@gitster.g/
    ---
    v3:
    • Remove repeated and redundant `test_when_finished` on
      patch files[1]
    
      🔗 1: https://lore.kernel.org/git/CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz/T/#m06803e233a2e385e694432d45ecf402f7a67e482
    ---
    v2:
    This version drops the whole functionality around being able to *go
    back* (and forth) to using `--notes` for the range diff.[1] The
    behavior was too complex to explain and motivate compared to the
    utility (little).
    
    🔗 1: https://lore.kernel.org/git/8f0a076b-4822-44e2-a842-cc1e39ae1c1d@app.fastmail.com/#t
    
    Also:
    
    • Use a parse-options callback for the option instead of
      `revision.c:handle_revision_opt`
    • Msg: Rewrite the (former last) paragraph about why we are not
      erroring when `--range-diff-notes` is given without
      `--range-diff`. Partly because the facts have changed; now we
      cannot turn off the `override` bit/flag. But it’s just many words
      to say that: why spend code disallowing something that you might
      as well allow?
    • Add a couple more tests, so simple that they also have an
      accompanying comment each explaining why they exist
    • Msg: Add a paragraph explaining why there are two tests specifically
      for the single-patch case. It’s not just to cover every permutation.
    • Remove useless `>actual` in tests that don’t test `actual` (they
      test the patch files instead)
    • Fix (kind of) the tests that use `$prev` as in:
    
          git format-patch --range-diff=$prev
    
      This is a very questionable and indirect use from this part of the
      suite:
    
          for prev in topic main..topic
          do
              [body]
          done
    
      I.e. it is just `main..topic`. This is monkey-see-monkey-do code
      from my previous visit of this file. Which then turns out in turn
      is a monkey-_ from *another* author. I think the existing `$prev`
      should get a cleanup (separately).

Notes (testing):
    v4:
    • Compiled and ran `t3206-range-diff`.
    • Ran `make html` and looked at git-format-patch(1).

 Documentation/git-format-patch.adoc | 11 ++++
 builtin/log.c                       | 42 +++++++++++++-
 t/t3206-range-diff.sh               | 86 +++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 191f64b77d1..2399ba24454 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -378,6 +378,17 @@ case is to show comparison with an older iteration of the same
 topic and the tool should find more correspondence between the two
 sets of patches.
 
+`--range-diff-notes=<ref>`::
+`--no-range-diff-notes`::
+	Used with `--range-diff`, tweak what notes to display in the
+	range diff.
++
+The default behavior is to display the same notes in the range diff as
+on the patches; see `--notes`. Use `--range-diff-notes=<ref>` to use
+_<ref>_ for the range diff instead. This option can be given multiple
+times to show notes from multiple refs. Use `--no-range-diff-notes` to
+disable notes in the range diff.
+
 `--notes[=<ref>]`::
 `--no-notes`::
 	Append the notes (see linkgit:git-notes[1]) for the commit
diff --git a/builtin/log.c b/builtin/log.c
index 560af00e2fd..445400ba782 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1327,15 +1327,44 @@ static void prepare_cover_text(struct pretty_print_context *pp,
 	strbuf_release(&subject_sb);
 }
 
+struct rdiff_notes {
+	/*
+	 * True if we want to override the notes behavior
+	 * of 'format-patch'
+	 */
+	bool override;
+	struct string_list notes;
+};
+
+static int rdiff_notes_cb(const struct option *option,
+			  const char *arg,
+			  int unset)
+{
+	struct option opt = *option;
+	struct rdiff_notes *rdiff_notes = option->value;
+
+	rdiff_notes->override = 1;
+	opt.value = &rdiff_notes->notes;
+	return parse_opt_string_list(&opt, arg, unset);
+}
+
 static int get_notes_refs(struct string_list_item *item, void *arg)
 {
 	strvec_pushf(arg, "--notes=%s", item->string);
 	return 0;
 }
 
-static void get_notes_args(struct rev_info *rev)
+static void get_notes_args(struct rdiff_notes *rdiff_notes,
+			   struct rev_info *rev)
 {
-	if (!rev->show_notes) {
+	if (rdiff_notes->override) {
+		if (rdiff_notes->notes.nr)
+			for_each_string_list(&rdiff_notes->notes,
+					     get_notes_refs,
+					     &rev->rdiff_log_arg);
+		else
+			strvec_push(&rev->rdiff_log_arg, "--no-notes");
+	} else if (!rev->show_notes) {
 		strvec_push(&rev->rdiff_log_arg, "--no-notes");
 	} else if (rev->notes_opt.use_default_notes > 0 ||
 		   (rev->notes_opt.use_default_notes == -1 &&
@@ -1995,6 +2024,9 @@ int cmd_format_patch(int argc,
 	struct strbuf rdiff1 = STRBUF_INIT;
 	struct strbuf rdiff2 = STRBUF_INIT;
 	struct strbuf rdiff_title = STRBUF_INIT;
+	struct rdiff_notes rdiff_notes = {
+		.notes = STRING_LIST_INIT_NODUP,
+	};
 	const char *rfc = NULL;
 	int creation_factor = -1;
 	const char *signature = git_version_string;
@@ -2091,6 +2123,9 @@ int cmd_format_patch(int argc,
 			     parse_opt_object_name),
 		OPT_STRING(0, "range-diff", &rdiff_prev, N_("refspec"),
 			   N_("show changes against <refspec> in cover letter or single patch")),
+		OPT_CALLBACK_F(0, "range-diff-notes", &rdiff_notes, N_("note"),
+			       N_("override notes behavior for the range diff"),
+			       0, rdiff_notes_cb),
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("percentage by which creation is weighted")),
 		OPT_BOOL(0, "force-in-body-from", &force_in_body_from,
@@ -2406,7 +2441,7 @@ int cmd_format_patch(int argc,
 		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
 					     _("Range-diff:"),
 					     _("Range-diff against v%d:"));
-		get_notes_args(&rev);
+		get_notes_args(&rdiff_notes, &rev);
 	}
 
 	/*
@@ -2570,6 +2605,7 @@ int cmd_format_patch(int argc,
 	release_revisions(&rev);
 	format_config_release(&cfg);
 	strvec_clear(&rev.rdiff_log_arg);
+	string_list_clear(&rdiff_notes.notes, 0);
 	return 0;
 }
 
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index ef92704de39..679a707c873 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -845,6 +845,92 @@ test_expect_success 'format-patch --range-diff with multiple notes' '
 	test_cmp expect actual
 '
 
+# Unlike '--notes', '--range-diff-notes' requires a value
+test_expect_success 'format-patch --range-diff-notes requires a value' '
+	cat >expect <<-EOF &&
+	error: option \`range-diff-notes${SQ} requires a value
+	EOF
+	test_must_fail git format-patch --range-diff=main..topic \
+		--cover-letter --range-diff-notes 2>actual &&
+	test_cmp expect actual
+'
+
+# The '--range-diff-notes' has no effect but is allowed
+test_expect_success 'format-patch --range-diff-notes=not-a-note (no --range-diff)' '
+	test_when_finished "rm -f 000?-*" &&
+	git format-patch --range-diff-notes=not-a-note --cover-letter \
+		main..unmodified &&
+	test_file_not_empty 0000-cover-letter* &&
+	test_grep ! "^Range-diff:" 0000-cover-letter* &&
+	test_grep ! "## Notes " 0000-cover-letter*
+'
+
+test_expect_success 'format-patch --range-diff --notes=custom --no-range-diff-notes' '
+	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
+	git notes --ref=custom add -m "topic note1" topic &&
+	git notes --ref=custom add -m "unmodified note1" unmodified &&
+	test_when_finished "rm -f 000?-*" &&
+	git format-patch --range-diff=main..topic --notes=custom \
+		--no-range-diff-notes --cover-letter \
+		main..unmodified &&
+	test_grep "^Notes (custom):" 0004-* &&
+	test_grep "^Range-diff:" 0000-cover-letter* &&
+	test_grep ! "## Notes (custom) ##" 0000-cover-letter*
+'
+
+test_expect_success 'format-patch --range-diff --no-notes --range-diff-notes=custom' '
+	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
+	git notes --ref=custom add -m "topic note1" topic &&
+	git notes --ref=custom add -m "unmodified note1" unmodified &&
+	test_when_finished "rm -f 000?-*" &&
+	git format-patch --range-diff=main..topic --no-notes \
+		--range-diff-notes=custom --cover-letter \
+		main..unmodified &&
+	test_grep ! "^Notes (custom):" 0004-* &&
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
+	git format-patch --range-diff=main..topic --notes=patch \
+		--range-diff-notes=rdiff --cover-letter \
+		main..unmodified &&
+	test_grep "^Notes (patch):" 0004-* &&
+	test_grep ! "^Notes (rdiff):" 0004-* &&
+	test_grep "^Range-diff:" 0000-cover-letter* &&
+	test_grep "## Notes (rdiff) ##" 0000-cover-letter* &&
+	test_grep ! "## Notes (patch) ##" 0000-cover-letter*
+'
+
+test_expect_success 'format-patch --range-diff --no-range-diff-notes on single patch' '
+	test_when_finished "git notes --ref=custom remove HEAD unmodified || :" &&
+	git notes --ref=custom add -m "topic note (custom)" HEAD &&
+	git notes --ref=custom add -m "unmodified note (custom)" unmodified &&
+	git format-patch --notes=custom --range-diff=main..topic \
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
+	git format-patch --range-diff=main..topic \
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
2.55.0.793.gc667de3f2c5

