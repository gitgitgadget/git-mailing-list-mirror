Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8665279C0
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342878; cv=none; b=t9JI7g6wiD7z0W3wbw6gJCW3Am/qyd4fpfGWewcZwzXFD5GsT85JuNvei/aSNgONBjUkiOiDV4bqLW/oFtFhVvVmu8w3/K+N2TjcJ3nbjjb3SoHtrH0uuOl9YIRNAq/n+vNS3mF2Sf8YcEyb6iZBVZ/eYYMI30H3yI60217IiPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342878; c=relaxed/simple;
	bh=nFjVbHLY1rH6kbfLaKeKPSseULS5Cil49Sww8NCtT90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyA3UrzqIFgCDmgxsH51U7WzeBxaGQH3GpaisEpkPbgxYaXaNcGE6USIlvcCnIP1rg6tnIoyR2/XF2iPOhnCwoNWMgqfgs+sq+f1Ym/BVlHwvQe58C7PDMnQZDtlpsoh4QkcZQ2U8Uts+KyZ/1GdywGt9yHtsibST87Y0z5NrYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=utqvRQWK; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="utqvRQWK"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c547932d2eso391119685a.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742342875; x=1742947675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nFjVbHLY1rH6kbfLaKeKPSseULS5Cil49Sww8NCtT90=;
        b=utqvRQWKZWSc6Z60Mv9w4Hg3k+CdShse9Sfvfumq4tqzaoCtFmphJuX8VbWz8milT9
         IcJ3FtAjDDMbU/7LmEARZui+0LnNwAqhC2YqI1OBaa+yTekTW4bTDIxwvEVt2MPBBCeY
         qajthL7wBl6x4/VFP5yyjUyT8bzKazM0MiNl9ipiA6wTnjbF/4CZjvJriTKFxHdEbii4
         IukNMOLbJmNL8Y4L/CLSX4Avt70T8ugzH80n2CG0nvYyq2wtSl/JS97l2zoL9u409oi3
         7o9RhjKkCJbqM8Y3nxGIjA3Jn2kR8WM9yIx/cR6m9qYADKkP0d47YUCkZ5ktZZ2IR3Ov
         bGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742342875; x=1742947675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFjVbHLY1rH6kbfLaKeKPSseULS5Cil49Sww8NCtT90=;
        b=ozuwAF9sy8oMd86IjU18njxAD1rIAioVnJUzHOolisqR8hTBYVn/yftyUYJn96K4/R
         SzY3dQxPoW5O4v5I4Ni6lgQ3mV2BfJKWY5J52t+MnEL1gTXh2+nkwrNR63Pz10TC+qln
         Sv/Uzulio2BW8g2HAQFfIj9p+qi/NGwfoZmhF+y0Qv4uLZQoMCl0DnPsbu/w8DdgSRuW
         K7uKeQrCAHU9I4bgjstHNG8DGtCtx6mHFnT9ZAxJB8dHfX2OAq19O8+gfCTDkwNLSV2C
         nPzEVqhyI0APMjirfLrgcac2WJLE0ZMak7WSGpxI4Q3AYWboUNHqd7jmV62waMJQmcph
         nKDQ==
X-Gm-Message-State: AOJu0Yyz8WkSf2nyRv8c3fpqWOm2SZnKg2PxmoVDqqTvTIqzPbI5KbWB
	LElm2IIzuQrfsNQLFmfrw5ETrPCWzHb3XdESahDltjbCnp90ZWBc+B6IkWiAicDC0BrrE/pW9nx
	AruA=
X-Gm-Gg: ASbGncvQRND6ju9abkwVwebDgZqAHn685FWa7wTb4DLYFdozeMzsFpUMpTUSPI22IOh
	LwmkKEDdFpz2STbH4pbzuRI4PV4z7JKfkyuZ1NUCWHrWzoCGQu5/QYrWlMrTjZmpB+/Wg42vpYO
	2DNQbLsCaRuh8wl1ZtQ8UJsdEpKbv7p0TeuvJQF0QfR9BZOXv6unQQraLiMMLYRBGih/h+Yw4yv
	Zvh1VaAbWtpxhqWeH32Sp70d1Nv1GlG6DAUEXqhKhEN15D6yzvm7hZbcqv69FvA1QpQ9mq228mC
	yd00+s8uixjPZGIieiqWgizEgpmvtKEqY9WRlto9pX3PxIRZvvwnNgn/1EeqtvAWWWT3hMm5rRz
	2Otks1rtxbIyshRel
X-Google-Smtp-Source: AGHT+IGW9YUnLPe6YCpOplJZh0N9rExN4YhTtMQVtqFW2u8gvuMe36QrcbUXUDxdiyBtFgB2gztEog==
X-Received: by 2002:a05:620a:3903:b0:7c5:592c:c27 with SMTP id af79cd13be357-7c5a83d9fb8mr104196185a.21.1742342875361;
        Tue, 18 Mar 2025 17:07:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d8ab26sm784282185a.110.2025.03.18.17.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:07:55 -0700 (PDT)
Date: Tue, 18 Mar 2025 20:07:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 02/13] pack-revindex: prepare for incremental MIDX
 bitmaps
Message-ID: <Z9oK2XBF9plTBbnl@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <f2a232e556a066c1a5083f02584ddc3637ecfc48.1741983492.git.me@ttaylorr.com>
 <20250318012726.GB1471939@coredump.intra.peff.net>
 <Z9oJoZdfyA4eAbeD@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9oJoZdfyA4eAbeD@nand.local>

On Tue, Mar 18, 2025 at 08:02:41PM -0400, Taylor Blau wrote:
> > I understand why we need to account for the objects in the base to
> > offset our total size.
> >
> > Similar to Patrick's comments on v3, I wondered about why we couldn't
> > just modify bitmap_num_objects() here, and why some callers would be
> > left with the other.
> >
> > I guess sometimes we still need to consider a single layer. We can't
> > quite just access m->num_objects there, because we still need the midx
> > vs pack abstraction layer. I just thought there'd be more discussion
> > here, but it looks the same as v3.
>
> Right; some callers care about the number of objects in *their* layer,
> like computing the size of some bitmap extensions, bounds-checking
> pseudo-merge commit lookups, or generating positions for objects in the
> extended index.
>
> I'm happy to include that discussion somewhere in the commit message or
> as a comment nearby bitmap_non_extended_bits(), but I'm not sure which
> is better. If you have thoughts, LMK.

I renamed this function to bitmap_num_objects_total(), which I think
more clearly distinguishes it from bitmap_num_objects(). If you have
other thoughts or things you think I should do in addition to that, LMK.

Thanks,
Taylor
