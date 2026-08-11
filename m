Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B67A442FB9
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450571; cv=none; b=s5g2kRL7Bg1Wmge2R0oYGspl2jVgytmKVJ3K07RXXBYp6B9TXU0uqxocVZhI7nAe54LZRwU0Lel+YsGHmNFrHgPhePQUwhVFCI8AbSPB9r0ZbZmBAJSbY+KLe9xEb0eBtQ8iu3jpR9yABvngkS9IbUCE6fX2n+vKQCXfbqpC6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450571; c=relaxed/simple;
	bh=SQ705QwVMBdOa60CF4nwYvx68tMpsm7ogaApxTa64qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEOxxAjTw5mGdTXqZZfMc7naBHwqLCdmTEP+TwFFeP7ezGf0X38C1pMdXz868rIc6EQuk/SYSSjceqTbgw6ax2rWUbSUeDcLzvx3fTBMjiF8x5VoIZaZIkpe8/F8dVlMMgxbzrSEdJQJsHSRrbtN65rQBchz/ouXfU6kSNIOpmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kDtOZ6s1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WlpkyL97; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kDtOZ6s1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WlpkyL97"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F8D114000A9;
	Tue, 11 Aug 2026 08:16:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 11 Aug 2026 08:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786450569;
	 x=1786536969; bh=FmWsX3upFQVFfbnCoiBa4F++xU0ERW1BBHecldXPUjA=; b=
	kDtOZ6s1JQT4ZrNp3P95oZ527jTHC6ZZTSlWk/S09CCf1skYjXb4BENcXCAiTKnh
	jStWzCZWpF42hWHLE2FIHBgqWTezMdGhrSh5ddm3w1/9AGRpsmQSd0TcSuWC7Uxw
	QIkjr9EqRpFDXciI+uNie25GTxNFCOriT7TNE+H+PT9xZ9yLEJEri5I9h0ZsagIs
	OGBf7a/11Qa6urw/bzcuz3JpHlk41GosEGLAhjai0pQiNtL/ulNbRoK+oP0obXx5
	P/6i2aPjZC2J2CD4AEOmFW0PgTb2RUS3R8rKwddIvyHGK4Y5ZtiUaRwHBaSeHzUZ
	Txj4UDA51Qm19nLlok7uuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786450569; x=
	1786536969; bh=FmWsX3upFQVFfbnCoiBa4F++xU0ERW1BBHecldXPUjA=; b=W
	lpkyL97Fvn7DkG+zMZd6fXD+jqjBxrCZx6JWGLELlAeT3hyxGXL8SrnloGX2Fh1T
	xEss/j5nAqCF8NplftmqVm0BeFdWj5iLVGla4tJlhyCzK1EEje7pgyDkD9/aWJJC
	pt0uoodkdU/IfjO7QU+57uFSsvKrn/DVIDRsW+zBXl/8fhARJ2KnGgG4Tq8Yzhst
	z6JPuB9GoIeY4StwdK7g/n/pcU4efB2cF6hGg2oYdgzoZDH3gJJtgjzg+9cBHZTS
	9JOAzA5FrjKRa21Y+NQ9hcUS/8Zv9cATS+KxYfGtr8ZDkSuEpq6IsG+LFjoeL1Ec
	yT+fjNCg4ajS0rBOllF4Q==
X-ME-Sender: <xms:iRJ7asqvzzbE1S7mCAiyO3ezQdE3X0Tky26NYa96GWoBQRqmIaG5HQ>
    <xme:iRJ7aspyfp1KnZhNyQrVjCbL0Mg07XXjeNR767Up80rrjho17mmeFeQdjdzWxTsr3
    xfveSbxv70voCoQiowOunuRpaUqjkdkOQmSzgjrYyUPD4TWQW-r>
X-ME-Received: <xmr:iRJ7an3qbtCwBgevVxHCYOQmnSBKczBZHTraia0MMOyWywT5CwynDhCvyoMkKtqijidr0x9kakLi8R8vcQ0ROM0bC7YNU6IbqkxjsutvGw>
X-ME-Proxy-Cause: dmFkZTFNokYn+VjKEfid7txtx6qPZWSmejZPLZU/I4/HtTDQ0Drd1y+0HBqoibQKTTJXZz
    i7yIobb3xL2qO+Uss8Q1nJBHQeTATeZrWEfPOF7Vut0R6eJO/LFOPXUanBp04Pl03rwmSH
    ohGhsC93rxvTTNREuk1ebGiD+mFSVSiF8GsLmkCzPw6o7/YTnWydForLD52c2Kf0YDbFJk
    KSLAUKYND531p1h+ROHis4eKJmCxNYcTUXRIay1wK/oABBJrA/akMVslk5jrUg4uJ2dsfh
    Mc6/OJybcGHmaNrKOI1twvEy+Nj6VYvNOdiwS0fQEM/bbgoAaACI2z2h2CZsdJjY18A3Sw
    1Cjt4iUr7VoC9fHjVzhhrM62F+YJ5Tu8+sNpnyuU7xXfK7cRuvdmsJxhyyl73jLA8XXw97
    6z+HjrnCAAwcQFIku18LDhpvJ2ofhNdKyaTDzS0vXpHXRuABSZJWHAaWVNhlMic0mzxdOB
    TKNiNevmQx//Dn3y8inkb8gi3vobXxDmdvLPB8N9q7bQu+Tl+zgZY2SWDgmsKx2pPh/lqU
    +k0OGDFMy4jfMXSzgWIt8vBnDFlsAI1hwgGowxX4qNSiiWbQ2Ux0zsJsXBOsoNSrK6SMMS
    tZiuVyBY8EfPNEnWBduNNYDlx42hJtK1DDMDWSZR7VeaFYJc3nQ5BPAPXR7w
X-ME-Proxy: <xmx:iRJ7aiEj2tfXS8vftrMbOudk4ofNfWGoM9hUwsySmEBhJ6u_PIbLIQ>
    <xmx:iRJ7aqHrn2Z3pOn0WGWCDr97dnJt6i1QRchQ9enYrcxnm70V6y9w-w>
    <xmx:iRJ7at7Z6WjkfayLQM56Q0DRpXxcZJm9THiFzg9L3_qBJiZT9ZTz4w>
    <xmx:iRJ7anwMFamEq5MLxbaSAndan8FJYbu4TgHFW4EB3klAkuAeBR4Jzg>
    <xmx:iRJ7ag7p_S6r1713jPmnEpKrdGDxAvD9S7YxZR0QLxtt-pNpyYe8c2BI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 08:16:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 765d259c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Aug 2026 12:16:07 +0000 (UTC)
Date: Tue, 11 Aug 2026 14:16:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v3 2/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <ansSg4qsPwh5FcR9@pks.im>
References: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im>
 <20260701-pks-libgit-in-subdir-v3-2-5e4860056094@pks.im>
 <alR9GDNTbdjWB4dq@szeder.dev>
 <2d455ecf-972e-e3ce-54bc-683050c04282@gmx.de>
 <xmqqjyqpb96n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqjyqpb96n.fsf@gitster.g>

On Mon, Jul 20, 2026 at 03:14:24PM -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > My own (obviously subjective and biased) take is that the tradeoff is
> >> > worth it, as these issues are a one-time cost while the benefits to
> >> > discoverability will be permanent.
> >> 
> >> It is not a one-time cost, but will be an ongoing burden.
> >
> > It is maybe drawn-out, but it is a one-time cost. It's not like we're
> > going to mass-rename source files to move them to `lib/` every two weeks
> > from now on.
> 
> Since the topic was posted, I have dealt with the fallout from it at
> least twice a day (which, when we are lucky, is not a huge time
> sink, as I have mostly automated it by now), and again every time a
> new topic is posted that touches the moved files in substantial ways
> or adds new files that ought to be moved.  The latter is the most
> time-consuming to handle.  This will continue until all contemporary
> topics, as well as the topic in question, graduate.
> 
> If that is not an ongoing burden, I do not know what is.

I guess the argument is rather that it's a burden now, but once it's
merged and the dust has settled it's going to become less so.

> > And this statement neglects to acknowledge that the lack of clean
> > organization of source code files is an ongoing burden _right now_, and
> > would be at least partially addressed by the move.
> 
> At least, Gábor does not seem to think that the lack of clean
> organization is so severe as to warrant a massive code churn like
> this.
> 
> I value stability much more than prettiness.  If we had started out
> with almost nothing at the root level and almost everything in
> either 'lib' or 'builtin', I would have strongly preferred to keep
> that structure.  But since we have been using a layout that has all
> built-in commands in 'builtin', with subsystems like 'refs' and
> 'odb' in their own directories, and everything else at the root
> level, I would prefer to keep that organization until a substantial
> subsystem update wants to carve out a new location for itself, just
> as past updates to create 'builtin', 'refs', and 'odb' did.
> 
> Compared to those past moves, the proposed change looks more like
> churn for the sake of moving things around, without achieving any
> real organizational improvement.
> 
> I must say that I, too, remain skeptical.

My main motivation isn't prettiness though, it's newcomers to the
project. Git is not an easy project to get started in, and the root
cause of that of course isn't our file layout but probably rather that
Git has been growing organically for 20 years. But the file layout
definitely doesn't help newcomers to find their way around in the
product.

So I'd say main motivation isn't prettiness, it's discoverability. And
sure, that's a property that regulars on the mailing list are unlikely
to care about as they already know their way around the project. But I'm
sure that folks who are new would appreciate it if they could see at a
glance what parts the project is made of to help them find the right
files at the right time.

Anyway, as I've said already: I'm totally fine if the result of this
discussion is that we don't want to do it. It is churn, and that churn
has of course does have a cost.

Thanks!

Patrick
