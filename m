Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5323F5BCF
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531835; cv=none; b=Ddru+9eEA9gOO4Oke00TTis3/290ik0n4RxzwNQXc4Vk14s/bLecky85aAOlL06+vzFZNWqFs+fm1b1mA6A7wu/7pAkcKuoL1J4JlIyXjfb0AKUnTT/giCfkHRJNej0PXXlzhdh/KhUw1kt8xdP1Sl8j6Euu50NSgFS3HWzYROk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531835; c=relaxed/simple;
	bh=hGgGNrFRDPADZxOxN3sDuSeBp7Vdi05GNV4T8lHyFWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFDM/dktOWvoPR9bRX5R1dabXSsOxPu6zwsMt502MDvxMhdtB3bCbgraJNbQObyRtiS7DSHJI/5oiX5wUtDnYAZQbf4n+y2a9eM1ShuYGAo8pPQUWi4E0eKquTr1yPoCZ3q5TxRTG2qcyX2u+upSBWGXUf7ruq/IWTBPalYEb14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W95bYrOE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cqIbjhKA; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W95bYrOE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cqIbjhKA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7A1011400088;
	Mon, 15 Jun 2026 09:57:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Jun 2026 09:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531833;
	 x=1781618233; bh=DDiJy7ny5X0qllDWE+l0rwGuhyFKZqD6i1rRx1upTTQ=; b=
	W95bYrOEg/FjielgNY5E5xpiuSf/kfKaUotFIcK/oOzQx3jJ2nsy1Pgzk8MHpVcM
	6HJQAxFpPMDC7XQqj+rS9Uv6LrT7gaeWuO8EsocXTkfNznJPuDDQ7aeNaZhSZ1Q6
	LIsXyG0r67h2KhBWDCYOtpHFa3ek5v/I614FFWNWp2rctxAVtYudnrE9HqYRPS96
	hf4NRE9cShsQ00EyeBbvPz2lgA4ubtgK392k7gGe2xUJ+wJizrq0Ngo1+xUM+Sa7
	zaFrS0o9mQlX5wT6ULesVaRZDxS1P3BkasmRJeG/DHunWExz8CsNOVBOZcQNYm+J
	WSw3uj2r6i+81QvR0ncK+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531833; x=
	1781618233; bh=DDiJy7ny5X0qllDWE+l0rwGuhyFKZqD6i1rRx1upTTQ=; b=c
	qIbjhKAq6cNSBlUKjSN/3piC6MrCP83pPc3NJrcY7i9CmaASA+gVAkskYxMxgZMK
	NOjFMrHPscubsK+OdVZAR4+r+QDP+dJ5bZzJLVW59migeRJ9B//JmBnFBKgx27fY
	NgtkO/F7pgTfO+WvYR7BWF+bZ5pPYXsAorsiXpPoQJpuw0PAG/geFT1/x6ILflQb
	Nj/u7o23ctIHl/08PokJ1Twkz19J/aKSmZjrVbec5M+MyOsOb4gRpX1FjmnkPAsg
	fyXbQYUOqVeFm8/oWUFPdS5pg3ILm4YlhXD5kI6t/MFvnaxAw1BjR7jzSuRi/Rgi
	p4J7e00Z/7RHO0VgoXrlg==
X-ME-Sender: <xms:uQQwaockM181ui-vLkRPj1bgncHje7kTt1EJzXzmhFHSNjgTEqfKeQ>
    <xme:uQQwahrP3eucSS9vtpzor2qFX9hDk5VD8syxqipCPre9AcOOD0zjlPSy3tV2hGEj4
    RSeKAls0ad55rfS35o3Dc9iV-GgKHy6Mw6Fo5AqmR6CoyTlz0PVkw>
X-ME-Received: <xmr:uQQwam6S-GFPr7XhiSpK-Ybvyaj-mBAOTfPTTd3gm4Ly9QlCOEkJl0UQuyOIWsqcOnDgxU-GgyPd2JmX-GEsmKmGXyOvsUx8VIOiPg-8cA>
X-ME-Proxy-Cause: dmFkZTGFhnwv/YvFh6g4CptNd7XsyKN95Web0ZIZs4XMP2v59A2c8hDhZ4VNJ/MQxBhMoI
    FWZ9GvenrC3kM7RRy3k2kxBtkzeIGwjw8dLo/RpOMYqK1kz3TfFEo7V8uaLwaE7NQYHF3I
    wfF67zuCkHSv7iQgvKBFFp6OUjP0P3VEOUQIt8OSsqw2klesHbMKhOydcbE6VEmPPlIPNq
    ZySPByW6p2jKJ0N4UqPKjGwqXr9fX/2NZVLxm0BYmDIPXuoILOsOLWVhQptj77pEZp+d72
    CziUcfUBHDeap8uqtsPocxWbqNRndtyNwiJlbnFM0XNN1VUAqQL6wbZ0+VSk9v9/mJXbLe
    1dTQS4z+U0inJxWHjoIAlUkX5BMICqL/zp9zZ0RcEHWgM1sx9bJawkWYI8QhmUebZ8binW
    zGykl/5YhbZa/pteWlk5oWTpiVK8dY29gvAK38ZeT0xbs7ks7z2Vk2PWodG1Dp8dUJVylM
    gT6AJuPP8ha+i7UXBBQOXP87IKf80gRSz5augmEFoD6N5Q1G0s8Z/XR8zkSMZmguAscy6S
    gLNzXqPkVJ7bW3mLNz5WvZca+uZ4Gs/MNWQtGSHBZW50i9cXbl2cKF4IX2C8XBTMW/H56L
    h+zHRqCti+I212dIPQVWCj5qJnX/wgec9ayzXCYmzCICVbrvwpowFSBFvKSg
X-ME-Proxy: <xmx:uQQwanqwl1S2q0Ily_M4MyqTmayu9vg63yQns1BLlGxpKjQoTN7Yig>
    <xmx:uQQwaog7_TMpOsAnWVwtanaJ8lmUW2WIBcOx50rVFy3dTOpP1ooddg>
    <xmx:uQQwahIKQIKRIBcygX4ADbJLuj6onqCjG2H-clvhjhlMWFsgmXaaJA>
    <xmx:uQQwaoB_u1BCst_dlpQAmqwuDaS5dHpTWJSP21eCLmLlN9yR6vz4TQ>
    <xmx:uQQwahWXPvRDtSc4VD67hrMYAZW96m883YD0U1jeSFWORaU1ZZGTwRAB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:57:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 93baacf6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:57:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 15:56:54 +0200
Subject: [PATCH v2 8/8] refs: drop local buffer in
 `refs_compute_filesystem_location()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-8-f4854aa99859@pks.im>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
In-Reply-To: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

We're using a local buffer in `refs_compute_filesystem_location()` that
is only used so that we can fill it and then call `strbuf_realpath()` on
its result. This roundtrip isn't necessary though: `strbuf_realpath()`
already knows to use a single buffer as both input and output at the
same time. So all this does is to add a bit of confusion and an extra
memory allocation.

Drop the local buffer.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index e69b9b8ac8..4912510590 100644
--- a/refs.c
+++ b/refs.c
@@ -3571,8 +3571,6 @@ void refs_compute_filesystem_location(const char *gitdir, const char *payload,
 				      bool *is_worktree, struct strbuf *refdir,
 				      struct strbuf *ref_common_dir)
 {
-	struct strbuf sb = STRBUF_INIT;
-
 	*is_worktree = get_common_dir_noenv(ref_common_dir, gitdir);
 
 	if (!payload) {
@@ -3586,8 +3584,8 @@ void refs_compute_filesystem_location(const char *gitdir, const char *payload,
 	}
 
 	if (!is_absolute_path(payload)) {
-		strbuf_addf(&sb, "%s/%s", ref_common_dir->buf, payload);
-		strbuf_realpath(ref_common_dir, sb.buf, 1);
+		strbuf_addf(ref_common_dir, "/%s", payload);
+		strbuf_realpath(ref_common_dir, ref_common_dir->buf, 1);
 	} else {
 		strbuf_realpath(ref_common_dir, payload, 1);
 	}
@@ -3600,6 +3598,4 @@ void refs_compute_filesystem_location(const char *gitdir, const char *payload,
 			BUG("worktree path does not contain slash");
 		strbuf_addf(refdir, "/worktrees/%s", wt_id + 1);
 	}
-
-	strbuf_release(&sb);
 }

-- 
2.55.0.rc0.738.g0c8ab3ebcc.dirty

