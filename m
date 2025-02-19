Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BACA1E25F1
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971423; cv=none; b=af7FbT/QRMudPPo2Zgd2goL2MzFsl3OgMw4HWgaSBeY1b+nc9PSXE96Mf/JaEcenOjVuPokbtfAWPSamfl4pswHhGVlZRTQz6IZBYehplQAsQiZ5JzZU6ukFLt1iOO6xfd08OmkU/cXDP55O39+I3RT6Zexi/HKQya9ef4iwVeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971423; c=relaxed/simple;
	bh=XKxtVxuqsFE43JhxGlT/NuQ37uDpyb/85cG36fxY1ow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OiQyWESukhx7vkx6O7u6wLcCARqts8RpdJP/2Y2vtx3rDyswVA9ylSdw7fIHMD2MIQuaHoY/wmLbIL1w9jLPL4AIO3vu1yy7wMUUBcY819jTuw7dU2B1t+i200D/eOPznj/K9Wz/4hBVn0qAUi5h0o3iAFBMwEXckM/XjK6H7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g/Y9BzCL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FqJFkGM0; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g/Y9BzCL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FqJFkGM0"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8709911400EA;
	Wed, 19 Feb 2025 08:23:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 19 Feb 2025 08:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739971421;
	 x=1740057821; bh=XbuW2srf4xkSDMPpv60fJIBGys5GrR76lH4/AS2pQWc=; b=
	g/Y9BzCLbctZuL948TI3R+ugMO2I4abF5rDsH8rBo+SPESnMlK9386wR191dvYu0
	RLeflntXWkJR4Y4ogjnqYY7G5BYBn0ABokN8vU0VCJlAVpkauC/nfkjJAizMNVv1
	9gNChNdMSwzDi+nUn8LWKJvRSnloY8ju+T2XCg2O9wbYi9TodvYfPiRQY1OsNJ2j
	GkeJqC7B798gDKXSIbN71XHOjN/azaehImm/ufyGDURo0lD0V2rxlSQOkS787kl2
	AGtymwi3fAUGIxB6NdwZpCs8VXcO1b9DqDjRBYaiV3ItS6k+E06pR0VGaadoJ7rr
	rPFw5kUfqKNwXGpqoyi9jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739971421; x=
	1740057821; bh=XbuW2srf4xkSDMPpv60fJIBGys5GrR76lH4/AS2pQWc=; b=F
	qJFkGM0J2biC4W8DOrUCnM2en+c5Ra4h8U4u/bmVOsBdAwARv3OUmHdq9oSkauCV
	/bOCd1aoiCItKk2rVIlIv8S0mdTQEcdchRw7wmupipemV7DnnWZ+qPrF7vpzpo41
	mUm51r6u324eXlBwlXzMzBrD+KwhVPZ+iSByswL2Pix4QI6+4OEg1dE0aICpDgn4
	gY+P7cHHwTBbnTtXggPyDMlrO3eCvWcUdrQtALDQEOOMyro9klaGcCKD5STxn5HZ
	zfvRGqNNobcRk59fbGuDIzxIpdHSIU56voybu9JKN5m8aByPZggJZILVpoJpI0qR
	ku4C57qRXTr/5CmfJb6Lw==
X-ME-Sender: <xms:Xdu1Z1AT67G4JS4TBHQC-73V4xnkcgE0gE_fmL1ClOtavpDP0ni9nQ>
    <xme:Xdu1Zzg1J2qkEVwrBhEyTxo-EvBPjCRjc8GXtSF1zHFUluRzUDkarLubxtjWdlqtj
    -EGHYqTgPRyzp2E-A>
X-ME-Received: <xmr:Xdu1ZwlRggMHefW3MbO118w_8zuIUJk6G5xeJc4zsuaMAX3sCv4BP55Wletx5oGn6Vl6C0po0a2uISzTaT66DpmpBcEYfLX4La4SrQHvrD_OY5U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtddu
    ffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghl
    uhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:Xdu1Z_wCelpAGYRr8D02EcMLX96m-GK8WhCVM3LD2DiMI2pkG1AYnQ>
    <xmx:Xdu1Z6RxNanFv15WMf2Uxvh4VpQT_2IuMZ2RtssDKWACTW2eU4Q-Mw>
    <xmx:Xdu1ZyZX8Yu8Jy1ZkvqUp6yavTXuOZsiz0emlLNDdeVSGpTdZ--Lrw>
    <xmx:Xdu1Z7TQsydsvKwlePPVIKQoBDVbM0jWju1p70a_des_UqRmmu7rlA>
    <xmx:Xdu1Z3R9KFIDpaBqBxCxUxVN4mh5qQkSrvbCXG-nHw1lVIpYZ2XwGHxX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:23:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id abf4145a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:23:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:23:30 +0100
Subject: [PATCH v2 03/16] builtin/update-ref: skip ambiguity checks when
 parsing object IDs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250219-pks-update-ref-optimization-v2-3-e696e7220b22@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
In-Reply-To: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
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
 builtin/update-ref.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 4d35bdc4b4b..d603f54b770 100644
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
@@ -772,7 +774,8 @@ int cmd_update_ref(int argc,
 		refname = argv[0];
 		value = argv[1];
 		oldval = argv[2];
-		if (repo_get_oid(the_repository, value, &oid))
+		if (repo_get_oid_with_flags(the_repository, value, &oid,
+					    GET_OID_SKIP_AMBIGUITY_CHECK))
 			die("%s: not a valid SHA1", value);
 	}
 
@@ -783,7 +786,8 @@ int cmd_update_ref(int argc,
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

