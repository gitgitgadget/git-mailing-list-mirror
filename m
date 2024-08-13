Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C207744C64
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530869; cv=none; b=ILeMmLbutOiofwdBjszB119IIRERptx4SKEwKAFt6itmVY0Z/u3JJheBqtmK5ABM2nQRik/n42HHb9ZD+teSa+7bXkB2GKrmDhPdaUU/wNR8FhsR0DVON92iw3ELg6Qs0XJVxN0GrWxXcZnEvnybga1EfBceANgrm+cMzW10Xmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530869; c=relaxed/simple;
	bh=zTOpOF5WOxjr7NY/ZZIB9PW7EIkbabQZwJpumeVjmIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxD+i63T17t43A67K4/HK+M9UKfDu4vyTZw9meGywnoouSe8aXJ07WdIkcvHEc9UnWQkdRzi3zEgc4JCmAUqbzyVBH1w1ehUyoxK1fcKcMieduNHzIrlMkspQxY9I6mDFVZSZP95B4WYOWQ71sOIsonFse1GFbWcujFnabetfCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dE9k7B+F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dJrihle9; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dE9k7B+F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dJrihle9"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D29181151C33;
	Tue, 13 Aug 2024 02:34:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 13 Aug 2024 02:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723530866; x=1723617266; bh=p2qpKcfUgd
	WvOAVv6yhlHjbmFtACnKabHLKO1HI06Hs=; b=dE9k7B+Fm2XfQFiYw6nlSZBQrZ
	w7Ck5xF8XWigeRFaw9YNk8BidlVNk+qGq5+t7bdZov5Hra7yB8uqfBIKz81BHmMi
	cDmuLOwDs1JvChSV8wfhxlVAm8DOxvgnfRRK8nHG9vq3aL2FSdFEBele7cNJYRRx
	UBFDBqGvao4M5EdIBoQ1xw4z0dzwQVIRlmaVAPQ3K92ao32dfLULcTahEjO2YUb1
	Stthk99rmI3DM/oW6uUESn027mvoUB7vSXe3s6HMq+JYj7RbkGtMI7FU7wxq+e5S
	j1t5g04NPdU0XkvZiL6RG+iO4jRzYD6DQLZgHM+9fd8m27jmLqMkC2LJl2OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723530866; x=1723617266; bh=p2qpKcfUgdWvOAVv6yhlHjbmFtAC
	nKabHLKO1HI06Hs=; b=dJrihle9ZIodI9p+Uzz6KJ9yTA5wtQZetaYhjp9iIjKF
	JDFytn8FdHYjlhmzakNbKwmewEQs7Bwe/Y2zFY/e6gM7YApASVxwlB0TCAcRoLz6
	l4UDJdMa2Y/emq309dUIhBvAnoc/bzlbJO87OXXgdn5oxCkUguIF0t3gjCPJ2dfU
	wv6+nVCv/yPQne1MWYrF5tKVbLfu7gN5Q9jiZf00PfwWcXxau6+JbGwLzglumPJK
	FjDe/7SPbY5wOR6sg4ifuvJLb2KmNFDD2BVJHNnS91DNB9dmfqFREHGd8DvxscMe
	wUlYW1O/XU+ZjZ/cMbhS/qv9+D/XBlY6oa8Bv/ZhZQ==
X-ME-Sender: <xms:cv66Zg3sxk8oDb7HXlOVjDlyo4N8ZlioncxDi1C4E4oBSO4-Twh7oA>
    <xme:cv66ZrFLuNmkDyZGLUn4DF5JqZfVXGMJqgMYbUkqx-ePpJcYdLE3WSsFHWVzjdi3B
    Zs4UyYCD1kQqcgkMQ>
X-ME-Received: <xmr:cv66Zo6YBYTCHsIj06d2xN9fRlrqREbFrMKWza3CVEp1KdjEttRd-WzSMDDEr1e5QMvy9azcS_Vaz01Qy7b5waueakg_9bMxr_mz--ivNfBpRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:cv66Zp30PEkKYVyi57626tAam5TnA1c7SRtjkzuacU-HvRKA18WfdA>
    <xmx:cv66ZjH5uNWC9O7hOlvqu4CBD53U4vjeo04Mk9U_m2SRKz9q-ab-ZQ>
    <xmx:cv66Zi-8tuelPKDKbh2vqgO8OdTHn30KxgkJ9E_C-huX-m64ZOJ97w>
    <xmx:cv66Zonr0YXRp6VlwRh1L_m35TNWsVE1m0ymuhWtbGzWxXxPnYVJvQ>
    <xmx:cv66ZngCGBgtea1kR-VY4hIqWUG6Rz-QZSIz7Sxz_pbPKseSxkgrfhZ5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 02:34:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b1621cec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 06:34:08 +0000 (UTC)
Date: Tue, 13 Aug 2024 08:34:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, James Liu <james@jamesliu.io>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 01/22] remote: plug memory leak when aliasing URLs
Message-ID: <Zrr-YpD-Yzowmqq3@tanuki>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
 <2afa51f9ffedfa6dab51c9515f695ddfe0a9a4f9.1723121979.git.ps@pks.im>
 <20240812143710.GA3800522@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812143710.GA3800522@coredump.intra.peff.net>

On Mon, Aug 12, 2024 at 10:37:10AM -0400, Jeff King wrote:
> On Thu, Aug 08, 2024 at 03:04:33PM +0200, Patrick Steinhardt wrote:
> 
> > When we have a `url.*.insteadOf` configuration, then we end up aliasing
> > URLs when populating remotes. One place where this happens is in
> > `alias_all_urls()`, where we loop through all remotes and then alias
> > each of their URLs. The actual aliasing logic is then contained in
> > `alias_url()`, which returns an allocated string that contains the new
> > URL. This URL replaces the old URL that we have in the strvec that
> > contanis all remote URLs.
> > 
> > We replace the remote URLs via `strvec_replace()`, which does not hand
> > over ownership of the new string to the vector. Still, we didn't free
> > the aliased URL and thus have a memory leak here. Fix it by freeing the
> > aliased string.
> 
> Thanks, this one is my fault. When I replaced the open-coded replacement
> in 8e804415fd (remote: use strvecs to store remote url/pushurl,
> 2024-06-14), for some reason I thought that strvec_replace() would take
> ownership of the pointer. We could make a "_nodup()" variant, but it is
> probably not worth the extra API complexity.
> 
> Curiously, these are the only calls for strvec_replace(). You added it
> in 11ce77b5cc (strvec: add functions to replace and remove strings,
> 2024-05-27) but I don't see them used in any iteration of that patch
> series. So yet another option is to change the semantics of
> strvec_replace(), but I think that is an even worse idea. ;)

Oh, interesting. I certainly wanted to use it back then, but guess that
later iterations removed those callsites again. In any case, it is being
used now, so at least it isn't dead code :)

Patrick
