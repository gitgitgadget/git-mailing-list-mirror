Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF82F36B
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342915; cv=none; b=cjDKJd8mFGMgxC4SOuH8ezB+dakPKlK8Qd63QsE3/ZgP7DYkLQRoaFDZlDdTkxhpBQ4M9FUO2lVaC3q31RWin8FShpm0xAoRWm3ak/cUG+x1+ZjdeqdVBJxF5jA0EfLsC3MHeevUIbP5GOHKrGRxzgUoUmTg8MugoN0/bCmTD/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342915; c=relaxed/simple;
	bh=G6s0nSIClc+5bAY6q+IQNGjFGIE/Gamv1S0q5NhnNzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYKrh3SC+XNnsSfyIK8Ibc1uu50f15iMh8bNH92dniWBTcEjOtv8Ac6XU/NKKbylC+5eWqXIVuVt92y8dsJl5/dOznnKUoyt2ZTbk5Duz2cIcOUV0WZOVeR2khD6E9V3I0VupGCUkfF+jGN5Imk4ae5cqpo/h3f/efqpa9pZYrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Px7sSlvc; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Px7sSlvc"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dd15d03eacso1847186d6.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742342912; x=1742947712; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G6s0nSIClc+5bAY6q+IQNGjFGIE/Gamv1S0q5NhnNzs=;
        b=Px7sSlvcZcfN+iOS8aVOBO4T9rq1V0C2ekB7QEgtJD9iJgybXV07jPSEJYUzb3dLQ1
         8+ZlyOtprrSe8/J2P56iCj31V5TLX8sTjMX8E8vn6BAcDracvdSzVJT5cJYftd9yuwsd
         R3s4Yt7QGhJlXC9ujgE8EVhFXnIo6zzZfB7zSXGV3YGDLCbjdROWsVmDAXwt8AV29mUD
         MHFUXs+AG/Hh6jznkDCtvcixFqMMJPIF2Zcr8XOFMCzpGVe18oWXF0DzRnQx9i7z+mSR
         FQWht4zuZpWSXItsNw1r/zdHA3jNESG0L1cG/7APyeNH8ujRTT0JgoUdxPaz+o/whyHz
         YW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742342912; x=1742947712;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6s0nSIClc+5bAY6q+IQNGjFGIE/Gamv1S0q5NhnNzs=;
        b=gR5ZKXseWh2tSuaTWnY+iGKSLnXma71aTtsEMvnQDllxMxS5+QqIWvoSjGAvcKrIhM
         /vu0NNjc7uSS6CeYWx7E4O2UidFkJ23cfTonEfaghY36t0ogtyAeS57UefyYY+2D74Pc
         WQkaiOouzMZ32btyR+2ZlOPLFr8PqSH6e9cNG1qSEVIVlRs2nV9GMhDxywKfOHkvkYN7
         GxUf/tqjaw93jbb3J2n/AQ4zQZBMMvZnTL5bFInrRTLigMLYyBkp6N6eY3G5cNSln85Z
         ySvj9t8jbQqgpsmuwqoEU+MeIl72eEDLqEpupPB7kXM/l1a4lonIY3Ns0k6EMXPQ/CAr
         mCAA==
X-Gm-Message-State: AOJu0YxspyNPWvN1+TZde2lhZs1ScN+iy/ax+HWhovSX2qpH1Nt+yE98
	LxHEReJWuV6u+nPeBhvd769FFyoyhPEIXkEHQhiodqFphVd0WVdNkAZmacXm/WlV2hTEN5byMFG
	4evY=
X-Gm-Gg: ASbGncvy4ElwPYezHqwR5jMHgIStIHmNwF2VcvSFUH+eWu1hKJKrxUll1qZn3tfIuxy
	YudXCUG/EcEtqj2v8etaAUI9EyAOOlPRyE6ad4CadGmqX37ZxQbJpM3YkDFjTGOCnlT1COrKTE2
	8vBgF9Iu5MQuP7ZvtJzhphqBCTK++f8qSwhiw+TZDcxYSh3nUOiaCDSy+OX69T0YCKSV0O6ddTH
	BIbksmHD/MQl1YKtT+2AK+YhNhhk0uC8qblMaxKoZcqipNDO58JH9mY0Po037cGLb/AjPWXrIWK
	HrsCNoGGDXh/hYWLwwAPKvekWzc3548BAjy2KzpnnyPSfx+uATyWAYX5t7MV/9ZJEYxBa+1H3vu
	rxFvacu3kmkcp1vS+p77kNTOHV+o=
X-Google-Smtp-Source: AGHT+IGSDPm8JA2X2jdxHisHZgq3enoMi3BI8d/HCYUVU0nI5h7+9Pu0IQG3XC7ty3KBYjEZ/rnanA==
X-Received: by 2002:a05:6214:194b:b0:6e6:69e4:825e with SMTP id 6a1803df08f44-6eb298649b5mr12998986d6.21.1742342912712;
        Tue, 18 Mar 2025 17:08:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade24b8c2sm73176076d6.50.2025.03.18.17.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:08:32 -0700 (PDT)
Date: Tue, 18 Mar 2025 20:08:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 03/13] pack-bitmap.c: open and store incremental
 bitmap layers
Message-ID: <Z9oK/7sn0f4XtQUb@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <aca0318fb12499ea810d03e66cc3145d682f5098.1741983492.git.me@ttaylorr.com>
 <CABPp-BHXYzMR61C=aX4yNn4QdgZ8uMtivg33oAN_eC3=J1U8kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BHXYzMR61C=aX4yNn4QdgZ8uMtivg33oAN_eC3=J1U8kw@mail.gmail.com>

On Mon, Mar 17, 2025 at 09:13:45PM -0700, Elijah Newren wrote:
> On Fri, Mar 14, 2025 at 1:18 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > Prepare the pack-bitmap machinery to work with incremental MIDXs by
> > adding a new "base" field to keep track of the bitmap index associated
> > with the previous MIDX layer.
> >
> > The changes in this commit are mostly boilerplate to open the correct
> > bitmap(s), add them to the chain bitmap layers along the "base" pointer,
>
> s/chain/chain of/ ?

Good eyes again!

> > ensures that the correct packs and their reverse indexes are loaded
>
> s/ensures/ensure/ ?

...and again!

Thanks,
Taylor
