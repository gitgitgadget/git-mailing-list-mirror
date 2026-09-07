Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750563C4172
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775257; cv=none; b=hNhpuA8io/yaGJLGvWf5QeK7t4NgFDP6XQScTal8srb3UeON/MQYJ5TouDBCGkLDobhcuUhi/Jiy/ang5apbfK+MKNSU/rXY7D4V94UQyzQHL2B4SipdGxHXcF7g3UIi8wYK41JedG/5vmXqxMSVXqsAAgG/RNplAXNC2QO1eek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775257; c=relaxed/simple;
	bh=ChwTR+Qo3G16giHYxSQrATygH4Y2HU9lXfSjLYkShZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaNCQvAB6E4wnDMh49utrxMj6nOA2DlYY68Iwh9kj1X/5u/f2vLEV+Lp+CSR+nxyxh24ckXaLwyfF29AXq3Qz9pI8VpEIMXCPMtqdRwPQurYP73n4XXkzM7RiSTOEl2XOz/rVx1CFRFlTgq51J6RvHFvfeW4ycusEUGvPBr8O7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Thd+ynTy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YcktqHV5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Thd+ynTy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YcktqHV5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 76EF7EC0252;
	Mon,  7 Sep 2026 06:00:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 07 Sep 2026 06:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788775255; x=1788861655; bh=UYmtjj94PO
	9ADoXdlgLqeHCau9RcFvCShNYU6yJOO+Q=; b=Thd+ynTybMwpWqCFOlYmUgffDP
	o2dsQd2KMwaDdrzznHtQkFlQ2xJOfzp8e+O3jZqna+SDbUHMZXbFh93pkQ2aTDM8
	34aM9klGwwL1YGTJ3SmntvZOgonl3IeXzpW4N/gJM/FheICkoho1EKVwOUbD/1DL
	miPNkBnpbwb6GHJfL+DvpsNUBHdPl6MjVz/uPY8VzrfAzQonPG0rOQAdjSjBWkXx
	C/2c2KqwpDse8avmAuorMu/GqZQH9ir10it7NCd5YtIG8EBcyx9XaQhURYD5PSqz
	AsWif2PHBV2gZLkiXbAzGC2k2CbJJ7FjMz5kf4bmWTqAO4eeivRHcnuqhNpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788775255; x=1788861655; bh=UYmtjj94PO9ADoXdlgLqeHCau9RcFvCShNY
	U6yJOO+Q=; b=YcktqHV5x8aZv1jKFukxw/JhC6aclcheNigbPk1TOvmfBKwxRHs
	Xbl9CQGjc0O57zontHe0B+t5BLY7K26F2QYZXg3D/mKcYh+p0FA4VMvxU9FlwhP1
	Vwgo4sCSpC8DeTOtFnGdEbJqzg3q2VsqWqU/Flq3RW8QTyN1LEChjCPABan1h/VA
	5FImC6cvg+G4kIObc14e+UmKFO0o8a0h6v7DqTkcB32T567dLX8kI3NW863l7pZE
	fx4BpbAXXJOQgTtkv0xrzKsnU8ynfinVhCFRRCl0mw+GNfxEsQ2PsjRFBhq69i82
	cq460/GYD9JgsfOYOCup/ttvQ1iflIrdudw==
X-ME-Sender: <xms:V4uealI6h_lI2XFrdQMBAbHcMrmyJVvbcwNA9jscbVDI_1TI1V_hvg>
    <xme:V4ueanIgJXUZB2bz_GkGBMSp9XW64yGpjUKeSDMXtezZRA1x-DYkPxhD8XIUaPYff
    wLMIssTQ1RQjMSrf6J5YiePeGN2g51s_kWBkSImQZgjx2IvlDqFhA>
X-ME-Received: <xmr:V4uearUyVjWrYB3DexW3G4hGkIUje0U1-mrBn3eZCpNI_ZLv2YQV3w>
X-ME-Proxy-Cause: dmFkZTE619ur0eGsSbAONtE1/IMaDOme1k1/jmMFCtyE7sTxODVYTKwzlvVT9Dhs+R9AS/
    nyeH23WtLjiqVNFBFbrqj7/Bm7naUK2myztgZNrQjSm4VIM/ji78Z61k/CTw09YFaPWNGe
    p3ya0lLLVTzcR+iIgVME2IbXWVETAdMwBea0hroZvvLrZD9IEMxfhL5lm7AKS4Vrxmvp/+
    TLR6lDgNDq05Vm2mfCUbUT5JsPSqG3XpxCsZpymswZzGI6ZXBaoW62k60Uo4QeQOW9INRI
    PHIxhLreMCfGYb5pAfST16yUMtvjQGUZjVrZV3CLmmsAZNS3FvKBwg+y3d3TwDHc9fkFdz
    r8H1+Q/T3JiqTa0GMaXHMntaKmwAK7GyEeWkP6JPLbLLh6xKgcM0FIQtR0ScZU+FXLEJmG
    1b2nK8s57w/meZjr639xo0Y4jnwvwmsbuTbbVl6PngM+BQoBAUuf4JUPH7vcW5GV4XQpzk
    iKFn4ErQlT1N6E2hvHAJPgPYmNnDMuWyQGTvzXuD6IbZvZx9s4yd9j/xdySKmxgdIYz16a
    psNCxv0qQLGndBgeXJyhSW61681K4mHrySeBGcaeHfRPXPWEvUyzp7UOB/OZt+raQzCLnq
    dcjGjOK2jDnORxFD9dvV5n42KU35KLxcfMdDfnzzIXYfFzE23d4KP0qJGWig
X-ME-Proxy: <xmx:V4ueahh--AN2WYxawelciwqEmkHCkgucA3hBDfwLERjuPG7f4w2l3w>
    <xmx:V4ueau-9_emlXXGy-LHtmhsrmni_6FGq5kt3SQybhRLjdNZp3t7blg>
    <xmx:V4ueajCEmpFirJObCQ2cj7_xdZhWKt1eWN51pO4JwzJd2u1S3--KXw>
    <xmx:V4ueajIbYinpN06r6Jols6CoUSxsZKtk0CW21FB4AMzUv6-0MOL_kA>
    <xmx:V4ueambkThKwoU0FPYWvlmwFnnjQaVV_lhXvGpO6Lan9T_iaEgnUzvAK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 06:00:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 552e1c7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 10:00:53 +0000 (UTC)
Date: Mon, 7 Sep 2026 12:00:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/11] setup: rename ref storage format environment
 variables
Message-ID: <ap6LUs6-5h0oui3l@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
 <20260904-b4-pks-unify-ref-storage-format-v1-9-08144e5004ff@pks.im>
 <CAOLa=ZT7WQ-J-i6n_nqm0MtDypm3V=3jyG6y6a8U=EvicMqgow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT7WQ-J-i6n_nqm0MtDypm3V=3jyG6y6a8U=EvicMqgow@mail.gmail.com>

On Fri, Sep 04, 2026 at 09:20:30AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/environment.h b/environment.h
> > index e7ec5b0437..e6b933f8db 100644
> > --- a/environment.h
> > +++ b/environment.h
> > @@ -44,6 +44,7 @@
> >  #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
> >  #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
> >  #define GIT_REFERENCE_BACKEND_ENVIRONMENT "GIT_REFERENCE_BACKEND"
> > +#define GIT_REF_STORAGE_ENVIRONMENT "GIT_REF_STORAGE"
> 
> Shouldn't we also be adding and using
> GIT_DEFAULT_REF_STORAGE_ENVIRONMENT? The rest of the changes look to be
> in order.

I refrained from doing so because the other variable wasn't listed here,
either, so I was mostly aiming for compatibility with the previous code.
Happy to change though if you feel strongly about it.

Patrick
