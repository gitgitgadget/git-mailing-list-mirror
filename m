Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8479C32FA29
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205892; cv=none; b=Iu11euUI0YjrMDDviEak+zWhGibpwqbKP8cmON1v3uTGV/Q7YbJnoTbzQeNWfe/9umSRLDVgtSGZ4zuXQifSjPrcEKZ8LYwQzcjisiG4GVVbUB1WSOue33OoBxLVPGEw9eN0SPh7aJqbWyK5chHMzxbZp6fGdLaefe1uvqO7ge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205892; c=relaxed/simple;
	bh=OqQOKF2z8dHwvOB713xAHs0INIErNzpKNKBgj8w44Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUSzmcCaa3O+P15I9G2Og1leoP+kxTD6f5rGMyigGadKqtS38bwbejeMMrlfR7NPIoW+uoHxizj17EExI35RVbw784TOsrwMnp5JU2HE8LbIw6R04Xz6wq7JRwFAYHCoBN8XBK0HQcAEqwV7Mi4bpqPT+W5g5DO/yNPI4EB7Cqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JCc0JP9A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xSZWPk2x; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JCc0JP9A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xSZWPk2x"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C7D721D00033;
	Mon, 12 Jan 2026 03:18:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 12 Jan 2026 03:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768205890; x=1768292290; bh=+Si9wmlRjM
	kMvTKz99z+cssjCiFt1FWlqYADs7DxDI8=; b=JCc0JP9Ae22QUgpOgnhRBm/U+P
	CoHZOW8ZNIcyeoNo3CQ/9ndTpUWOWQEXDkCYiaNozSf/BtsH3HjBQVm+4SY/Dz9T
	dzfC4LQI0PcS2c8EdWvbJr/a/Hef78/uCDnp2nNwmlJ9pKnBk2Nn8TfPtX/u56EH
	1Vwf+cflw+IQ23yWdFn2PCPu2F4ZoQ4u4cVclVHWFU3KrO39x+Lhiwvh9yEHaQ1K
	UX3hQY+wK8gC0SdSwkza24cDOmZ8uuox99iZQR1Ze7cEKTrPQh/pR+4PO5IwvhNU
	J0QFjEvhIUtosQ8XnZTzpJGkHYI1SJ4Er78OiebSShsu+h/88u66rTUpmvkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768205890; x=1768292290; bh=+Si9wmlRjMkMvTKz99z+cssjCiFt1FWlqYA
	Ds7DxDI8=; b=xSZWPk2xpfPP8Kaxv9rK0un7fBJTw5JzyXdp9y5K5ei9i5Dpsay
	QXJpuleglyTkKzUW7l9FxhlUI5WNFmNj+J0yLtNyPMMvYVBRlpojSyqxTRMFu8Pa
	wtcfVVicnJSIVbRaMP9jYUlM3IexxoUmVcovP2IagVdPqjfgQinE4xY+NF/ROu3H
	wEMAA2g0FqV5r4GKOW8DS93VWm+i9BOsNcpayRlzOjYPtgi81uQV3YcnY5zIE12e
	acEMGL2b+IMO0br+S5YA2XPGsPoKjJL6nuBbAVoaCL3AEknuE+al2CGMkVwAT2GK
	+qbA+CSGeUkqtidMzMIwhUGWxXcjAcfuyLQ==
X-ME-Sender: <xms:Qq5kaXUMKBWUbaeywFWfzlMAeM3DVIvTYsbRoTz18UiDOa2FuPYNbA>
    <xme:Qq5kaXBj7KDG1_zvksjaMGO1OEUOmnRepZGq6FNhgWuDEI7sNMx-z816zQ65ErgOq
    HN-jhX43qTiEhdJY-3r7Opg_ktqXm4dSf6KrX4k_k7CgcFDaq9jbQ>
X-ME-Received: <xmr:Qq5kaQz_uuX8gTyNgUkHIoahKuIZDOBBqR9PBVBu-j3wCJ013KguNX3W3r7WMfqLOXWiOZgki3z2YheKQZJnL11k0OCKrajC8mB3igMMCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeileehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjh
    hirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:Qq5kacDjnUFKfu6etKDG9E7npxpxjQtzFDn3uO1M5TH9xW5sgpjsrQ>
    <xmx:Qq5kaVb0OarX0nZIJIU7WIGhMadM0ufxiYKBSMh0rpQV6XmDi1DuDg>
    <xmx:Qq5kacjNC2q4AZN-0lCH6xqqB1ku-gnYj9yT45-X2Txx9_34xNk5Xw>
    <xmx:Qq5kaf5XG1TG1RJxvEhQOjaiaN7Padg6NL-N2Ero-AqlpZ5kcTn7TQ>
    <xmx:Qq5kabfycCwf1P41UBKJd9SWdxmguhs40S72W8MMzRbftbeGbCNRLtL7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 03:18:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id acccc050 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 08:18:09 +0000 (UTC)
Date: Mon, 12 Jan 2026 09:18:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 00/17] Fixes and improvements for ref consistency checks
Message-ID: <aWSuPkzH4RsG472A@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
 <aWJWCiTFQAZqDb9y@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWJWCiTFQAZqDb9y@ArchLinux>

On Sat, Jan 10, 2026 at 09:37:14PM +0800, shejialuo wrote:
> On Fri, Jan 09, 2026 at 01:39:29PM +0100, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this patch series contains a bunch of fixes and improvements for ref
> > consistency checks. It is structured as follows:
> > 
> >   - Patches 1 to 4 contain a couple of cleanups for the consistency
> >     checks done by the "files" backend.
> > 
> >   - Patches 5 to 7 introduce checks for root refs for the "files"
> >     backend.
> > 
> >   - Patches 9 to 14 introduce infrastructure for shared checks with the
> >     "files" and "reftable" backend.
> > 
> >   - Patches 15 to 17 move some ref consistency checks that were still
> >     driven by git-fsck(1) into `git refs verify`.
> > 
> > Thanks!
> > 
> > Patrick
> 
> I left some comments. In conclusion, I very appreciate the direction to
> share the common logic for both "files" backend and "reftable" backend.
> And also, we could check the correctness of `HEAD` to make the ref
> subsystem self-contained.

Thanks for your review!

Patrick
