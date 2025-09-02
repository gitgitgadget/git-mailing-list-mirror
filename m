Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AB92E6CBD
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803033; cv=none; b=dHXNFD8cpejl+6YVD6YjTE5P6F5gvGIKzLzvk4/aZJjK488NMJgrUGVL9CXszyk6ZFc0mlhV0qhOFdVjQVpuf/FJaxEkoTG1YDDkUV827/yEMfJb2aMdd3Tm3mSkOOUqkb1/j+CGrek7s5z0/0lsJXbo/tdnYGS2j7//HFDOjXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803033; c=relaxed/simple;
	bh=WEjQzEH75ddmXHiJk6+kqxAcQHYHlKHD2nKzpIV5T0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXhWD0d3eMKpUAF4a09eSkPN+vVjopIYj2a+ChrTJtSAaGBTJBzQNIe+ea2L8bdF6H2C3qe6C6chBlo7W/K3nsKEcduIbj4bjR/rLBWaKxy9DPvnbj09Nu6UazeKtXy1fRh+vPrgIYVQBAUkLSgajfUc0F/v/SOD6AupXtR/vOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ebMPeh1R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YN5hKDkF; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ebMPeh1R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YN5hKDkF"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 39538140028B;
	Tue,  2 Sep 2025 04:50:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 02 Sep 2025 04:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756803030; x=1756889430; bh=+5yiDrOTs4
	j8EK/x2VkHe6f3s3Lxd16kdsvaJ+QVMzw=; b=ebMPeh1RmwgTwJF4WhpjaswHA/
	9lvtdoQK2ViFrQWJqOblkdgf46BV7BMtaxBKo5OMpFvQaD1357Cn9koB0O+O1Qr3
	7HKMThF+YhgsLRZIKAwiKSggLLdviLA5vWlnDk5/RcKSvk6hy/gAWDbg4BchgQxl
	KFze7/EvyWfzquwKIekRNn1cFG9mtUzNz8ShOiiBRQmVoMn9LF36aNM9Y2DHO3xz
	hUgmXwf/vRMIzQsiSlIjO4uepFVL6BeaziNMcaald8ktfTchJBKE9+lPqgWLMlfK
	hRgiwY89RhJw6P5tJJQOdhJwZ63xBl9Vv143yfesJxMFmhAX8vaEcuQCZPdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756803030; x=1756889430; bh=+5yiDrOTs4j8EK/x2VkHe6f3s3Lxd16kdsv
	aJ+QVMzw=; b=YN5hKDkFOfFfNBiuabUBUYhNCuF4L56fi1MjBjFGQi/FGjQOa1g
	mCH/s2jNVGId4TSwrR+cROfSHY3+wGtPktjTuVtzuZn758NkiG3ajKszvcrotDbG
	hNWQtdfV0NC04uxftkaJVlqbvCoMYrd8UVlBDfBLb3osyj3udINEsLcFaDZNCmwT
	/x6h/vlxTMKNHIOOb10NR76c8Tqoc83TCyJgNFQE6D9G0VYXousXPavERf8frU1n
	EmMjAnQHljbBrOqfWPv1tmeid0Np5R3hgAGsKTQQft3yw05uB2sfBgVHx/VxonKH
	kI6s+GwX0qlCGH6nXDAhSE2ZPTBha1mGfKw==
X-ME-Sender: <xms:1a-2aMdcmT-iWxdGwySkZID8sJZtCYtUcNJMKJF3lTuSS5lzDRzNAQ>
    <xme:1a-2aIxYBWV3Mrdf0GOo_CJsM7gy5Q-l5imQclP_NZnCzg7Gpq9OJS9Aa2TxCI_Sp
    VCZBhoCo-9mbQm7Vw>
X-ME-Received: <xmr:1a-2aKGJBLNvyL2z6A1zUFtNu5bLbjlQ23Io99nexPYFJT8cC9pu7cEv2j9m3bxo1fMRVXmbeuXptslayy2lv8ZessctkxYP2TTG0YgCa1XN_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleegiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1a-2aEx1QnhqyCDd__CFDXe4DZhf26XP-VrmF8WMV_eaefYE7M_oiw>
    <xmx:1a-2aDuHVELLimSbTlxsxAAKab2Pw88gwYWHcv4xfBBYzvdo1U5vVw>
    <xmx:1a-2aJ2py4tHDkndU7qHOxsZzvfv5rPv2mVb9uaP5S3texpNmZFBAw>
    <xmx:1a-2aG8sAx5pD6WmMX_7nAPyEwVQbj4PrfrA8hASBXe-9PcDkl6x0Q>
    <xmx:1q-2aOWM76hfvbwDF0di93z5L7ianJKfANTfltU8PG1LnrxGj7ctW_eK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 04:50:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fdff466a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 08:50:28 +0000 (UTC)
Date: Tue, 2 Sep 2025 10:50:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 09/16] packfile: split up responsibilities of
 `reprepare_packed_git()`
Message-ID: <aLav0TRRg6mH4Umw@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-9-d10623355e9f@pks.im>
 <aK0XeiRz13O7j+HO@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK0XeiRz13O7j+HO@nand.local>

On Mon, Aug 25, 2025 at 10:10:02PM -0400, Taylor Blau wrote:
> On Thu, Aug 21, 2025 at 09:39:07AM +0200, Patrick Steinhardt wrote:
> > diff --git a/odb.c b/odb.c
> > index 80ec6fc1fa..37ed21f53b 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -694,7 +694,7 @@ static int do_oid_object_info_extended(struct object_database *odb,
> >
> >  		/* Not a loose object; someone else may have just packed it. */
> >  		if (!(flags & OBJECT_INFO_QUICK)) {
> > -			reprepare_packed_git(odb->repo);
> > +			odb_reprepare(odb->repo->objects);
> >  			if (find_pack_entry(odb->repo, real, &e))
> >  				break;
> >  		}
> > @@ -1039,3 +1039,26 @@ void odb_clear(struct object_database *o)
> >
> >  	string_list_clear(&o->submodule_source_paths, 0);
> >  }
> > +
> > +void odb_reprepare(struct object_database *o)
> 
> OK; so here is the new location for the non-packfile related portions of
> the former reprepare_packed_git() function. That makes sense, but...
> 
> > +{
> > +	struct odb_source *source;
> > +
> > +	/*
> > +	 * Reprepare alt odbs, in case the alternates file was modified
> > +	 * during the course of this process. This only _adds_ odbs to
> > +	 * the linked list, so existing odbs will continue to exist for
> > +	 * the lifetime of the process.
> > +	 */
> > +	o->loaded_alternates = 0;
> > +	odb_prepare_alternates(o);
> > +
> > +	for (source = o->sources; source; source = source->next)
> > +		odb_clear_loose_cache(source);
> > +
> > +	o->approximate_object_count_valid = 0;
> > +
> > +	packfile_store_reprepare(o->packfiles);
> > +
> > +	obj_read_unlock();
> 
> ...I think I am missing where we call odb_read_lock(). The function
> packfile_store_reprepare() has a comment that it must be called under
> the odb_read_lock(), but I don't see where we acquire that lock here.
> 
> Are the callers of odb_reprepare() supposed to acquire that lock? If so,
> it seems a little awkward that the caller is supposed to acquire the
> lock, but the callee is the one to release it. Is this function missing
> a odb_read_lock() at the top?
> 
> I looked at a few callers here and none of them seem to be holding this
> lock. pthread_mutex_unlock() is supposed to check that the mutex lock is
> held for recursive and error-checking mutexes. IIRC we initialize the
> the odb mutex with PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP, so I am a
> little surprised that this did not cause a runtime error.

Oh, that's a very good catch. And yes, surprising indeed that this does
not cause an error anywhere. But if you look at the code it ultimately
isn't all that surprising: there is only a single command in our code
base that performs concurrent reads via the ODB, namely git-grep(1).
That command explicitly opts into `obj_read_use_lock` by calling
`enable_obj_read_lock()`. All the other commands never perform any
locking whatsoever.

In any case, I think I merely missed to add the locking call into
`odb_reprepare()`. It shouldn't be the responsibility of the caller to
care about locking, it should be handled automatically.

Will fix.

Patrick
