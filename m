Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D660A31AAA2
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 20:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510470; cv=none; b=GDkiUXjBG06fmAIOxcuqy+uWZdTPHcFs2/7HPrQtf61FYOGRt6quVtalzA6bLXw5LqsmyNOAuEvjoheWyhDEbaHeet0iaNvOUZpDXUTovogrT2iXGyOifEcUB1YxpP70d+qlyAzLwFXJ4UlC/vRQLG4DSHOJ+D4uPr5tBmYgwV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510470; c=relaxed/simple;
	bh=mTLg7pcgsL9HXWWFSuP5PtzpPHgY93LzGQt5C3zQLvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POmEHEYdtginmFfP574Rk/qhIWWeyZgrFBh5ThgyKEBryONxjmQaYk3V8KB1H3/nQoPi+fNH/G/WHBWAgfsjdRqRgLixgaEyfgHDPLQFsrvE9NWZg7LH/N8xUbuMVA6eke/AVbBCqDojt1RNohNqFLuW60HlFiHbn5WUv7RRg5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGACzIht; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGACzIht"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-45c8e85deffso396674b6e.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 12:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768510468; x=1769115268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2MbTmlMJSY4uI3LrolOVKVPCQ8gTD5qw9FxDjI61dTA=;
        b=kGACzIht+qqCTuKixfmRLo3DjOzyarH2PZYgt3mOiny8Ebeh2Em9l3NF46KX2VZEhZ
         4cjtQOJMaXO6Q13wPb5mSCJNBwNVJflvkwvb2dymyqygx6lQMpv9jr5+zIOx+1CySOCW
         zL1Fgyu/MLrxyfdijq+DivTXjZaSEpESfk8wTrnm9Ia3cP/d3cYYcPJPMMQg33Pia6Aj
         OzvnLZCAKCS1IWiBboUMmGUjyaWRymlNxh4nlulfDcFvVuO3NBxgb5HWVAPYRLf2VopQ
         fxiXmSin+oPWMd+3cqM5XoWe8yY+BqljgXnbBMe2yBVOpY9MBBqqlbjTNBF0Mrk9bzvM
         6zLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768510468; x=1769115268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MbTmlMJSY4uI3LrolOVKVPCQ8gTD5qw9FxDjI61dTA=;
        b=pJ3aPgF00sn6JcexTEvdbP1g59mrEQTZODcK0oU2rWFSK8xWQvR2ikZ2kllTdSCOCI
         89+I0jiqJdAZa4RS0ZMsHXiofmvv06imAJaPVlq5t7rvJT30dz3RE5o7QmJdicWajhXL
         b9ULacsySrn+sCdI4TOnRVpQFUXkL2cbTl20ZoAvG5+y1ycwy7CkzB3pQKx93p1+Wx/8
         dDRWDeZgbMYfgBq9ANAx2e/KsMw18IEi3t/JICEnRQDl2hxmAsv5t3VIQ/Qlg/Te22On
         dGlBuP9kJ65J6Tz8tlso57PTezqQMA5YIm8JXthebknOWIr+VBbSLFCxMHy5xWTp0n5Z
         CLCw==
X-Gm-Message-State: AOJu0YwUmblZhVzkddLhLDJ4uGp7CaoJFSnLVOghdo6io5IjO5gdduBa
	VNOqV6+9ybEAXMXu9TXBtMQI8hXE94GryJNZOD5tchGQgoEJSTjbmoMuaPwh4Q==
X-Gm-Gg: AY/fxX4i8vO9PLnvYl7ziBkBHcjR8ZQDyX6/tWgG4KMvLOn4zShBy45GrOtGLabrhTu
	gWdGKnFRjs6/oftC5lscEVeDOyGm9JlHip0ropu+V3X5aoUBspEi7qkgpwq5Dq3jRCjSG+EYUv2
	4r9ZhMKXVftihjXjds77GU2IP+jwxcTAAg7y/OpoIlyYpYE6+9k1FnsNSTKowT3elKGuaAoU9Xn
	I0QFMLbKPxGwu/xk1c1gSZH4T2C6ZeOb2TcusP97APZhmdCmCR6EpYamVdS2afKlDcy6ssK+xpI
	VN6+kgXS9e2haXmCey/JcsN6JZeenp8U2GVrBoALtzZKpMulO2PXXCw8jTWNJ1TvpMgLI0m8Qjj
	eNdilfaeIj/Xc7RMq2QVMNxU4ympQdGCpFGgDVSjQtwuT1YdugCX30XyV1Ph8MPBxqXo7zsx2AB
	CRWCex
X-Received: by 2002:a05:6808:344c:b0:450:c7b5:23d0 with SMTP id 5614622812f47-45c9d8a85f4mr264844b6e.49.1768510467618;
        Thu, 15 Jan 2026 12:54:27 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9decac58sm236818b6e.5.2026.01.15.12.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 12:54:26 -0800 (PST)
Date: Thu, 15 Jan 2026 14:54:23 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/14] object-file: introduce function to iterate through
 objects
Message-ID: <aWlSYGIe5izqWwte@denethor>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
 <20260115-pks-odb-for-each-object-v1-4-5418a91d5d99@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115-pks-odb-for-each-object-v1-4-5418a91d5d99@pks.im>

On 26/01/15 12:04PM, Patrick Steinhardt wrote:
> We have multiple divergent interfaces to iterate through objects of a
> specific backend:
> 
>   - `for_each_loose_object()` yields all loose objects.
> 
>   - `for_each_packed_object()` (somewhat obviously) yields all packed
>     objects.
> 
> These functions have different function signatures, which makes it hard
> to create a common abstraction layer that covers both of these.

I assume that the intention is to eventually have a generic
for_each_object() function that can iterate across objects regardless of
the source. Is the end goal to have each source define the appropriate
for_each_object callback?

> Introduce a new function `odb_source_loose_for_each_object()` to plug
> this gap. This function doesn't take any data specific to loose objects,
> but instead it accepts a `struct object_info` that will be populated the
> exact same as if `odb_source_loose_read_object()` was called.
> 
> The benefit of this new interface is that we can continue to pass
> backend-specific data, as `struct object_info` contains a union for
> these exact use cases. This will allow us to unify how we iterate
> through objects across both loose and packed objects in a subsequent
> commit.

Naive question: in a future where we have additional ODB backends, does
this mean that `struct object_info` would also need to be updated to
include them?

> The `for_each_loose_object()` function continues to exist for now, but
> it will be removed at the end of this patch series.
