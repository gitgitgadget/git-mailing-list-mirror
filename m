Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877E3242BC
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 05:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786339554; cv=none; b=UaUqSRR2wOi19kvOofX+G0dO2u6BHrFPMF/zr7HPr8DJn8ScpMFLwllO3kNIzDt8+A/v+ZUt80BCtNmHUiSb4xab0AVRxwmVvgdTtzTAqtHe2wFS1b5amFtehLvw2arkN3Y1nn6FkjWF5TIYLwTOSAl6WjOMJCOv71DLG30SwRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786339554; c=relaxed/simple;
	bh=jDha6PKeO6vshY8fOepBtL0MtkH451jXt6yoH0MKcfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfxVr3ItDIHD3DD9fkEwlrk29E5uYUltyNBGzDZD6VFhTJFM+6UYyLWghh3iBS7APCDLsC7ANkt+byomCMCzC+HyEa6523HPw/jKZYefkl6k7XkHk6n+m/dudMsQ0KaGVXwNnUFTVqShUU815QlDjKzso3L0sMET+Xftbh6oY3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YCFnMWLN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kvm/L8dv; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YCFnMWLN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kvm/L8dv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 47CBA140002C;
	Mon, 10 Aug 2026 01:25:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 10 Aug 2026 01:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786339552; x=1786425952; bh=WCaVveOzOQ
	XzsgkPsDRIvRL50KKM4+UJ3HYthEcRxCo=; b=YCFnMWLN6IGMEfGFTbTB+p+Puv
	Z50JpSxxsBk3a1tVqf74u9jaL8SHlyzEnpByEALDNdX+6Kugv8p2KR1pwxkQbxC0
	cowMZVLX8dWqtSI8XgKIdmfF94F4NSIQGJMudbuzCbPuRAdC2TIrkKNmi16Rfe+p
	pJplwPTQ6is60HIe1GfGoQ1KU5MRG2bRoD4bZ5iCCb5TJbXm3cikCTGw1vyHzWM9
	w/qT217yo7G0ljsfWx3XWRMeZUZmu2PqKZrnxggmEQl3H1isMcz+PJFdkynaDdEc
	0faVvn+KWvcbVmlFvcHTLAd0heoq9g0o7Hr4mxUJ7Z4glgdQp9vpbekWr4vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786339552; x=1786425952; bh=WCaVveOzOQXzsgkPsDRIvRL50KKM4+UJ3HY
	thEcRxCo=; b=kvm/L8dvGGe9ItBw/HCkxXzvu5+001+Ug4PH9LDXHQglBYt9qwW
	o7jSTbzEsmndPKLpSHIfXjtwsi7Y0tWkxCcL/2D3IkaBPAlVULZb/+A9vIQ4oc0o
	AE7WcIF/DZb2kBjGeNWZQcfG8DFNmD5dU3qYn5E9Yw4EL0NToDBr59Fb0zEtuLpt
	/OmXGGdkVCfCUKoVQksF9RPtyWHQBWo0qvjNT4Cv/pEaCvbtDZeCdoOTjbv8mzSH
	AS7A5uq+hVBH83Tj5alRuSlBTiLGh0Lx0tvj4cGh3JtIEVi2Ebw1BtTKf2cYI8SO
	l71VPkUc//vLb9DILbR1OTABPF1Zp1S+D/g==
X-ME-Sender: <xms:4GB5amBabhtkt7GAUDmyn8SUFg1-2eKWoUw_6jkCWMvEQHu2QQX4bg>
    <xme:4GB5anh73cacge1tLcx9OzimUfrM8xrIbyQq_i4IpDpluiw7AOpBJn1_hGsUZjFw6
    54BAtL24fgl1wTTVN0wJTy0hg2vSbpezmMbJMTRhbeWeVlZvSNkq4E>
X-ME-Received: <xmr:4GB5aulvxfk5hjkKMbPKK-V4P8l2xY1pjyTAPyWY97cwLAZJZwfNW2zWRhL_uJLqXJONw9vUbSfj3KEcoLarmwul40faid-QSAs9IJF-wA>
X-ME-Proxy-Cause: dmFkZTFYwsiVYVCDzkAszyWtI+H9nr+s5G4QHs8mvZAsN4gl1tEkzSL6nv++IL36CDOSO2
    H5lVgJG8VgZf/WQnO584Ie1J3UVm1WbhrhRM/7pPS0Fbn76pnSS28YdMhsTppGdZ9Fe0q4
    bfWDNdZerscZ7aW2gr5PZlKHdGsPv/irPFHjeGZXtUnn/qITWWnpqG9qY7GkdqJV/045/f
    sQ5ao/WzsjKKk4p+N6TcSo+vDt8RGqznnOREXDIIk/e5PtfDqqapB4i58fY8nBeMDLKsoV
    2CCDXB5322+2vA9RixcHqvkk3G7I/2OdC6heFJP4fhTKF+fUY6D2/UOrxUzdxM5Ff87gT6
    zCo4BOHmxnVxBJLbL/ukzXhJ77sO8m9sHY9xDQxMhYV6KAR+8eW9qJZTD19LhqpwNJ+Oj8
    ao7pfVqS5JzlO59oikhxBbopD6HvO6B3M2TwnbHXjDir8QdSBpQqKBUOvx5DkXyS2l/cRp
    A5OrjeWlvymSIFYeIE/zuhqzYIn8o6faAhqPcetrlZh67i89V7RuKO7qvDQYOoZpN64cC6
    PVic3zWWik2xWpIAPE367o2UjLPpzeOmrYBkJYeHdNiRoC2R5cOC27h5s5RUBWw/XIRvO0
    I6QcgNO384Jk4M0SR+weHuqUDtEc9gUzgdkMZrB3rkOgyBJD5S4yyZ18QviQ
X-ME-Proxy: <xmx:4GB5ajoKiM1NDYTq4Xax5tlGAXPtInO3aOHZfZCYszOEj2gH3BAWRg>
    <xmx:4GB5anGs1SKScn1XkQfsttt7hYMyocEGaSWjp1RvUFGO3Dgx91sT4w>
    <xmx:4GB5avw_qhJ-XE5iQGknd2Z2GRBI4Y9We33jwAZSAbTCqRG3ndlbVw>
    <xmx:4GB5asq5NPSe1xJMisvo72tNHyC758zSf-ApPQ2z4-sjg1XmhzwQ1Q>
    <xmx:4GB5aohQxoR9My3B1AG-C0aB9EN-RUdimbwPH-XquMURq_1NYt2vb707>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 01:25:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 65d3cec9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 05:25:49 +0000 (UTC)
Date: Mon, 10 Aug 2026 07:25:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <ttaylorr@openai.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] odb: make packfile generation pluggable
Message-ID: <anlg2rThlBLavyU8@pks.im>
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
 <xmqq33wpej49.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq33wpej49.fsf@gitster.g>

On Fri, Aug 07, 2026 at 02:05:58PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this patch series makes packfile generation pluggable.
> >
> > Note that this series only makes those parts pluggable that are required
> > for the transport layer. The other parts that relate to packfile
> > generation as required by our repository maintenance is kept as-is, as
> > there is a bunch of options there that are way too specific to the
> > "files" backend to be portable. This should ultimately not be much of a
> > problem though, as maintenance itself is already pluggable in the first
> > place.
> >
> > It's a bit of a shame though for git-pack-objects(1), which still isn't
> > usable with alternate backends. I tried several times to find good
> > solutions for making it fully pluggable, but due to the backend-specific
> > options it's an utter mess. I want to eventually address this though:
> > same as with git-refs(1), I want to introduce git-objects(1) to care
> > about all things ODB. And as part of that command we can also introduce
> > a command that generates packfiles in a generic fashion, without all the
> > cruft that git-pack-objects(1) has. This is part of a future patch
> > series though.
> >
> > The series is built on top of 2c78326f81 (The 11th batch, 2026-08-05).
> 
> With "--no-ref-delta" thing in flight, this will not play well with
> what is in 'seen', though.

Ah, dang, you're right. I'm not quite sure about the status of that
series -- there's been a discussion around whether it is the right fix
in the first case with Peff, and there wasn't an answer since Peff's
last mail.

Taylor, could you maybe share what your plans are? If you want to pursue
it further I'm happy to add it as a dependency and/or wait a bit.

Patrick
