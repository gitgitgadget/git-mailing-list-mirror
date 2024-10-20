Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DC926AC3
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729451735; cv=none; b=oYwhumNr3fn8pNfQksxSozpqvsoEAbBODbGWKOyeDnN44UkRZ7Z5PYIPiE0QVi1Z6S2MFUdX4r9SZi1mKwRG7coIHKtEw77YLUlYoRLT90tc+BVlvj7dJlopXIRbtYIw2Wp393cxTtIkXaiosjufP01Kb9otuu6cXGU7Ek/mttY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729451735; c=relaxed/simple;
	bh=bBUJGfXqLApaJvISgfFs5lI3HvmB8BQFJXBKFxR1ShQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1Fpi0mVdG4R+ZEpPhJCfG/pXhajJFT/O5cBW4/LZpejxTmMxC8VuZBt1Ppd0Dk3tWQer516YkCJyltI6vh2h56m/I+OyLfBoscYHWiEH4PU6XW8GuaPTuV+ZdQkpj5btf98edRlN+vvSo1JLCV2vY1Kna6vAKo/4772K/gb0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HWMgIUO5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m/sAez/C; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HWMgIUO5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m/sAez/C"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 76ECF1140145;
	Sun, 20 Oct 2024 15:15:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 20 Oct 2024 15:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729451732;
	 x=1729538132; bh=kaiciUjgduZ3ceg7eCnFvGMa4CI8e9VIGRC729QtW8U=; b=
	HWMgIUO5Zw6Tn4Fz/0vsedlR8NGTSaOiK2gAVue9JSTXYaz1DtrWCc0RsGIFb0BE
	HkgCfo/pbir4znp8lxT8882Lc4wYacaDNX7LH3QfQK09bUruw1AgiUohIsxN903/
	nDclbJ8T3uHq5aQ8iWqIAitOSmt2BxRugdKEZz/A5jZgaXmz9yn0T/e1zX1ds7Vl
	D0+SHSVjQT/NpINFsHRWNLjMvOYS/Pw5/aXvgArQR/acTFU1wXKYPxdyqb0Ou0vv
	N9blXuwnnxHCVKrMPRhjM0uEC7aEuXt4YrRq6/e9fZHg5YoYT6nq7HWGUzQDI78r
	sGjb1YF7vWllIMA6hew4Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729451732; x=
	1729538132; bh=kaiciUjgduZ3ceg7eCnFvGMa4CI8e9VIGRC729QtW8U=; b=m
	/sAez/C2gAdlJ3/Wib9fZ+JHNbIaRzXWjThtT/+5SKEci9E3+WIkHA1UI5FQN+Al
	i11/o641YJ9loMf6PTSuNdjEsUls69DAESKSp6kV9n26f3Knjr0vi0JkFz3HScHt
	MMeTa0D6zXu70PhzedbMcTzq76AU369dWmQuLMllaYrhLa5c0UGSCYmofgewrOoY
	kaGbOErMivZUeKZeV8PJ7iKmfxdYw+LTXUwMd7288+rV6I4e31EsUuFAbcxlxXBi
	Ucep6/361dGAkNXIPZN92tAwgqT+/QkaDLfhMW7Z5q8WPGVTwn8U7nyRrK3fLFiw
	G6WsNkAu50bdaQPT4PDtw==
X-ME-Sender: <xms:1FYVZ-jvv4S28sLAfytzGP556gyb-LplY3-2arvrrjZ3l1aO1hcN86g>
    <xme:1FYVZ_CxGZl5kGumUm9EgcFHVlz3TK9QD0IBj0yNQqE8Y_JzymErmt3V3DBT-oV7V
    Af2Z9C5IDCKMk_org>
X-ME-Received: <xmr:1FYVZ2G7bmY5GGxswarS7unUIqKhyFO-mI82QrztskgNCEg9DDfyxAcNrADPDwv9XsN6v9jz-K6pIsvD90bRm6NBEStjFsi60nNS5bUq8Lvz3HhDZr5b0dkgpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehjedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgf
    eglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdp
    rhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:1FYVZ3RazjknU3Jf5JLm8G6Jzo-UhZIgLbwmnFouc8x2Ov_qoAWfmw>
    <xmx:1FYVZ7x_VDlyw7DMzzugHn-QW6DBS0XU40HRcKOhske8Xmpchs5OuQ>
    <xmx:1FYVZ17n851-3NPEo-ArwElhXkOZzOVWrniPfzR9ovN5a3OJBe5E9Q>
    <xmx:1FYVZ4yI_aOInvL0cP9D3Ox_HebXBmf5gECZvmFHe18ixWdyeuJ05A>
    <xmx:1FYVZ7-aYpGHlAJVabEiafa_BhvRYN0TONey2EZL9VuC0V6WJeT46oRx>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Oct 2024 15:15:31 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com
Subject: [PATCH 3/4] Documentation/git-bundle.txt: mention --all in spec. refs
Date: Sun, 20 Oct 2024 21:15:01 +0200
Message-ID: <33980a47d132c9ea56238641031e72c5c7e2565a.1729451376.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729451376.git.code@khaugsbakk.name>
References: <cover.1729451376.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 33980a47d132c9ea56238641031e72c5c7e2565a
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Mention `--all` as an alternative in “Specifying References”.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-bundle.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index bf0d448a736..cf25e6e8540 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -135,7 +135,7 @@ SPECIFYING REFERENCES
 ---------------------
 
 Revisions must be accompanied by reference names to be packaged in a
-bundle.
+bundle.  Alternatively `--all` can be used to package all refs.
 
 More than one reference may be packaged, and more than one set of prerequisite objects can
 be specified.  The objects packaged are those not contained in the
-- 
2.46.1.641.g54e7913fcb6

