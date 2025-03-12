Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4CC2571A6
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794980; cv=none; b=VD9KiPJZYVVrQ8wFEMM0EfjTPEtJpjW53m43une9IqyFz7tKZFNKZIza8AZf6eozAfb+MUWeImbopLeYVF7xnZqhtTCsMU1ldCx7AjNqOoh+5CGBvKvQ8J1J9xgSmfUyoUztCXIUNiBhKNIphle/FAQDrvFDxntA8Hwh3tlOtMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794980; c=relaxed/simple;
	bh=UEQlJe7aVyXCfgy8qDCNY20ApVIz/18SbwSHOrhd9dM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GuDGQSqzqlc9/wAEitQewRz8pK9CrNiulHTc0w6ReyfhzisxVs9JAal0dSYGx4xh+GAhOVseuBMUSnv2YChtZE0xGQOMwAiqe1m8AXX/mTL2pSVtGRgwFsIKBJoxeX7S3VGlf/A8i8pVqidzJLJ9QG/+cmiOpq4N/n48YLmtCxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NCrDVEz4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YSvMnSfX; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NCrDVEz4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YSvMnSfX"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 787C52540312;
	Wed, 12 Mar 2025 11:56:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Wed, 12 Mar 2025 11:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741794977;
	 x=1741881377; bh=IwM6MUJPchaH0pGEK87waKftLh0xe4LSG+oJ2KQbL9E=; b=
	NCrDVEz4z5TeYTbwWZZwtH9feKmXa21vqNo/lfl36MDL26fDtlbbLs+RaO/r36Ht
	tT+VurPMVDj8WPnMiSJGu6VZgGi7+Pn9irULpFb0fLi2zoZlNlAg12KBV6ypiyf4
	C8PFQ4YXturT4FSn32azVN2dicBNK4JhlUZG+tEAevgEGJkOrCGsE2GkmVZiGOdy
	CAP4QtUoFZCPSEX8Z3ZKgskyK4wJdOwqAN/5CXpUwzAlAWg98lsLMTMNeRYwpuR5
	FIKfCVOm7jrCgAf+L8LpxuSBiWyb9XgOWjqfbAtNAJOOV9vxyT5aBp32BDQLCapG
	xwJfWdZ1vxS+qjaz/qbcsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741794977; x=
	1741881377; bh=IwM6MUJPchaH0pGEK87waKftLh0xe4LSG+oJ2KQbL9E=; b=Y
	SvMnSfX7mu/L1k5cd9fC6OMG6NblhUtc3TFV4EV8JDx4PgqBy/CiaSGfaE1y9cvL
	/lJPmN/wVojtlvzacgoocOF0Sua3yMW48e5lapXTANIG/jngqHziAA/sc1A4B4ZS
	3ChfELGsttSCCC7+5PBDQmOdPBRbhxuNeLnPgzxJ/ev4+RtoHzoHtLCO31wiQToB
	fetNmxXjK+Ob1w1ccQLy9qIjACERdMzhlhUzP6CSrVN6SmXA0pCdfXDcT+sIlVJr
	v69fdwBAXE+T8+aLb908eiJJ18wFh3AIi+BIZM4AMK9daCU6N2rRGBxcsmYkTqcU
	n63V3zxN94tLXlEtKUgUQ==
X-ME-Sender: <xms:oa7RZ1wnZz4v4gjS-kNjKe7OtI2aK6lb43N45fl_-u-1oCVlCT9T-A>
    <xme:oa7RZ1SGDpgpiM7XQ-H5hQ9KFdJ4Qu7TNn12z1wyC7tS3bqK0e6d4CiC4RLj5LTld
    8aRXlaivOzKYNx4eA>
X-ME-Received: <xmr:oa7RZ_UBr2884rMWUyrVY-t9UZNwUmIKbXFzi7rHwEq73yVv0jRFwdoyRHF-xv04V8UuMJl51XsRvyNquyE8XvTXvqXPTP1IKMIiRK4Ts_aSsrY3iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdt
    udffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vghtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oa7RZ3hfBVJW5NL8OBruk2icVjaPfxc9-S3irvBxpNK3byu0OlHDIQ>
    <xmx:oa7RZ3A68w687jYb4gLBhqXOd1MCAJVjFUokFITByFcKFCUTvnx3IQ>
    <xmx:oa7RZwIeN2RMbfmuTO0AHfcBg-oosQSblcCmMzSVnJgyZxGKBSkdbg>
    <xmx:oa7RZ2Ak4wjAaHffcd8wlCgljuuHjETN_aiDizzKvID7d32Audh97A>
    <xmx:oa7RZ5BNNgmEoyJcuEbVClQyA-bQxWnROebos0jKsJN59LciHQazkewP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:56:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c5def754 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:56:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Mar 2025 16:56:09 +0100
Subject: [PATCH v6 03/16] builtin/update-ref: skip ambiguity checks when
 parsing object IDs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250312-pks-update-ref-optimization-v6-3-f778e0414f55@pks.im>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
In-Reply-To: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
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
2.49.0.rc2.394.gf6994c5077.dirty

