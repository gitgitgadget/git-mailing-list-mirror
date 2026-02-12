Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B829E11D
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770879596; cv=none; b=IWkkDrImVJ0Co78x2elZat1qKFIHR0e/29TTOY1G6HMjvNfu5vStTcluvjeir4PRHnP7rxDNnlrOvmjO+gKPk9rbWzzx7bVxATL27eZ1or3jdjXZRC+96xyAikzTsDNGG7pYFcWJFNsyIfH1vzovm3FPrs6l5vV7OJnkjyK4q+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770879596; c=relaxed/simple;
	bh=SzLxmdDhipvRxsK9U7N/GJL6hydppOt/UZkf5Ocpado=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ITQrQHCmYj9ke59Mtvsa0Q6pcIxyinU4sUb1oX4DK/FKxm1mqPeZmpl3bXb1QrBavuh1QIH2RHMVfTru9zru4hRFn7StWZlRRR794QxjrTjxQQp6j1CcsC8b0kEM+LTVdgCfwc08X3AOOLc7Bn4ME3+SdjwViOznKHR8yL992T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RqLB/xOV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IaY79MlQ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RqLB/xOV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IaY79MlQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 440C0EC05C0
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 01:59:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 12 Feb 2026 01:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770879594;
	 x=1770965994; bh=zsUyiusjxLZR0qPPhv+tJRupkQjaZ196eEnqZe0jx0U=; b=
	RqLB/xOVOWahPD+vYJCNJkDuHNqpE+F4QO36onso929+/9gizrOCngMZSPEC+ggp
	yGycnsXqVyHRwgxrB1MidoYnyQsurhysqaC8uFyzqfx1wAokjAuvUHZGgNBQI4Xp
	SoSmR0gJcO3yyaazaoHkLfQJYSaLNfdN2QgD29eZ75PFoeMZ06D0w2MT1EP3qolt
	limX+oH5X+M0rce+rVNnRAOrtI+xTiRfWtJ1MjFuUl2zDM9uLe5MdvAFOsMDgBtf
	yRN8+t7Ze0gy+G6+EAjk4jIRjMiP32TE2bosYcjRTCvaCao2/RiZGkxjqN150n4i
	uqZL9gWcGm3CDSy1on9GqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770879594; x=
	1770965994; bh=zsUyiusjxLZR0qPPhv+tJRupkQjaZ196eEnqZe0jx0U=; b=I
	aY79MlQt9L3Iwkk5JK6/KDzy38Nx/EN5BrJ3NSlqKietWv4ip519lJEfF4j9qo0f
	OF/w030lORuxSNIcpt01/4nvXywKdGBbKLnkMKWF5zMRAKUH3FbYbkFSZGUuUCwM
	4BPG1JFQXn1VUeqSMURTsPPJTalTZq6dIdBCv246uP7vlTtLKxC1njoBBkdoZD3J
	Px2xr93P7/UK8cv+B7vntZRycrem1rNzcuhMVkwFsnN0GehpJ0jKfOt9jS1CwHCo
	uEYWntI5bFjNVNSh678IlTF6m2uKE8s0kLnaSd8PitHv4DDSoGL9WLJIrp8GdEX7
	bcIdIyMtnepDnRJWL4eFQ==
X-ME-Sender: <xms:anqNaU8DBV8RGhQKkTb9rWE3YSWUdtWfNaXwSBfilk6cilnJb9kNuw>
    <xme:anqNaTp3jyuJpokpxEikknPQKcAhjPzheeXy7YAHR-lEsKaKilAUxab23rwWfVjGH
    uZxotj7yOqdSa46ZyCA4cWkazS9Yp33TEuqv7W3_0Xieycd7YZCVQ>
X-ME-Received: <xmr:anqNafpKziLovkP71idFi8-GuOQvN57--d9UomLbfAxTfnDL6t0aQkSXjsTGG8qvWNZ7uQswXWmLFoumGL7hI1YOv-FutcPlRS9lVx7S8TE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdegjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:anqNaZkJIHw_r3yA6GEIcsz7ogoxzaG0Xpo1iRriLYio_D-3eazBoQ>
    <xmx:anqNaZGBdMoMbKRJqSkpTinUncel9-iuhAiiX9PQmybeyVapeCWTiw>
    <xmx:anqNaapdWtG5u_zLHpTWK-EPotbEr9iq-_XXiTnzyvGRRPPaaJjNVw>
    <xmx:anqNad6mVyd3pXeiT1IPQHYzrVt2OY6MdJw3_B3tHdZ3cZ78Wy58gQ>
    <xmx:anqNaUvxfd-l5siS1dzwimMgo22irdTnVSuIAF3HL-K5tIm6TPfZ_bkO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 12 Feb 2026 01:59:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4943e17b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 12 Feb 2026 06:59:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Feb 2026 07:59:38 +0100
Subject: [PATCH v2 2/5] builtin/fsck: fix flags passed to
 `odb_has_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-b4-pks-read-object-info-flags-v2-2-3bfa9bb149ef@pks.im>
References: <20260212-b4-pks-read-object-info-flags-v2-0-3bfa9bb149ef@pks.im>
In-Reply-To: <20260212-b4-pks-read-object-info-flags-v2-0-3bfa9bb149ef@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

In `mark_object()` we invoke `has_object()` with a value of 1. This is
somewhat fishy given that the function expects a bitset of flags, so any
behaviour that this results in is purely coincidental and may break at
any point in time.

The call to `has_object()` was originally introduced in 9eb86f41de
(fsck: do not lazy fetch known non-promisor object, 2020-08-05). The
intent here was to skip lazy fetches of promisor objects: we have
already verified that the object is not a promisor object, so if the
object is missing it indicates a corrupt repository.

The hardcoded value that we pass maps to `HAS_OBJECT_RECHECK_PACKED`,
which is probably the intended behaviour: `odb_has_object()` will not
fetch promisor objects unless `HAS_OBJECT_FETCH_PROMISOR` is passed, but
we may want to verify that no concurrent process has written the object
that we're trying to read.

Convert the code to use the named flag instead of the the hardcoded
value.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0512f78a87..1d059dd6c2 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -162,7 +162,8 @@ static int mark_object(struct object *obj, enum object_type type,
 		return 0;
 
 	if (!(obj->flags & HAS_OBJ)) {
-		if (parent && !odb_has_object(the_repository->objects, &obj->oid, 1)) {
+		if (parent && !odb_has_object(the_repository->objects, &obj->oid,
+					      HAS_OBJECT_RECHECK_PACKED)) {
 			printf_ln(_("broken link from %7s %s\n"
 				    "              to %7s %s"),
 				  printable_type(&parent->oid, parent->type),

-- 
2.53.0.295.g64333814d3.dirty

