Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8E25CC61
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734813; cv=none; b=YAobXi0UC8PfvrCKlWynDg5hKfvA/YTqnkjeZijkUgfiZEpUQw5x4aK4N5PL/Jo1IjMebsfeqvSN+/3xABGcyt5NgqrXGaS8LmC8eSGISld4uQ6RqSfPAg4U5eHCLd0yX0kfu326kSx0pvcb2P5q3qY0fJ7A7Xw6EFcI9glyYtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734813; c=relaxed/simple;
	bh=sztKoWSueHXnBhBTtJ+fQ72mXi/TCj8dEI0ouP5OzzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=To4fUml4rALRDdaDA5QPoZPcrm1vO4BRSgYoIvrmviZCqOv6eHCM8SDTe2KZbHZA3zueLfQ7dTDZFFLwoOLNwKMczRNi+ll2Uf/Ht6wlUHlA7vA5t0PmaLnWKpPzscOgwJCJ4ancamO12IsRfw3LRabUfQtePZyCMCb30h19GVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=koZH6qFn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n3aS7Ags; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="koZH6qFn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n3aS7Ags"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6361D1380991;
	Fri, 28 Feb 2025 04:26:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 28 Feb 2025 04:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740734810;
	 x=1740821210; bh=P6p6op1elrNG/xkBbYTvM4EY7sxtgf1QqbTME2G1O38=; b=
	koZH6qFnH5PohWyrPVJPBDqYrfr0KASk5/AEowsFi+eCh071Brtdkg3+ukhrG0vN
	7PR6b5tIEfpyVTbd49zAAjhGLHydNY4NGfZ6Ncj/oBTHNKFwP24TY9D3JO/w/5b6
	PWdmFfHJvxwbia1wd6Nr1PLh12QyO0O00Z4GSX0VrtWa7iP8XotKWoOvvQskoswH
	295M0i+C0+3nVsU5WTNUVtXiQoiJTr3uAM2004J06ERH4pgN1SYuGQy9cATLwH7x
	+trwRG4hW6CilLG/oCqYa1xY7hOk928DydOJtKZKbiPZoCpUUSsVJB3rjQoZfpET
	wqhusTu0prwSucdGL0UEpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740734810; x=
	1740821210; bh=P6p6op1elrNG/xkBbYTvM4EY7sxtgf1QqbTME2G1O38=; b=n
	3aS7Ags2ZTpsBPQ5/FonngZsnLzl+LkQs4wwegNsrvJFUmREcdTd7MUNza8SX1+L
	t24Lwodm8LYdpH0CZamGZIvsY9qXRN8Jfw5dB1/Q529bVST1xTzmQoawy7mnqRiQ
	pkfHEklntBZt2v1ES/c4lOByyglhmTxVFj+KwpHx6SWDH376Bi6mmxkFZnQHuSbD
	5zmKQIIXfWbmIMu59fDiKaZrNnh5KcX4Xbi8t7d+iNYKfGB1wBREc6+Mjkt4H9qU
	5nYBKp0TYcc2FpEIHjkY20HGi9QRFEwy7PeniE6WW6lXI7hRooNhV9O5NLqKbNkE
	WcjK1VnvmAKeANyMpKONw==
X-ME-Sender: <xms:WoHBZ37cj-iCgOJfuQdpAZHNpZD0MiP-J7gMlNQFblpfMIPirujfgg>
    <xme:WoHBZ84xeBVT8Fqfm-e_dYQ7QVN-iuTsHS1ApvKPB9XNDKqBmP0D09-pzxZd7LtLP
    ZQilW0RkOXB9z59xA>
X-ME-Received: <xmr:WoHBZ-egNKYBaq71A-Hy-FEU6SP6l-4KZ0ECRGYdB6JZGRhODr-VZ6XuEHc_YS8E4WC3f7GQusrdnOcfJf3G2sLO9bL_d2C0_BCRfgvX_4cCs-h4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtddu
    ffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghj
    ihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhush
    hthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WoHBZ4J4z_h8c6Qck7wC9VOkMXdfaoVuxWJHbgmMw2N1_gsz3vnfAA>
    <xmx:WoHBZ7LftmZTqH7oJyYbH1tp6kY4tmXllYkiQfmdCH7otkzR1WloKQ>
    <xmx:WoHBZxzH1R3BDnUqlESQQMRVeeW05Qk1jlqr9Z0E_iGfTfbmBc_QMw>
    <xmx:WoHBZ3KAVg0TuZb2t3InpQZAnUWOD9bvups1--dbuMf_nQABP_WesQ>
    <xmx:WoHBZ4rLqSfCWvClXzHhlzztZDCFRYILMLLYUvLSfff_jkyuHUBgsnAn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 04:26:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ca2995a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 09:26:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Feb 2025 10:26:40 +0100
Subject: [PATCH v4 03/16] builtin/update-ref: skip ambiguity checks when
 parsing object IDs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-pks-update-ref-optimization-v4-3-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Most of the commands in git-update-ref(1) accept an old and/or new
object ID to update a specific reference to. These object IDs get parsed
via `repo_get_oid()`, which not only handles plain object IDs, but also
those that have a suffix like "~" or "^2". More surprisingly though, it
even knows to resolve arbitrary revisions, despite the fact that its
manpage does not mention this fact even once.

One consequence of this is that we also check for ambiguous references:
when parsing a full object ID where the DWIM mechanism would also cause
us to resolve it as a branch, we'd end up printing a warning. While this
check makes sense to have in general, it is arguably less useful in the
context of git-update-ref(1). This is due to multiple reasons:

  - The manpage is explicitly structured around object IDs. So if we see
    a fully blown object ID, the intent should be quite clear in
    general.

  - The command is part of our plumbing layer and not a tool that users
    would generally use in interactive workflows. As such, the warning
    will likely not be visible to anybody in the first place.

  - Users can and should use the fully-qualified refname in case there
    is any potential for ambiguity. And given that this command is part
    of our plumbing layer, one should always try to be as defensive as
    possible and use fully-qualified refnames.

Furthermore, this check can be quite expensive when updating lots of
references via `--stdin`, because we try to read multiple references per
object ID that we parse according to the DWIM rules. This effect can be
seen both with the "files" and "reftable" backend.

The issue is not unique to git-update-ref(1), but was also an issue in
git-cat-file(1), where it was addressed by disabling the ambiguity check
in 25fba78d36b (cat-file: disable object/refname ambiguity check for
batch mode, 2013-07-12).

Disable the warning in git-update-ref(1), which provides a significant
speedup with both backends. The user-visible outcome is unchanged even
when ambiguity exists, except that we don't show the warning anymore.

The following benchmark creates 10000 new references with a 100000
preexisting refs with the "files" backend:

    Benchmark 1: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)
      Time (mean ± σ):     467.3 ms ±   5.1 ms    [User: 100.0 ms, System: 365.1 ms]
      Range (min … max):   461.9 ms … 479.3 ms    10 runs

    Benchmark 2: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):     394.1 ms ±   5.8 ms    [User: 63.3 ms, System: 327.6 ms]
      Range (min … max):   384.9 ms … 405.7 ms    10 runs

    Summary
      update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD) ran
        1.19 ± 0.02 times faster than update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)

And with the "reftable" backend:

    Benchmark 1: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
      Time (mean ± σ):     146.9 ms ±   2.2 ms    [User: 90.4 ms, System: 56.0 ms]
      Range (min … max):   142.7 ms … 150.8 ms    19 runs

    Benchmark 2: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):      63.2 ms ±   1.1 ms    [User: 41.0 ms, System: 21.8 ms]
      Range (min … max):    61.1 ms …  66.6 ms    41 runs

    Summary
      update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD) ran
        2.32 ± 0.05 times faster than update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)

Note that the absolute improvement with both backends is roughly in the
same ballpark, but the relative improvement for the "reftable" backend
is more significant because writing the new table to disk is faster in
the first place.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/update-ref.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 4d35bdc4b4b..1d541e13ade 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -179,7 +179,8 @@ static int parse_next_oid(const char **next, const char *end,
 		(*next)++;
 		*next = parse_arg(*next, &arg);
 		if (arg.len) {
-			if (repo_get_oid(the_repository, arg.buf, oid))
+			if (repo_get_oid_with_flags(the_repository, arg.buf, oid,
+						    GET_OID_SKIP_AMBIGUITY_CHECK))
 				goto invalid;
 		} else {
 			/* Without -z, an empty value means all zeros: */
@@ -197,7 +198,8 @@ static int parse_next_oid(const char **next, const char *end,
 		*next += arg.len;
 
 		if (arg.len) {
-			if (repo_get_oid(the_repository, arg.buf, oid))
+			if (repo_get_oid_with_flags(the_repository, arg.buf, oid,
+						    GET_OID_SKIP_AMBIGUITY_CHECK))
 				goto invalid;
 		} else if (flags & PARSE_SHA1_ALLOW_EMPTY) {
 			/* With -z, treat an empty value as all zeros: */
@@ -299,7 +301,8 @@ static void parse_cmd_symref_update(struct ref_transaction *transaction,
 			die("symref-update %s: expected old value", refname);
 
 		if (!strcmp(old_arg, "oid")) {
-			if (repo_get_oid(the_repository, old_target, &old_oid))
+			if (repo_get_oid_with_flags(the_repository, old_target, &old_oid,
+						    GET_OID_SKIP_AMBIGUITY_CHECK))
 				die("symref-update %s: invalid oid: %s", refname, old_target);
 
 			have_old_oid = 1;
@@ -772,7 +775,8 @@ int cmd_update_ref(int argc,
 		refname = argv[0];
 		value = argv[1];
 		oldval = argv[2];
-		if (repo_get_oid(the_repository, value, &oid))
+		if (repo_get_oid_with_flags(the_repository, value, &oid,
+					    GET_OID_SKIP_AMBIGUITY_CHECK))
 			die("%s: not a valid SHA1", value);
 	}
 
@@ -783,7 +787,8 @@ int cmd_update_ref(int argc,
 			 * must not already exist:
 			 */
 			oidclr(&oldoid, the_repository->hash_algo);
-		else if (repo_get_oid(the_repository, oldval, &oldoid))
+		else if (repo_get_oid_with_flags(the_repository, oldval, &oldoid,
+						 GET_OID_SKIP_AMBIGUITY_CHECK))
 			die("%s: not a valid old SHA1", oldval);
 	}
 

-- 
2.49.0.rc0.375.gae4b89d849.dirty

