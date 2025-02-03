Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9380F1D63DD
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738564193; cv=none; b=baWRadP8hTo3esYCc6q4eMJuZ+sSwkVTYSKHgPkkTcUm5ogTuquPnZPytZtJUdS1Fss3Z53cuo5mp3ClzzvBjkzN4aBZEyDuPdTxhzBC9A6WMxxL45mojBzoDh2JJhwbMT7T+j6MIRLA3eQ2BXNnGxCu16luzvt52Upbkb3ahag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738564193; c=relaxed/simple;
	bh=nFeC6BtcS+hOfHxDK3EtT6qcz0nydlJdwyNZA2ujWho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=APe5KhuXpUm+N4FKsqjs8QvuiQdG03Un67QtWltV0bQHgdI731w8OrpebM/X0i/Y3Iy44EJwdidBrdWfqg7ooXhq/TIU0Mp8AO7wVnZoyN3D2XjPYH7oTXT0sj6N8/vg94XiMWS09g18j8YUDVla4X6f29ojn4o53HerUzRgLD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cOpSgiTi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D6tMcWuz; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cOpSgiTi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D6tMcWuz"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 85CD61140173;
	Mon,  3 Feb 2025 01:29:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 03 Feb 2025 01:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738564189;
	 x=1738650589; bh=3y8btysFk6GGvvuftdxS6BVIk/hr4qyQagAbM69FupY=; b=
	cOpSgiTiW9H3hDKm3oAAg9X+ZH1lKh9tqe1ObY6LvvoC4dCBaUgfvCNSte26jF2z
	UWpUYfBSK2lvDUBkFBlb2estp7AAYLJoN9dH0H+R/ia5T3rRJMaEumvHMbpydlDk
	T3hvsz/DChVawPldmfciebEkrhReaBAc+87s/Waauq8SfmnWoceR6PsU/D6MX9Np
	5r77usA3xLmT8qvNAWrjCZF6G2hQ9Nr3r8LzeTWTcq3vAIuFFWut5b2ZlIQ/63q1
	uEerHJPo7K0nkGCxQDBWS4EO0xrNKExWufIJHBcch6/j+7vbbM3FDI5Dm8CkLHXX
	ANMv4Pjhab1L6eCUGAr4Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738564189; x=
	1738650589; bh=3y8btysFk6GGvvuftdxS6BVIk/hr4qyQagAbM69FupY=; b=D
	6tMcWuzmXNAfDXy1oloDS5X2p8k9BMY5cZ/q14MEH19Jjv3CHz+Yy+OMmRkT2b4/
	sKi8LwSSFyqbotuY2SSg/eh5t5PfCRaN1k+KmKN9ez51qZNCklo+3Hi41MWh9n9F
	rvlMM2ZaeJjNuL70i3goktGH7M2MfAfYaACqrj+tKpBVWQT79s/zH2ocjyqLvCie
	snpSSw48CKgYi9/V3boNgSepDvrzgj1l1+hIcjsBt6iD0t/G12hM9pTFt7Izn79F
	avOBPOgRoiQ/k03Dd6fpczXU5r6RiyjXlka0HEw2C90GfZNMGAc6Mp2NkAyBc0li
	2SLYE6oII1nDHyQW7L2wg==
X-ME-Sender: <xms:XWKgZz6ckSCeUmwFbBa6gjtRVJccngf8DJb5K7FP9LgXFdrMRoZzMg>
    <xme:XWKgZ45WfcV2r7Opo-ZZ3flOx2aIFgOYkIvmg2LHeRynlb4A5gVGxIw3EZM10nVHS
    jVGbasBa6Bz1SLbLA>
X-ME-Received: <xmr:XWKgZ6fGaZglU2YlSaSsoIE1LL6M1Ddtb8mpNH8DHpKXuOAphvldHoaXSchSuZ6sEuCo1yF69ASMEIWcqLI0NUBGmhusRYvqT6hCgnhnT_pxzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopeiihhhihihouh
    drjhigsegrlhhisggrsggrqdhinhgtrdgtohhm
X-ME-Proxy: <xmx:XWKgZ0ILWyZi9VmWkKC52rxRsqNXsXlfSUwl5wnWCEPKt-hbwc28kQ>
    <xmx:XWKgZ3Lb_Pl9fKaEh4oCSdoIIh2FWnqKxlqB05pj4Fr-BCprrLolIg>
    <xmx:XWKgZ9x30EdCZhKQA901fzKS6mmpfHu4BIm4e2HnaFpCkAa9GFrVJQ>
    <xmx:XWKgZzJC4JiAoCFn21oPEWZhK7WPdZ_0P43E9DuxOTRr9dqmxL3H8A>
    <xmx:XWKgZ0ElMfLB3EEO0rjn1eWNl2agSaGo34ilAL86L5vMB314si1WoMkL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 01:29:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9455b33c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 06:29:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 07:29:37 +0100
Subject: [PATCH v5 7/8] t5543: atomic push reports exit code failure
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-push-atomic-respect-exit-code-v5-7-d66481e36622@pks.im>
References: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
In-Reply-To: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

Add new test cases in t5543 to avoid ignoring the exit code of
git-receive-pack(1) during atomic push with "--porcelain" flag.

We'd typically notice this case because the refs would have their error
message set. But there is an edge case when pushing refs succeeds, but
git-receive-pack(1) exits with a non-zero exit code at a later point in
time due to another error. An atomic git-push(1) would ignore that error
code, and consequently it would return successfully and not print any
error message at all.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5543-atomic-push.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 04b47ad84a..32181b9afb 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -280,4 +280,34 @@ test_expect_success 'atomic push reports (reject by non-ff)' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'atomic push reports exit code failure' '
+	write_script receive-pack-wrapper <<-\EOF &&
+	git-receive-pack "$@"
+	exit 1
+	EOF
+	test_must_fail git -C workbench push --atomic \
+		--receive-pack="${SQ}$(pwd)${SQ}/receive-pack-wrapper" \
+		up HEAD:refs/heads/no-conflict 2>err &&
+	cat >expect <<-EOF &&
+	To ../upstream
+	 * [new branch]      HEAD -> no-conflict
+	error: failed to push some refs to ${SQ}../upstream${SQ}
+	EOF
+	test_cmp expect err
+'
+
+test_expect_failure 'atomic push reports exit code failure with porcelain' '
+	write_script receive-pack-wrapper <<-\EOF &&
+	git-receive-pack "$@"
+	exit 1
+	EOF
+	test_must_fail git -C workbench push --atomic --porcelain \
+		--receive-pack="${SQ}$(pwd)${SQ}/receive-pack-wrapper" \
+		up HEAD:refs/heads/no-conflict-porcelain 2>err &&
+	cat >expect <<-EOF &&
+	error: failed to push some refs to ${SQ}../upstream${SQ}
+	EOF
+	test_cmp expect err
+'
+
 test_done

-- 
2.48.1.502.g6dc24dfdaf.dirty

