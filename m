Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731C518871A
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736637103; cv=none; b=KW8Jxf1APjhHEFVga7v65WPJNQ2qeSRNteizsUoLysa1/oVNTbcYIS0CbXYhjZhI6d7rHgkXiYNLX47JaY1IudZLRojvb0M2n3Y+iJtDMU/cvVn59vWjPEp8JnCRwsCm3TQaodrTQvDRAKRQA9Ji7mSKFliXNmZM3ItIIyauvuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736637103; c=relaxed/simple;
	bh=YO6JYPgjeEjQQ6N4bDIfiKY40nWjl92fj0VDM3+oGxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNksBj0eyyy7iDHVG9k1Po65ue/z6jL55dvkSderMzuix0y2nVv1jTc8Jm8jZhj+GK/0XqRYZjyOYCB8N8tSoQVMyE95U96oShsIZ4/nmpTCJGG2NB8uXo6OBuBfZ0q6aalpGk0z+RQXrl7KI9zuo2BCvbKQBCyE9rH3IjdJM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=JxHpbIa9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yor8fueQ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="JxHpbIa9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yor8fueQ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E9F21140168;
	Sat, 11 Jan 2025 18:11:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 11 Jan 2025 18:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1736637100; x=1736723500; bh=zMg9WNr5HK1fBHtH9iimk
	mn5Nh7LWUvKtfWp6jk/5+8=; b=JxHpbIa99WJVPnYtY2yRE6lQb/zN2dyMx+0EN
	RM2KNr1o+dHn8j8pFKvGsDKnvSKLMzHsntATld3xNf3ENolPOiFgFKX1pFiwfC8p
	YqbH5Zcu5/RByT3yF8APijDn/oxqoUABFi7dot2F38hanC5shvd9P8q5pCyArJy1
	0w/hcioKLBU+2etHweuT7NOOD/uWG8oYy+IzvRbSqEbVN2Whqdty48RV5htDp/mU
	gvDB7aS4K9XHaK8Us6fmg+KxGA7dv5+2DgMyceCYHgNJzE7jM67otZsQIOuxhQms
	edYdJPBa4vjY6KigY1SurQQqPRHb6jwgjKIUydl0+kep80zAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736637100; x=1736723500; bh=zMg9WNr5HK1fBHtH9iimkmn5Nh7LWUvKtfW
	p6jk/5+8=; b=yor8fueQRBv54fsGHmOtdABT3r7FOd7IxwbkacvIWlOvq2pbyV4
	773XK9rYAMKD4sRUji23Vbl7FvWHz/ppYtcCJN3laITEJTrLjl7aPWVoyRJM31z9
	u3USWLAgJZVDmzRZYdVKsLa8k+3YxvOD/BIqmjyFZMxmckIqoAgtGH1+Ujb5juJl
	6Ke+EzW3eo3/IT0TKP0yKrjsiBOlaniUh4eQlEwdnbo76xvXQ3fZk8NwMeHIAB65
	ZvWXwCLehR8fzw2J3k1l3Mel+R56Tw/P46Vcog3iNhXSKR1Mm5dVVgWwICI5WceZ
	VRka59Qwlx7GgaOG25/ALJh4s/0F67QDTbg==
X-ME-Sender: <xms:q_qCZ_R23XShvn025mRj6w9VWEPPs2zrBTkpXpST5Jzxpv0GEcgWSA>
    <xme:q_qCZwz6EEQuCVZMgzVCt4uF999zWLUN83o3nefp-tqwIoq4B_OElSWFaHloI96mW
    tKRVl2cV3WHnAhHvA>
X-ME-Received: <xmr:q_qCZ02XUR6kBWVLRORZFsBT-fzY9C14QjK7151H-i7L-ceu4UUThOPEmzg93MH034BvAolfqcsF2X7tfqKJ7I4kGJQmCWEomQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehuddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomheplfgrnhcurfgrlhhushcuoehjphgrlhhushesfhgrshhtmhgrihhlrdgtohhmqe
    enucggtffrrghtthgvrhhnpefhkedvvdegkefhjeduieevueeihfdukeehjefhleehudfh
    hfelgefgtedtteeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjphgrlhhushesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjphgr
    lhhushesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:q_qCZ_AFjLy6de6FnbzvnJxbPltR5yf1k6Q3nsXFYlJffN3xOAvfQA>
    <xmx:q_qCZ4jrd-pTDVMcld-non5Y5bThj3kySsaua5enTFpSNNQJ_77B5Q>
    <xmx:q_qCZzoV8iTHxSCfnwE13eOYdh0N_Ku7pgX8cESSIZ8PcMO-04lrIA>
    <xmx:q_qCZzi3Ooo1JmbeIV8M8KuRckZtkBzePOQBGP5B9894HzJcLIhyrg>
    <xmx:rPqCZxsobhsWe2_LTArVjPXtR-WcjEgNQUEx9YjSeFeZJiFF5Bo0TSQy>
Feedback-ID: i01894241:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jan 2025 18:11:39 -0500 (EST)
From: Jan Palus <jpalus@fastmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Jan Palus <jpalus@fastmail.com>
Subject: [PATCH] t8002-blame: simplify padding generation in blank boundary tests
Date: Sun, 12 Jan 2025 00:11:07 +0100
Message-ID: <20250111231107.2190448-1-jpalus@fastmail.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes compatibility with mksh as well:
$ mksh -c 'printf "%0.s" ""'
printf: %0.s: invalid conversion specification

Fixes: e7fb2ca945 ("builtin/blame: fix out-of-bounds write with blank boundary commits")
Signed-off-by: Jan Palus <jpalus@fastmail.com>
---
 t/t8002-blame.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 1ad039e123..e98993276a 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -138,7 +138,7 @@ test_expect_success 'blame --abbrev -b truncates the blank boundary' '
 	# Note that `--abbrev=` always gets incremented by 1, which is why we
 	# expect 11 leading spaces and not 10.
 	cat >expect <<-EOF &&
-	$(printf "%0.s " $(test_seq 11)) (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
+	$(printf "%11s" "") (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
 	EOF
 	git blame -b --abbrev=10 ^HEAD -- abbrev.t >actual &&
 	test_cmp expect actual
@@ -146,7 +146,7 @@ test_expect_success 'blame --abbrev -b truncates the blank boundary' '
 
 test_expect_success 'blame with excessive --abbrev and -b culls to hash length' '
 	cat >expect <<-EOF &&
-	$(printf "%0.s " $(test_seq $hexsz)) (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
+	$(printf "%${hexsz}s" "") (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
 	EOF
 	git blame -b --abbrev=9000 ^HEAD -- abbrev.t >actual &&
 	test_cmp expect actual
-- 
2.48.0

