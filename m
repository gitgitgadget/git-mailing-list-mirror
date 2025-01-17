Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E448B1FBCBC
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107782; cv=none; b=d6WzhLYP6T93xUT/5C+5BJw0uuKsWSFdNo1MaQB1EudAS3uhhVTQ2G3MO+vRmJT/ib7XGpjYC6kGsiaktt/NyKMCW5Y2x+gQZCpVBSTGOReWxVe1M344nQGIHPU7BUA2kWRsL0AaY28g8HGbgOk86DiexgG9VCxO3YFI2V5/YVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107782; c=relaxed/simple;
	bh=LWBJzbwp59oZ09VLdGzE1LPkvqlsEcxeebN2k+S2HP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gejzpNW0JfTCl3t+6QunZ9omgpSQf6IwUOVvjra0Qi50pT8JXs8wN2c7w5mwKf/f80imn8HxEHZQe4Zs3IwJctDTexpAxeJmC9E3zSzRXSK57/joxynCyzdV2K+4PZo1J5IAbPmckVIHyhsMI06wSs0ekTfr+U+of0I9D5We7LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m9FiNr+g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YwB8kege; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m9FiNr+g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YwB8kege"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E93E31380854;
	Fri, 17 Jan 2025 04:56:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 17 Jan 2025 04:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737107779;
	 x=1737194179; bh=vrcAprk0Ba89xb/9L4yFUO4WB81aPV1Fi2HUfJ3ax9U=; b=
	m9FiNr+gujjo3Mg9T72ZzPCpi4V7l+XvjvQUQlKoouG3Hbw4qsJCSae8gYL5YUcF
	dz/l59iLlFuYSs5giyC2uC/AUIc9Y947OSwRt5CvmTPJY8Ry0NTUioR9D655KOJt
	/mpDfFG/w89/BiLu2oqx6ymKiihdX1j/mZ5jcD9OC1amlkKcxFqG9mv5acJ6BZ2e
	sNTv9Yvyvy6BAKMbhAQDy4enJUCXtgznRtuKrNnShWaIqQV9/sZn57ja2m1pKKPf
	B2LfIMCKv0ZQKTWJDgqqMQJsbUMCSdBn0rams0cm5xJhzcntrikPrCgdMt/TVQZi
	dTEtdyNYHj+/pEFohmeIyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737107779; x=
	1737194179; bh=vrcAprk0Ba89xb/9L4yFUO4WB81aPV1Fi2HUfJ3ax9U=; b=Y
	wB8kegeDdQXqXqJ2vvTuQZRLm5bYlQ8SrXgeAhywHSGExlOeHAqiYtwcx1OfAyTZ
	DWtyyBF7L/l9e8xFHtrqT7jUSs2IMm/JSTJG23V8B0NT5esn5OrCO0NLs5YTR8NP
	RSzGoivRkEzPkQn9YqM1eTS2HN3aYo5EJ4oXWW8ksx5GXbq6a2XiEGsZYDaG9Do4
	7FJ2C9vEh/s2XdPUqW+MNRIk5ZBoYRLAgQy/o9h+xPySfG+n3bo0ZA2woy9EEV0G
	YzBqubir8pOdY4RETfvkymqdeDMPbka4ccIYUVHdQ4UjlI4qUVhqNyAQzFwYAMD/
	ALM1/NRqYpHI+/OMMURIA==
X-ME-Sender: <xms:QymKZ9Ov8sZJaVj8S5pfQxnsim6VqzSsCY8HriDNfMmPOiPXOSsdxA>
    <xme:QymKZ_-KxhdMOn1Om1_hzb4SIw8tQCDw_QolFlbOwYlNYRnIiOegWSVr9bhHH3N-b
    AGheWSvyBQ1gQcnOw>
X-ME-Received: <xmr:QymKZ8Sg3rx1GjmYRC_7nuwgUYDxYBvPPPLBvbuUSMmTfyHO2XgK1Xc1QlsZR5C6Hekt7tbeO-NBH1sbS872SdnFP4TyLPwsN6olTfBKUo87-uY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghrghgrsehfrhgvvggssh
    gurdhorhhg
X-ME-Proxy: <xmx:QymKZ5v3zeDeXnEcviJa8lv0fEQPaZJFdAyrbTkvYEgK2fQQ4Td6gg>
    <xmx:QymKZ1dzT636mViIhkiMmnXLS2R1nvYl2DzSnYFa061WXVOJZ_aJeg>
    <xmx:QymKZ13ijnMStOHQ2jvs0jTuSkPN5eP8mQSmXv9TFsD94YI2TRWaqA>
    <xmx:QymKZx-Bj1l-kXXwhSMuX1WzG8aLHGgTTJYCMDf24Qi6xPyDohDZCw>
    <xmx:QymKZ2r0PiEgc93S6xpmO-HkABFfAEZkF3DXCUKueSYHiRnEvm2-iQAa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 04:56:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f6caec5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jan 2025 09:56:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Jan 2025 10:56:06 +0100
Subject: [PATCH 2/3] meson: introduce build option for contrib
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-b4-pks-build-subtree-v1-2-03c2ed6cc42e@pks.im>
References: <20250117-b4-pks-build-subtree-v1-0-03c2ed6cc42e@pks.im>
In-Reply-To: <20250117-b4-pks-build-subtree-v1-0-03c2ed6cc42e@pks.im>
To: git@vger.kernel.org
Cc: Renato Botelho <garga@FreeBSD.org>
X-Mailer: b4 0.14.2

We unconditionally wire up building command completion present in the
"contrib/" directory. This may or may not be what users want, and we
don't provide a way to disable it.

Introduce a new "contrib" build option. This option is introduced as an
array so that users can manually pick which exact features they want to
include from the "contrib" directory. By default, we build and install
shell completions, which is a commonly used feature and also the current
default.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/meson.build | 4 +++-
 meson_options.txt   | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/meson.build b/contrib/meson.build
index a7b77b87c2..d74b64a518 100644
--- a/contrib/meson.build
+++ b/contrib/meson.build
@@ -1 +1,3 @@
-subdir('completion')
+foreach feature : get_option('contrib')
+  subdir(feature)
+endforeach
diff --git a/meson_options.txt b/meson_options.txt
index f50bb40cdf..4f02c92524 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -27,6 +27,8 @@ option('version', type: 'string', value: '',
   description: 'Version string reported by git-version(1) and other tools.')
 
 # Features supported by Git.
+option('contrib', type: 'array', value: [ 'completion' ], choices: [ 'completion', 'subtree' ],
+  description: 'Contributed features to include.')
 option('curl', type: 'feature', value: 'enabled',
   description: 'Build helpers used to access remotes with the HTTP transport.')
 option('expat', type: 'feature', value: 'enabled',

-- 
2.48.0.257.gd3603152ad.dirty

