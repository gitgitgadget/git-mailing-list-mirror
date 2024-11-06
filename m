Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9861E0DBD
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898863; cv=none; b=KxiDuzvtlof3SpRBte/Hcia1S0x9z3eRSIMwXJtClc1lWLZRQHsXHytzlHZsbq66bJcmN98V6XRj1RIaNXV3OSAbR5o/rIwAXy8opIb0RHpAMjCkxumYhLO7nbyBN5xBtRZCeQ/B6H2eMoI+8FOVxFa1Ix9cP+L1kaPqoaijToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898863; c=relaxed/simple;
	bh=6o46ZyIn0zKtRIhEYLQpZ6kj3lG4IJGL9hiiEvIlJss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOL6hbjFOZTbvbNo5X1Ln18uMiqWNvoAfx4MzhlzOwwf64uGlyZ04MYVEJrnXGW8I9k9c1Y0C/3YrNGzNgp2MfcD7rtz0MC5mWPsGUDj3y3WbkInbnQF23BVQB3VRHUq66FSxxephgbeLp+CVW+IkbOQwyp9GMmcbPoruv/jLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jpwjrod9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PaXBZrjO; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jpwjrod9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PaXBZrjO"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5D61114019A;
	Wed,  6 Nov 2024 08:14:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 06 Nov 2024 08:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730898858; x=1730985258; bh=6JmpDw4Tkz
	afCVea+XyLFFl9mGsv1VFBXMYmtV63nmo=; b=Jpwjrod9D3hlwBZk8g4vB8urFS
	23C0IXlj/S/O/bniHIxTXPPvYGTBKAckUWOgGLcXvInrDFZiVOs61o8Vlk6GN/nL
	4iiDT5Iz2oDTgByH+fkBtLSEMXj/9E4vbYRRn0A6jiq4ZNnpmKaACm8aVc3tnjVy
	drlFwifoUQ3bfLQo5annq710h4PPIzIYh7ARK2XJYH133D33IzHJh76x4OxQE/tD
	h5O/vLbQnqpu7Q3HbtWQTQoaTgCGTpSKignZStGu3inOba+rzOobkOft5yS6L6tQ
	4OyPH/+rpOfYf0rc7gReUFrDwOdNFJJRa1yjE2Thj9a+XVFzKRNAOGYi4uhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730898858; x=1730985258; bh=6JmpDw4TkzafCVea+XyLFFl9mGsv1VFBXMY
	mtV63nmo=; b=PaXBZrjOoSXpVqpVjC4Zajjx9IV3u+FHToezpTugXST09zF1By9
	k5iiYMuw5xjm4UcdW5hEnLTKSflvOguxiUTNC4Hna3Cu19TGEKihU70ZIlaM6tZm
	weKS4szVaYpZsEMq/jVa5/JfZ0eDJ5bWpoedLG63HDGcQH3NeX4AD1HyHcnI1LVz
	B1No3yd0xSkZUMs+OvU+a+xt4Aagwhtm4IFdyOef5TyCFwO8yD0ImAUsrJX4j1IV
	+4sPwZThs6A7LS2/0u6l1WqC1S8uM1gekp7wYAC8MjMtYRSGmjEc8bucN2KdcvgF
	xeZir2OUjfqqOigK2rJOKXBAWn+aWzfAL3w==
X-ME-Sender: <xms:qmsrZ5vJVjXMXEthZiD2w1IrmbGHsSa5p0m4QWJRAqal6v97016sQg>
    <xme:qmsrZyc17ztmuwmKqwEd-qTn6fXwmabVkTEjMKDviLA1oq6EeOJFa9L00r1iqhARk
    cf5WOaHwblTL-vpiQ>
X-ME-Received: <xmr:qmsrZ8wD7zeEb3ecloZvIXEgbmufJZoDYQgcxLP94GSq70Nueiy-mPrSd8eu3wWweMCduAF17uUvO_n4rcVpLUNtVtd-5ULlQ7SWxG4ZszyA1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:qmsrZwNSITvbbSXiZ9tGueAnCyAT7Gks6F6G8NEeK4g8jviNEe6YtA>
    <xmx:qmsrZ59h5o1kd_bbuQ4fi6wvFwgOdymADCzI45t4v0y85nyroKQaag>
    <xmx:qmsrZwUHR8hMdKjuWQnPklNT34IG8KjEM1GM7ur_3xOJ1r9CH2HlLw>
    <xmx:qmsrZ6cMxlf2VtPzEhm6asUFTjRZb38WeNgyK4irUqFsol9T4Mv6rw>
    <xmx:qmsrZ1bpdzRzDFRuuDzJXrmXqLz59qeMpdJ6N1gfJKrGqWoBYVxIq6dg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 08:14:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3ada0d4d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Nov 2024 13:13:53 +0000 (UTC)
Date: Wed, 6 Nov 2024 14:14:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 3/9] ref: initialize target name outside of check
 functions
Message-ID: <Zytrn-WWLIupKZ6m@pks.im>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
 <ZxZYZy-9deyT6I9a@ArchLinux>
 <ZynFMnYgpCbYwQOs@pks.im>
 <Zyth0-rUAj83Rz6F@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyth0-rUAj83Rz6F@ArchLinux>

On Wed, Nov 06, 2024 at 08:32:19PM +0800, shejialuo wrote:
> On Tue, Nov 05, 2024 at 08:11:46AM +0100, Patrick Steinhardt wrote:
> > On Mon, Oct 21, 2024 at 09:34:31PM +0800, shejialuo wrote:
> > > In order not to do repeat calculation, rename "refs_check_dir" to
> > > "target_name". And in "files_fsck_refs_dir", create a new strbuf
> > > "target_name", thus whenever we handle a new target, calculate the
> > > name and call the check functions one by one.
> > 
> > "target_name" is somewhat of a weird name. I'd expect that this is
> > either the path to the reference, in which case I'd call this "path", or
> > the name of the reference that is to be checked, in which case I'd call
> > this "refname".
> > 
> 
> I felt quite hard to name this variable when I wrote the code. "refname"
> is not suitable due to we may check the reflog later by calling
> "files_fsck_refs_dir" function.

I anticipate that we'll likely have separate infra for checking reflogs
as they are both stored in a different directory and because their
format is completely different compared to normal refs. So there isn't
really too much of a point to plan ahead for sharing logic here, I'd
think, and thus "refname" might be a better fit. If that changes in the
future we can still refactor the code.

Patrick
