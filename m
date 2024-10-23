Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC792AD20
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714516; cv=none; b=KVAxIZu6+WaM2G5GPYI4LdObcO7FTpySl/lMcMRy3AG6SA9nasOIzmtbFoY4LkTnfvODL0v/6He+irZg/c7Gur2ccAdx8WpQ0IL2DLH7KcdKE8LtFqBjjrQdiL2/yd92Ud+f2SMCpdsIFtPf8wqj4aCN7TW/vT4h4o7aTK4HksA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714516; c=relaxed/simple;
	bh=Jq3LPhvt8Gh8CQqc6OvD5nEYOwySWLQPL0w6zGljXPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yk5AzH7BFuIhTlI2YdD+XclfBPeWXd1B2nOc6z1yDtTDLpKnzuM+yYed9suQpYHVIxGaoo7U6ttQDQD5+EcSj+MoaRx3cDl1FDNQQw2XpD+9Um/CYm4YXEx7g8wIKbsFsZCLpqeExDA1QDTB672qsC9wTBB47O+09IBseSPNyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Kq+tENNo; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Kq+tENNo"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e5a5a59094so1394107b3.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 13:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729714514; x=1730319314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fevQZDABbym91GGzVI8Ky5E44jzIGdXcXvgO/KVbVS0=;
        b=Kq+tENNo9U0gTYQuJrGno0EXPVt5E9Cl5lIhzHjAMQplYAMy4nCyoBhtOryPA9B2uw
         rKA5AUQtRKmGcCqi/DYAJkY4u/ms6vc4c3E0cLCMj5QQnqOzzgq4WQ9bCBK2qcyQvKnr
         vXGTpDMkGj7/ARpfmqzvsRdhUmOGlT4yg0rp6OVH9fkCMmdpMAQDE+qhW8kl4hR5qnkP
         4ZIntSMA5pRjZGAcR8WhcMmsg1XWdfCiXg1Kg3lPEzVPsmgWwXY2BUSo7GzCX/b1Ry04
         pwGvbO1e9zsoYQpxXpdiPtKYYBEoQxqH3anV/Vm6M/q+3NIQfYoRMw+tC5U2VlUYAv7z
         rGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729714514; x=1730319314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fevQZDABbym91GGzVI8Ky5E44jzIGdXcXvgO/KVbVS0=;
        b=uoYPU1qLCvIU7bC3PJ5UngJCIgyxBspVbtFRMKruCuo6SurY7uk6qkv0Nj3nLAnNob
         9rJbG36RfCViwdfSgixyjg2pmJPZqY/W9ZCJZjYD4RXA/uV6Bin1gLuOPtJjVs+SA8yA
         K8ic9yIL6vfercQUU03laKANUIceucAsqt8Ap3ixiC/SjAJbtHRn40rLMSm/fRJPnKbp
         78lfjvMfYInYl4OOYjqKDIq7uUGnkDX9zI7wLY0j8Fik+nqH1OfcfOCjTU0e2UT6XQud
         jukYMpsLI8/wc6Ugsz1SZKHcqbEawxUBX+8yk8R4Cq3H2kZHS9ZOeAg20BR5MMzkECjv
         ZNCg==
X-Gm-Message-State: AOJu0YwB3bwyRVMPaMENIaIkCHHJMF1lwl89Z/Hmr9ksWxRE4QSs+VE5
	Jppj70Rgj4TOF5nyCoQM2mT22GBjwRa46ITIYTWF0dg7OH37ow77bTmfxYQOMC4=
X-Google-Smtp-Source: AGHT+IFbQLiCPXZm6363sZAxZxrjixiJzFsU7eyNK0fhwSPzsijeSFB98v7v4VL8/sufhgCaGXQsAg==
X-Received: by 2002:a05:690c:b:b0:6e3:3275:8e5e with SMTP id 00721157ae682-6e7f0f79677mr43363307b3.33.1729714513903;
        Wed, 23 Oct 2024 13:15:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5cee7f6sm16558727b3.105.2024.10.23.13.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:15:13 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:15:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
Message-ID: <ZxlZUP5uZtjZxFoU@nand.local>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
 <ZxLOlx69KQp9jXDF@nand.local>
 <ZxjmQQ3MxDlaJid7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxjmQQ3MxDlaJid7@pks.im>

On Wed, Oct 23, 2024 at 02:04:17PM +0200, Patrick Steinhardt wrote:
> On Fri, Oct 18, 2024 at 05:09:43PM -0400, Taylor Blau wrote:
> > On Fri, Oct 18, 2024 at 02:23:47PM +0200, Patrick Steinhardt wrote:
> > > This series is based on 15030f9556 (The second batch, 2024-10-15) and
> > > has the following dependencies:
> > >
> > >   - ps/cmake-clar at c6d3e52c91 (cmake: set up proper
> > >     dependencies for generated clar headers, 2024-10-15).
> > >
> > >   - ps/upgrade-clar at f3501edb0e (Makefile: adjust sed command for
> > >     generating "clar-decls.h", 2024-10-14).
> > >
> > >   - ps/platform-compat-fixes at 80ebd91b83 (http: fix build error on
> > >     FreeBSD, 2024-10-16).
> > >
> > > These deps are mostly just there to make tests pass on all platforms,
> > > but I wouldn't want folks to go test things and discover breakage that
> > > is not caused by Meson itself :) You can also find this version of the
> > > patch series at [1], branch "pks-meson-v3". @Taylor, I'm fine with
> > > keeping this out of "seen" if you prefer to wait for those dependencies
> > > to land first.
> >
> > Of the three, only the last one is marked as "Will merge to 'next'?" in
> > the next integration round[^1]. All three are in 'seen', so this should
> > apply cleanly on top of those.
> >
> > What is the state of those first two topics? Are they ready to go, or
> > are we expecting a new round for any of them?
>
> These have been merged into a single topic now and should be ready to go
> from my point of view. But they still require reviews.

OK, so: ps/platform-compat-fixes is in 'next', and ps/cmake-clar has
been folded into ps/upgrade-clar. Have all three have been combined into
ps/build?

If so, should this topic be rebuilt on ps/upgrade-clar so that we don't
see the same patches twice, perhaps? Or am I still missing something
here?

Thanks,
Taylor
