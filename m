Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3CA35950
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759100285; cv=none; b=qhxg4U6wOVdVAkrGP4TKBW3FARWtbXhySlcLO9+mcnIQgZX0wN14b0IbI5TlsBEO6Qxsx8XGeWDQPqguIRP6znOnwbW8YH1AbQX03AAPpBxtl89aMo8+mTRIHd92rOm54ueTZ67GuKgzlbg0rQMJBmHeth2MWVAOnrAhu23fsE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759100285; c=relaxed/simple;
	bh=j0KFcmWUOg1o/d4c0PTumfBCZSWCKp4u/QKPascE/dE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fzp5Z8ZNr+sJPz9fLsEwACLDVQqEv/mojsPd5RmTr9yhthp3pJwBYLWs47pKO5I3PqLo93Mpww40dvN9YSmw6ledBJsm9cLsYXyo2ga1nAbjT0YmCG9Wfk4MUIer7mtHMP04EmJ41Yo+VGcx6Nn65yuDI9O3Hgs4H9D3Oi/odsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SrQZXeqP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dBV8rDKN; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SrQZXeqP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dBV8rDKN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A6D6EC00A2;
	Sun, 28 Sep 2025 18:58:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 28 Sep 2025 18:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759100282; x=1759186682; bh=0cq4x0ysMf
	k5EvjwsoF2K6df1pS+hOty3p4wgqfKuII=; b=SrQZXeqPxKG4PvmUY0t7yFKJN/
	uAnGfI40yo3iXQrHgFeRQjX8H9qjJMsNDWZQYKNqf1gzO1hfOS+h9PfoS3chTks9
	jfjWy1+W/4AQLvjLFw5yur8cxOCdePww+i5+EGrl7u8SK+Ef6N+AmTPpEHcSHsav
	W3Tt7DaTe33UxwsthFkn0kO+mZczrq+mposOjjCvQnQpDJDSNeR22RwTdTox4Nr8
	zM0xpJ9ZiHxeilXmzsnDTTh3z7JG/qsow0dYgws2SAeX3UePSa9e9VOXEMIpXiDr
	95/LiuBDIR2S5RSjgEAFvBnnmRFuKaa1IyYxQNpDnHjHzTGA9H44on312n2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759100282; x=1759186682; bh=0cq4x0ysMfk5EvjwsoF2K6df1pS+hOty3p4
	wgqfKuII=; b=dBV8rDKNozW+8uTIFuzfVUPbc89EO50frSlgZ3Efv037HSOSsxn
	yScsx19a5X/C5zBsi8r4Od+AWHafB89zOwTbilb4ka+Ae0tD3zosRyh2rXSbc/wt
	P6WG5gMR3C76iPXrvxOJK3b61/qlsxwyHdKFqAoHc4ZK87WROLYewLvGdmTqPoev
	vJGVvnOwFXjxnWHePtvk5kSo+u/9hQY506R3puBni1diq0IvmPeV+SBhEpuhYJ/M
	81+YAq+Jl+jD18ILPqJuFybDpt7MsEWsuq+8Ynd+2r/BAqIzEt3t/4O5yYaTvegr
	NxSsA5mewL++wx0g2ehCJ+9W/CN3hy443Tw==
X-ME-Sender: <xms:eb3ZaAqqCLY43opZaHBny8yJGsBhvl6bLtlDTzSVxReok-xHpagYNg>
    <xme:eb3ZaI5me7ZZ8Ju8KM9OJ0AOkjovp0zT3cSPtylSQ1JcMZxcE-g7VJx40pTD_FRQy
    fowgDfuGdNx99zFbU7nCbvJU0BWmvuybX10fNpVDnqneW82cRtmjA>
X-ME-Received: <xmr:eb3ZaHca2ioo3wMZRBmOhpDPpNYKRh_g-S3TbYQ8BY9rm1MCi7dWJmTFBPSn3doKRtc42VBKMB89reb6O1YNDDYNEeKRJl4vbZJl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejieeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepphhssehpkhhsrdhimhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eb3ZaN6cB1mDIO_b6ZiBKZ1LAPcAx87v5NL5fJJZDB387Gg_vA8R2g>
    <xmx:er3ZaOsSiidncuUzxnAMpibhbNBddpg9UhKQZ2ADvc5QIrXzjOISZA>
    <xmx:er3ZaNiPum_GGDnHJMLgrn8tgaOsNAU5o3glbru-BgJs5k3FhjqQYg>
    <xmx:er3ZaJqqpY7GbA_fk96exTJwvZZoI0onxUjCXVzrPQLLl9tyBXHTUA>
    <xmx:er3ZaL4OVrUod4D-I8a82enN2nne1Jge1tHgiKIuqIoeRBd2EihV6lxL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Sep 2025 18:58:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH 00/49] repack: prepare for incremental MIDX-based repacking
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com> (Taylor Blau's message of
	"Sun, 28 Sep 2025 18:07:10 -0400")
References: <cover.1759097191.git.me@ttaylorr.com>
Date: Sun, 28 Sep 2025 15:58:00 -0700
Message-ID: <xmqqcy7a5gnb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

>  * This series depends on ps/packfile-store at dd52a29b78 (packfile:
>    refactor `get_packed_git_mru()` to work on packfile store,
>    2025-09-23).
>
>  * This series is split out of my local copy of
>    tb/incremental-midx-part-3. I suggest queueing it as
>    tb/incremental-midx-part-3.1 ;-).

Both of these comments are very much appreciated.  Do we say
something to encourage these in our developer-facing documentation?

The points to stress are:

 - If you are not building directly on top of the recent tip of
   'master', mention what topics that are not yet in 'master' your
   patches depend on.

 - If your series is a part of a larger effort, briefly describe
   what your overall direction and grand vision is, and state where
   in that grand picture the current series fits.

 - If you have a short one-line summary for the topic to be used as
   a topic branch name in mind, do suggest it.

Thanks.
