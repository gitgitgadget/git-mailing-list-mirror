Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75627392C47
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770193723; cv=none; b=MTLHM/f6GthudlKmNgoQwSgICjpnBVpipKFUnwEtSWex+YZin6AcR2hghE4G+JOp9N2J5WsjXxUIMSH1JCMvxR74AbB0xlNG8sAQRwfXAKPsmeglJJMbq98lfFcdT/ABVDMmc/HEBGnd6MUkURv4dl9AzcXFdVnjPd0GwRmjWUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770193723; c=relaxed/simple;
	bh=xCMw/sqng5ZJupKEeXl20Wej6BTfIsipi3Rke1D9wuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGzNZ3pNu2wID73CUaNmADKJ7twGTJiwXO6votfqLovG7ZJiBnp1h2NbmC4PCV1kAnNdAdbUD1hwP/s5LUDxpWYjqDJ3SG2XMsT0MZ84XzTnFAYWYBRroUsoxTCTXRtpC+AXZmokS6RhUPtl1Eo1KgxEkPlTvPo/5xJoHPivMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A4m2cvAX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AXePSyo6; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A4m2cvAX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AXePSyo6"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5FF5D7A00BC;
	Wed,  4 Feb 2026 03:28:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 04 Feb 2026 03:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770193722;
	 x=1770280122; bh=3V0RwekfGPiytC70I0pjy2rkRy8wtCcVsQ83eH4f3BE=; b=
	A4m2cvAXQ3KYHijR81SlunwZS1YhrsSSVNEggoe/NM1ueNOIkzHsCcA04rqrX7bV
	VtfqNQG0vD+LDMA5glacwwue7nusuK7UOBcqk14R4AFd63QEWB8yZK7aPhlyTk/M
	Jxf341PafNl7c0b9VuQM4NgMTGaswcJd63x/dlcHgMeXmC4gXf19rPE/kC2ikNqh
	mnCH8xFfw2jnVv4iFGUPdi35ZFBfPKLJXv/0G+JMz3ZejeUI2+QPCOh79LDnVby4
	m39Orb679BCtNx+RvUaCptrDAHrZyzX694/yh3r9ZYGEO3+/dM9SKjaAFXZ0cNhm
	T6kfEwXNcEDi6UtkOcDMOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770193722; x=
	1770280122; bh=3V0RwekfGPiytC70I0pjy2rkRy8wtCcVsQ83eH4f3BE=; b=A
	XePSyo6NNggWlTT9tQpk5SqXSku4WFXss512JOvdESlH5KO68BdrzDGqaxj61N9s
	v0ssC7h4FhjcwdGcBV7UA9ca+9gZjKpOD/9dAZ9ZmmlQDgb2QHDxrdMJS0UOS8Ej
	9gbZv4aq6GDnmN2200xJxTe5ZD/Xd9O5QTBt69sTQXhfmSIp+HvK58Q2hNs28Gsh
	BXsaIHwMO9OaM3U6sWppgeqWtH885RxgGw2eyLUVybKbLt1dl0kj/fQJJ5Qt4iAm
	TxKoi4GhMMKDLusfYYklnpq/YHyfB7YhbqvXSP2jCRClbfnqPdQeyjCXe+LAHa3t
	gySV9kB+Q/3zGuqCKDywA==
X-ME-Sender: <xms:OgODaTnZa4c4lxZ1pLbGJfO7LSGVya3BIWhq9w22_OQxnLhGQzer3A>
    <xme:OgODaeSqcu4CNiXuupxjYNJnoX3IX-xyxBxl2TTsTNw2s6HQhIjm6XsUXXvZFsPob
    HBH1vUvVhP72sG1Rtwoe3LL5VmUgn3f3-S43tvsZY_n3VPvkcbXHQ>
X-ME-Received: <xmr:OgODaXCjCQMoWnYadfb49Yn1w7S8KbRrWXp2b82AePFMDkkmyYL-okH3rZ6K4V_hN1CJ3XqSd-PNB14b0AtnBsPnB_AOz6ZKnWMtFEo47L6OHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:OgODaVS6-6fmB2lb9uvOuhJUhLPTm1P5K7tWncbZ_wpWmLb3ArjuIw>
    <xmx:OgODaVpJZ7dLIZszvH-EhSYwVMvZNcyFWrgBkF9JM8P9v-5PO_lZYg>
    <xmx:OgODaXyYaphT3Xmg056AuTpmz2Y5aZhFegkDHyOxxUnaQFTqNwXZaw>
    <xmx:OgODaaJehTJjJaQ37dX03YqoDYfxVyLcPYP5OsiS1Fckpucufh3wgg>
    <xmx:OgODaSRaKYlsmcDvQ1gHOPrYtX3D0rziV4pldA3FPk9ejPi5xyZI7004>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 03:28:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd047d1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Feb 2026 08:28:39 +0000 (UTC)
Date: Wed, 4 Feb 2026 09:28:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] builtin/repo: find tree with most entries
Message-ID: <aYMDL4m7Ceifl1Ja@pks.im>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260203221758.1164434-6-jltobler@gmail.com>
 <xmqqldh9qw5d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqldh9qw5d.fsf@gitster.g>

On Tue, Feb 03, 2026 at 02:50:38PM -0800, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > The size of a tree object usually corresponds with the number of entries
> > it has. While iterating through objects in the repository for
> > git-repo-structure, identify the tree with the most entries and display
> > it in the output.
> 
> All of these "largest" and "most", it would be a lot more
> interesting if we can give not just these extreme values but
> distrubution, possibly in a graphical way for bonus points.

That would be amazing indeed! I think having the largest values is still
valuable as it allows you to detect weird outliers quite easily. But
having a histogram would of course give the bigger picture.

I guess the challenging part would be to compute the buckets of that
histogram in a streaming fashion. But I guess we could:

  1. Pick a target number of buckets.

  2. Track the maximum respective values as we stream.

  3. Merge existing buckets and create new ones in case the maximum
     value changes.

The target number of buckets may not necessarily be the same number as
the number of buckets that we will eventually print for increased
resolution.

The distributions could then be printed as an ASCII bar chart, for
example something like:

    0-50   │████████████████████████████████████████ 1,247
   50-100  │█████████████████████████████████ 812
  100-150  │█████████████ 401
  150-200  │████████ 253
  200-250  │████ 128
  250-300  │██ 67
  300+     │▏ 12
           0        250       500       750      1k     1.2k count
    bytes / count

From my point of view that would be the cherry on top of the new tool :)
I'd personally still like to learn about maximum values in the table, as
I've found that info to be useful with some customer incidents in the
past. It's not giving you a trend, but it immediately gives you some
good signal that the repo shape might be weird if you have commits with
hundreds of parents.

So maybe this is another step we can do in a subsequent patch series?

Thanks!

Patrick
