Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0F83DDDA7
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990052; cv=none; b=fjTz/27tos/Em0hv6rs1dpJHBTa31Yv7wlkpJ8i4MB2JZ6h3Kxe6TL5HSDKD0i3NKShLUByNPrjiEm+qJXWy9Q+CcFB07MuZNadCVNUib9a4Jp49BVIXZfT+kc6iYezLVyzJOjHA7pE9eT553fqfO40XbXFFfTk0oZ4b/hBT3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990052; c=relaxed/simple;
	bh=BlGqJn39EOAPwrYm5TIjFeJ6FDQ5mO3SAyNFpDMBcck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFHbq6AHRWPgVSDip9aOjWTfTle0yUaTHVAu1BeNFIkQwJWWmIkswwLuvW6Xi6+xuKydmtPrqdTRp4OBi/X2/94g2YbAtB7VFMwlPQTKgz74//2yIGX/b9eCRv39rOgqT/H8FECLeWC/SKTV3To/E7c2qSFd7pAT4rQ7vTMHPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E09XYu7p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Io57DXBz; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E09XYu7p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Io57DXBz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 038AC7A0166;
	Tue,  9 Jun 2026 03:27:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 09 Jun 2026 03:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780990048; x=1781076448; bh=LEXcTf5bfi
	1s77Z2N+jCuzBq5j7y6fGXij+iVtT28Gs=; b=E09XYu7py2PJogWk1h84XDAYya
	dKSRvdWceNCF+z5JR+bqkK/Z4fv2nyOtmj91gPeRQlQM2+/JA9pYjRXyguEQrTBH
	pa/C5t4lWau9YZrytsm+2F6qosMKY64PxLsto5RfAl9aAlgn6PFQdynyPmENC7Eh
	kolLWqw+zfhbynRwH725K7Dw7KdFgdMRTL1pQyoOkp1chBn9Yi7C+oLKW0IFicjP
	B4zcsAc1yMRdNQoaayIBlVbgAdoBXFLNWlNThmnf3wNRsPavLTvFjJ4OkJKxk3mV
	Thr7t2aRcivuVT5ys7clPC8RcRfo5t3Rv2fWdbM9UUkiH5IEce7iP39t6XFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780990048; x=1781076448; bh=LEXcTf5bfi1s77Z2N+jCuzBq5j7y6fGXij+
	iVtT28Gs=; b=Io57DXBzF9VN59VlC7++w+gccpo7xSQpsf3RRPdsbv3sqkz85n3
	WSHMfYXuxHCN8jdAbXMV6peimuJU6SbhkdsIu1S92ie7x7ttaqjWg6scBHveCDrO
	RB5BC8O3q5AfojehB8R0AmqKAvuYLk4zmgT7pQco7yjqwFLzdOkAv5C/YjYr395k
	HSw5yk3sPmUYtavI9coVPtSs/cINatcsEnTTmKEjdWq3Ue5hZyu5mqOfxJTTxpXE
	C668yxLdDStpOk4u6LWzAzCS9vkmtDDfB6x/g0cawzHrMca84J9kYTMl0htU+X3u
	XEB8q78g5NZnmUmIHWqR+8mShsMvZRuNUHQ==
X-ME-Sender: <xms:YMAnamnx96UiGiekK3sJGUuVsmTVRfxeFoRyIBPRU9du7UvZv3Q5hQ>
    <xme:YMAnaj2_1eD6w4OjdbI9lBvAdTemtbHavtUEn3szitvz9hxzXFU1sKEHlmZVi2F1i
    RsNynC8qxG5KQuegkiFNqVQ5L0Kxp9mJak--01C3Ia0pbmBUOyazw>
X-ME-Received: <xmr:YMAnaiQxWCtdzYg7OUezrXcwntALaOxMp3GqDCnjDN2DSGH9nx1mtv4rC8o3K71fVwEnsCnj2JbcKMahDf4OWo4adRGjHGF6j3uAlk6LmY0>
X-ME-Proxy-Cause: dmFkZTE+WiGn93e6aTjpyM1udZTIsILEIP+SMuzxLvAFU5zzzpYSehhDJVkVTdq/uU+Iwg
    avpPTWXyukFYrwMIGwhMWsiePNkRF7jj2GHrDkLERwpQT7lIfyYgfBAi8WaTZv0bNcUALb
    YB4/odYLUPOjvJHTn8qTZlJroTnzCUJzjPoYgO0w6e8gHtJ2RGvVg95G8ZiFsM9YcXyXkB
    mDNnAPmbvXfakYAAOA3rIxcQ991eEt6JQlzG0EK5SKNrIUMkfFgThoHb/MY/iaf8aeZvbH
    bn0vxksPxmNVeyb43q8Sfdq/nO2Sq5OWrHYw9pUt3q+V0+gHL1XGxiYoTTJBl5EC7LiPLL
    5vmni74+iRlaAMq17Wd9xawt8orI5IDi2YpNfy3APDc3fpAYg4tBaJ43w9sAqq2zyYyRdS
    wt3mAy1cM+5MhtTve6tpigv/1gucCPNVqAM8jeCCfJNEx1T7LVlfay838HSySjL8WXuO1L
    ktDVgq0F4cyxuIgJ6BmYcEi95BJDo7avn92TuzIOzyLDdktA7jfW++iyrNtGr8JJdl1Ez9
    XSDn4B9rCNM/ZEAp1MUOXbw6h1iOZ0+nLckhHTtGwHNjaJgYSY55vOfV1g62gGSwHWdnXR
    r+wMRoyGTU8LNQ2TDCNSXhKPfN8cuO06ZnYUnEBv+nMMkqqmC4VlC9aAzvhg
X-ME-Proxy: <xmx:YMAnaluNvV3mSkzMKNR399PQncyY7GFPC51IsQ-jnowVLMzPURp97Q>
    <xmx:YMAnanZvX1qqaA-HP-XEY1VWafQfKXL0IB6tSgPYfMD81iXIUvyoRg>
    <xmx:YMAnaqtkJuu7TeqCGj1ymukKCgE_pxhTGW9YIZ6A85lfPv3vAJT3Hw>
    <xmx:YMAnapExA5EKo3mRpOgFAlXvNyzIFGtzKJtqoloyvzAxN3AtYLoHRg>
    <xmx:YMAnavUaUktql50klniMnaW5mtTR0H9e7zKHgv8lD7iZcyH2ng9-iPSN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 03:27:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8a1d3989 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 07:27:25 +0000 (UTC)
Date: Tue, 9 Jun 2026 09:27:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/16] odb/source-packed: start converting to a proper
 `struct odb_source`
Message-ID: <aifAVpxanV31KUpC@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
 <20260604-pks-odb-source-packed-v1-4-2e7ab31b4b5c@pks.im>
 <CAOLa=ZQst6ucwvtVOfXC6g1ZcP9_UZAwRyAXfQdjL7WcJ6ZzxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQst6ucwvtVOfXC6g1ZcP9_UZAwRyAXfQdjL7WcJ6ZzxQ@mail.gmail.com>

On Mon, Jun 08, 2026 at 08:29:04AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb/source-packed.c b/odb/source-packed.c
> > index 12e785be48..f81a990cbd 100644
> > --- a/odb/source-packed.c
> > +++ b/odb/source-packed.c
> > +	CALLOC_ARRAY(packed, 1);
> > +	odb_source_init(&packed->base, parent->base.odb, ODB_SOURCE_PACKED,
> > +			parent->base.path, parent->base.local);
> > +	packed->files = parent;
> > +	strmap_init(&packed->packs_by_path);
> > +
> > +	packed->base.free = odb_source_packed_free;
> > +
> > +	if (!is_absolute_path(parent->base.path))
> > +		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
> > +
> 
> Tangent: seems like no one sets the 'name' field within
> `chdir_notify_register()`. It is meant for tracing purposes, but if no
> one is using it, we might as well remove it...? Perhaps #leftoverbits

There are some callers: `chdir_notify_reparent()` calls
`chdir_notify_register()` with a name, and the reference backends call
that function with names.

Ultimately though I think that this infrastructure is somewhat misguided
overall: we use this to update relative paths after chdir(3p), but if we
stored absolute paths in the first place then we wouldn't have to care
about the paths changing at all.

I plan to revisit this infra for the object database going forward: we
expose and use `struct odb_source::path` in various other subsystems,
including user-facing ones. This is inherently wrong though, as there
may be sources that don't even have an on-disk path. So there's a need
to drop that field and make it an internal implementation detail of the
source's backend. And once we've done that, we can just as well start to
store absolute paths.

For the reference backends we can already do that refactoring now-ish.
I'll send a patch series later today.

Patrick
