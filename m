Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA5C476054
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235766; cv=none; b=oEhMo/zqt7c/dRrIWtAOxwIElL8x9u1iZBLO4TQ17Wr8Joi8VLTpJHNZVKJntwLMZ9jWdW++4zu/FBwqX1OM67nqS6t0iwfxbq9Q9tdgIiNB0AgInRP6hWSTrZMZfZLHD34q/oGZZs1ue7cO5uTcZ7dLn1BBrjI/jAuSHZfLFs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235766; c=relaxed/simple;
	bh=WFI91h/Xlc/icHjBg9hgNoBiQpNWB6i0lMR4j5ETvEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwVBmH+UodPW8KQSspCc8PEkU7fJXE4Aq/2DcDqrWdhymqq+HBWXiLYhSRBZ7wXzd1Pl19Y8K0RGYsI5jGhU+tilOL0e4i2cDhPOnXgHkklCNWWeQVJdhhch4fuHyl4ivZH7VmpUm4OCFJ0dII/fjfXiZP/iT1mexmSMIfciFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QMMdv3Sr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dd9ZHOik; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QMMdv3Sr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dd9ZHOik"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B37C8EC023E;
	Thu, 20 Aug 2026 10:22:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 20 Aug 2026 10:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787235761; x=1787322161; bh=6zUt7GMdqf
	Zp1irEx40lSp6898H271LY+c2+XHiVREY=; b=QMMdv3Sr2rCVyj4ffgNq+gBYp9
	ismjHZngOtluKDVuVMmoX8IgY15jKFUPKgKQgSt/H+X1ThHaI98//KD87IyrMQgX
	C2KYWYRj2ABpizKOm1ihKPEAGLrz17yTcqnLwYasC1h42KlOxPx8kppWGDm0lc9F
	mOqBeu09+PC30Fd+jGUrTDwB7TiFAfU9mJezHiTz/7ma+3RzjqqDKyMMGYEjGRAW
	fZHXjOt8ENsTAiO8RHrmhGnJOpACVe9VkC5/jXxtk9rMpCIPdSY+CEQrB428JCEW
	YF+HiPyhf5+Ne38IzlfAxEfN4pPx7umqP4Ty82YGnazFMr4DlSV+epr3KTQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787235761; x=1787322161; bh=6zUt7GMdqfZp1irEx40lSp6898H271LY+c2
	+XHiVREY=; b=Dd9ZHOikzqJ7vDhRrgtUv6HyNZLfkUdnrLSPvL6z3xl2OPKKNbP
	3vT4s1Ca4oemWeX/0pwyarqLp2P+1OrZJbMNcXO9WWR3MxB7sIMm5PD2fnC/my8Z
	mxKO5mpZ9CoEIsSTUHD3Y+Lj8uVuK69NuzInu7F3TXZsS6K9/p+8D0hTiYs6r6lJ
	o3OrXD4ctIoFkI6Vq0b8mIZVsINE1m47LywR55kndIaZFFAhdJTTdqWQQy4/zwyo
	M9mYbsxHQ+LgSMKsVFsFy75lUlKUBdpn413IkrQoGKpvGsRIT9TDp1+yGWAYvQRb
	pV9c5+0B8ecxCHRDxegB8t8Twfn6NqDhnnQ==
X-ME-Sender: <xms:sQ2HasXg_0OzAfWP80V8JJkdwVi1YtZ5OVyB2PHUlgGWA2TxGVWX3g>
    <xme:sQ2HaoCpUZV7QUekPoL-6q77x6iQkK1fF3Zay8s0jNQuL4JVX-hRSvVXdBOtIqZwF
    A0nVQHDCmHeLkB96A0Lrhv1ED8l0cb7R7dVCpci7oqA_gsy9kYDULA>
X-ME-Received: <xmr:sQ2HatwzjGh2WxkpQKPtT7uMvFMIbmaaJAmuDW3XgId39mmgRcccbxXo58uhRRJ7Sli9jGl7C47H13prvhZhuT25ENmiK_XnGb8tXwfbwg>
X-ME-Proxy-Cause: dmFkZTGF93IlkDmzRCxJn0k0fIuvALPcvyxxT9PLG+UPYEeutKjLsl83d/LFQblsOU8o9o
    aI0+yoi1i2z1JN2tIkCfVZMuuAiVIS+25zWgp97ZzBmwt2GFvYA4UHB5qUUp2wqP3Z8ExU
    6/bSeEbR5tBBJXmhgIrGIr3vgnTV+jMzYq0IparnCOY9cjbqCvoYxQ10Eqxp/wCs3QvuSU
    mxDQMpZlTglXXmW54TNBRws7SRqqoHZZFUpdiURDNIdPh48OSbmqeXCu+6GDbpV5kMQyjU
    I7ljbCGpG0tAzEGEtAnmjno4zHPkLy8YQTxeSgmbuKyx0STnCqi1oUy64HJr79XRUiI/gA
    fIyggvp1XWXIjZDXKGb/IkZ7+qpyR8Bx9F2MdMNvbdWe5IktxUnM+QG6sSVhKYPxDDpvpj
    mrVCWKDgMnKFaQudBAyaaLOn4f2+odA8PyQk5+piq+eboTSNHQacXguokTqXTkl485UnRW
    JMGXtNFc91iknNe6poE3dpGu23AASB7bobK4lDzs6qqoRAV2yHKdaOLG/PLufmkaF/97VA
    QlCAE1a0/zdwHANA58F+r/a/TH05F5pqLpoxbAKZ59URS6MOodO+aRqjh9ytEVw8v5iRYo
    gNyghuQlw/wovwkLoGXIHR0iXl70JrPmWfxRGGpLmA3nKpE0hjRWBk5bvmCA
X-ME-Proxy: <xmx:sQ2HalBA5Pn7PzUCjaVF6bjirwoP9-PlYDVSZ9UlDFojMSMrfG6z3g>
    <xmx:sQ2Haqa9GIyGJaWNLYD54vunvjPoOyEXlHeKR1o9Sf-A6RhRMB_EGg>
    <xmx:sQ2HathkhbSs_ZZvldafaPSG75oJn5lLVQqccjUWOv0hT7plyNZdcw>
    <xmx:sQ2Has4JWWpRoVvthDjGT49wVwWkLIkTmRGmjjD1AbOtAlb4UIC92Q>
    <xmx:sQ2HasAzIgUEaxXZZUNaACpo8mxpG6ELhH7FGgh_Bb6xG27F19vKE4Hp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 10:22:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1cb1549a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 14:22:37 +0000 (UTC)
Date: Thu, 20 Aug 2026 16:22:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] odb/source: introduce error status when reading
 objects
Message-ID: <aocNq1N9MWS4BeaJ@pks.im>
References: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
 <20260819-pks-odb-generic-corrupt-objects-v2-2-a984e3a0ad6f@pks.im>
 <CAOLa=ZSCf3CvTwtgj7RXncT6zPhyp4EX9r=g55uD+mTA1zp-5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSCf3CvTwtgj7RXncT6zPhyp4EX9r=g55uD+mTA1zp-5w@mail.gmail.com>

On Thu, Aug 20, 2026 at 08:41:10AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The `read_object_info()` callback of `struct odb_source` is documented
> > to return a negative error code in case reading the object has failed,
> > and zero otherwise. This is overly broad though, as there are two very
> > different kinds of failures:
> >
> >   - The object may not exist in the source at all.
> >
> >   - The object exists, but reading it has failed, for example because
> >     its on-disk state is corrupt.
> >
> > This distinction matters to callers: when an object is corrupt in one
> > source we may still find a good copy of it in another source, so we may
> > still be able to proceed with a given operation.
> >
> 
> But isn't that the same for an object not existing in a source? If it
> doesn't exist in one source, we may find a good copy of it in another?

Yeah, that paragraph is a bit odd indeed. What I really wanted to say is
that the failure mode is different depending on whether the object is
found at all: if it's not then we'd fail gracefully, if it is but it's
corrupt then we die.

> > diff --git a/odb.c b/odb.c
> > index caf1d0f542..1b37b26376 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -696,12 +696,12 @@ static int oid_object_info_convert(struct repository *r,
> >  	return ret;
> >  }
> >
> 
> Here and elsewhere. Shouldn't we explicitly return ODB_READ_OK or
> ODB_READ_ERROR instead of relying on implicit conversion?

I didn't want to go through the complete callchain to make sure that we
explicitly return those values. I think it'd be mostly pointless: the
return code convention is established enough, and all callers already
return the expected values anyway, even though they're not using the
enum now.

Patrick
