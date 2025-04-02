Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D223771E
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592414; cv=none; b=BUfpvZPmQpP1PR0U2YIIcP5pWeKl7xsPVJdBF5/fsYRF/5+KbxrHvELzc9hR/VgNufq9vgUGoGn/Rao6x/MBtVvV2UjMZwFjV9QtJZ2n1bGUIqqbAJRHlJyXQOsRRKmmPjr+MZOIgeQislb2L+ngQTujVIXXI5moh4eYaQsd7/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592414; c=relaxed/simple;
	bh=9QMCIi9+dFio7plGMwKmvidY2UV190KpPJjZCjRmI5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNPvy9cCFkG6QBCp2ViZlSEDPYspfiUj0Z/ZRPQuaY39eFrN3WTHTJdeAL7LtMkwocC0rlRTqz/ZfWAl66/ovycqLCXDV+T+2HKakbRhyxP3GpSIQ0UgEE7uUQ2RbZHK64dLRZIQkN8dry5zpEoZZZA5U0b53B+e3nU/+l06mu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VbqCsQQj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wv0fsozd; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VbqCsQQj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wv0fsozd"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7DA4D2540253;
	Wed,  2 Apr 2025 07:13:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Wed, 02 Apr 2025 07:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743592411; x=1743678811; bh=lZBY3PhGqe
	EMWMKO7Um4S9rlsAHS3uNbG0XCtzd/wpA=; b=VbqCsQQjK/x5Dnb0l4tmDIi6V9
	dXFefWWQqdbFCkZ+zs0viED+QpVlYmEhRhdiaXwSH61lDgkYH+4kynQC+nnPkmbe
	sKzpKC4LYUHZx3Zn69fi1Kp8IUxj6UXSB5q8v1gBdYyv3mRhecEwuHORTupTv3NW
	8VcL5JS6WpWoiXHODWc2PCztNl3BjEU0YkvknCvnKTYQzzpeYyh5ibxlxxoiqZlr
	ykEn9b0Ovj4p58IJUh9yUI035obr5TJgeyaH5c68Zyakz7RAVNeCCj0zJ8xvhL3q
	of7tllHxT98kXLsIBMdKlWWQab/a5Ztr66JQxC979ReSXiwJEWDbtVWY7V5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743592411; x=1743678811; bh=lZBY3PhGqeEMWMKO7Um4S9rlsAHS3uNbG0X
	Ctzd/wpA=; b=Wv0fsozdrS+zqLV/TYL2IADd6EjE0h/VGHxBa+vXxr6nGR6MsgZ
	V/kZaYEpKjHlNW+JU9EX1/rEs9Qo8q31EKXk47+nHIOW5HO0ai9PnmARN0hccADJ
	eyPhO8WjYKA4z9U0G6LgGi9Xy20iuucIdxz9AL83q85E0VIIr6TJtfjKtEoa8rrE
	mRuqa3KFI7VD8EW917eYV8p0ROijT31yCo94DbML1Y7XQIVCRMxYxIFtzmRtJUAO
	3heaG0gtiwBJY5c6Tn4/3rOQZZxJ+QUAMEfVoF6kIT0koBFvzhpx+bewTK5SNm6K
	CwkgHdnw02gC9bSwoSaZvuCohofxu9N1A5Q==
X-ME-Sender: <xms:2xvtZwTCtGogLtj4X6FIiWXt6VigBWOZVtz4lej6xKVWvI6DnVeFQg>
    <xme:2xvtZ9xP7HC1NmozAmEMFnq--nl9wlfa5Zo-sWWrgXBj-fU6nLzOZbc2uhACASGTC
    Cq-RoCwRigleoNgvg>
X-ME-Received: <xmr:2xvtZ90AjsIRXAbbynP8GmeJL_QIA0k5FQob_yK7gFFWI2snmN2T-4zfOi1Qmkx_hzoM8UADgcFCeedjf_1VMIpSudV97Y8AJy2ZoSKJRA1jRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:2xvtZ0BY3CHfmx9L_zqBuB8_zXnnrLTT7UU6z-RckY8UQXnet-id2w>
    <xmx:2xvtZ5jXXnn8Tcq0EhVwDTRLmvWCmgljViEmwvC1bUtexC9SWIUXgA>
    <xmx:2xvtZwr4GvRVXwCwpqnDOFgdj8XiPaxIHsVN5WIWOol6J4RDpxN49w>
    <xmx:2xvtZ8gpKvKDojyAM9wxS06iZQkLteFO-lYWgurbI78KP2q0XmBbqg>
    <xmx:2xvtZ8HBHHwDooUX35rmCHqRwxlMoqoaQbMmaKZQx_FD0KlnZM89AyLA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a89c3346 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:29 +0000 (UTC)
Date: Wed, 2 Apr 2025 13:13:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/10] builtin/cat-file: wire up an option to filter
 objects
Message-ID: <Z-0b2e-Y3T7W5Jka@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
 <20250327-pks-cat-file-object-type-filter-v2-2-4bbc7085d7c5@pks.im>
 <87r02cf6l1.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r02cf6l1.fsf@iotcl.com>

On Tue, Apr 01, 2025 at 01:45:46PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 8e40016dd24..940900d92ad 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -1000,6 +1013,8 @@ int cmd_cat_file(int argc,
> >  			    N_("run filters on object's content"), 'w'),
> >  		OPT_STRING(0, "path", &force_path, N_("blob|tree"),
> >  			   N_("use a <path> for (--textconv | --filters); Not with 'batch'")),
> > +		OPT_CALLBACK(0, "filter", &batch.objects_filter, N_("args"),
> > +			     N_("object filtering"), opt_parse_list_objects_filter),
> 
> Because we've decided on `--filter` we can use
> `OPT_PARSE_LIST_OBJECTS_FILTER` here now.

Ah, indeed, well-spotted.

Patrick
