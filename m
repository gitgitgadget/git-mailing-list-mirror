Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8DE232424
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866874; cv=none; b=El7O83nQLvxwJMr1kRuV4fH9y5vwXt+yc33Pq+fU9YUFs8vQeJfev9+m3NjV6zfEkde11mJMfn4pfcyBI6uObdJBykBnWpnr1g4oj7FrJ6dOiVQw9NHPeC6skJz2Ct6OjxWrznUlhpoJ+D+UQfDGiN75AxYwFxIInXyFL65oAlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866874; c=relaxed/simple;
	bh=Od1LbqjTNFHwNEdQQvq0Vrau9SaznnzS327/MkCpdAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXPp7eeopGDQVAs98ahkuXBq9M6yA/wZUmhkadaiALa5MyX0C859j2+1/W8vsXSnNA4z9i0le53pcdD1aFMomNxkKlrVd71jQDODWyBQw9l5KzKNGJMebhMK8jcB+fW9j6ZV6UoEB1LyyqOH3Mcd7oQA6D14c3XXoMDXU8OUecQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vMyNJTOI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PYzaxt3Q; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vMyNJTOI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PYzaxt3Q"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ACB3D1140225;
	Tue, 14 Jan 2025 10:01:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 14 Jan 2025 10:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736866870; x=1736953270; bh=OvUMm1hYmr
	nZnADRdedtrOdetE5MxV70aYLkTc1GtIU=; b=vMyNJTOI+Hg8yXuxSFvWBLdQBB
	sLk5iKS3gLsH+7pHSkAHpTY37mvmGSL/Xy6cyv1h2AopkBmLsfD8AgIx6prrlb9m
	JATk9mLOCmJZ4eytOSe46hxd4imlKKu4/iBSid4+5pQK5T5ioV/55cO99Twoyg9o
	JAfQ8aWTzKTaB6z2V0iB2/U+BbGB9t9dvkUEKUd/i0uWZoxtb4gTw7nvJUjjMWe2
	/pHPLR1dAjllrxkznxUncUGA54KBOv+ngKJWKOiDaX8yHBnLTgV2T51HtKKTaZOj
	8RWkseh4WDD13RohlJU2AEzW/mOPrJQ08l51lV/m1ITNfwjAD/cfNf1a1OIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736866870; x=1736953270; bh=OvUMm1hYmrnZnADRdedtrOdetE5MxV70aYL
	kTc1GtIU=; b=PYzaxt3Q6r9RKEeM9R4bbWgYfaQKu/GwuuwHyJhrUR7k4cHec3/
	9OomXf2Y9orh93dyOmn45o23snfh4CPbJeyv1bApJepWyGfOeM7LjDeN8vt2bWCb
	RZLsWQtNpZmAp7NTVbaDkjJtfzPqEeaqpgO25Wz/0TV9KAsfpXMAkGmIxWlkCzKa
	DBdZudO0VMmu/4AO2H+xzWN58aHjw2SAJkn4VKKkVJhlpdps33ZO4Mzl2uyQwvSM
	UnwWS8SXmV4ipAX0Y93W6lgVHpsUSH8Ong3w8ZEDvFb/DkV4eu2Mn2vUVHB+P5XX
	X2w6gsN6uNIjyCVmDQ3Uv99bfiyG/4bvl5A==
X-ME-Sender: <xms:NnyGZ4_dj6eJkRFnmagV0IYuVju_zpTdKiW7ZhZBbOlTTNKJ_8Dvvw>
    <xme:NnyGZwvsGSNQbvm7JHRMgi_iOvHn1TDw9cDD-bTLbeDLn1X4uwStPg7FuE84M3Le5
    ePVH12tK1dRtF-i7A>
X-ME-Received: <xmr:NnyGZ-C6n1fhqcbhsPh5nCaqwKZlr--XWVeariiZEPJapqYISRDNMxFnSXFedDy-dSlUvXuK4r3ikmzMQqOzJ3V-j_Ilxp3O1AxYMUtZ0H9g8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehs
    rghmsehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:NnyGZ4c9S5zczQYot5HC3Bcno22lM6-Kn8cbTfuoRY0pxhDBScdtDg>
    <xmx:NnyGZ9NACCyEuwcRm4YKpHdCNnDjny_YSGYIioDLILwdyDa4aD-F8A>
    <xmx:NnyGZynIK2f5Wg3NgW2gwRCTf760TV1IypOxvlnSqhvJKuaUShXjGg>
    <xmx:NnyGZ_ug4sksTrPNY2NHND_Uz5DGvLZ0ydU21bzKBrSN9aGNwd72Xg>
    <xmx:NnyGZyo0a0aVeo1EXri047WCR6h-FLjFvWOfsaRCvi9SiB9zy-PqmxAB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 10:01:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 303b62e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 15:01:07 +0000 (UTC)
Date: Tue, 14 Jan 2025 16:01:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Sam James <sam@gentoo.org>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH v3] meson: fix missing deps for technical articles
Message-ID: <Z4Z8Mg2IME0mveHJ@pks.im>
References: <5114dc9a00377826a55f6bab007d2ad1a4de8bc5.1736866030.git.sam@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5114dc9a00377826a55f6bab007d2ad1a4de8bc5.1736866030.git.sam@gentoo.org>

On Tue, Jan 14, 2025 at 02:47:10PM +0000, Sam James wrote:
> We need an explicit `depends: documentation_deps` so that all of our
> Documentation targets know they require asciidoc.conf. This shows up
> as parallel build failures with it not yet being available.
> 
> Other targets look OK already.
> 
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
> v3: Fixed commit message.
> v2: Drop incorrect dep I'd added for api-index.sh as pointed out by Patrick.

Thanks, this version looks good to me.

Patrick
