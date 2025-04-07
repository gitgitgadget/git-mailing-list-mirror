Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D10979F2
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012857; cv=none; b=AguZVyY+RWEg6ZhUdB/TSeI+eIHF1moytKOsTfa0LVrA5TCfTps1nNPS0iAF2vynRTdP51UM0Iua4vCofPANX/zFQj8Ur7cmm3QYcLZdtgQSKxbvMe0z02MP2CLTpwsbUBC831pSJ1Eek+7wtvoosBSNXlu5SchrhKq0/EpHFGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012857; c=relaxed/simple;
	bh=QCrKzV4jFNMEmKZmxoS/O34SEYGjuX+bl1C3MXbxV4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H++gT5oGUsHlp3usxFV7Xf0/BhnnmQJMHCKo1chEA1zhpx5+nW4mvXRSXnUM+Gj3YPZdAV+xAO27v5/9siW12egVbbwgSxeJNWR5ZoGxLbQVMjVwKPTFp6lvUyIOqThs9RiTo4yCkm9JGMNLxp+jiZkvdRGiWpmYvoTRuxZWxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oCSbJz8/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dNoeFuwK; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oCSbJz8/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dNoeFuwK"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3779E1140210;
	Mon,  7 Apr 2025 04:00:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 07 Apr 2025 04:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744012854; x=1744099254; bh=hFpF+cM40j
	1fupx1N7EwjeUw4V1tmN91RKQ2eU03qZg=; b=oCSbJz8/PbVF5JgQo+i4S3KtB3
	d+Z8wpT3yo6Qzd7NF4FC3eOIPktJLHWW4zFmx29L+/5CsbbkWS0Rs7Cy6JqH1Buq
	Atdko7IU+uODOdZYdJARjfQqaHVxCn3P+CPCnKOxaEXx7FtJ56BRFitocXTzlcy+
	vpbBXirHAAaZjbK+IKxXPvPenBoeZ1HRJB0Cf8pHE6pn0fjp9WZuzrfvcCCBKAWI
	qNlk86cdRSejd53QIPzowQrJwYF7GgyLU/NTdUzzOS520gHzu9m16RgT93pWttvi
	rv2e+q0oOnLZCUMYLKaoUbyC+HhhoQ6bF+1+eDOIhDj+0oD/3vPgOYRYCGvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744012854; x=1744099254; bh=hFpF+cM40j1fupx1N7EwjeUw4V1tmN91RKQ
	2eU03qZg=; b=dNoeFuwKFzj58BN+4QgNbfsBunB8br0+pOI3EVKi6JEeuJV8UNu
	R1xGYGdRLjq7yCs9Q3K33E/DlWSkr2yK6VHvAHpKrRGyxHf1q+tnGZe304bPshRJ
	Ax/huOgRGdh03XdHbzoE1mexBaVR/GryUGSwy9t6JExDnCTleyhcWsDUoyeRsJAL
	e68EGj7Yg3q65SFJoKWkM2Lhy684XWWaDIX1iYjepTfyEwTNl5gR+lJM5/o4S5gp
	tGNHWVb/0wXOnWu7VSNca/AzogAZi3XdS8UZb+/XpjSL/sTaZJgO3i8cnN44gjNd
	v9IcdTgH3gjz5zpAirrw0zvzygYDj0yKWlQ==
X-ME-Sender: <xms:NYbzZ9BwWU3F5PEjwJj-4yBczfDmbdZCb0ZSqVjmbVY8in9EFXp3dA>
    <xme:NYbzZ7gEJvI2lmBuDkq-Rqw05JUNQbjuDVuvxqVlZc2SooR-b5dt0OMeEWQJ4zM0n
    WZGj3FsPCwt5sPCWg>
X-ME-Received: <xmr:NYbzZ4mqbSPb2qwLXwVQz1mtbjNI3_cJtx_MF7oZ4pv2cGawFMk0prZ_g_t-aXJttThU3ofbnFp2IZKymud4R2SKSOZVlZ2zZVtVgcMKCQId1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleelieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshgtohhtthesghhithgsuhhtlhgvrhdrtghomhdprhgtphhtthhopehmrghr
    thhinhhvohhniiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepnhhitghosegtrhihph
    htohhnvggtthhorhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepvghkvghmphhinhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepphhhihhlihhpmhgvthiighgvrhessghluhgvfihinhdrtghhpdhrtghpthhtohep
    rhgvmhhosegsuhgvnhiilhhirdguvghv
X-ME-Proxy: <xmx:NYbzZ3weGOa5dC62e_akgy2vsT4dHU676j7wzl6TBWzc9nvePKzVUg>
    <xmx:NYbzZyQnPIK2d6ZcVu2YzIadUQsja_hCWKAN80dp2aUJumm0Tbs0Ng>
    <xmx:NYbzZ6ae3UyjBMkOOuzx2FswwJ8cGG2zjK56e9-vwrkakLhETOKVSw>
    <xmx:NYbzZzRCi35DH70uH-NkbKmrOF9mnRXlH8lMLQYs02kTloWV6VF4IQ>
    <xmx:NobzZ0ma-TmU9pFc8sVaXzGKFQRNf7n76vYQB3VjkWXwv3Ss9dvzYKr1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 04:00:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b36c9d0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 08:00:50 +0000 (UTC)
Date: Mon, 7 Apr 2025 10:00:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Nico Williams <nico@cryptonector.com>
Cc: Martin von Zweigbergk <martinvonz@google.com>,
	Elijah Newren <newren@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z_OGMb-1oV0Ex05e@pks.im>
References: <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <Z+7PDi5y4wXJBK4r@ubby>
 <CAESOdVAd+X=6nEULHtKKotH_W5yNaJAcUajRU79EuG+0SF3m1A@mail.gmail.com>
 <Z+8IF67AC8gSouYc@ubby>
 <CAESOdVAWWP=Rte4bx3zUZc6p0XiZaJS2OZr8ezRPkfq8K1TYfw@mail.gmail.com>
 <Z+9N2REkYZhrbkzb@ubby>
 <CAESOdVCekFDxOWTTF71dpH1id_H2t9SaNo6buJ1MbvTnaENY7g@mail.gmail.com>
 <Z+9ez7kbh/L0Iq4k@ubby>
 <Z--nnOhsUCaqo45z@pks.im>
 <Z/ADDp/mIzuOofYl@ubby>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/ADDp/mIzuOofYl@ubby>

On Fri, Apr 04, 2025 at 11:04:30AM -0500, Nico Williams wrote:
> On Fri, Apr 04, 2025 at 11:34:20AM +0200, Patrick Steinhardt wrote:
> > > Ah, well, Git does have an index: refs.  You could use
> > > refs/change-IDs/<change-ID> to index by change ID.
> > 
> > I don't think references are a good mechanism to track change IDs. The
> > expectation around refs is that users can change them basically at will,
> > but it certainly does not make any sense to let them update change IDs.
> 
> git meta (a separate project) uses refs named refs/commits/$full_hash.
> Users can always break their repos in a many many ways.  Using refs is
> fine.

True, they can. But if we use refs as a storage mechanism this means
that a remote user can also mess with _your_ repository by introducing a
broken `refs/change-IDs/<change-ID>` ref that points to a commit with a
different change ID.

You can of course work around this by treating such references
specially. But that would introduce more complexity into a central
subsystem of Git, and the result would probably be another mechanism
with leaky abstractions and confusing behaviour.

> > Furthermore, as we have already discussed, change IDs are not unique,
> > but refs can only point to a single commit ID. So that's another
> > mismatch that we cannot address.
> 
> Oh I agree with that!  But I think I've made that pretty clear by now :]
> 
> However one could have refs/change-IDs/<change-ID> ultimately point to
> an object that lists the commits with that change ID, and then that
> would function as an index for non-unique change IDs.

That would be possible indeed, but now it's getting even more awkward.

So I'm not yet convinced that refs are a good fit for storing cached
change IDs.

Patrick
