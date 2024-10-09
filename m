Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4178A19F402
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485800; cv=none; b=WqofVHyKla3m322Pyn+mWr1/EZ63OSsDiRPhCFrP3nQrl57gJcXHSug9CxHyk2ynZPKGV7xzeSuoohzNEUqdBqMHyWE2JDwa1sc/n3b+q1v8lmhtRpR6ZuKjnW3kwUtT1M6HlgTo4sJnl3yiZ1Xk1b33ieqpbxJOlQXj4qpDFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485800; c=relaxed/simple;
	bh=OSLp0anec5VzID3xwgHW+Bx0ysfm1q/NlbNeqLFAAHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfQc7ImkAgPDMeh5Ytc9GYENuiybc515D80+vYtBlBcb2RbiYcGCG1by79lKQ+P8AP6Twy3/B2dXDCotWxFZfo7+2195U5I9eHcy2vq/ovTeetlelHwl8TQfnwmI5E7C7807q7lvad9nkORk/OEke3LyDYYiAXO8kQeC/7cQ0NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R2bzkHc/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k0mF0iHy; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R2bzkHc/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k0mF0iHy"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 6800813801EF;
	Wed,  9 Oct 2024 10:56:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 09 Oct 2024 10:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485798; x=1728572198; bh=hfc6lJ6toT
	Dn58jdjgmZsXqX6d7MkdF7KXYXSz1eaOI=; b=R2bzkHc/5TYYd0rJ3Y/uno+pIX
	ckhM3qDbuY9mKAZ5ECtZ6Ae556dg2o/tGk82D++D8iFxXT0qreyz2qJiK6WrRczt
	mJdQ7t3q+ByKoT2rO+mYTwNjmwSph+Eb+dz/oyjGToitJ+fwLyW1VSvD741KIuyx
	oFIv6n90gjCvLHKqp2K+EoTuWHKNAM/5cyOZ6kxl1PvufDTnPeqIrR3QzvH4Y86h
	nDXD2fTkJaNFWd6SxGezYgv2uxkO3r1TmIxbgN+9y7tL6eBPcDKRdMLNantLe1tO
	KyLDg4BMcWQ+5SNghWoq84L0dNSagQuhREhli3s34hLGHGQtDN5g3aDoEC2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485798; x=1728572198; bh=hfc6lJ6toTDn58jdjgmZsXqX6d7M
	kdF7KXYXSz1eaOI=; b=k0mF0iHywwIz3uPcIBn+vRQ7zcE5OGuhlvkWiARF/paF
	akhSif86KeN9SUokKMM2kFhukgBXNR7EbFYhNBy9WlfWZOpQ5d4z1mJvjLaifPYI
	qGHeQBxiMi+C68tBZgZJ8yOALAe1mwAgYpttM8l/DhwJRrqhBE/iCI8yqt/amAhG
	IoTo0HE5zkgxNS6qqy57Lqyz8nGGl4Lx5kCpZVolkWnYQvUTRy0PBr/8sPsdZaDM
	TmmhPyY3KMxLYk2OPB6nwkyfiqqHomhPlGEZgfBOhi6YgUCTFFYxpxSCPm9ZYld3
	XwUx2iFKsQmaMYYuK/ztytebeK01CaH3vpnH1Er/yA==
X-ME-Sender: <xms:ppkGZ3cFoWTt_bxd_jBrMOZMHHNTYXwt_4KqwWymXS3mZK3A9x1Wag>
    <xme:ppkGZ9NZIge-SoLk1_11dklotNZKDUhCUmElMZoRgTo1WHl9BD3l2IWflVRAXwI9_
    ePQg-jYqIXAcrw-Ww>
X-ME-Received: <xmr:ppkGZwgpOKYjHKX457dbMOJG85v9iyv53LBmVx_EX0kJ7G2fS386N9wLDEAKFx4bP6xq0dUIpiJQktMuTx7Xpz3xXcw-SUFjaz8uGqMu2bIGcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiies
    ghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:ppkGZ48UCkM6_jkHCI2ukIEGqozrrnhV5GXgk80JXFMmy92tdx7tTA>
    <xmx:ppkGZzv_2suW_nmi2tvoE7cXgtpM7M2uk7MDqTMX0jr031sMX5S8qQ>
    <xmx:ppkGZ3FK2IInY6u82MjDRy7oTxwxm5OPybRf7F5F_cUAmjFiyux1Vg>
    <xmx:ppkGZ6PJwhkaHNaGqBsPySV-3b4SUVP-Zcz9cP7QvT4Z7I9T49SE-w>
    <xmx:ppkGZ5WQgcaJYIjs7FojExyimjMnt4fuu18dbhDaS1_aYXQmRjNJuiqd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:56:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c44e6e5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:55:34 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:56:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 10/24] builtin/credential-cache: fix missing parameter
 for stub function
Message-ID: <161f6b063afcaab69bb0c930ddf0d9ad188a1d05.1728485139.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728485139.git.ps@pks.im>

When not compiling the credential cache we may use a stub function for
`cmd_credential_cache()`. With commit 9b1cb5070f (builtin: add a
repository parameter for builtin functions, 2024-09-13), we have added a
new parameter to all of those top-level `cmd_*()` functions, and did
indeed adapt the non-stubbed-out `cmd_credential_cache()`. But we didn't
adapt the stubbed-out variant, so the code does not compile.

Fix this by adding the missing parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/credential-cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 5de8b9123bf..c51f7fc2ade 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -189,7 +189,8 @@ int cmd_credential_cache(int argc,
 
 #else
 
-int cmd_credential_cache(int argc, const char **argv, const char *prefix)
+int cmd_credential_cache(int argc, const char **argv, const char *prefix,
+			 struct repository *repo UNUSED)
 {
 	const char * const usage[] = {
 		"git credential-cache [options] <action>",
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

