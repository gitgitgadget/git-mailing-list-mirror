Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C69E199EBB
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564706; cv=none; b=mSXDKoGOr/NDbwglC85kMja2m431WaajfUa7VwEUuCyqKBMBRC3jPdTRinQwF5+RkN+ZDad/DhrZVwMZoGftvCoMM4EOd5Nls9Dz0SEoPNmyGvUCJoVHoBp24siZpwMFZc9X90OHcEkydzFq2eW3cSrc3DwWM8+CfLr88cklCBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564706; c=relaxed/simple;
	bh=P9cgrfGMbnOwFRtj+5LVhNoZEHCCqaTlkfsayvQyzQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5y99GwOlH0cE9BPsjB7PzkMDmuoDMwIYHu7y1PbVoW1DXeNMGy+0uwZ4KTjlUyJmJrb5iotC0yt0/QMuqWW8ABsY9bWvSm20eIilcuP7dfPguBsdy+5iOj6sBoRGAZHbjV5/m+mE3AL3hXhzXe61/XEIT0Avg6oHpD05u2usyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ND3uZrSm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f5pa2ZqP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ND3uZrSm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f5pa2ZqP"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 49A0413801BB;
	Fri, 25 Apr 2025 03:05:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 25 Apr 2025 03:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745564703; x=1745651103; bh=oct5uWeIEp
	cZJ6rYjaEWlIzib6jW3nw0un29+JJwQus=; b=ND3uZrSmDkNvQimG8Wrh1Cai+0
	04u4u46mzxtX1P9J2DhPmxaVlozYjAjUDimn4cPOgHuUuphis9cIBDgfd4qNzglp
	r2ViMjaK1cBADZnsfKgaDveIkfXFbQhNOvm85O471eZJtZHhKi2FzMam3EsBtlvy
	uGkZsvsQf3B4vPZgpPtwIGklJJzz1zebnFLFYqVrjaClQnFVS6ZiE575nGjp74Ys
	7zbZYkiaRP63BiE0eIo/4Ta1snZTV+btO6bv8nVZRl45jB3MgGTyZGCImQ39Oz7n
	LPHrgGRYr8H2PQ29I0qYMPfjX5e31ISLgM6mcF7ouPyTHysS8KaTSDc80avw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745564703; x=1745651103; bh=oct5uWeIEpcZJ6rYjaEWlIzib6jW3nw0un2
	9+JJwQus=; b=f5pa2ZqPKIefr4skivgx68A/sgu4jeZ/3LsONCIZbpFz5R0ijVJ
	bfjLkjuo/J0I7Xql35HFyPpkyBxBxfPpfP6RXU08ihO7WA7rILvkQExAtfOmOa1Y
	bbSrbUj/NjiabdaIXUruA7YhfR6m7qtTwdwbSfuowh4Gp8ExNTbrgUUpo8P3Nzs7
	9L97CVt81ZapQyeqH/Z1hUmKiBr+Wv4ftEak+wziyf9lakUQnpFCmMKZp1hFrDUZ
	JUPrHLGvbnCRjsqduIMkGu3H1dClA6BR4Nwjy0pRdXD3r7ykujRrzKJlLrWLbVFK
	fWaax4g870TEfLGrfmwHmtDFiu9B3m8DpwA==
X-ME-Sender: <xms:HzQLaA6n8XjfIiyuHd2tOgXSHosI3bdE0R9KowLqcDtMM8RkO2CC3g>
    <xme:HzQLaB7R2Afc41yehX9UbPfUoc5DH4naSCE7bBJGzuvsUv9PW43O4j2IbBS2RhVoH
    bAB2o160O0YC042ag>
X-ME-Received: <xmr:HzQLaPdVOub2zAM8L9o0BVoMStAkL1YJ3F7YzeWNEN8TbLnGeUBwOMV31GOe9RRzwR3pBe7_1XEgNmOlLucpfkAJcri_MTiK1mBjqYbT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheduieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HzQLaFLwqSaLEQja2ExFRuX2UTtYo4PjnGoCEFKYUa9yth-KF4BuFw>
    <xmx:HzQLaELDIAiFf710NW7nmFEWrjajAm6wMl_RIpk8aVKvUZrt8RUCyg>
    <xmx:HzQLaGwLH6PhChFR5EiwBEC8Cnv_NkB5-cHIN0JY17zBEMTmfs_lKQ>
    <xmx:HzQLaIJ2qPp-XnaHeCP34FgPonraanJC4vbnKUrDO2x2EGb88XIMpA>
    <xmx:HzQLaOi_DcH_HNkem_ShxBrw2U-vecpHXRBdbVMsX8lDER37ZvlrM_5j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:05:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 285d46a9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:05:00 +0000 (UTC)
Date: Fri, 25 Apr 2025 09:04:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/13] builtin/index-pack: don't fetch promised objects
 for collision check
Message-ID: <aAs0F58Hlpn6WI6b@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
 <20250423-pks-object-store-cleanups-v1-7-81f8411a5d08@pks.im>
 <CAOLa=ZQh+agLJYEGWU2O2=iRnJy94y9Cud3XRVaGVHC4YdbBZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQh+agLJYEGWU2O2=iRnJy94y9Cud3XRVaGVHC4YdbBZw@mail.gmail.com>

On Wed, Apr 23, 2025 at 10:08:05AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Any packed objects indexed via git-index-pack(1) are subject to a
> > collision check. This collision check has the intent to determine
> > whether we already have an object with the same object ID, but different
> > contents in the repository.
> >
> > The check whether the collision check is really needed is performed via
> > `repo_has_object_file_with_flags(..., OBJECT_INFO_QUICK)`. \
> >
> 
> Nit: this was a little confusing at first, until I saw the code. So what
> this means is that the collision check is only performed, iff
> `repo_has_object_file_with_flags(...)` returns true.
> 
> I think the confusing part was 'is performed via', perhaps:
> 
>   The collision check is only performed, if
>   repo_has_object_file_with_flags(..., OBJECT_INFO_QUICK) returns a
>   truthy value.
> 
> But it is okay as is too!

Will rephrase.

> > But unless
> > explicitly told otherwise via `OBJECT_INFO_SKIP_FETCH_OBJECT`, this
> > function will also cause us to fetch the object ID in case it is part of
> > a promisor pack. As such, we may end up fetching the object only to
> > check whether the fetched object and the object that we're indexing have
> > the same content.
> >
> 
> So us fetching the object is pointless, since we only care about the
> 'does it exist' part and not really what it contains. In that case,
> shouldn't this be s/same content/same oid/?

No, it really checks for the same content. It basically verifies that
any pair of objects that:

  - Exist in the packfile that we're currently indexing.
  - And preexists in the local repository.

Actually have the same content.

The weird part is that we also do this for objects that don't yet exist
in the repository, but which are promised to us. This causes us to fetch
them first only to verify that the fetched promised object has the same
content as the packfile. And given that git-index-pack(1) would usually
run after a fetch, we end up verifying that the fetched object obtained
from the promisor is the same as the fetched object obtained from the
packfile. Which ultimately seems rather dubious to me.

Patrick
