Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4DE1FDA92
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 05:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757395590; cv=none; b=RnbZaNpaSugb5oTiREaFWc5YGc0DtdfxW+1jfacIgV0Nr49j8f932WXMbEPWOKMF46rhUyfrCtCBYD3dd8mxUV03CEqMXeORGaND8DWJH/tJJCmxUgrLT/9uCmQAS2wAbJdNqNWrBhpuKh3H2k2nWy7+sO097VPP0tBQPwDxaDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757395590; c=relaxed/simple;
	bh=oyGiIbiCgH0RhS5iSw106ZtaOasDkr7erS5b5o2CwaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTZg6GP9hHi6ydhxMU33g9k4MGx8pDPIG7Fr0Wi03v4XgAHAkR3WEvsD70c6C6HtDWiIOvVgAdh7HmVUIsuBAZNHKOcEVNtfnrxdLKSfUh1vkQbFY5YAmg6sRqY38TskJzi40pAJwE+2IySHFyg5pfeaG6XbgZBMBkU4A/dRtYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=taGIDJIm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BLjAhMMa; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="taGIDJIm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BLjAhMMa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E7D114000FE;
	Tue,  9 Sep 2025 01:26:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 09 Sep 2025 01:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757395586; x=1757481986; bh=yOMrpa2B0d
	+QK6BxUnTMsqhwcAO2btG0GQBGqlYiOTM=; b=taGIDJImrLjGj0uixyi3sXSRM1
	NBECK5wDKQrsesUTXUphK0i3TXZEtAAjE2AZbN6Umvp80oPex/kpD12EHEMpipgV
	nteTDfxoDru2cTkRRGxWrvarGueMLJipQCD9CU0IdJSOlZfFR5CdFU6toGGXI7xu
	eU720pDETr85XuGi+bwAkGgxrkqV68ifLwGWH8WLbirsQKpFVr7NyikwPLj9aDbQ
	+ljE61euFmFwLd+oSbItSnj9ah+J+K8hoSmwprbdGgQgYh/oXCWv0SuHud5gxc1s
	xC1eT+tZA5c1bRbMvIBvJxJ0XcjBKra2JHxVImmmnLBcWHMuLnSxGu8LYQJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757395586; x=1757481986; bh=yOMrpa2B0d+QK6BxUnTMsqhwcAO2btG0GQB
	GqlYiOTM=; b=BLjAhMMaZ4Yk3l8RJt4P0wIy04YIkk+6Ko9B/3jKnTGznwZaY6N
	krFNqegPvHAJIAjChhl004/uJPtS9Qf5thJZNUmJ299oKPRabiE+GPDkjPnbKFXr
	oRN/mTWYdS4b5aVZR57t/aQWev2Z8FodKMMP32X+TEO5Gh7i/Q/0einmNFZ44zFf
	QcLypGPHDoV7Um/89Q9Hb8D/BTljKzXVCCCW8m6BggtJxU4U5BZyZWMU+w6h0dNu
	Trt5crr170hdLnEjrqfLKleVkQiPKPIB7vUaF0hS2yH+GnPyA7DpNcLhFmSLAeeU
	tIfIv8sJG5VHbFFjRWaMQKLJOefeVCEZBnQ==
X-ME-Sender: <xms:gbq_aLBgVBb2dpVyhHf-LMePQLlsBvt8fXw9mf1nEGbEYAOmrBCTuw>
    <xme:gbq_aMFY9YDfaFfNUyGB36V0K2Dv6Gi2ovsDpL-vNTzt3hjsR9wzybWZ_PD_Sf1-s
    L5mHlsKEbcz6q0SAg>
X-ME-Received: <xmr:gbq_aDI-QF-fkUSIYDtnwylGFfa_neXk_jkWhBRsJhtGejES7oXrw6VbMvXpw2JNb1YaMff3fbfSMSpyytU4_vVSM7H7OCHroRC_4tUQ73o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    mhhilhgrhhhusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:gbq_aAmdlKVYmnf2TcBMAtQllS6tusgWbnbYOTeRjqbutRHHSbzoQQ>
    <xmx:gbq_aLRAP-aPqDOTrxxi_NRFKlQG4a9qAN2tWtS_J1bI954Tz8_3SA>
    <xmx:gbq_aCJY6yIyyYLwbNOTy1TIHDym89_e51N14YqLZ0roO9R07228Og>
    <xmx:gbq_aBD55yV-s5Rmv93r445ujsl9LGRfUCT-jtR4NepNiEE3XFYu2Q>
    <xmx:grq_aGT5VHJm8KIyHxW-Coo6H4o0Id-MaW84vt9UGtm5fH9Chp7fiLWj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 01:26:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2fa02a83 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 05:26:23 +0000 (UTC)
Date: Tue, 9 Sep 2025 07:26:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Milan Hauth <milahu@gmail.com>, git@vger.kernel.org
Subject: Re: Git dumb HTTP protocol should work without update-server-info
Message-ID: <aL-6fPzaOhGpUafK@pks.im>
References: <CAGiEHCtP29bQRsEyLabNrLuiP96P-o7EEGi88B7pJbP0tfprxw@mail.gmail.com>
 <aL2fn4j5uhrVWrDp@fruit.crustytoothpaste.net>
 <aL6kevExmhesoEWN@pks.im>
 <xmqqy0qpxawn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0qpxawn.fsf@gitster.g>

On Mon, Sep 08, 2025 at 07:43:20AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Sun, Sep 07, 2025 at 03:07:11PM +0000, brian m. carlson wrote:
> >> I will also note that the dumb HTTP protocol doesn't work with reftable
> >> and there was some suggestion of removing it for Git 3.0.  It certainly
> >> will not work out of the box with Git 3.0, since the default is
> >> reftable.
> >
> > Yes, indeed. In theory though reftables could also be the solution to
> > the underlying issue: the client can be tought to read the "tables.list"
> > file and then fetch all tables listed therein. The result would be fully
> > consistent, unless any of the tables gets garbage collected. The client
> > would notice and abort the operation, after which it could restart the
> > operation.
> >
> > In that case there would be no need for git-update-server-info(1)
> > anymore. The "tables.list" file sits in a well-known location,
> > identifies all other tables we have to download, and there are no
> > atomicity issues anymore.
> 
> Does tables.list list what pack files there are in the repository?  
> I somehow doubt it.
> 
> The dumb HTTP transport was meant to be able to operate with a truly
> dumb HTTP server, that does not even have to support WebDAV at all,
> so there needs some tables at known name that lists _all_ the files
> the cloners are expected to be able to download from.  We still need
> the output from update-server-info [*] to tell what packs are there
> even if tables.list is stored at the known path.

Oh, you're right. I only remembered that we need it for refs, but of
course we also need it for packs.

Patrick
