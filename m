Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C885C5E
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723807485; cv=none; b=rAm8pOEbnLwTF6FX9QrPuPbFk8ZbA8SmOa4xb7zCdCmVH1FKiHj1WNOwILee3cpimiVnbDBo0s/5NCOEwqIoziuDe+eK6IpSkOjYPLimIc21VbXYP9eCUqt//3l2e2Fkb+bmMWag4N+wLnJUc26H/rhdAAu5dfNs7OoPvcLdi6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723807485; c=relaxed/simple;
	bh=HZUvhGMQ4XcY5dHboxMIigTB9snjRMz70hdOJVtt+Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHsAD52fdxIUlbJGpvnGISQrUtmojOBRTd5F48E1G1gNfcKz6kwkx9p+btVyLQLsF/JCfa4j4gervKoRxwIcVxOisEK1bDcX1G2+I3x8XONMdVTpYXegOUwqSPdkfNc/BrBxmlJBqRtiQvur9/+5t+X9Sgp4cqHNzCXSolcwlyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U93Y7lwb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UmVskjqP; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U93Y7lwb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UmVskjqP"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 67BA31151BE7;
	Fri, 16 Aug 2024 07:24:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 16 Aug 2024 07:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723807482; x=1723893882; bh=22Lu9UHxRy
	qbDKGK6/axWHjs3TKm6DVEBlbMFum/QFI=; b=U93Y7lwbLM3oGWaE6GgostkD9E
	qPwKE1kTCOYyMyWfXBe/0BBQMPFtUDtXF2dRibrYt4A0+ABLcmkAajgMifVQaetE
	BhwXx9HPeMwL+GqnUy44htslTgNl3MPi4un4KOrZYJsl2ZuKLNp9l0WK0CqFBhP5
	QwyI9Bidb40WCoJSrWtrbYLaE29MZn0ssXV7HjjXqnUDmRi5i4SvCVAGICgVW/+4
	R7jek+TIPxyT/z56jnGkcv7FJ7AB6nb3NYgtzxhbJhasFd0Qi0ZIVHTEt/uhd/7Z
	81jbfhDt8gHhlVyrm5LuDKnJUanichaLTxWjT+dAdhnDPnRwNOfUNHolYuUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723807482; x=1723893882; bh=22Lu9UHxRyqbDKGK6/axWHjs3TKm
	6DVEBlbMFum/QFI=; b=UmVskjqPEwwSEPEZNHdU+9IHWfAXfHyd1BrQG4My6oZ+
	etvaDaP+/uRQZMDe9VskXCGXr32YvklDg+JwL0ViZ0vWSJWgaeih+pHD5rpyh3qV
	c7DeSTDrn68UuNeYe0/wqgm5SG9AQsIEtQNvq0WsVh5+VqY0NlCdTR21VOogZnL6
	v0dX45+gRb3YPRJYqFwYVSmVVc8MjIdjUZ5ZRfrjc4/ssEAaEyT1ktPwtH0bxtLo
	6CYQSk71P6dMDKXmKpUAHS/9LjnHBKl+ZsbDTpOPG3RsvTlasF9MYtFHp1easXt6
	D0OIADmWI7sI33sLdeTPGTakdJBr+8TlGmFMKFuSzQ==
X-ME-Sender: <xms:-Ta_ZmbPhenLAvRTSqhm2l16VyYqat3ov7rRDOSCjH748_-AQ5SNYw>
    <xme:-Ta_ZpYOTZTxayt52dnKeY6ZQzuTCDEY5GmJVI-0fXW6q5k9vGdyziIhLXFfAQvwk
    5Khn4L6GDNb-unjYg>
X-ME-Received: <xmr:-Ta_Zg9Skt3owjTLY1DlqG9oYprj-6tafwxjUZJ13dKYdurXjjSMdgcsUmbr7yox9XZ0-6uD9sBJg9a92iu6wcodNC--njWza9FUg0hnNthpQZI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruh
    hsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepmhhhsehglhgrnhguihhu
    mhdrohhrghdprhgtphhtthhopegvmhhrrghsshesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepjhgrshhonhesiiigvdgtgedrtghomhdprhgtphhtthhopegushhimhhitgesmhgr
    nhhjrghrohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:-Ta_ZorWvbmDjrizymqQfn1zD9WKM42lhpMlukkNLTEKLQW75RnmXg>
    <xmx:-Ta_ZhoZEFSzOJxqRAdYc1NKbGDwBw8__X_TLE6C0JhnrzDI1n8SzA>
    <xmx:-Ta_ZmSoRnIwPFl-rqxdy90IUn4aDfz5LQYpsIM2oMb-kMAG9S_GBQ>
    <xmx:-Ta_ZhocLYqEPkBWpEHZuVBJkZE6sa9h0B-sgg1Eb9F-Da8VFZwsrQ>
    <xmx:-ja_Zi5T6ewsxgHLJJkqQW7996eo0kWT44pYiFmD0XJqk5gRCN6j1rxc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 07:24:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0141888d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 11:24:15 +0000 (UTC)
Date: Fri, 16 Aug 2024 13:24:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com,
	mh@glandium.org, sandals@crustytoothpaste.net, Jason@zx2c4.com,
	dsimic@manjaro.org
Subject: Re: [PATCH v2 4/5] config: add git_configset_alloc() and
 git_configset_clear_and_free()
Message-ID: <Zr827Bd5jrQwhIEp@tanuki>
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com>
 <908ad0b82fa084fc4e56d7f6dff49e4f255af6ec.1723242556.git.steadmon@google.com>
 <47b18fa4-f01b-4f42-8d04-9e145515ccc1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47b18fa4-f01b-4f42-8d04-9e145515ccc1@gmail.com>

On Mon, Aug 12, 2024 at 10:10:48AM +0100, Phillip Wood wrote:
> Hi Josh
> 
> On 09/08/2024 23:41, Josh Steadmon wrote:
> > Add git_configset_alloc() and git_configset_clear_and_free() functions
> > so that callers can manage config_set structs on the heap. This also
> > allows non-C external consumers to treat config_sets as opaque structs.
> 
> Do we really need to add this code to config.c rather than handling it in
> the wrapper layer in the next patch?
> 
> Looking ahead I wonder how useful it is to users of the library to separate
> out allocation from initialization. A function that allocates and
> initializes a configset would be more convenient and harder to misuse.
> Calling release functions *_free() rather than *_clear_and_free() would be
> more convenient as well. I also noticed that the data types are not
> namespaced when they are exported. So perhaps we could drop this patch and
> add the following to the next patch.

Agreed. This is also part of our coding guidelines as of 10f0723c8d
(Documentation: document idiomatic function names, 2024-07-30).

Patrick
