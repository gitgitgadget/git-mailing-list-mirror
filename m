Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34573E00A5
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 05:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792042093; cv=none; b=oZPGxRTgOTFmsACsY4Tyiu3NgBVvigVVFYF52FoqfBhW6UftJjCHBvnPwn+0FciM8xWVkyA4a+KOb70FCvqIyH9bTga2EaZKlsH1UXoulSfQX5gut9dkZ0ADL8IWeHwcgOWUetcFx0sE1PGMWjfv5m/VkkAZ1/30n5cgU8ftuXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792042093; c=relaxed/simple;
	bh=cpLqzlKZ7aif3q411cPhk82D0UQPQwvrdUtlR2n39uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UcJCW0E+Ve9DHR4aAqvE3oFuTnWa5u8MJ395z3Jig/FoUu9ERdtco37EHixp77hOErGyRE6c2ttzoPVtvRyGO+PSbDm5Rp8DDwLxL9rnOYUbzT/qyZw4qwdQ8Q03E/T5prl18qT54AKvdpGdlIOKXQpIUq7DQTTS/MDmzqsIBXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vOstfsFK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UysGtQHV; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vOstfsFK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UysGtQHV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 04A8A1D000D0
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 01:28:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 Oct 2026 01:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792042090;
	 x=1792128490; bh=omOqjPjs2XiAsDziuBoSoU1YMoxMXomynGcRT/u46/0=; b=
	vOstfsFKhWPP6OjMWd7PD3mNj9a3p8QDlvLCw6/N4cacvAx4SwFciF7Q6HRGIRka
	1yHFn4rSC0cfFUDLeTI/zXswZBE1BdJCc3GlW1Z+M2X0nfxqxbkKPvXip5dOWkt3
	5QVObaaKWAMzK8dqYB3X/jlaUqB/yI6kN+9m5HhmKCdh+YLaxmS9yl6PwRCtfeJq
	W6xCzjBm3gFsosQJFbTP3lE9LbtS0lAk/nbEg3faoV3oTPSiGpWkt72VhG+ApW0z
	KriDm4/rkB5swCK8RiT0teBK8hYPEF0CBj6ckUqVa1Of/32j+uAprOFplf39uhfb
	oSrQ4wJsIfQejacljFCtYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792042090; x=
	1792128490; bh=omOqjPjs2XiAsDziuBoSoU1YMoxMXomynGcRT/u46/0=; b=U
	ysGtQHV5vi/M9HRLbhXm5LIQsRb5TnFmg6JCmkrTbL0a47mmUW0cKwVSlfVn/ygW
	58QE4IsLfzpeYoTPCAfn6ntSGc9lss2sT+tURIAcJi/2PyjKj0HGlgUWuyHDF0tb
	mECLwFWfGsxroYbkWJteBB7vltUmaVcZk3X1SqPELYP0FNDF/xVNpovTQUZA+tPF
	xGkCoKe1baEqQAptt6nFCxSGX6iCmYry4Tf0NyZASAQFHw5qpSRu6FP/UrQcfcQZ
	MQ67/Pes2Ph60GjzSoII5ehEfQ5/Skd7NT+Hw70pI04UdhX6etlDkflXigqV5DwK
	WDUzkUQqiXTIxT5DMsuBw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792042090; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SCdcFKEfOa6b5w6+xLu0RUD372jKLtcxPKB3xoSt+MwKgCj
	Md52jQLr4QKg5mFPnUyDrgzo5DrJWLts5jQEEl5SWzN1pgAxI6bpgnVu/kPdTx6Q
	pgKJwi2JGnmrJYJphiLE/ja7/0x41iv7U4r5wJoiF/TaSouNUABBhMMjSrUVf4EX
	QXFdyx5M3go6mxe8b1P9lY9zAp8Y+Ea4IKT2FgzJI01QfOlLYueNXLWK3eTe87zH
	cRSWxkaQFZ9MP8EvnAPT/RP4BzZUXjGKFIHM7hP/hJLZdR+nTn2rrRK07yEDnUm0
	J63Qyrwj/PTenLKCCrSeq/2fqC3Rtu2JbAsQ0NA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:UURnUfvANXlWqL+obFTrO4FMRbEOSJUM83pACIJymuk=:cpLqzlKZ7aif3q411cPhk82D0UQPQwvrdUtlR2n39uk=;
X-ME-Sender: <xms:amTQan1XJ7X4gHXSCAjsjW1A8jakb8LQg89OzShbl8-kKE3KbRDQ2A>
    <xme:amTQas90w6J19CENDx_q9mHY0RX49bRvmODEkNh8VIAo2CPzDw28DwHMjynk_jtZ3
    tdfl73i1f8pVERxoxdNv4qFHQkfvA4W7fzHfqy8Ucy47SKasSGdsg>
X-ME-Received: <xmr:amTQagNJEbyHo6KCn8Ag55RL5MsT_J329I0WB7kZfgySzlviP1-IUVIcRfvg-TMfVZEEbVg>
X-ME-Proxy-Cause: dmFkZTEa9JLFP211LHCPYAkcBBzEFk1IhJ4kgxZx+xXJTLD0p3Ey6drVVWQQL5l2AdU40C
    Ac/CKiFIR0gvL9/mDakqsSAPTjkzbS8TdjwpghFe6st3LJKw0bvqDCWGmZk+tpLVzFgW6k
    LTxfDRjI75E80+A7aT42+66KrxDs9tRv9a7kBslu1G2DcutR7sMdUSJPx75otId12kNwzZ
    YQW2FwQKLs970Txkry9K7eJ7JQmy6JHi1RpoHkPyOsFTY361NNI0H/W7dfkG4RTaraEMDN
    4CQW2BcGOU9oJJeVo8k4+AgzYKTE5w+nmis45BGjp7iaV/ypNPjF12zEkbDmn78vjVHxh/
    l3P8cvtkwGwXvqrBAfbW6B9Ec48s9ccZD3PV83aJPhcWQFYO0FvsJz5wqoMlKOMaxqUPao
    /bUfQwzthJ7qmZcQPkYZnsBvMTczhT7z0XvMVM0Ouwvro6ql3VWUvPp0jRiDqeCZOccAOV
    HfNa34jhcHKaN2Q9DxZkIdn5g0XLKc0cIUe97JgT3kDAz5pE6TPcMcfVNs9XUO5+FBmMOZ
    SGo2Jz0sIHPyJjPh5goVoxopkPUSe0HQaeer9ziVFzCVmwkontDDCH/Plj5vfxwnLrjhkC
    zW8KLr9zXNEtfzHUV7FKimP3MoqAhLugFu6XmtWbfBow9A5j91QHzj2OVZFA
X-ME-Proxy: <xmx:amTQaofyWQn3oPVa4tqH4VWi0qvm0GyDYtOZL-G_qz4mrP7iSE9h9A>
    <xmx:amTQanVKu6aWUfxdrG1L0gMBle6cLMSk4vv8kYwmWjqUReWrbzVC5g>
    <xmx:amTQaogrfGBRkgHXg4pM2cKblOZln_CrEszjbBUoNM7-SZztDPnJNw>
    <xmx:amTQau8AlAvly-nRmjdi1gOMjQ14V1Ix_tx98UGU0FAxG-GNR_EjbQ>
    <xmx:amTQai4HFIq7-inCLX_HxhHIiw7HFUvfOHNUF8xcUWilENSD2mCjmMB9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 01:28:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a6021e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 05:28:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Oct 2026 07:27:58 +0200
Subject: [PATCH v3 4/6] odb: remove read loop for found objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-pks-odb-files-alternates-cleanups-v3-4-bfc62fd780eb@pks.im>
References: <20261015-pks-odb-files-alternates-cleanups-v3-0-bfc62fd780eb@pks.im>
In-Reply-To: <20261015-pks-odb-files-alternates-cleanups-v3-0-bfc62fd780eb@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>, 
 Justin Tobler <jltobler@gmail.com>, Tyrie Vella <tyrielv@gmail.com>
X-Mailer: b4 0.15.2

Before moving alternates into the "files" backend we had to handle
alternates in `do_oid_object_info_extended()`. This made the retry logic
somewhat complex, as we had to juggle reloading of the sources, the
second read and fetching missing objects. And to handle the potential
retries we loop around that logic multiple times.

Nowadays though, the reload and retry logic are located in the "files"
backend itself. Consequently, using a loop is a bit on the heavy side
and makes the code harder to reason about.

Simplify the logic by removing the loop. Instead, we explicitly re-read
exactly once after having fetched objects from a promisor remote.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/odb.c b/odb.c
index 69a4c203bc..095183aec0 100644
--- a/odb.c
+++ b/odb.c
@@ -265,7 +265,6 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 	struct strbuf corrupt_err = STRBUF_INIT;
 	const struct object_id *real = oid;
 	enum odb_read_status ret;
-	int already_retried = 0;
 	bool corrupt = false;
 
 	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
@@ -277,38 +276,39 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 	if (!odb_source_read_object_info(odb->inmemory_objects, oid, oi, flags, NULL))
 		return 0;
 
-	while (1) {
+	ret = odb_source_read_object_info(odb->source, real, oi, flags,
+					  &corrupt_err);
+	if (!ret)
+		goto out;
+	if (ret != ODB_READ_NOT_FOUND)
+		corrupt = true;
+
+	/* Try to fetch the missing object from a promisor remote. */
+	if (odb->repo->fetch_if_missing && repo_has_promisor_remote(odb->repo) &&
+	    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
+		promisor_remote_get_direct(odb->repo, real, 1);
+
 		ret = odb_source_read_object_info(odb->source, real, oi, flags,
 						  corrupt_err.len ? NULL : &corrupt_err);
 		if (!ret)
 			goto out;
 		if (ret != ODB_READ_NOT_FOUND)
 			corrupt = true;
+	}
 
-		/* Check if it is a missing object */
-		if (odb->repo->fetch_if_missing && repo_has_promisor_remote(odb->repo) &&
-		    !already_retried &&
-		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
-			promisor_remote_get_direct(odb->repo, real, 1);
-			already_retried = 1;
-			continue;
-		}
-
-		if (flags & OBJECT_INFO_DIE_IF_CORRUPT) {
-			if ((flags & OBJECT_INFO_LOOKUP_REPLACE) && !oideq(real, oid))
-				die(_("replacement %s not found for %s"),
-				    oid_to_hex(real), oid_to_hex(oid));
-			if (corrupt) {
-				if (corrupt_err.len)
-					die("%s", corrupt_err.buf);
-				die(_("object %s is corrupt"), oid_to_hex(real));
-			}
+	if (flags & OBJECT_INFO_DIE_IF_CORRUPT) {
+		if ((flags & OBJECT_INFO_LOOKUP_REPLACE) && !oideq(real, oid))
+			die(_("replacement %s not found for %s"),
+			    oid_to_hex(real), oid_to_hex(oid));
+		if (corrupt) {
+			if (corrupt_err.len)
+				die("%s", corrupt_err.buf);
+			die(_("object %s is corrupt"), oid_to_hex(real));
 		}
-
-		ret = corrupt ? ODB_READ_ERROR : ODB_READ_NOT_FOUND;
-		goto out;
 	}
 
+	ret = corrupt ? ODB_READ_ERROR : ODB_READ_NOT_FOUND;
+
 out:
 	strbuf_release(&corrupt_err);
 	return ret;

-- 
2.56.0.212.g129ede20d9.dirty

