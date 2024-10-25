Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0665D189B9F
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 05:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729833668; cv=none; b=GNqyryPStSTP3r+wNeUbWXfT6zmdkvOD+1kTrzPsnOQ8H3MkhFtTZV6em+jglF1EXRd4HS7sH6df9gmV2uo/9N3J/SRfgnNXseTsUlmNAmHoc+Ka9h7OGHu1++YcIKmwa37Qqyo0hd8GwBKdnVIEGgli6ehGdAbr6GAou1gnVgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729833668; c=relaxed/simple;
	bh=duQ+rMq7vuTTTDKYwT2AxnDJwPT9ZMq3TBZ6V/zZBPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1enQ/exgmUDB6+1MiAp651K86gcCs/3cI/VzDYKx9itvlRMzhY551UGtJuegZ15Ti3r+fkfa2/s0PggAh6ZaZsZbsmlI2vKhwSY0evJTOWACqAG4BMPlFadthGfyY5wEb3l1zw1D2ULdkmucyKrv9XrvjYzyz/BBhaMXPFPRDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pQE29pEW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b5RQfJY6; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pQE29pEW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b5RQfJY6"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE59F1140088;
	Fri, 25 Oct 2024 01:21:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 25 Oct 2024 01:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729833662; x=1729920062; bh=duQ+rMq7vu
	TTTDKYwT2AxnDJwPT9ZMq3TBZ6V/zZBPc=; b=pQE29pEWDHCpeD77sDfJzlp1hC
	mMC/6wb+Gqk/LOctDDdEJ6bMfkRo1xo0BDhDQhsWAvjWpY34ASjJ9Bi1mJdhZL0u
	BPDsBDjiTAHcGEmB+2jtHfbqx9xoPsDTmfcddOE2qHXHHN2aMPzSg1T6AGMeJsnf
	65cFlN12r+dM44nFRhs5XdUvLazlVahRjbToLPlMTVb1p/l/hbs/MfWYTGtJzBNp
	UE0bldzfcpJSBGXoCLm6W4n4H9sbPc0yfJVuKz/mNAZIdGUWvw7eo/rDysUGDBiT
	o5UrYWrIxkgYRO9NumIMJB0Mxz5nYXJ9waHIy0P6CO+F14YGjjjKlx/7lDwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729833662; x=1729920062; bh=duQ+rMq7vuTTTDKYwT2AxnDJwPT9
	ZMq3TBZ6V/zZBPc=; b=b5RQfJY6LCVHBsFj1lTO4gy45RIBF1sVqFXZS1X89USr
	nkkiDxbgpHHu55mjSxd69S75p5zWmzrfbzUYeGcXlUuutJQOfQV863aRwBIxKIEW
	lG0px36FEesgU4J7nFr3nyHiAGiu4zbMlrAS0REjzDGbIlbBUIH7JzkFLHoF1QSX
	Dq9TqJ80Bw7VtbY96y6M+GBcuRhYYXeTgFQDCWUNgpsVtXmKtHHa/SeJLgJWmr7E
	Sn3kb8N7c/nsKCEbpEQtJ1bd+8pRZTxZ817+addOnlmTr4JjXWVJIaEDsLsst0FT
	Nd844bOcfVLE60reQBMNDrO39xqSx4YN3SPliPz62Q==
X-ME-Sender: <xms:viobZ3Q9aZe4avypknBpLmrJNLl6oEA5RPMde0f9-ULQJUHjf-O5SQ>
    <xme:viobZ4x-64v9_XZPTyYncx5jho7pIsvvs27bm_GflgYnRoFUv7uWCFkoba10LIdYu
    53rQcuZcgoUol5WKQ>
X-ME-Received: <xmr:viobZ80BZy8CkqzH3esa9_2GzGEYv1ZsRtp64halCGLChQ_DwORUJJgs5U-eJw-L9gj7FEcPtRdpRmBYjw0agkRBMg6OJBJB8YZt1THqdvyMDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejuddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhies
    rhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:viobZ3BeWW5sZNKn_ysCKnPRNns6p3EgggZaBUBb3JmKuY4W5pMvNQ>
    <xmx:viobZwiaabJTJSgDewajmxoeUU_dI9uJ2NZh9KqXRt5tvUiXrC-apw>
    <xmx:viobZ7phoEexe13DclqH5Sh2oL-B-4YPI4Mgri3CnrCZcDXVHhLcGA>
    <xmx:viobZ7hJLG3ZJmosVoQouKQOU6KJMb2P2u_Pb1bch2M_9__RiD8qCA>
    <xmx:viobZ7XnMEiidlvpm94bOdgjD7PFl4WMsg2rFUokSFTjVlMHqsF4ABoS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Oct 2024 01:21:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6493c5d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 25 Oct 2024 05:21:00 +0000 (UTC)
Date: Fri, 25 Oct 2024 07:20:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Eli Schwartz <eschwartz@gentoo.org>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
Message-ID: <Zxsqr3X4FAWfy0HP@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
 <86de131b-bdea-4c37-b512-68b8378f4343@ramsayjones.plus.com>
 <361e69ee-4491-4e2b-8edc-fdf4bcbb8532@gentoo.org>
 <b35b6f10-ebb5-4266-ab95-aafb67cfad22@ramsayjones.plus.com>
 <ZxjmTbATU7usHcqQ@pks.im>
 <c32a7dc3-cf9f-4d42-98da-80009f9df847@ramsayjones.plus.com>
 <Zxn1HWg7KxZwBy9h@pks.im>
 <787ef076-ba72-4a0d-bfd9-1f79de4f4039@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787ef076-ba72-4a0d-bfd9-1f79de4f4039@ramsayjones.plus.com>

On Thu, Oct 24, 2024 at 06:34:24PM +0100, Ramsay Jones wrote:
> On 24/10/2024 08:19, Patrick Steinhardt wrote:
> Having a quick squint at the failure, it '# failed 1 among 397 test(s)'
> which was 'not ok 391 - correct handling of backslashes', which is the
> only test marked with a '!CYGWIN' prerequisite! ;) So it seems that I
> am doing something wrong, which results in the prerequisite not being
> set.

The CYGWIN prerequisite is set depending on whether or not `uname -s`
contains "*CYGWIN*". Does your system maybe pick up the wrong uname(1)
binary somehow?

> I haven't debugged that yet, but I wanted to note the above improvement
> having 'fixed' my python installation. (It doesn't look good for the
> TEST package! :) ).

Great, happy to hear that this is resolved now.

Patrick
