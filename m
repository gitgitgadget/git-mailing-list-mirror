Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62720D4EB
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273729; cv=none; b=cqY0t56r9yeUxmGylacrw5mkU2RJ6Lt+LnoWOO8U1n3ZdqSFfV2D13m40MQdy46EFcsuMG+0hwmi8sdPRB59U45m8Rt+XEsil0U2BboRduOzU037rTwXTPFIzTpF+mXhmKmm1MxjDDqsFXbHV+MHV3uXjpxUITsV+73HOISQdJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273729; c=relaxed/simple;
	bh=Bj59QpE5CmuY8gGaz9xpAji0XBAG/hRpO5VBer7nPgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mPGdoAu66UYdW3c2f4brdNIMUQJrxtqYs4TUMEVLHzNAgn/FxkwBRp6vv5VA8rqSE6cB+s2cb4lzvm8iJG4ElDTc2WmXgatS40XvcflCK4SNGwbTPdiC03Gb4dWcUcUFXUwJP80Y77WdUqGIy1ugTmMTOQqF4waHPAB/H47FDT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cDVJwi2Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EF5Scycz; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cDVJwi2Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EF5Scycz"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 71181254016F;
	Thu,  6 Mar 2025 10:08:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 06 Mar 2025 10:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273726;
	 x=1741360126; bh=3GFK0R+2Yi1vt7crwjEysdxfkATZiwA48VLZos2UG2U=; b=
	cDVJwi2YxrXaE8oVZWfXfrM4it9P5L58xqd3luupbhUECLruNLajJWb7nbIB9DDZ
	fq+WTfwpYHRcN4qC0Us5aOlCoXophrYTPsTChe7E3Yp3yFwdqfWxaz61C8LVlopB
	naNGYoq6bSMEvw2gtkfZGHJ+wTWM3grHbS3Rk4p7uCQbfT8IjsBHQecn/oF/ze+s
	k/zDMCAcXzD/QOZNsYPxiPjQx2sduo7SnvHETfAPJrhqXsvF3hVh20QiQ7nn6C+d
	VU6BJE5jPz59BrZAKDlwADY4vNQ/LaBJcrfMKFJmfTqXsMmYcIbZ+lWyMFQWNJxc
	BiP80sbg/98GC1eZJVS+rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273726; x=
	1741360126; bh=3GFK0R+2Yi1vt7crwjEysdxfkATZiwA48VLZos2UG2U=; b=E
	F5Scycz5KCDYAt5Lw6SHVzNDx5BZ+ta42yyZO865ItpbdlkeIpuRZSaprPYOPKri
	Q5UJeDhQHeFahXSzxKBXp5MqL0yHnsUeFDlGgRP9HMFsKWnyj48Y8t/1z7zJUplF
	rOdP0+SxQrXx/KbNsznPgV0s+ZzEKTDgKn9iSsy4FceriDAwmijPyr5nXcwOhrTb
	qMN7rq3bw62ALwkQk5BONqzducL/C9x56OMdWmGdcoQS1mGpIeg2ryF75BKFJKD+
	aY8ddnPgd9wCWPLuPeF6dlNRM0ykPnlKJ3U8rGzBeq9Dbx2rQmDomDJnHmMPwOQ/
	x4xK1AKfsvGWJNKxWwm3A==
X-ME-Sender: <xms:frrJZ9PxypD0QC5S6xUYbdYIpF8VQIpMtwOiYdCzgeX3effF8XmOgg>
    <xme:frrJZ_-kJizgniNCMSR4492-KXaPXRBHYnZywguKM8eaoYdSrUDE8CrvjPCIzNC3C
    DLudonIotjexnu6Sw>
X-ME-Received: <xmr:frrJZ8SyJbmUsalRv1FFPdAYNbqpEaWra0YQWjQGU7dT15NMFLCz6G0HH9nWcsKB5bBZ0kg1PCiPZihRTgRayaBln3gT3XzOJ6h5g4NnLMYVAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdt
    udffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpd
    hrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:frrJZ5uhPL3AQWfxwg188IKktbrnhQDu7QyxFr3UkFOPmuyyibd_PQ>
    <xmx:frrJZ1fVKa3MW8phTa-_FII0hSZ93dSl7h4x5hG0FZds_om1zNsQPQ>
    <xmx:frrJZ12clu_GUGHVBkmSxqCn06-BEocnaFwVdqVZZa287Al-g9xhow>
    <xmx:frrJZx-z9ZG6QgcY3GkGKgkSzMl2Y2dZmKcar2Xbm3m3pIwXWldi-Q>
    <xmx:frrJZ_tsD9nxW4FktyIGFoFkxC2HCQK4miOecGL-e34CcQww4QsemErf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:08:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 696cd2fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:08:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:08:34 +0100
Subject: [PATCH v5 03/16] builtin/update-ref: skip ambiguity checks when
 parsing object IDs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250306-pks-update-ref-optimization-v5-3-dcb2ee037e97@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
In-Reply-To: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
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
2.49.0.rc0.416.g627208d89d.dirty

