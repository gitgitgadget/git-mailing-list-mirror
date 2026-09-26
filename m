Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410B037475D
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790447312; cv=none; b=uCQYemoehOqxSwRXsB40CEfQ7dIpSxGRrp1wn+ENWHksyYmmWBKcCCv8/SbQ2kRF23SbHliaXb3DqkWly/J+nZvxss+pba6WvwhVb13TDTgQcX5tKu9HqZC2e3hqvUgO9i12Sj1ptpSto+GvfUH9uKhijVvxwaRk84sgcKiz+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790447312; c=relaxed/simple;
	bh=u2uciBq7/81CeKd94h1vVXRoVe3ZZsfxqDwrrg6uMy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzJre5qh6yxAnKE3AOFaBU2Qh+IZItIdojpEK/OYOD9TebitaPCYfByF80SW8Fy5t4KMqwc4bWrHm7+3OJ50x3cGovhKnej6ZyD84aeQfjlr2hERrtEowENYvAD1f7Ocn0pXwBPI+ED4B5a9XA6vaHo4/mVZy6D7H7Q8vtBRtyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=O78YChKi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rWL3Vwkv; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="O78YChKi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rWL3Vwkv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 51E371400077;
	Sat, 26 Sep 2026 14:28:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 26 Sep 2026 14:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790447309;
	 x=1790533709; bh=MGCT+ShShB3zQsabx0mNMi94NPLgYmuvip57hjV8tv0=; b=
	O78YChKiuMX7CiSa93o30ObJB6yAa2aLTYW3ZEOeKFBHprbCE78pekFBq/lTJ/Gm
	VVB9pKTBBBZCWJ/wev+K+ZQMWqa3K9MCnlkFhMKC8EAM5YZm9eq/edUq143t5s4F
	IKLpM1XzrTMhUup6m0Z8vqXhMRP1Et387DTMg5vKDBhcsSb6Y6UAHYgloExMBmsl
	ttvr9vOKl9yR52pf+kt55Rq57oRpjRPwg9ozI4ouJEW8jRO8cOJghqM3FEDxzHbL
	1wHmWEMk5rjoMqa0bQVOZB8n6soO85Kmh9QRZmv4Zbb7gJo1w7wKPHe1jyGWyLO7
	9Z2FltWJqcBu0kcxpTKsRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790447309; x=
	1790533709; bh=MGCT+ShShB3zQsabx0mNMi94NPLgYmuvip57hjV8tv0=; b=r
	WL3Vwkv9+K+qTvSxN++3udVjS3lJO3miKVI9UfTkAWrClDEGtIxltKk4WN4ppqBC
	pYLhtpvciLPA9ghgbH7sFwXvFBksI/sAfnCctys8J4+lnB9lhFzb5SpK7Si6GfzT
	MW9v3T6eptI/WbqQFDEfED2xtOGYfeppuNrN21hYq8CtjScw6rRuC8e6woSqDV3p
	paUHT16Om3KzC7J1VkvK5rPPhaWFqvNZRCbT21PBPfHzJvJqtp5M2nKBbN245yw5
	Nicl12vs+uPWdaQZilARr7+NeOX73UegnonDjhtnqkSPK14a/jPFgW/K3irMIOWK
	M88wMY3PoQevEk+zZ/YMA==
X-ME-Sender: <xms:zQ64arm4jh5_K88UOjMP35O9neIazzYTzSRRHPywVd4u1MzhFBONZsY>
    <xme:zQ64al2ddVipiGurtz6RlaYr11WET-A5ShG_J86uwxMDXixbnu0VlIwu9UiOblnAZ
    DpdlvzTOZh_aNJYp5EtETdI0JSx047F6edl32LrB8W0ddtp6fjjN_5M>
X-ME-Received: <xmr:zQ64amqcG3uhuCry-2TtmACfRb7e_W6THwHydznuHn_yTz09cSxhLHrPU-RaUfzXYBl1tTDgxhvkbxa8ctQjDsciycyTDOju9N_nMyxCsZCRFLAwb_l4hE8>
X-ME-Proxy-Cause: dmFkZTGtgMxuGTy7Bp5MsJBrnJiF9VCvZMrtRpgVR0Y0sPKACHIXZ5CSOsULqqc/1FAMRW
    Ms8pYbRMknCAkWXJyerPTSrQuPYLkZ1IUTaFIsVgiIMIFdS4eV+2c/eV3Tl3m2dIkHClY1
    m+SY46uqNug3bc6GdTjiF62TbCXMiGaj66FvAtRP/VeXDoPwQ0pe0/irkdy57f/lPJW3Zi
    8ZM8kuK1yILCSHTTkS43KvY00FYI43GrJQgvICsVArTuhrVQJSjT1FhQYFFv3O6783CzgM
    fcZTZbUeYcc3NsmGDWvSeVuB+KZOPsdTLaqe+mADe15m7UlpH1HdIwcf3fK+gxlGwGQwjH
    HHePOxwFrItsBkiOlT18XBDvGvF4V0DuKlLHQ4O+3d8nP7BwuRL9NiOm+AJs7qNTGe+nIn
    M4frBYF+hV68CZG24UKjsqFf5nBA3cOTDBe95PXWFnDEqZ5ow5ej/GfO+YEI75FYE0Gz5e
    91hQnAs2v/1v02d2E5YNvPNHtctWhizy7SZg1/UEm1Pku7nO05VeNhL9B1bisYAqO2o6eE
    /SYdV9d2Pm6BM8DvhO9j+gVkjTPHTVAJtp12avXAA+9jcLdrkSLeZf7HysI6rg3p+RVCAV
    nNWSl53OJWK/u5EGvsjtVOG6OUyHZc1qR2GMfu8uXtADr976d3FZXKCWVbMw
X-ME-Proxy: <xmx:zQ64aifjIDCVjQnpBNemO9d2LSAzQO51p31dRzDav-f8SysCxGzczg>
    <xmx:zQ64alr3SvGk9DXRKrO3lRuBbFPb-Jz6fz2aUHn2AMT07I-9Y7cC3w>
    <xmx:zQ64ajF7tHhx_TBBpg6i4tDOWIJ5X0vG0qfOSh9zBYyNgJ5YiYaH8w>
    <xmx:zQ64aluNnSLJDaK2V7N40psQ27cluJuNRZHIL2oMD6bedh-8rSJQog>
    <xmx:zQ64arHntfUvzKPMX2Y6AcE2Uia-FBfFaPMhxQEbICl57iNGN6O3mbQa>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Sep 2026 14:28:28 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] format-patch: learn --[no-]range-diff-notes
Date: Sat, 26 Sep 2026 20:27:46 +0200
Message-ID: <V2_format-patch_learn_--range-diff-notes.cdd@msgid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <V2_CV_format-patch_learn_--range-diff-notes.cdb@m5gid.xyz>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz> <V2_CV_format-patch_learn_--range-diff-notes.cdb@m5gid.xyz>
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

Well, we can’t. Therefore we need `rdiff_notes.override` to set whenever
any of these options are given.

† 1: For example, let say we have two notes ref that are used for a
     patch series:

     1. testing. What the user has done to test this iteration.
     2. changelog. The same example from the introduction.

     You could include both notes on the patches but only show `testing` in
     the range diff.

***

Note that using `--creation-factor` without `--range-diff` will cause
the command to die. But this is not the case for `--[no-]range-diff-
notes`; we would have to check `rdiff_notes.override`, which is a sticky
value (cannot be turned off). The reason is that it is potentially
inconvenient to error out since it would not let you turn off
`--range-diff` in, say, some alias that uses `--no-range-diff-
notes`. Granted, it is difficult for me to come up with a concrete use
case since `--range-diff` requires a value, specifically a value which
is probably not that reusable (revision range), and yet you have
something like an alias set up with it. But why spend code closing
that door? There is no usability upside to erroring out.

***

Add two tests here for the single-patch case, i.e. the case where the
range diff is on the patch and not in the cover letter. These are meant
as regression tests based on my encounter with single-patch range diff
notes handling bug.[2]

† 2: 155986b4 (format-patch: handle range-diff on notes correctly for
     single patches, 2025-09-25)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
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
    CI: https://github.com/LemmingAvalanche/git/actions/runs/36231842902
    
    This run is on a previous iteration where v1 patch/commit 2/3 was still
    there. But that is just a rename. So I compiled and tested
    `t/t3206-range-diff.sh` and took that as proof that the full CI/build run
    is still valid.

 Documentation/git-format-patch.adoc | 15 +++++
 builtin/log.c                       | 54 +++++++++++++++++-
 t/t3206-range-diff.sh               | 87 +++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 191f64b77d1..5907f299a8d 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -378,6 +378,21 @@ case is to show comparison with an older iteration of the same
 topic and the tool should find more correspondence between the two
 sets of patches.
 
+`--range-diff-notes=<ref>`::
+`--no-range-diff-notes`::
+	Used with `--range-diff`, tweak what notes to display in the
+	range diff.
++
+The default behavior is to display the same notes in the range diff as
+on the patches; see `--notes`. But you can use these options to use a
+different list of notes. For example, say you have given three notes
+refs to `--notes`. At this point those same three notes will be
+displayed in the range diff. But then you pass
+`--range-diff-notes=<ref>`. Now the range diff will only display
+_<ref>_. You can of course pass more refs to this option, just like
+`--notes`. And you can also turn off all range diff notes with
+`--no-range-diff-notes`.
+
 `--notes[=<ref>]`::
 `--no-notes`::
 	Append the notes (see linkgit:git-notes[1]) for the commit
diff --git a/builtin/log.c b/builtin/log.c
index 560af00e2fd..d70101f0755 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1327,15 +1327,56 @@ static void prepare_cover_text(struct pretty_print_context *pp,
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
+		       const char *arg,
+		       int unset)
+{
+	struct rdiff_notes *rdiff_notes = option->value;
+
+	rdiff_notes->override = 1;
+
+	/*
+	 * The rest is the same as
+	 * parse-options-cb.c:parse_opt_string_list
+	 */
+	if (unset) {
+		string_list_clear(&rdiff_notes->notes, 0);
+		return 0;
+	}
+
+	if (!arg)
+		return -1;
+
+	string_list_append(&rdiff_notes->notes, arg);
+	return 0;
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
@@ -1995,6 +2036,9 @@ int cmd_format_patch(int argc,
 	struct strbuf rdiff1 = STRBUF_INIT;
 	struct strbuf rdiff2 = STRBUF_INIT;
 	struct strbuf rdiff_title = STRBUF_INIT;
+	struct rdiff_notes rdiff_notes = {
+		.notes = STRING_LIST_INIT_NODUP,
+	};
 	const char *rfc = NULL;
 	int creation_factor = -1;
 	const char *signature = git_version_string;
@@ -2091,6 +2135,9 @@ int cmd_format_patch(int argc,
 			     parse_opt_object_name),
 		OPT_STRING(0, "range-diff", &rdiff_prev, N_("refspec"),
 			   N_("show changes against <refspec> in cover letter or single patch")),
+		OPT_CALLBACK_F(0, "range-diff-notes", &rdiff_notes, N_("note"),
+			       N_("override notes behavior for the range diff"),
+			       0, rdiff_notes_cb),
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("percentage by which creation is weighted")),
 		OPT_BOOL(0, "force-in-body-from", &force_in_body_from,
@@ -2406,7 +2453,7 @@ int cmd_format_patch(int argc,
 		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
 					     _("Range-diff:"),
 					     _("Range-diff against v%d:"));
-		get_notes_args(&rev);
+		get_notes_args(&rdiff_notes, &rev);
 	}
 
 	/*
@@ -2570,6 +2617,7 @@ int cmd_format_patch(int argc,
 	release_revisions(&rev);
 	format_config_release(&cfg);
 	strvec_clear(&rev.rdiff_log_arg);
+	string_list_clear(&rdiff_notes.notes, 0);
 	return 0;
 }
 
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index ef92704de39..640c5dec52e 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -845,6 +845,93 @@ test_expect_success 'format-patch --range-diff with multiple notes' '
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
+	test_when_finished "rm -f 000?-*" &&
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

