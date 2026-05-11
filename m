Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0400C38C2D1
	for <git@vger.kernel.org>; Mon, 11 May 2026 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484627; cv=none; b=BFhTKsNk8424WdR6mWsIFlFGVlUVfoLOgx9i2IxYYHYejJPugkq7cW3iEa1jeLmO0mTkQcTFo3zn3gk9cFrHAueXpzRFBlF+ImP6XN0oMZruZSlwR/YtQNndpJiqvV/qAuyWbCMTq2jZVMIlnE1N4XnOKlWuO+Yc3Rb56KrCfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484627; c=relaxed/simple;
	bh=BLas5FPy0XX3v/uGaWIBMDdliAHijIpv1TRdSl2Wit4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtkfQTCo0QZ27EYPyyqriBJiQ0GJGbSqVndlBD4ld6355dSby5Dsua4VteHcTkUv8jMNygpPdJOyotKPj76QGpAnNND9zfcu2otuvLnHenAqFh5LgYSTkRqRb/nEnSuA9tL3eIrZaHAYX07cNT4nMH+wdfYr6fJcWS3CJLhyYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MoIfAar4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fqKfKB68; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MoIfAar4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fqKfKB68"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 23BA9EC0123;
	Mon, 11 May 2026 03:30:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 11 May 2026 03:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778484625; x=1778571025; bh=ntutkdQxmC
	kjsYjJGloEbp0dwskFVNAV6aUinX5jAMc=; b=MoIfAar4Xo4lE3k7OplqSptqAC
	w2Eg6vWSm7X1ILOye+n+LQqVddvR1eJTDYBf3/sb/StKzpmcPeo7A+Z69Thys17X
	eCfwlqfH10EPZWWlDYJfpt5QHxMPOmnkfcuQs4WXcKNHWzy/+dUaz4jmg9LdEn/I
	XPyRPXTJGW0ahl537WLYsktst6DrdlDnq0QxkXsoP01SMnEP5vU4QrjKrWzaYUjT
	UwxJ3pAzTB9Hlp9GsAe3gKH/9Kmh0dN+KMxS1S6GoJz5pzBKiFoI+Jw6uaFIyk8A
	MOjris4D4DhMwkuxJ3uP72RJMiNCdWKOOmy4sC4bmnVcYpOCdjhoM0Rgsomw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778484625; x=1778571025; bh=ntutkdQxmCkjsYjJGloEbp0dwskFVNAV6aU
	inX5jAMc=; b=fqKfKB68yUxrWfgdZqJjojHB9W9xByH1rFkWh5a+Pb3iYwJiWME
	8wnreXubcgeVPQqb1Lmv0FpUppPrqLh+0gdfWXHyKk71paXKHx5k7xrqSqouIPy4
	CZ/U7Ps87mCUm6ExDvUxOtcoZ7uOyf6M56yajx0Nw9znfasxjAeTpxuLVTp5EWKl
	/etOVxXbMyYhvqSEYgg+GDYyO00xTW5gbyy0NZfIhy+Ndp7QBLrzKqvtu0DjgVq/
	aoT4IbyxwEdl1URhUj0pK1S2OZZZJF0BcW16xAbyt4LGQXW6cpYjTU6aIRP5s4s0
	ghp1tXLAqoazrm3iSJEC36ptEmWN+gFg+IQ==
X-ME-Sender: <xms:kIUBaqXZqjxLDjjAAPBL8LJay18-14oKmLimrf4fBgtm1nLuikbJZw>
    <xme:kIUBapLJGEHQJ8Uzbq3sOdY4uBkYi0RhVBEOG38AGxlE0RZUVEbtIrBEYPyDmhnXu
    wLVVpb0l0oi6nFBZxy0tsmdxlx8QLw5jqpdoH7u0kvJY6UkZAm_qA>
X-ME-Received: <xmr:kIUBaiDUXPIiLuRXcjcebwy8LIKwMfUmpx-P8_PnwlTa5tk_CY1I15rB9x1-NT38E1FQUaIZB49Tl3g0GHREiCS9ITmnnGtz77Zd3vairg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprg
    hlrghnsegsrhgrihhthhifrghithgvrdguvghvpdhrtghpthhtohepshgrnhgurghlshes
    tghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:kIUBahfHJ_MKdV6ZazaemhLq5IJvjOtsB7HLvbrJkQ0MTjEvu4cwMg>
    <xmx:kIUBap2egkEFFzXkNxwGHaBpf32aFws-UnMDDDpGOjAPC-LvvomZYQ>
    <xmx:kIUBaghNfK-ur1LPnbFZd7lx_mEr9ry1gU6Ihyv4vOJ8kSiIpdAU1Q>
    <xmx:kIUBaqn4iCGx2roTnLC9l6XqWQXnB2FrP1_vCWaM40PGmOurAM_a3Q>
    <xmx:kYUBakH8oIaJP9whCVf_tex7TxBU2Y_CRs6MV48lTsta3NnfpLghJLP->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 03:30:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f4fb641b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 07:30:22 +0000 (UTC)
Date: Mon, 11 May 2026 09:30:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Alan Braithwaite via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com,
	jonathantanmy@google.com, me@ttaylorr.com,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Alan Braithwaite <alan@braithwaite.dev>
Subject: Re: [PATCH v6] clone: add clone.<url>.defaultObjectFilter config
Message-ID: <agGFi9G7HxatnyFs@pks.im>
References: <pull.2058.v5.git.1772847236966.gitgitgadget@gmail.com>
 <pull.2058.v6.git.1773553022381.gitgitgadget@gmail.com>
 <abe1l8ONmFIhzaxi@pks.im>
 <xmqq8q9qvffs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8q9qvffs.fsf@gitster.g>

On Mon, May 11, 2026 at 11:38:15AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Sun, Mar 15, 2026 at 05:37:02AM +0000, Alan Braithwaite via GitGitGadget wrote:
> >>  1:  fa1ea69bdb ! 1:  480453b2e7 clone: add clone.<url>.defaultObjectFilter config
> >>      @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
> >>       +test_expect_success 'setup for clone.defaultObjectFilter tests' '
> >>       +	git init default-filter-src &&
> >>       +	echo "small" >default-filter-src/small.txt &&
> >>      -+	dd if=/dev/zero of=default-filter-src/large.bin bs=1024 count=100 2>/dev/null &&
> >>       +	git -C default-filter-src add . &&
> >>       +	git -C default-filter-src commit -m "initial" &&
> >>       +
> >
> > As Junio already pointed out, this change here is a bit puzzling. Not
> > that I think it's a problem, but one wonders why this existed in the
> > first place if it seemed to not be necessary.
> >> ...
> >> +	normalized_url = url_normalize(url, &config.url);
> >> +	if (!normalized_url) {
> >> +		urlmatch_config_release(&config);
> >> +		return NULL;
> >> +	}
> >
> > We haven't allocated anything, right? So in theory, we should be able to
> > return early without calling `urlmatch_config_release()`. This could be
> > stressed further by moving the error path earlier, so that it's the
> > first thing we do in the function.
> 
> 
> We haven't heard any response to these points raised in the message
> I am responding to.  Should I still keep the patch in my tree,
> hoping that a responses may come some day?  I am tempted to discard
> the topic as it has been quite a while since we last looked at it.

It's been a while indeed. I'd say we can discard it for now, as we can
easily add it back in at a later point in time once the next version is
posted.

Patrick
