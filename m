Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB922D9792
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765021692; cv=none; b=uT9po0baFvZDPnR81dsDrOtkxzexz8Y7saQ/uU7GQHZGVai6kG7UypWZ4CZN3AXWQ6pZX4GYtLy2SCGWX+P4fmT/+wmUyQF8/aFjfjEIUOVgmXubctNwlt6x93oHqtC/a64VDH0+O1/Y/sd0zJlKGGaZ5BVkkEozzRzNidBH8fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765021692; c=relaxed/simple;
	bh=KaFqUlVCh/D1cY/Tasdv7NfxOIt5PIJtb+ylK3cnkUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dtO5VjPYPaRo8kYUsCqpHyAg/x0wmr70mAMy1zpSHVwwy+szohdEd+kONme1ZY5gIe3rxmXx7uhbtSqtZ5kCRJ6AcjzGeaNeQ2h7cCV2lj6YRBmt2ZZyWSkv3cJ1RjiMDsQtOPyTceaDGvBdV6JIeffR03w7hX2GmJdRlr8qtDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I+UznRmU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y7h+KPX+; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I+UznRmU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y7h+KPX+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8267A1D000F8;
	Sat,  6 Dec 2025 06:48:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 06 Dec 2025 06:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765021690;
	 x=1765108090; bh=Q6l5PluVPLCCKM4ouNrR0HLmON1c3MlLLaw5jqg6y4c=; b=
	I+UznRmUBBpzFIneZHzCTLGfgX6rUS7Qk0rg0MVwFstaa1zbxJutDg9T9DN8DSe1
	efuv1uJdo15588wEgzjEKaG1r2fa3Uh/0WJqE6P6WbM53n19Znwc/St3epAjdV+y
	ogxRkeF5uMlu8Hbo7BPkmUlW09p751AKtP3X3bNvH3q7yOe7Rk9VC1tM/g1Ku7HS
	ECqHiKxeQRENFZB4FSN4F2UTQ/P7IhpilQJuabiMJcUhVDGfBb13NgkUG8e8BDnS
	UUG8CV/IAfSSllo6FmPJINmUgXfmhgN9leZwXtR3NwyIGTK3SRfh1NH1pzJh45Yo
	crm0erSkjmJshaexBHBLjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765021690; x=
	1765108090; bh=Q6l5PluVPLCCKM4ouNrR0HLmON1c3MlLLaw5jqg6y4c=; b=Y
	7h+KPX++1DD1B/MOdAiIXU1fDMnnYnXX6kodQxp/lNZSJEeg3ddS4UPuYZXW7/3B
	quf9zETqMNu521Eg3h4DfzWCUmi+cru0TzSYLrG0YJVvFiWlTRZYb3GNm+eQHvGe
	NUXQYGSd/aDrVeiLBGsh64doiFalsjZiXbqs+Y5lmqoOf0cMdLAigCB7QoZbdL3j
	mm41IKpvT1NFlMb1gijxJEqA2J+joDTdqJiXf95leAp6Dm/Mqw3SO2ht6qeaSFSv
	IwiZokRt/BuXrwy7wz9rJfo4Wqr1V/p2NxJRhCiDEJxSWAzDdNgc2Lzo4tWNDoMW
	Cv+RhaUA4E3BYgdeonUww==
X-ME-Sender: <xms:-hc0aSqXj8kZjd87fiyuGY6kMkHg0sqYQKLD50ldpgwWRVWyAbW_9w>
    <xme:-hc0aXrZ2f2UF4TcvFssK1IkJSzZBv78mSPsENZePfEXr6ptHEzouOsY2tdkgtY-Y
    q8lcTywTjhKhipJtPgnUhKmQf3SKwE-Evn4_1F-mflySMSdYwHVnA>
X-ME-Received: <xmr:-hc0acNCh4U7ar-Ju7aC_MdBO5czxUBp6uLTkBGSTYarT9435x4vYeQo5P9Xy_161Tg3-xnZtLan1EtqoK-whUPo9769j_VVrWguCfOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-hc0aQytdt_qVj-bTkvA814J3-TYjzu-PTTrlZHeeO7COOFdFTDatg>
    <xmx:-hc0adurUWGF0olxhIPvouA12peDbjlpp7ATpUng5QR-uzyLliREeg>
    <xmx:-hc0aR48p3Z52qgiolvutg4pJ2iBeXt41zda4rBhlaYn9eqKojmOBA>
    <xmx:-hc0aUSgyrxJowGCd_E2AWXm6Rhm6D6WOD-VjamwekMoQuxDIwLWyw>
    <xmx:-hc0aSJJmK5Ei-_RFUVDY6UNte6fd1poTc6dmVZuFDY-hNsOoM3bAZCG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 06:48:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 09d6c1ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 6 Dec 2025 11:48:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sat, 06 Dec 2025 12:47:34 +0100
Subject: [PATCH v2 3/3] gitattributes: disable blank-at-eof errors for clar
 test expectations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251206-b4-pks-clar-update-v2-3-9a14b10c1a36@pks.im>
References: <20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im>
In-Reply-To: <20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

The clar unit testing framework carries a couple of files that contain
expected output for its self-tests. Some of these files expectedly end
with a blank line at the end of the file, which Git would consider to be
a whitespace error by default.

Teach our gitattributes to ignore those errors.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitattributes b/.gitattributes
index 700743c3f5..38b1c52fe0 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -17,3 +17,4 @@ CODE_OF_CONDUCT.md -whitespace
 /Documentation/gitk.adoc conflict-marker-size=32
 /Documentation/user-manual.adoc conflict-marker-size=32
 /t/t????-*.sh conflict-marker-size=32
+/t/unit-tests/clar/test/expected/* whitespace=-blank-at-eof

-- 
2.52.0.239.gd5f0c6e74e.dirty

