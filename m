Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7239325E469
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473766; cv=none; b=VhQ56NCxPhb+REwwWYW65pKmrtar7Lin7/KeEyJWw4EUHJJsgzv/MM8Ac8dlA8dW7qsRq+XEvYLRLsZM/d9TPFwXCHpD4Gg7QYn+3Z9cN8obVU+z2vNJ+66V3SxwY3ULmzVAnpDGEfpbbhJDmIOO9t0stW5bd1KjukF6jEnjByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473766; c=relaxed/simple;
	bh=lTKGZtW2zf3MNWro1o+HdvTuFnw9elX9AxdZHNSOZss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gq405gaD4ukN7AyeAKiYOcEhFgty7YVGkIIdzrbn12XD9ZrVYkySLL+77yeSnaA1cYiPNx/Xo21rG8Tuzd9xhg8jvvAR5E6o22FvrEM/jSTbV/9LUzaMQbANqjYzsqK2J5l6dvHfvIrk/9Eig3uiB+aBK6qfnEJ7PufdD6PuGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bG+SeFQN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vqjbaGiH; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bG+SeFQN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vqjbaGiH"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3439F2540175;
	Tue, 25 Feb 2025 03:56:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Feb 2025 03:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740473762;
	 x=1740560162; bh=sJeCZYPZBOxMGQJ0YiGbXeyVB7lD85cCy+Z0y2lgfe8=; b=
	bG+SeFQNKu/m3oEmudtbMsPI+E28rNZPhDXBFB5XuUI4pGpOGcs0CJ4yALrEb0/b
	cBr0YFa9IRU1AKVHrTWEUkfIJsrKQz2ZPVrC5Ql15hAzcYUlw3k/U4Kx6vO1IkEy
	bGKxt1axEsrKfyuPwWmCFCYjIypGvfqML568LVjU1JgjX1PitytILmP9GM9SwQlE
	OWMGYvJjUXUiJ6lHsXUvv0SWtRPUGOFuwgwM32F5Oj2MC6/ZJ2JQcZe8f1K86cTX
	RZmKAKnH9tafnn3Hk4licl5COzCUhRWzWZoV5r7b8nmuzQd194IMXhSru0Jy885J
	qp5Dukr/cYMV7YSkAH4SgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740473762; x=
	1740560162; bh=sJeCZYPZBOxMGQJ0YiGbXeyVB7lD85cCy+Z0y2lgfe8=; b=v
	qjbaGiH59A6XfE/u0vF4Loqqz64cl0NFA3QqIPaHJFcEkGTIg1mLy42sUrfcimeu
	LrZX15sWjBVAQ4RE/k0ZAX41DprG4uKhUpFiPajgmSDXKtoMYQENIq/RDWzhX8RN
	PwrunfUPGM6m/7SZUcZaULoechEaQVGNjIaZ5J7IG21OkuYGGqrncvwm0APuW+9O
	LvLMEYJecmhefgxRtXeHk84zG1H78n2L0TVNqSF9qaXRH5qzX5BWt3CgH8GxctFv
	n0k6lK8N8NGt8wxhB9nfXNr5BauaIom8MIFDiHwbkzIh9dDLXMuId+DGLujvPvlD
	RORx3LlRPpAc9xbWxSZAQ==
X-ME-Sender: <xms:ooW9Z1RCPtwSZUGNRmTzEHfLnTNJZefDvZCZ-iMusvVeIKpW0KBfsQ>
    <xme:ooW9Z-zRf_tqM5cbDjEpkSLoAIbC2C8ID1iS-0lvzdPIzTSGCBDX1S4USAiowRiHa
    9iZSXBeN8YJjc_Jlw>
X-ME-Received: <xmr:ooW9Z63B9hCtgP3cyz_gcacZ4q5Mu_FahUvFQzAhm-a4hWMmkiTK-0Ay4rCghE6dvi43wgwvanr0wgTw7nyaUkpRq-8d0iB-j7TjuiYCOhSDWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtddu
    ffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehshhgvjhhirghluh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthho
    ohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ooW9Z9BQccGVAPScVUS5m0r0hIESTXL8LoB34vQs3r8Pwy0Vw5yyvw>
    <xmx:ooW9Z-gM3kejWIY-G3PTnzo5yXZeBXrTtW1DESd64bp3SMGtJ1SsgA>
    <xmx:ooW9ZxqL6q84yFZqRctu4S-03XKpKJ0UsePKjbDJ5-mntiXzzvaZVQ>
    <xmx:ooW9Z5gnbNoLSHqOJY8vT8bx0BPkvvnkzcqv_GvKVKURLVJC_IjXcg>
    <xmx:ooW9ZyivcWwiJxCKD-g7I9qk-y6H_MJySVXIVgSyZ4WwALm0u6fVDqg4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:56:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8b1b44e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:55:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Feb 2025 09:55:49 +0100
Subject: [PATCH v3 03/16] builtin/update-ref: skip ambiguity checks when
 parsing object IDs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-pks-update-ref-optimization-v3-3-77c3687cda75@pks.im>
References: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
In-Reply-To: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
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
even knows to resolve references, despite the fact that its manpage does
not mention this fact even once.

One consequence of this is that we also check for ambiguous references:
when parsing a full object ID where the DWIM mechanism would also cause
us to resolve it as a branch, we'd end up printing a warning. While this
check makes sense to have in general, it is arguably less useful in the
context of git-update-ref(1). This is out of two reasons:

  - The manpage is explicitly structured around object IDs. So if we see
    a fully blown object ID, the intent should be quite clear in
    general.

  - The command is part of our plumbing layer and not a tool that users
    would generally use in interactive workflows. As such, the warning
    will likely not be visible to anybody in the first place.

Furthermore, this check can be quite expensive when updating lots of
references via `--stdin`, because we try to read multiple references per
object ID that we parse according to the DWIM rules. This effect can be
seen both with the "files" and "reftable" backend.

The issue is not unique to git-update-ref(1), but was also an issue in
git-cat-file(1), where it was addressed by disabling the ambiguity check
in 25fba78d36b (cat-file: disable object/refname ambiguity check for
batch mode, 2013-07-12).

Disable the warning in git-update-ref(1), which provides a significant
speedup with both backends. The following benchmark creates 10000 new
references with a 100000 preexisting refs with the "files" backend:

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
2.48.1.683.gf705b3209c.dirty

