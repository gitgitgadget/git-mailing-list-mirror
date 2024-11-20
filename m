Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191BF1BD9FC
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110011; cv=none; b=eFXbhPGHZ8xM4Z7jNoEO15LUB5QSlw9glnauWKJc7BEH+xN1cbQZwW6oYPkW7VLjCTRdkl8M0kL9XCIVeFetpIa69Q5Z3cHgMy9JAbisENmNa+7kDT4ut/zLS40iHgzhEGb/jkKNGa2AwFE7LQnFq05PN20x2U1PLpIJGGkge08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110011; c=relaxed/simple;
	bh=xi0pEP/hZXQA45Ucm/AbDw2L3Ot8X3w9ZpB+A8kVkwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FGiLFx4td0fLu79AlY0VYcMAsNq8xTG0ZWEVKnEidRuq37WJixsDhxsWnVfV/1airHoL16T+zj4GtpFwjcx7LBq3FuhyeVIFUrX6eAUxkmKOEcZP0gejED1OGrm8Vno/Xex/CAfWviyf3HQNS4O6xVF0ZasT9oIoClDieeITGlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TCbQyyAM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z7xCRL8B; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TCbQyyAM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z7xCRL8B"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 76AD511401D0;
	Wed, 20 Nov 2024 08:40:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 20 Nov 2024 08:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732110009;
	 x=1732196409; bh=Yq0SWTlBx58GPBc+AUuJUkH85ypD/GNfifomt7w1OtE=; b=
	TCbQyyAMeOQCYJQqapFytp0kCCzb28Gc9HUjm4Y9YYChXTKf8UMJpeMNfEty2iTF
	MNyNBz7sCljjnI2CGgyhMoX75eXSkiIiUQBYL7BHlaj6NfBf9WrOYj6owu0qvdGQ
	5tzKlEawjzR4UQMQcAO1TYK+X9sJsAnYffVx1M/YDOqJfBKI3u6LoY2i8K5dTfSD
	o+J3AI9jiYCJqql4Nu/kBpSKNyFIvQ593HL43Sy3109Nhwzc6Kdo3s4ittF6V9yc
	NnnUvp6DOO7V9vVo3+ugaDOSR6pyA8QJzP5cc2llPLUyo/DAHaExRBtS2FM3UGGX
	hkKB/7FBiFC+xHZnkHWBqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732110009; x=
	1732196409; bh=Yq0SWTlBx58GPBc+AUuJUkH85ypD/GNfifomt7w1OtE=; b=Z
	7xCRL8BY/3RRwmcpUvCFN3kzJz38dhAarWc2V8KTHZFuBiaz2edmSKpZjEoymSe5
	lzy4o9c142KblPrHHAE0oPKkaqPHYDax6Soj5tR7Zuwed+J7eBrJwtvH0HpMtHPv
	raHCME9zt9kAhIMPUNEJJmjHbMUzmX6dlJ2n91j49+JWH3CmwiYgmn/et/3e7j9q
	is1DfNFbpXXeGob658SuaUV8fpvhcvqsC9DV8QOM+W+2rprH50IHnDAUKC6SrvIS
	p/hGACfcWqhwKIE2liWaZeI8MoplT6BeUTi/vcOF3X00fRFJELeBQlbn3d3OZ27o
	KiHk8lC/MS65U0SsxhFYQ==
X-ME-Sender: <xms:ueY9Z2zcQ-IWkWcDaVhkPwK3KVMxfxn9vvfgRYE2yBevF3QNaoaDwA>
    <xme:ueY9ZyT-c3I91ooRk2ZAAEeU51eOcd4wHjpWlVtOv6N59nUpOHScJDAJQKg-saqgJ
    4N_I9eUqY9RTGr46w>
X-ME-Received: <xmr:ueY9Z4XlR2rY1LS1CvylnQYetp9WYrnD3efOjJK23ezz1GF8guxF4TGBk1yIl6Ph1vgwdrw1p3JRZjWyuLCsDqoG2byoiHE8GpFkzRU4oz8gkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehtohhonhesihhothgtlhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ueY9Z8ijUQr9tT7All7rkwcVn4C1wDv9Gv8AY-FIGs69ZBsYyY-Egw>
    <xmx:ueY9Z4AwjGaU_BGUEr_MVtHOjq90HsG83vsUIKa-n4ylVhkRXXOM5w>
    <xmx:ueY9Z9JCKtR757cKu_tL89NTdvh8H41jcIryJuRPVo9r4LAl6jNFKw>
    <xmx:ueY9Z_CwPHZxRTvtJITx5odNiN63YXHPhc_iqpzUASGbI3LA8b2XgA>
    <xmx:ueY9Z79tWeeY7LBhL6Y7aEw9Ryb3hkYaXWrkARyQijtEiaj_Km-t3KWb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:40:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c248153d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:50 +0100
Subject: [PATCH v3 21/27] global: drop `UNLEAK()` annotation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-21-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

There are two users of `UNLEAK()` left in our codebase:

  - In "builtin/clone.c", annotating the `repo` variable. That leak has
    already been fixed though as you can see in the context, where we do
    know to free `repo_to_free`.

  - In "builtin/diff.c", to unleak entries of the `blob[]` array. That
    leak has also been fixed, because the entries we assign to that
    array come from `rev.pending.objects`, and we do eventually release
    `rev`.

This neatly demonstrates one of the issues with `UNLEAK()`: it is quite
easy for the annotation to become stale. A second issue is that its
whole intent is to paper over leaks. And while that has been a necessary
evil in the past, because Git was leaking left and right, it isn't
really much of an issue nowadays where our test suite has no known leaks
anymore.

Remove the last two users of this macro.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 1 -
 builtin/diff.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 59fcb317a68a77eee3ca96a60720c556e044c369..e851b1475d7be8f0af78c27d4ef15467a2769a74 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1586,7 +1586,6 @@ int cmd_clone(int argc,
 	free(dir);
 	free(path);
 	free(repo_to_free);
-	UNLEAK(repo);
 	junk_mode = JUNK_LEAVE_ALL;
 
 	transport_ls_refs_options_release(&transport_ls_refs_options);
diff --git a/builtin/diff.c b/builtin/diff.c
index dca52d4221ed19d27950bee9022ae7efb1d2f17a..2fe92f373e9991489fcaeeba381bbfe017a5316a 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -628,6 +628,5 @@ int cmd_diff(int argc,
 	release_revisions(&rev);
 	object_array_clear(&ent);
 	symdiff_release(&sdiff);
-	UNLEAK(blob);
 	return result;
 }

-- 
2.47.0.274.g962d0b743d.dirty

