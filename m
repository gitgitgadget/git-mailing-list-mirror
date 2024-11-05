Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EB11B5336
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787445; cv=none; b=A9MBUgaoSK2SAFa0+lyZPnSWc+RbPzkCz1HWdK8uDJmhE9TpkXop9EUp6UxGfgeeUIHlhUsaOMJA4FObQWf29l7SQTPvT6NOlU8u53MK++RwNWDvaOxNr8+CdfVWwyuo1IxatEOh0B7uXMMh3L6aAnYPf3vYJrayb4fee1V7Ew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787445; c=relaxed/simple;
	bh=kE9CG+AKANsk+W+5/LZNpEMG4u/baXAte8+JqkzM9Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfXGMdIoJAf+0vijZ5G83KD1jgIPNx4pRD8hHAPklcRIFPYf1bSwizyUwGuiOgE96wHDQjCJ4QvhcmR3vADI4vrh3Fu4jjye5uFLur++QVJfv8qz1P6b0I6Y5YxVpClVpYl1qTUH/jrr+xaOFXklhWqFf+1t85lxx7AcIcSENRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e60k5Xfk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lpfekX4Z; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e60k5Xfk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lpfekX4Z"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id EF3EB114016D;
	Tue,  5 Nov 2024 01:17:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 05 Nov 2024 01:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787442; x=1730873842; bh=pWdazviE/S
	mKHExwZ4qusnmGTDZvg50nQoKlog/2OuI=; b=e60k5XfkpQPt7kT4hMm3uKelAS
	RTWSaGJLWMfNHTPIBNR7nG/iBxcO29lTbnHHaQNEmjSnL+50CyxgdemZwixG+QO5
	qCmpUYF9rnaxe8e9KeyXo9dHLW6wlvqqSGxUfQxOLFykitrsaN/XZk2/LtEOMUIn
	/FEFEECxRKV8G6AlAasV5mUX9f9M5Lqn4kQMznZgDjnPsZ7S/qwqui0vJ+3WWcOn
	Ds8IOIjM5QcJotDBaVPHRGvkEQR2GRGOZXOdPA1UojPLjx4rhhwFu/1s+rDXAswi
	/z73WkNkpfT2knpQOYkZQIhk7pxAKxYWac2/xw8hD+aNfwV49MH4M9DkbY3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787442; x=1730873842; bh=pWdazviE/SmKHExwZ4qusnmGTDZvg50nQoK
	log/2OuI=; b=lpfekX4Z8YNq/ukD7qMZsx3YQfOlSkrWXLsV1JorMrpU+Pjiq0d
	uvCvL4QOJsU5BJScU6uiBqflOljEhVYSzrpENW7VMCVq36cK1SwB6bpfF3eFCZR7
	lO7AoIc24SuVPlhU+X+2SN0YLwNpOMFj7pDvdDW6usjlgdgPSt962Fn6gNYtMJQo
	BHBLJanbmXVjyIcGLjU+owvLAS+cRYePTg1z47IFPcQjjIie9AFe6AyFsyjDIVsO
	eCNSLkr45BP9xbZyRmbLSUOjw1QX1YXSa1ymXLMcYD9Pe2pQ544SWNI0V9dKLnN2
	w+qPmWLRaVXbLPS9FMTtBedtG1QKDGz+RQQ==
X-ME-Sender: <xms:crgpZ0RjHqRx1l5rlqopOrIv_OAaKJz_bkxVtbSGrGFM18qbDGOEuA>
    <xme:crgpZxx4xfDrDwJcp36WXBDyO1QPRej3_l9iuw55u0u2WW6mB9_FzIAEW4QvZvSZN
    0nAYYJLig71KvEaEA>
X-ME-Received: <xmr:crgpZx2kLeebgFEGiEmY6FtfOcs7bQQP3oP9x0FqE3HY580ld91a_Xw_V40wv_GWbQ3egrshgu-uHuqM2CVUZ2zR0xnW5XaYi2cqPxtH3ZYZWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:crgpZ4BagCVWVPWVnFqIhJvVq-lsbHOB5w6Mic6he6zIuKKIGdWmWw>
    <xmx:crgpZ9hMOfOPqqXfrqeJOu6WkCOS7p8EMq70BCeinrp2drSTIs6Kbg>
    <xmx:crgpZ0pkdrKBJ1m-luRgNmUho-t2UmXWMjfNj1NBRwO00VKO4H9s5g>
    <xmx:crgpZwjBWG1eC-wtKRWKEU9rgNq71yU-pf1SIR7lJke3uS7zEaaAew>
    <xmx:crgpZ7bDsDymOtR1yt9o4Pg541c_NXlYKEUNEWAK7tNknPKc0AWSLGp7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 382ff353 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:16:59 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:17:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 10/22] trailer: fix leaking trailer values
Message-ID: <dac63bae39e01e612621b36b698d13d06a21a2ae.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

Fix leaking trailer values when replacing the value with a command or
when the token value is empty.

This leak is exposed by t7513, but plugging it does not make the whole
test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 trailer.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/trailer.c b/trailer.c
index 682d74505bf..6bafe92b326 100644
--- a/trailer.c
+++ b/trailer.c
@@ -249,7 +249,9 @@ static char *apply_command(struct conf_info *conf, const char *arg)
 static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg_tok)
 {
 	if (arg_tok->conf.command || arg_tok->conf.cmd) {
-		const char *arg;
+		char *value_to_free = NULL;
+		char *arg;
+
 		if (arg_tok->value && arg_tok->value[0]) {
 			arg = arg_tok->value;
 		} else {
@@ -257,9 +259,13 @@ static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg
 				arg = xstrdup(in_tok->value);
 			else
 				arg = xstrdup("");
+			value_to_free = arg_tok->value;
 		}
+
 		arg_tok->value = apply_command(&arg_tok->conf, arg);
-		free((char *)arg);
+
+		free(value_to_free);
+		free(arg);
 	}
 }
 
-- 
2.47.0.229.g8f8d6eee53.dirty

