Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E34A07
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728536100; cv=none; b=pDv9DAhXlYuGHPcL2HZwUmipCaKzI7wDsR/vO28WheW3R/iThhfPsJdCd84H9+U4cyPleL7cWDHSGivuqU+odvN03qDRec6W1ux4DwNegX+/ii7hxtzYwBBw6JVUvINV6beUmYTDRSpeX6kvwAJ2WMfNPlO9zWxKapWschwG1AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728536100; c=relaxed/simple;
	bh=xTiBRRWVnGetj7KyHWVeVmw+KBJPF2RQkUilt+1/OLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVIu+qI8yPRUGgun0DZgnua8IbTEhmMx7ds+mFFPBuaKqguUvmpSnpEa2on86iSy8FS0guBJB8s3wnoUlINvfxqpqn5x6LN6T6iKehqA0fbphkvPfoiBJMvLM1FL2PqE6a/9hnBdGr+KWDlDmf2+GepjQVAuVDvCE9uDuI8DiTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O5+LtjZg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K/OcF8yR; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O5+LtjZg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K/OcF8yR"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F90111401AE;
	Thu, 10 Oct 2024 00:54:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 10 Oct 2024 00:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728536097; x=1728622497; bh=FK9KpGr91g
	/anX4dZOygc48HRzUBGqJN3irZCN7dhZw=; b=O5+LtjZghATqk2GHJ4Dsw3TVpt
	Dmwcj6vhQ5st/y1b93mJwtqSZqgA/j0Jwh3j+21EoaazRlD1rvIyRQJ1eAE9+hnU
	s55YkQ1/hQr7oItE5VO557ReStaKoPQ3UeV/naChWeXnWQLO53ANgcjU0GezMRuF
	qDVrJGnMOKTMYqEKqYfYV2k6iZr2fqzlfiE1rMC+/ghjFZIBlKoaoiC03to94J5v
	/VGPnnvmGUZdaasr5ugn1rt0bZf3HnVylVHOw/cNgujyCKlHbJOFEJmK3WvjXKa4
	B3FmKog9s+zJPr1yL0sqtQZk+QSjFXe4Ugt/xuTJnW5bdtdTVoDztemR82pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728536097; x=1728622497; bh=FK9KpGr91g/anX4dZOygc48HRzUB
	GqJN3irZCN7dhZw=; b=K/OcF8yRVK30oBnGfSyk0rOXOdCAlI5fUQMRCjAozrFX
	5GDK5mYcwZmjGCxoftn2SGmCnAtuXZigrKfRHPID8sjyeN+wejWZds7AOlT6ssGx
	aW/O/wdDrNPaO6uZrxFFdttZMF1BQwrpjG3RrplP0tnFUS+1En+8Xgyoo1/HUnHA
	577HROijzRcztlHJJ1ZE1OHyv6cuaF0YdYdUcP++nsgOUNqp9AI+i0bERJYeqKMT
	jOzWQvc+/Qazdlq0Qd4cdauaBAJVX5eSr/lCF7Jk4WuwmboyupA/A2lSHy9E0sJU
	WTnrHK+HtBMeeR55W+3Vcv9z6ZNSTU3YCP5bEapwEQ==
X-ME-Sender: <xms:IV4HZ8aXZvifayBdLL-iv45Um3YsR9kNZk4EnXX4hg9kx4Hr5sRfcg>
    <xme:IV4HZ3afiNalCCeHlZ8tlwkprnzTP0SA1p480-7708TT-utXivurBKeCk4DEDqH0U
    nLsVMLATtYgRwd-vw>
X-ME-Received: <xmr:IV4HZ29BmGPrvGOCoBjqRTRalBNj9wgAx0iabUys7d4vQpgzxYZQ9DbCKER82jXIG149P9LARZ3NuhMCzRRHFItrbRfQeEake2rjRMRhySJk5vHJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshh
    husghhrghmrdhkrghnohguihgruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:IV4HZ2oC1QvNiCvKCavRGiYIgjVrJBntbJw1wjRA6HrMkSiM9ZGX5Q>
    <xmx:IV4HZ3oH2cs4GmoHnLGGiBv2z0CgVEcOjsN2EFk_BPuSvt8ie1L4qw>
    <xmx:IV4HZ0Rnfvn3cOUz3bj683WY7w2c3qkQoCDq4HjW1fUJU6UCr-gEsA>
    <xmx:IV4HZ3qh5mhbqZpzG3yogVUaNgLJzZcjxj0m62zpewbsAzybxcRtEA>
    <xmx:IV4HZ2Xx6rlKI5v5WctHQ7H6lcGR8LfHZBpGWzKotDpTLRzrbId7Sc8e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 00:54:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7b504d0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Oct 2024 04:53:51 +0000 (UTC)
Date: Thu, 10 Oct 2024 06:54:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Shubham Kanodia <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH] builtin/gc: fix crash when running `git maintenance
 start`
Message-ID: <ZwdeFB2-LUuHVm08@pks.im>
References: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
 <976c97081af7c62960bd71d1b70039657e7cb711.1728389731.git.ps@pks.im>
 <xmqqbjzu1m2j.fsf@gitster.g>
 <xmqqmsjcoom9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmsjcoom9.fsf@gitster.g>

On Wed, Oct 09, 2024 at 04:14:38PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> Fix the regression by again unconditionally allocating the value in the
> >> `out` parameter, if provided. Add a test that unsets the environment
> >> variable to catch future regressions in this area.
> >>
> >> Reported-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
> >> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> >> ---
> >
> > Thanks for quickly reporting and addressing this one, both of you.
> >
> > Will queue.
> 
> We seem to be getting:
> 
>   git maintenance start --scheduler=systemd
>   D:/a/git/git/git.exe: error while loading shared libraries: ?: cannot open shared object file: No such file or directory
> 
> https://github.com/git/git/actions/runs/11264159690/job/31323795058#step:5:327

Oh well. Lucky me that I'm spending half of my life in Windows VMs now
anyway, so I'll have a look.

Patrick
