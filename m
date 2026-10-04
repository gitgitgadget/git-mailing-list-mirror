Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D870421247
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109112; cv=none; b=lqW88xSpViYITTeSYnK8XkXPC9hSf8P8qDoVWM0V26d2AX2w35AFOO1O5VSBkzvAHNaUaoWFBiZiFT76GhdI+wvdaTHX4ooqH56ZKHTFnDSMzGDlJU5iG8vz71BCPRDpFnOBvnQV7sitx4dX2A5VtJgjCZv3k8YrSbBPNrPgMS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109112; c=relaxed/simple;
	bh=tzDRoTU8pHI1Lvx+ad+o+JRl4skJ8UhP9RdUi53Ox3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdgIuF4FotYH2TW4wu1EvMdtsILUSw6l4RVhskYMd/+C4Z7UB1ivqqPM82A1vX+tEdIMNl5B2jdlCFHqtO7/DT3NHvS/YmP7LrecSfoE+gbRdBKHqW/o8auSrw/o97tLmUKwdIStrxuRbw/I1mb4MSstnS/DuDfAH50KHum/4p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=a/40sSn+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qZnxt8Gs; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="a/40sSn+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qZnxt8Gs"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 11460EC0319
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 06:18:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 04 Oct 2026 06:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791109109;
	 x=1791195509; bh=mIha+AIujG7HcE3bOhILs3XTI83cKBXjtGKMB1PJqUI=; b=
	a/40sSn+75OjVvA7vvr6R78qAqiw5y73xRrUr7mpZHYwCy2ts6vzdDAwC66+lbUZ
	/nChm5PWIpllqqO2STlAKKIHc0PtWWS3+0wwOScR63njZqa+N+avvUc7O3eb+e6Q
	UMykkxmGezC7YZGgkfzzhHAqUnU6vpt2+0yLePsL/cIyCEpq4pPb3Du/TQ267cHn
	2nw55/RTPbptyoUatBqf6KFr49+5ks6rD/+fChjvoDHO8Y5hVCuPW/opaDQm46fQ
	IxQi7oN1tJYBg5+rvMlwRFUcBiLmE8gpIF3Ddm7P/AMTF3wxBuLOzqiKIq08Uez2
	K1D3rZXyATK8a3NdHqB5kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791109109; x=
	1791195509; bh=mIha+AIujG7HcE3bOhILs3XTI83cKBXjtGKMB1PJqUI=; b=q
	Znxt8Gs+6eVrSejB26vRN5YftQQ9I7VrysMgV7jqcA3vmvRp/HKMuK2pCYGHh/P9
	XMVZddZYj1Tx5LOUCIqWbQasXoS/DWwljzd+rkY/3e8kOimC5e57eETAXAXWHaZe
	OfwvAPUazeC6E+iWNBSm0PsnwybgH1udxnJbmu4+PqAgX4/WODSKTbnFjg5pS7Oi
	Ryf8B+rhM5XCDyFoqD1YSe77ZCnW3/EyvHazcKFicRukh0dDwjOAQlllBfuy8Rll
	hUbEKEtAMmzPULli9bp0ilzU3Su1DccijtCkZeXXGEs3KVVfEN5S/dFYkZqCMoxG
	y69hh4MxL+eCJIpt/L7wg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791109109; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nSjHGk+10nMh53riEXiSptcG71nWm1kI1x1L7u2W3vRRoB/
	NL1edW3ckIT0cP6xcK1IbYNh/hVKD4XqBnUAhApecknjptu02MraStxrC56DoJ4r
	CH5Yx1cCGuXszHBFQS4bRwghPUne6EHB+erLHmhHXHs9hZSMNUN1xQF7mdTaxS4L
	AYTWTtNtYXWqNqfUrvqCYO4ROXmSriWw9Ggr2fz5PLktnUtSR70DIBmWtIFdUmsg
	RlSxZG8x4vOBTK/8wOC9QL8nq7tRPLLyTFb67QygL80RXsHkfJlavEFmIzggPfTu
	r1P20zJi2j5JV7uLB14i3Q5T6lQq7QkRRjLSbIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:IF4FLZzxxYmWOrLOHTNZDCXjUv0C3St5Qzq1jR3/gfA=:tzDRoTU8pHI1Lvx+ad+o+JRl4skJ8UhP9RdUi53Ox3Q=;
X-ME-Sender: <xms:9CfCatwKOmohKGDQ1476Lj1S7FXytp5GHArzk5doiWrvgBKCiT4fnsQ>
    <xme:9CfCakQId46GX-t9Aq1gfmKtwZkjBe4IENYu0UfYzuOJHwxI_RBP91mSyPoq6OFjz
    taQKOb-4V7UMj385kPubgY6Zoy5ZrBuv2_q8yZ8GRwcljsvYWAjtho>
X-ME-Received: <xmr:9CfCasWqtZ4qnQ86WxyX7pIhdQUHMnsMxLFwCtQsNt6hLW4liwY233d4XBD6HQLCIzsDMXSSWH3DsHwAINrPYU8_xN7ksapNq7U_RUKBdwjvcHnlUSU1hZE>
X-ME-Proxy-Cause: dmFkZTEqU11RHsWOTGi2xHzBOzbuhNvPX2SfEGFm0r/3HKnubuzFuhYArARJODE5hbis/G
    CUafZg+UO0HkrSKgVC3sXY4gOAM2g0YAiB3O9gqgocT52iYMXWF6zEU1luriyIdbCKT3ue
    yDpjgfkPDrBXN7SneTpC2rdUCUmwQftv8Vt3AocYu6HDEgenpQOvBkb5/Gnn6hffxub/A9
    s0rctstTyfrnObSY7Cez8+T56CVrRhcDVyWJ0/rRH32J7DFkxQoLEIbDr8xv0zN66oX9+B
    j0dEu9di9Mm7dCNrGotQjfos7aPvscyLYCxeKn/WFqTsJtLOZAFGUoLPesi/vmvECTWkXn
    sU/3Ma5+LhmhkR1NHYjK+3CjMZo4c2RFZo2vX7CFqxbyuCZPjtlZyJb0fvd+1TPoZBlyzS
    wW/Iwa08+2N6NhSWBhtqG4ZDp3B03bRza9RL26Z2dxYuewYZdEZCrV3ajtRNgs7oVQiJqw
    ay0Wno6Az17l/5dv9G/bcq9myO8BaYDDBusLNJQgBUH6BVaGXTuhvzw5bGstw/nKGyioON
    7S7SCxI3AD2WXAdGfTWSZ/mwPxixHcTEJIR/4M/8JXD5TOCGDC7UbKzUOY18YbxktnDFPC
    Kfyq7ac7HFkR3OBI4nf7U74W5HQqISnlghCTMumhqMtbBk394y6mWC0hQhDw
X-ME-Proxy: <xmx:9CfCaubBguch7WkDNxSevyPKFoLEY1uuMaSF2L7tRiIlOWu4SD_BpA>
    <xmx:9CfCaq1oKu6YiTrWVh53sMhkjhWvD5pHbk4K54_z0_SZII_q8uTdiA>
    <xmx:9CfCaohNLFbuoBGjhW3GEoGAing7z9xD3JFtH_-kZ5aRB5La7p5G_w>
    <xmx:9CfCamZG0G9Qx2e2a_NrMvEmznR7vHPVkgIfYxZTABqcOQaWjsQu8g>
    <xmx:9SfCajALe9Lq9peHVntoj0nSs7zzrDp4-auT3881YtE-ipt-HLvPyODI>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Oct 2026 06:18:28 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/2] format-patch: learn --[no-]range-diff-notes
Date: Sun,  4 Oct 2026 12:17:52 +0200
Message-ID: <V4_CV_format-patch_learn_--range-diff-notes.d5c@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
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

Topic name (applied): kh/format-patch-range-diff-notes

Topic summary: Teach 'format-patch' options to tweak notes output in the
range diff independent of what notes are output in the patches.

See patch 2/2 for details.

This is motivated by wanting to turn off range diff notes, but the goal
here is to implement it in full generality.

(How many of us `git format-patch --notes` users are there out there? More
than a dozen? Maybe just D. Ben Knoble and me?)

I have implemented this behavior for myself and used it for many
months. But that was hacky and only suitable for one person’s use.
So this is a completely new implementation. In other words: this is
new code, *not* tested for months.

§ Changes in v4

Mostly trim expository fat. Also one code refactor. See the patch *notes*
for details.

§ Link to v3

https://lore.kernel.org/git/V3_CV_format-patch_learn_--range-diff-notes.d39@m5gid.xyz/

[1/2] format-patch: simplify get_notes_arg parameters
[2/2] format-patch: learn --[no-]range-diff-notes

 Documentation/git-format-patch.adoc | 11 ++++
 builtin/log.c                       | 50 +++++++++++++++--
 t/t3206-range-diff.sh               | 86 +++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+), 6 deletions(-)

Interdiff against v3:
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 5907f299a8d..2399ba24454 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -384,14 +384,10 @@ sets of patches.
 	range diff.
 +
 The default behavior is to display the same notes in the range diff as
-on the patches; see `--notes`. But you can use these options to use a
-different list of notes. For example, say you have given three notes
-refs to `--notes`. At this point those same three notes will be
-displayed in the range diff. But then you pass
-`--range-diff-notes=<ref>`. Now the range diff will only display
-_<ref>_. You can of course pass more refs to this option, just like
-`--notes`. And you can also turn off all range diff notes with
-`--no-range-diff-notes`.
+on the patches; see `--notes`. Use `--range-diff-notes=<ref>` to use
+_<ref>_ for the range diff instead. This option can be given multiple
+times to show notes from multiple refs. Use `--no-range-diff-notes` to
+disable notes in the range diff.
 
 `--notes[=<ref>]`::
 `--no-notes`::
diff --git a/builtin/log.c b/builtin/log.c
index d70101f0755..445400ba782 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1337,27 +1337,15 @@ struct rdiff_notes {
 };
 
 static int rdiff_notes_cb(const struct option *option,
-		       const char *arg,
-		       int unset)
+			  const char *arg,
+			  int unset)
 {
+	struct option opt = *option;
 	struct rdiff_notes *rdiff_notes = option->value;
 
 	rdiff_notes->override = 1;
-
-	/*
-	 * The rest is the same as
-	 * parse-options-cb.c:parse_opt_string_list
-	 */
-	if (unset) {
-		string_list_clear(&rdiff_notes->notes, 0);
-		return 0;
-	}
-
-	if (!arg)
-		return -1;
-
-	string_list_append(&rdiff_notes->notes, arg);
-	return 0;
+	opt.value = &rdiff_notes->notes;
+	return parse_opt_string_list(&opt, arg, unset);
 }
 
 static int get_notes_refs(struct string_list_item *item, void *arg)
Range-diff against v3:
1:  977f9c2e97a ! 1:  bb60f300d3f format-patch: simplify get_notes_arg parameters
    @@ Commit message
         format-patch: simplify get_notes_arg parameters
     
         85bd88a7 (revision: add rdiff_log_arg to rev_info, 2025-09-25) added
    -    `rdiff_log_arg` to `struct rev_info`. I changed `get_notes_arg` by
    -    simply replacing the first argument with an access on this struct
    -    member. But the second argument was already `struct rev_info`. So I
    -    should have just simplified to *only* passing that parameter. Let’s do
    -    that now.
    +    `rdiff_log_arg` to `struct rev_info`. `get_notes_arg` was changed to
    +    take a second parameter, namely that member:
    +
    +        get_notes_args(&(rev.rdiff_log_arg), &rev);
    +
    +    But this is obviously unnecessary; we can just use `&rev`.
     
         Now is also a good time to format this `for_each...` line since it’s
         gotten quite long.
    @@ Commit message
     
     
      ## Notes (testing) ##
    +    v1:
         just compile tested
     
      ## builtin/log.c ##
2:  748759ca021 ! 2:  4cbd312fec6 format-patch: learn --[no-]range-diff-notes
    @@ Commit message
         document the iterations. But including them also includes them in the
         range diff. And they have nothing useful to say there.
     
    -    So it would be useful to turn off range diff notes handling with
    -    something like `--no-range-diff-notes`. This could then be turned on
    -    again with `--range-diff-notes`.
    +    Let’s teach git-format-patch(1) `--[no-]range-diff-notes` so that we
    +    can pass in different notes refs to the range diff, or just turn them
    +    off entirely.
     
    -    An off/on switch is enough for this behavior. However, a bare (no arg)
    -    option (together with the negation) is not consistent with `--[no-]notes
    -    [=<ref>]` and could cause confusion. And we are both conceptually and
    -    literally constructing an argument list to pass on to git-range-diff(1),
    -    which does have the same option format as git-format-patch(1). Moreover,
    -    it is useful to be able to specify exactly what notes you want
    -    git-format-patch(1) and git-range-diff(1) to use.[1] So let’s generalize
    -    it so that you can pass in whatever notes refs you want.
    +    In addition to storing the list of notes, we also need a boolean
    +    `override` to distinguish these two cases:
     
    -    But now we are faced with a problem that `--notes` does not have; how do
    -    we distinguish an empty `struct string_list` meaning these two things?:
    -
    -    • No such options given
    -    • `--no-range-diff-notes`
    -
    -    Well, we can’t. Therefore we need `rdiff_notes.override` to set whenever
    -    any of these options are given.
    -
    -    † 1: For example, let say we have two notes ref that are used for a
    -         patch series:
    -
    -         1. testing. What the user has done to test this iteration.
    -         2. changelog. The same example from the introduction.
    -
    -         You could include both notes on the patches but only show `testing` in
    -         the range diff.
    +    1. No such options were given and empty list (use `--notes`)
    +    2. Options were given and empty list (`--no-...` given; don’t use notes)
     
         ***
     
    @@ Commit message
         Add two tests here for the single-patch case, i.e. the case where the
         range diff is on the patch and not in the cover letter. These are meant
         as regression tests based on my encounter with single-patch range diff
    -    notes handling bug.[2]
    +    notes handling bug.[1]
     
    -    † 2: 155986b4 (format-patch: handle range-diff on notes correctly for
    +    † 1: 155986b4 (format-patch: handle range-diff on notes correctly for
              single patches, 2025-09-25)
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (testing) ##
    -    For v3: only compiled and ran `t3206-range-diff`.
    +    v4:
    +    • Compiled and ran `t3206-range-diff`.
    +    • Ran `make html` and looked at git-format-patch(1).
     
      ## Documentation/git-format-patch.adoc ##
     @@ Documentation/git-format-patch.adoc: case is to show comparison with an older iteration of the same
    @@ Documentation/git-format-patch.adoc: case is to show comparison with an older it
     +	range diff.
     ++
     +The default behavior is to display the same notes in the range diff as
    -+on the patches; see `--notes`. But you can use these options to use a
    -+different list of notes. For example, say you have given three notes
    -+refs to `--notes`. At this point those same three notes will be
    -+displayed in the range diff. But then you pass
    -+`--range-diff-notes=<ref>`. Now the range diff will only display
    -+_<ref>_. You can of course pass more refs to this option, just like
    -+`--notes`. And you can also turn off all range diff notes with
    -+`--no-range-diff-notes`.
    ++on the patches; see `--notes`. Use `--range-diff-notes=<ref>` to use
    ++_<ref>_ for the range diff instead. This option can be given multiple
    ++times to show notes from multiple refs. Use `--no-range-diff-notes` to
    ++disable notes in the range diff.
     +
      `--notes[=<ref>]`::
      `--no-notes`::
    @@ builtin/log.c: static void prepare_cover_text(struct pretty_print_context *pp,
     +};
     +
     +static int rdiff_notes_cb(const struct option *option,
    -+		       const char *arg,
    -+		       int unset)
    ++			  const char *arg,
    ++			  int unset)
     +{
    ++	struct option opt = *option;
     +	struct rdiff_notes *rdiff_notes = option->value;
     +
     +	rdiff_notes->override = 1;
    -+
    -+	/*
    -+	 * The rest is the same as
    -+	 * parse-options-cb.c:parse_opt_string_list
    -+	 */
    -+	if (unset) {
    -+		string_list_clear(&rdiff_notes->notes, 0);
    -+		return 0;
    -+	}
    -+
    -+	if (!arg)
    -+		return -1;
    -+
    -+	string_list_append(&rdiff_notes->notes, arg);
    -+	return 0;
    ++	opt.value = &rdiff_notes->notes;
    ++	return parse_opt_string_list(&opt, arg, unset);
     +}
     +
      static int get_notes_refs(struct string_list_item *item, void *arg)

base-commit: 1a3e64c6c4a623626ff0687008732a8e007e2a1c
-- 
2.55.0.793.gc667de3f2c5

