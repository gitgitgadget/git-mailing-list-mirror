Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170CC1E8356
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744366013; cv=none; b=oMgRJTFBMWWTmaDl45yYFGnMgImCqzZh8b/27UFjqBssvczlA0c+/0O1AU5XI/rUF3937xDBNn0wbtZv3udKWuYmW6PAzp/XB2V1inc5ivGEDKvz2jL0jrMY6suAn6nN3aqERTeDlpXWtkO3m/W93y9Il+HHLSo6+Mf9pIa9FMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744366013; c=relaxed/simple;
	bh=8E7opOumog80Y8nLv1MKoZh7KV9+uZINCTiPqDyTTr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ku1q83A2pP805lpklJXtFVb6VY4mHKK1PyBL8j5x/Hlk8luuyyF5ka05R8OBcreZ0Ywp6fD2h1wJJNrEqRf36LyUGmtn4KjAbCsJKygENQ13bZ7Y+QU0qGVIS75vla7oadwgRmQVPVex6F8N34rkHbm1qbGEmty+gxu0cGD6ODo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V3/4j1L0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UNZWrghC; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V3/4j1L0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UNZWrghC"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 244A011402D7;
	Fri, 11 Apr 2025 06:06:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 11 Apr 2025 06:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744366011; x=1744452411; bh=0gYfz7NrNn
	oQfGHRhPlisWiGyqt1q65Uifec+ZVwrYc=; b=V3/4j1L0k0U7Wu6YXJz0qdjj3z
	Dkv0nB4FeL58Yo4Wbn2ZLkb9tvN7oouQVQqV+ihXc6BdLF77J8AUA8xslLr0c9gi
	rHHdCqplaAhv7ZuvbbqpdtGXJiW/KWfEweJCfAbW4TuCtUDO3l4NyE0S4b8BYuJ/
	THAHlFmep8WE+mW8OdJuYyHwixxcfC6IyDKz9/sZeKTBu752ad7AHUN3Xth8i5bx
	0wzHC4sCxmj32N2vVAL9dyxAeKIG3gX9hjHw2+k6cG/WeL3TwrWig5ued5UoZ6Wg
	eKmfFiYD2831BGQ6p3SQF7KlxXIfhxEuYJLiwYz5lWY6QUlJuQWvjvETUjtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744366011; x=1744452411; bh=0gYfz7NrNnoQfGHRhPlisWiGyqt1q65Uife
	c+ZVwrYc=; b=UNZWrghCk0eZ5P/VtyotPUtnh6uYO/rJCfA2V8UCukCN8yJ9yYI
	3FMk3AEcJSk6SHBnfG/JIZd0UdbpYdymsZnoSMOBqONMMosSZZv0zKFMGE5wU+YB
	do92bVOPsb+h1CpCZMpEzqNmJjeS5PIY0eA20qxi3Yd6EatORgUaoVbiCCeLIRUs
	bPYVHQZejOX4U4UER0LyDsVAWZ7kgJhD3USjOxsF/53fe67tJK115HKt78cLXfGX
	WG5dSuLM9AV0tc2vK5bImfF2f2mF6fJ/Psw7mt4LHsxcPdjlQ0tVHH+aSQIXAWW+
	aiWqyYa7t2OUjnrSPjpYbDdnNAcTVnFs0+A==
X-ME-Sender: <xms:uun4Z7ta-ZAaQZQyqzErp6_aUYPKoamQDW6m0as9v99IWSXABbi6oQ>
    <xme:uun4Z8e_CdiL9wKNJGtgj7xeQN3m1KkAlhsgPcdnIjVneZVFLcOSwaw4rdRnyQd1w
    7TcFk7h-ul9qCylVg>
X-ME-Received: <xmr:uun4Z-zJRxO8Yr3vGzFcyBv0_V8ANVz2QUFIq1KCLsmkNF9jUPU0wb6hFS1ewSVt3JZFW8QtH_bbce07d1g62139frro-fD_yMebuqLbg-3DZiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudduheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpth
    htohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:uun4Z6Ntbscr7DR_H66jnmhBZByEoCGjJPr_9JhdNDzsdYr2LwuD1A>
    <xmx:uun4Z7_kDMmvFXWYgY121jE2cBUikyzN4wBFMZeYWE5bgfADcDUjuQ>
    <xmx:uun4Z6Wb-zIX0x19Pb_ZKIcKRWijc8GnDuKLo2W_yqpPQAnciZHw_w>
    <xmx:uun4Z8cUscdkUk1AsF0K6_wFNDlgNVYXQdNXrOZMFVoqQQ_wYBglPg>
    <xmx:u-n4Z6pJnlIQYDm5zHsFeKZT7hHjmkAcMTCOW8oCpTn0UZmSZhD57gIg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 06:06:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eac47bb6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 10:06:47 +0000 (UTC)
Date: Fri, 11 Apr 2025 12:06:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com
Subject: Re: [PATCH v2 2/4] meson: move headers definition from
 'contrib/coccinelle'
Message-ID: <Z_jptp_xj2gpJ65s@pks.im>
References: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
 <20250410-505-wire-up-sparse-via-meson-v2-2-acb45cc8a2e5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-505-wire-up-sparse-via-meson-v2-2-acb45cc8a2e5@gmail.com>

On Thu, Apr 10, 2025 at 01:30:32PM +0200, Karthik Nayak wrote:
> diff --git a/meson.build b/meson.build
> index e98cfa4909..790d178007 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -633,6 +633,28 @@ builtin_sources = [
>    'builtin/write-tree.c',
>  ]
>  
> +third_party_sources = [
> +  ':!contrib',
> +  ':!compat/inet_ntop.c',
> +  ':!compat/inet_pton.c',
> +  ':!compat/nedmalloc',
> +  ':!compat/obstack.*',
> +  ':!compat/poll',
> +  ':!compat/regex',
> +  ':!sha1collisiondetection',
> +  ':!sha1dc',
> +  ':!t/unit-tests/clar',
> +  ':!t/unit-tests/clar',
> +  ':!t/t[0-9][0-9][0-9][0-9]*',
> +]
> +
> +headers = []

I think we should make sure that this variable isn't declared at all
unless `git.found()`. Otherwise, we may accidentally it it even though
it does not contain anything sensible.

Patrick
