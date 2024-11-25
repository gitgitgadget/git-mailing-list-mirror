Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7190D16F27F
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528346; cv=none; b=ku2f4NJVyPybvnDkRRUl6HSNfmVtz4qGh6zozQ/1QWNkxIe+AiQo3UIiYFupjcxdugu/LobWk7Dyb5wIOQN6k/h5G20clSvH3F9NaGbv18DUvTonNgOGOUtgzXEnzWBCtlOWicWlcyPaa0mg7UX7aQhS0LRSDljIQLn1E6VW/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528346; c=relaxed/simple;
	bh=c5atHlQbH1Y4omdMXrx7BOUXgreEhw50iri8YCWusJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsFi4qb92DjimEH5uROZjDcdr6V7xOwj2+XN+qYa8XXtRkFckx3dxtYUciCcuhQxgb1iZ5ZdU4IY2Ok6KfcoGD3pJq4LTaH0IwAVAZyCmj3frMHfNXYLr+rIE4VejlGFV8HkI0Zxbb9gRzd1uFkiit399fm58bPD5lGkCV+FdV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EQj/fzuG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bCiujRdL; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EQj/fzuG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bCiujRdL"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 648FE1140103;
	Mon, 25 Nov 2024 04:52:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 25 Nov 2024 04:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528343;
	 x=1732614743; bh=ciawOMBRK/mg/Kxw3alxk0mpNLqtuj2HpLz3z128HN0=; b=
	EQj/fzuG4BJ9ax/oP62rmuPWBZPACghk+LxzD8qNMevuXcWNQYASYl/Ws0woIdZn
	CsNdPmrQPW5hKv7GxgbXtdcgBlK7oQNdy5FfRkosR70shhOffqAXnZTNPHPLFvN4
	NBQbNd8qtsOcFH/0a6j9DsRkFWUPWCXnv8OWhROdTgJSEip5mbYgibMJ5ZVreF8e
	A+2TQZg7WJyJxnJJ+O9oze4jpkePwFeIYKcpU3MZFeiOt9lt9b4BxQi24GdVGXl6
	ZvHwdZW/8UHIsztYi3jslGMBHpPWA+0/qgxhMwmGdnL/LMYQQ6+WQ4pNSkgHCdcS
	f2L32xB9Oytnr6pkIc2cng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528343; x=
	1732614743; bh=ciawOMBRK/mg/Kxw3alxk0mpNLqtuj2HpLz3z128HN0=; b=b
	CiujRdLfhwN3JMnRyDZbyHAn+MEv4/y4WzAcA+prGrssZqOAtbQ3RFMl0Yv5MCMj
	1ffrrQ7S90zkbzWxR8Dvs7ngay39MxiI1+lajh5gzBUM1u/8/W4GvUWgbanJAexe
	f9/B5YM3Fd6jCIrbx9X2UYNNrxMThvsxXJtm8BAyFr/m+jK2pc7Oe20gxUuH2v1d
	lt+bk4N3tBc9j2lm76s2pAWPJM49TBxlb+wNPG2hftAB0ewWEmPlTYwnkukFtB/b
	xPYNhJKmVKsdBLoAfsBlVqwJoo1fHR6a07i4pgjfEZrk1kuNapSlxq+E/lsVElkE
	PFAhRe7I7Q1aaPdJuZluQ==
X-ME-Sender: <xms:10hEZ56MZP1K_BNnSjdMH9gmcq1mDu-w-_L1uA-QS0pN-sUH3kaWbA>
    <xme:10hEZ27vwyeoi7_DALJaZuTYhoiRgCZvsrLntA_fM3-UAzjMbaTd6jlbXL3UCQt5M
    63XhngArSfK9R6jBA>
X-ME-Received: <xmr:10hEZwceUgyxIFGUhhMnY8PqpJUjoMUgnL1byEyJ0DC2hnX4SkGT4oNG9VTu2Z5JTTlc0fqXrhTXlKWNy1uRF0IHG7oThUMYWGRvFYuPHMyvoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdevteff
    vdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:10hEZyJ_SAvZiOoNGkjb2ua4oDbfAUOe7R-P6P0VjptU83bFqCAfnw>
    <xmx:10hEZ9Jxsts8Q9Zqi4soUX8vT83FbfZQAQMxDbuyPxvPnCp2IjA8Tw>
    <xmx:10hEZ7y-u2cTu5ahDmsfHIo3zZ-9LGfWj3NZpVjRIHmj6lvMhomWMA>
    <xmx:10hEZ5KvOigE5XjsApDbeDhmX7iXdbDbfg4uwfFqUbTaufB1QXiqLQ>
    <xmx:10hEZ6HepwVVFRYj9gwAJoN2iHQdHLOaHMVCxOa5WbP7QhCM6CAJTPFd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:52:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 552eb988 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:51:20 +0000 (UTC)
Date: Mon, 25 Nov 2024 10:52:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/9] refs/reftable: reuse iterators when reading refs
Message-ID: <Z0RIyXF2C-YFGCQA@pks.im>
References: <cover.1730732881.git.ps@pks.im>
 <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
 <CAP8UFD2woZV1O-B9vxEdM-1_R-oTDgt-k1RKt1wJJsofZHb9rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD2woZV1O-B9vxEdM-1_R-oTDgt-k1RKt1wJJsofZHb9rQ@mail.gmail.com>

On Mon, Nov 25, 2024 at 10:47:57AM +0100, Christian Couder wrote:
> Hi,
> 
> On Mon, Nov 25, 2024 at 8:38 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > Hi,
> >
> > this is the second version of my patch series that refactors the
> 
> Do you mean that despite the "v3" mark, it's only the second version
> because "v2" was just rebasing "v1" on top of a better base?

Nah, I simply forgot to update this introduction :)

Patrick
