Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57940277026
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792390990; cv=none; b=rblXPPZ6PxUHvizWm04PHEqebmyQjxFrks+YBTFew/7Ag/qv8Ho/2j1OlRoSeGLOYp7GC1izYHGklboflg826oHwAXfF+dvfjpvbL9hnEw6+hrEflXmNstwcBwCOoTH9UkqsX/nIJwI3JMKCGP9fHlvzaYay8kdoGQYlvIGn9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792390990; c=relaxed/simple;
	bh=aPoSMZDGuBnw5jpiE30vh31diNopcbGu/X6eRMZ0guc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/962HmlRPVKL4s12MPmSy9Xp9x0uaacK+4I9oTzlCwcXsOzd0qRSP3t4Nev6xTy63iIAGn/J9tM4LSIOZgRRFMORyUpaKBs9JTY+GQs6PrxSrBTG67VpcW8UDOsFrOd6q0pdwdWDCe4WMLha9NxqT0ZfXNu4R5fTxY4kZFfS04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Uk0+IkrN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dScBRGC8; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Uk0+IkrN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dScBRGC8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A010F7A00E5
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 02:23:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 19 Oct 2026 02:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792390988; x=1792477388; bh=hDWEQfqV7z
	hsQIEMw2nQ17eZZDFs58BV/BQT45DzTsg=; b=Uk0+IkrNDtzkMfy1YFsbjHLPT9
	gP3IMASG7DW8JcltKCoOmoDpXO05VU8fUN98xhxADPdww3/g9wC+lRHTsQO2h6+n
	oitPFMuK7ypFuS9CTpR/u/qVBKHCqEvR7gKksPsiko6hTLKzzkuDlZwocuMVYNSG
	ud1g1wPLTwP4VmL1jxoE2JGnicOje9IMrxQ1OJvfsFeifdB92rQCqQlyUCGOx/g4
	jYorfyG30tEo2I0RUUNCKvQL98NXig28Rnz/RfaMqe0ix8MJuqAzoWyQskKycL0d
	8Lk1xp1JrdiL+BLleGPDtwwM5aeZSwAZp1m0ROYnfqYswkzFUCbAwVd1Xc4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792390988; x=1792477388; bh=hDWEQfqV7zhsQIEMw2nQ17eZZDFs58BV/BQ
	T45DzTsg=; b=dScBRGC8znGwW6Me1QC9U6EW8NV0f/yYBdS7IPHoJIc/YrIuWIw
	cOmAk1zayF4j8yxyAk1jU78cbZH8eHzmybgj9OECij0SqT1AgQB4odd/2zYUWy0O
	+MA5sTG8AK+Pyk6FzyGZyx4IOL9BDKdCImDsJbpmxMGx13G35rqSUZyBOnXxH/up
	aJt9rS+CiSEI9dO2WyVK4o6i40VLqI5yRVtN+d4lSUmmZBgmRZj3KsmmTKrZ715I
	irornHeDC8qpuxZ96+c/H0DP1tdJJbVPRc5rZ84AuYoXm79WIqfTg2XRzUm6cR9d
	b5gnFMySAjvbGDfT3j45P9C1OAf54kmxfcg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792390988; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:eeQgg3Kibn8OHHbvlLRAlZE4xemP7n+g3VHTlj0BqH4J6Aa
	hza7k+TSV0g58w8yaLm3MHOOEKZb3Q++rBp2xyO8b9OqTrI71OruB054DhsRe52y
	W8zv13cdFM2/8sQa5z2mPrgIE31Q4V10cp+IbjT9Q+B4Luv1hfB/5AUJgDh/oICP
	swvv99khDUYIpGpulX8PPCb+H9N4HQFKcaOWayhx44mk+HDsDTNV2sc2+p2KQs1x
	/rebm6u7ScJgNjAcfpQcwnM1aP6nEbBfJBoYxFYbLtBLBidAk+BCj7k4R0jtz9ht
	tl44kLHgG9TlhMAJk4yye25URq4KRn2zd9f3AGg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:PxBHJvf4c1hU+LuFEUgodT3Tz6XoeFbSSdNjv9JoJXw=:aPoSMZDGuBnw5jpiE30vh31diNopcbGu/X6eRMZ0guc=;
X-ME-Sender: <xms:TLfVamjFmhslK8zxsjqiVqQwyvO-k21GUQactCslf9svr3ek705FoQ>
    <xme:TLfVat5jThX4oUpnQcpMWwwkn71JdHOpqWu_kHb49KRFrn1XHox4VvMmbtnxJMzZQ
    Dfj0vuz64pserbATdk9MHUMskgB0BXlMMnBZqOKW1cwDtl_0ARHr3g>
X-ME-Received: <xmr:TLfVamaM1Lcmbs7fCYkSE3tYAeK_J18jrKWyh7FCqLWNiwrB_zumyQ>
X-ME-Proxy-Cause: dmFkZTF2nLtAYYRbnkL40RU8Mc0Mzh1m7pmGrTsUfSZp1xoZ3zIlMEE2SUHA7don31HyQh
    JAYfHwFC7wprC/4SHu1edah1E91dJAkhBcCcnA6hpx+iRQnUagCUaUyw9dESa6Y+fbXSB8
    qBh1V+wbrE4K6rz37BRy9runsUgPKkEZQu9Ud6HeJu3zJe2oz0B9zIMYjt6SaScqY0+K4d
    0yudqz96zHj92oAZ0pkKzsDVVB1xoKQ8BNxHU6fX64o6KiHAhOd9iV5rGUy86JroV+oQmd
    ODKLSXtepNAAyJSfgmQSeJY14nBLg1X91RRe707ud25z0u+ut+lFOasxdBEv46MjGyTSot
    uywcLDRsR05eYjzruCKDGcC7Skg9d7HJJL9VDpX/eX4iZGM6Kju7FxdxY8H7IGEEZCG9e4
    X1qJ19B4X3B2sTRD/i1mc7ygkoLKuiyY5Tsd1n7LqJpJGIji/hH/joXhTMFVWLTvX3oRQI
    iMbhKUZ3bSZBDI2gki39uaE/earAw8FjfldS2UKdGfw+6Kof20zMZ01mrI0esvzheJFS6N
    5urTgXkLnwLoSsd6MCslNRbpLmYP63qVntneZRG/fQMeAfz+0e3WHMiWYZsAe6M1vW16G6
    PkT8UAuBE4bF0eL7jhR5Bsr23XVpKHFxmjJs2iDkyfHis/58mIvUYpB1ZIsw
X-ME-Proxy: <xmx:TLfVaq6VTKPgbrX2feuo6xGqxjRUA0Ovgd_2dyLDj9e46fkADXE1gA>
    <xmx:TLfVahDMk2vhUkI21RfCyU8nxDtIz5OFOAxN_kUdGepZ9f2TfE3h7A>
    <xmx:TLfVaoecAJpI1iJJP5ZlQPePmNfvVh6ugYgjySl76D9TZ3dovLwzVg>
    <xmx:TLfVaoI3kdOep0KKq51FX_EH5X0ntWixr7hfaaJaoMp-TxUqbKT-6A>
    <xmx:TLfVaobBA7c_8FBBS5nShXQEAfChF6SK17_AEARutpxReUog3OzioOhr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 02:23:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fb3e15f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 06:23:05 +0000 (UTC)
Date: Mon, 19 Oct 2026 08:23:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>,
	git@vger.kernel.org, coygeek@gmail.com, ben.knoble@gmail.com
Subject: Re: [PATCH v3] repack: do not rebuild packs on --dry-run
Message-ID: <atW3Rm5MUG9hqKVX@pks.im>
References: <20261010210050.76064-1-r.siddharth.shrimali@gmail.com>
 <20261016191344.82688-1-r.siddharth.shrimali@gmail.com>
 <xmqqse25e5ja.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqse25e5ja.fsf@gitster.g>

On Fri, Oct 16, 2026 at 01:47:53PM -0700, Junio C Hamano wrote:
[snip]
> Will queue as-is.  I think it is good enough, even though I did
> nitpick a couple of points in the above.

Yeah, I don't have anything else to add, either. Thanks!

Patrick
