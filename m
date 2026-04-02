Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1D389DE3
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114865; cv=none; b=S+puroKvhx0vSsUcveCo99N3SBHh9x/9TbUBPsxJUtp2EH1eEidPyIU6jQQCgKO+PPzduL82nLc/cNX1SMFQrRT3mBCwehiZ7/qtV5NBurq/co7VK7TXqSM8LOnSfSsq+KQ4MOyMJwOY+o7yHHnRMWkDu9+DINDJuGbKrPgD4yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114865; c=relaxed/simple;
	bh=qHmhWnBCF30SR+bwaNTlndNl0oxW4+9/n5fQqvNIkkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgUUKjNgSBpoMFhXQSoq5HtpgfuUvKDdkZjlwQoXghcfOSI8mUxwNioGGP13SWky29PXslobFTPpyHRMrcx9Xnv90czYx6uY2CJu8QEFz041D8e2YuWwoRRdHKEkZAVWUnBgKexo4iNeDFBlo8X0cTO4tFQ4xP39f8zfymflUwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d7qT5QA/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dZO9oFLv; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d7qT5QA/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dZO9oFLv"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5120E7A0374;
	Thu,  2 Apr 2026 03:27:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 02 Apr 2026 03:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775114863; x=1775201263; bh=bZ4Xd0AtOW
	88q/PeeSnFynEHfvY1qqmX0uFY8yMuqe0=; b=d7qT5QA/J0L0naHy/142BV+RXs
	05Bg5kSh9qjSbp8lnNM2a4CjuvZvY62C14Sh8YtHGDE97qQ9XW0OM0lvb+95Tv/I
	YTvMcupCr8JfJqNZ1Ix1Cub9MIMgLn98xog306lsUUaPxEcSmtYiKGZP/yKWpsLh
	LzFXquz4eHOWX56p7jNibMJWO+8X4WJKED7Wdc+q0T34Mv3xXDOb4xYapgEoMj4G
	5QuWuzj5tLh2VIV1TqTLgp80TgqJfyCsNp+nxMdIbDT9pIiyKHcGAtNW4Q605ZNW
	2wD88AAMNPNz4KgfGU6trYdUIquRj/du1mXdCzMATFMEYQNCEBx0BP8sAM5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775114863; x=1775201263; bh=bZ4Xd0AtOW88q/PeeSnFynEHfvY1qqmX0uF
	Y8yMuqe0=; b=dZO9oFLv1lA/npnyyH1523qTYZt4vz1KJvdoT0bu4Tjlh3QdVtf
	g1Uz96NRdtXaJcA9MdVzTP75HNgqbEJzvKwO5FIwA3r9mclptUxwNq2WT+joC+HZ
	ZhQDcVLzEFUiUriskXpIr73E0KqZdt89Jip3Ae3LnFtKJ4M2g0yLg40vkpMfJGjc
	/gCoMdewr3jEV+AfiNldQSAexZp+zhOjZtt0Sxyo5KwFECXTSIhO1jb6ktNY/DHi
	wWjXwkSiznjQOPO4eDJX6gLCUwYo7/h9N/x2D9pJoF8TtU/ynOCgpEGdjPX06Cj4
	HF/NDBbm8D8m3YALQbJhr1GewXfJOWmJUbQ==
X-ME-Sender: <xms:bxrOaeM0rtYUt-GgNt6D3mJBeJFE-ZID-14vKbNw-r2eG-ecst78Ig>
    <xme:bxrOaS8WiF_07Fhiz4GWWgTyH_lodRsDGcwGIJ9UToIVGBapvSETnjMOkmwHaSaNE
    BviFmtWYNXP0lSdoQd-_7oWHayXKQXgO9ibLEpDNFvuaCLXbSo5>
X-ME-Received: <xmr:bxrOaS6ifFpzw5Z7tD2rGs105ig_SzXyfYWel1dXy-cSOSW43YcWkIj2ivPJWzpx6glEDUU3coAQroGwMeHNZNl4iB3_4hFvyvDmw-JzFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehgedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgf
    eugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehshhhrvgihrghnshhhphgrlhhifigrlhgtmhhs
    mhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:bxrOaZ2qCA-FhY8-pIUhMzeVJ8vEduSLUVm69LZTbacEuxlHHAGbbw>
    <xmx:bxrOaZAwfIgyJO8jjC_K2VjhNMFj_3o2RNeATi86y2UjBx1BeHSYog>
    <xmx:bxrOab342fKn2vKIOM6-_Gr8wCBn1w2vzc1KVYEhHLibDwwojlivaw>
    <xmx:bxrOaTtpGUyLNDvs90qMU1xMZU5UloxA0iXiliuInSTtumWHKlDnfw>
    <xmx:bxrOaQ-Gbod3odgrwIx21ScveIBwYSSPpGAGCxSnPOOiM_lnBsBjsy7->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 03:27:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e1f4b42c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 07:27:42 +0000 (UTC)
Date: Thu, 2 Apr 2026 09:27:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 4/5] refs/reftable-backend: drop uses of the_repository
Message-ID: <ac4aa-qLWwoZ9uPZ@pks.im>
References: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-5-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329101725.1092900-5-shreyanshpaliwalcmsmn@gmail.com>

On Sun, Mar 29, 2026 at 03:46:42PM +0530, Shreyansh Paliwal wrote:
> reftable_be_init() and reftable_be_create_on_disk() use the_repository even
> though a repository instance is already available, either directly or via
> struct ref_store.
> 
> Replace these uses with the appropriate local repository instance (repo or
> ref_store->repo) to avoid relying on global state.
> 
> Note that USE_THE_REPOSITORY_VARIABLE cannot be removed yet, as
> is_bare_repository() is still there in the file.

I've got a patch series cooking now that'll eventually de-globalize
`is_bare_repository()`. So there's light at the end of the tunnel here :)

Patrick
