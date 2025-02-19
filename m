Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4321E102E
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970847; cv=none; b=Aq8YlQAB0oxgut+YTGX38fCqPdvK5vTkk1sJ8QAXE7Q2l4NEsnm1Nnid/NtmvjJ7jLVB1cCUjwd+8WeYTWIeuJCGVn4G0D2hT7abN3u25ZdQMfgvto7C17uM0LtUeqhbpQmjd0Mt/weHmU8vd1lpo6y7YI7BUT7Hhv8LIwZVVG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970847; c=relaxed/simple;
	bh=mY4lzOivTptFMKbuCLdMMve6j/1W5yee0LWySaRZWxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qi2Uhj05S1U37xwa/tdrLx6sCZQmjRigi9HqwOegsyjQo3hjzsqhFblEBfr/ODCV7udq+P4kTJFczdirtBk4g5u5bgB6MjSOC2SEOCG1MNqCQ3L4YwFUjd5qTG91OfAqxDjn3hNf3DJRSdr9bOS+LIutdc7UIKwzzCJB0MmeLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E39s3H2z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ioo/qrCp; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E39s3H2z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ioo/qrCp"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E76482540149;
	Wed, 19 Feb 2025 08:14:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Feb 2025 08:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739970844;
	 x=1740057244; bh=coYQ0IU816FHyvUOYVSuNNf+UUjRIMrOXaV9KEb76Rg=; b=
	E39s3H2zz1NhiFRQBEAEgz/bSvirU2LIr6gzYlV98YUqOqPhD+mJevQ+k4iPRFPR
	TAWOWI4ilqrmMTzZA3OB3tPmWb/61K4qOI1bUAIpYCvrJ5DTEBKHrZbw7/bEhiWK
	U3dN2OBhGqmMAcx/Oz0ByTZufuUQ5YAG7RYQe8QnWzWwCyEetefAtzSP6bnawi7+
	1MVAPc1EUbnyZsgh6PEW5szuvzlMJtJSYeLQ6hEzRs88ab52pxLdwfuoA/Bc/x3g
	9on87lFkMa3LuRab+nBLo4Ja7yYlMuB8VQ4HXukHDYQyoH3wsMBksc+n66cE7oUm
	Dfhqkq7fonau/lR73ISlMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739970844; x=
	1740057244; bh=coYQ0IU816FHyvUOYVSuNNf+UUjRIMrOXaV9KEb76Rg=; b=i
	oo/qrCp3GLN38On1XMdSCYxr1znTvEjJTDSn/T5CMnT7r50exbsUCRT3b8UjBaPm
	4l+oxXaZeC/AQQKeBgejHCN3EUtFFEN/adZjmx4jm7j//rz+bvOY31P1kVv7Fo6C
	y4NqJ9zkESJGnojPyNYsZkIDPvN9pCVNRnTjjLe04TdMCRMPvCjyBTMyi0PEvtUX
	oAQRtZhcj0D0TjpvFNcPIVu8fsSozYc3TQS4WijrJbGofypzu54VT6gvmfTHtbTZ
	hbm2xuBjb2jDeK1Fmg6mB8sqIVGVtsmxxvJe9c/7DfzAhVNnUT1LTrfNVq3GHwUT
	VoaAnr/35T/bVbz8jh7Gg==
X-ME-Sender: <xms:HNm1Z0ogOWOn9CNrE20O6nq7tv4fGvFfyzDmJFJ8VhSdrJ1yIIemIg>
    <xme:HNm1Z6pXg8q7lDAfuUK-GHanuUXMgacAaBSALDRU4aei4xWbfOInAiyPU8arbIAwy
    h9Dt5P1n-JY1JzGaQ>
X-ME-Received: <xmr:HNm1Z5Nnx27_PrIozT3JYe1wDtpMhDQiyF5RZvsWlI12RDJpnPylxd_ATZAD1ks-1bIQkIFfZYuKfi3knWKZLADwJ679Ghd3SMRZ52mQZYAYG-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:HNm1Z76XXIyGOJE7CfYmOWX-xPZJv2W414dsO9Jb4U4ZY8p2CMXE-Q>
    <xmx:HNm1Zz4ULdeXmYaRK4ErtdFnh2LRi6HnVvGR0RCzFLzIKdytzph5sQ>
    <xmx:HNm1Z7jubwwP2wX0dFjyJBV4iIfxMW7mcAfP5IpC8NszWHBlaubyLw>
    <xmx:HNm1Z96FX_ClH_OpiU4iprkd8J1ONIEkBDdG61JWrcVnjQ9DJ6eXXw>
    <xmx:HNm1Z22yfOCpmIxDB2Tdq0tq4QeqjWyD0MPiGoNHEkZgXmJiFYYwA3lG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:14:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a24d8f26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:14:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:13:45 +0100
Subject: [PATCH v2 05/10] contrib/credential: fix compilation of
 "osxkeychain" helper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-b4-pks-meson-contrib-v2-5-1ba5d7fde0b9@pks.im>
References: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
In-Reply-To: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

The "osxkeychain" helper does not compile due to a warning generated by
the unused `argc` parameter. Fix the warning by checking for the minimum
number of required arguments explicitly in the least restrictive way
possible.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 1c8310d7fef..611c9798b3a 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -422,7 +422,7 @@ int main(int argc, const char **argv)
 	const char *usage =
 		"usage: git credential-osxkeychain <get|store|erase>";
 
-	if (!argv[1])
+	if (argc < 2 || !*argv[1])
 		die("%s", usage);
 
 	if (open(argv[0], O_RDONLY | O_EXLOCK) == -1)

-- 
2.48.1.666.gff9fcf71b7.dirty

