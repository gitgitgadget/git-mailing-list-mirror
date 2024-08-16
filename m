Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700FF194C73
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805533; cv=none; b=mNPJYTrONtctRffPSO3F/YKssv4AWXGuJyCOfSyaxWDA5tCVfQmHn+HFsRD+3E6Z9eL/B/9kD2EmoaT7PjokBB/rydiiNwkkvn1XAhu8Ag9gcZgVfZJpGei/GINJrE3UTO6Oxt9DQtH5tDvuV8ePbBiOWZGT0tTkkWUuANVXhyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805533; c=relaxed/simple;
	bh=PK5yyM84XfNmnc5m2wRmfMEoVLM7UdMdSNDXCQd5APM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLMQ3HIhyj41ins81txtrIgb86cWBF1+RdGT0rU3eMJvdefTFaozqPZ4Eo0mTSTfyw4QWaVwsLuaFJ0Eox/w91iaUxHcebLnmR4JFTT0vv/eBJnVZ42ww9qberorbohp8Raer8nzzIG4I42ZYyQJuWFc44zfOaFN4dnbexFCFfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hnb0KzkC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GSsXMdco; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hnb0KzkC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GSsXMdco"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6A35B1151A82;
	Fri, 16 Aug 2024 06:52:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 Aug 2024 06:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723805531;
	 x=1723891931; bh=5PYem3ztrL3PQygLsCQK1IG/2QAYIPyUPvdI5mR4GT4=; b=
	hnb0KzkCoQ7XBLkqsTKFT1k43JtyPV3tQzP/3KXRbiFSasIpKzaPZdfgPbvZX66f
	tgProYpnxqf1rIoClwfLK8F9sQG8hY5ofVaO78EyzcPZEhqQ83pJHbXx8V4jdkDq
	DcwoxiVO0UNOXwHbRuy77d1J9Jr5iZ6hwQM12ReOZ0lbzNQtOD8/87B6xsJBraRU
	o30rMOYR+QC8/86pKkVnx2EOEcO436F+p2WIbe1GfNGqaSbTWB8D5YbfPXOhRa8o
	qdhox8/WNjuiK8IfAjxwN1r4XpBqhDrX60pjaJvDkbjzMBv+BzviQUUoWE8Dq70H
	51LxcbFq8ikY5n1TIogNAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723805531; x=
	1723891931; bh=5PYem3ztrL3PQygLsCQK1IG/2QAYIPyUPvdI5mR4GT4=; b=G
	SsXMdcoopxb1ckr6Am1rdIqCeoxMLyaIMFLBEGtcSy2hCwDOG0yd8tjxz2kH02FI
	YpJQ83YGLvUDC7iiQB8VLRYUWVTuvyqo/0EmqSREkByjGI82ZB8ZFMa99vVBJqIM
	z0ZaX0qbxobkELzlXNcM1dYqL8oB2uDkuwAVlkQd3sjt8Eem/UrLdnRS6tiMLn6I
	WO4CsX2b1iRPgBWoKiC0vqbGKdPPe4fAK53VJPKJwzfvPsw5bTl+boPSq1JzkaDK
	8R1py9UPUYS99f13J2MHjFQ1alHsGf6XhSJ3qcbSkoZmJHtMLW/9zVLOrRsdcOzI
	BoYKsYhUx/9iO3Z+8Nnew==
X-ME-Sender: <xms:Wy-_ZkixquaWZSI9gcidde7p203Y0WOGAbzEc8FqxWZkB4pviCJkqg>
    <xme:Wy-_ZtBHSrjMIb_gfdp-d3k22WgKbmdnSs1Fyvf25u5s-hOvV7mMLyfxCewIgAkk7
    2uSDrVbYo5N3oIYLw>
X-ME-Received: <xmr:Wy-_ZsHLRb98shXKvBS72O6L2p4OGOLB_Oicw_QkW51hYPpg_3o96tixFywQVB2rCDIpFceOrYowtM5iR0r9Us3GUKdgCIQfcZtvK1pONQG2gLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghvihhhphhitheshigrhhhoohdrtghomhdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:Wy-_ZlSTlp47vX9rrikhPiHyUlCAQCPtCxIyX-0vjQYGWMKhirBDPQ>
    <xmx:Wy-_Zhz3LbTFQorfRYtycE25biqesx0qtHMgYQCVXfgc9av_AKSJNw>
    <xmx:Wy-_Zj77S5pEq-g_vwzZv910rhOiL1rDLXw8VeFLJf0EIBFE2mfztQ>
    <xmx:Wy-_Zuw-2ckd0o7eZi-mU_KKyOFsEzh1_KadIEMXbraZCSnw8Uw4xQ>
    <xmx:Wy-_Zjs_I_TZ8sieOqCJOTt9OcrikhPeIxa5uuf2_IjlBr-Lgzj5mGd_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 06:52:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2f29fdc0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 10:51:47 +0000 (UTC)
Date: Fri, 16 Aug 2024 12:52:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: avih <avihpit@yahoo.com>
Cc: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 3/8] git-prompt: don't use shell arrays
Message-ID: <Zr8vWCKrddYpABIr@tanuki>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
 <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
 <7e994eae7bc3dfa021262410c801ddb124ce24f1.1723727653.git.gitgitgadget@gmail.com>
 <Zr8Swsn3H2ebB7g6@tanuki>
 <1677713578.1741123.1723802016957@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1677713578.1741123.1723802016957@mail.yahoo.com>

On Fri, Aug 16, 2024 at 09:53:36AM +0000, avih wrote:
>  On Friday, August 16, 2024 at 11:50:14 AM GMT+3, Patrick Steinhardt <ps@pks.im> wrote:
> > On Thu, Aug 15, 2024 at 01:14:08PM +0000, Avi Halachmi (:avih) via GitGitGadget wrote:
> >>
> >> -            svn_remote[$((${#svn_remote[@]} + 1))]="$value"
> >> +            svn_remotes=${svn_remotes}${value}${LF}  # URI\nURI\n...
> >
> >
> > I was wondering whether this is something we want to quote, mostly
> > because I still have the failures of dash in mind when assigning values
> > with spaces to a `local` variable without quoting. I do not know whether
> > the same issues also apply to non-local variables though, probably not.
> 
> IFS field splitting and glob expansion strictly never happen and never
> happened at the assignment part of a "simple command", since the first
> version of POSIX in 1994, so quotes are not needed to avoid that.

That's the theory, yes. But as said, we did hit bugs in similar areas in
dash where that wasn't properly honored, as Junio also pointed out on a
later patch. But that was in non-POSIX area anyway, as to the best of my
knowledge it only happens with `local` assignments.

Patrick
