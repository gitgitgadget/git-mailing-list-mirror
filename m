Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7962356B9
	for <git@vger.kernel.org>; Fri,  9 May 2025 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803005; cv=none; b=DLu+b3+/IbYVOSHEHX/8ppuf/I/0s0WYGWXGmomqKUxNoz5/Fy3shvvDT3XKr4ODBCfzV58iUmz4Cu26zOnuZaFu8UFLSIXQ+izSKqiPfP/VhOBcHHjiCKShjcivE2QYuB1woFlw4dscJx5YexkI0aRQ2I6eZzJNFRNSPvtxj5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803005; c=relaxed/simple;
	bh=ak8BxMnzdp+0lAHwV5zexIUwkAJjSlTCEcg7XmhdsnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OY88Omxshyc7pr44jL5yqxmnW0wBmC7YkIPwxB3WVLN/DvFeo0FvAk4khDUhedTiun0sSIMFTMWhI6mipwqueG+BqbPVCOjs8+rFHUuvp/VpKiwsdZ9wqxUwvxBXZJk5hxTwcoFWcqEfrEWg0UlQZvhpgwtvAI3YLksEQNayd8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO7QQI2n; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO7QQI2n"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7418e182864so1520577b3a.1
        for <git@vger.kernel.org>; Fri, 09 May 2025 08:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746803003; x=1747407803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WQiFFuScfd5dCfLqbIMvHH7iiUCGOPigyCmpeTdBJgY=;
        b=fO7QQI2nqBQ/0n+bbJEEGEoYb/6LNEE3sRJcr6AKyT2LuDpUw+o9WL4I5k8t1BQ4hv
         vUi2X5Pl7WplYVYupadrT09n6ixSmC8M9APVzdY/+8MxGlVyLW4gKV0VzqWiGWjtWsfq
         HG5brxdGCe6FDfrvKA0t/FC4kTaaDHkcTCBZvBJKUeoB6HiBnh7dZ0QmfX/DXuWT9FdR
         h/adVzLCp5NhA5+WqOS3pSZvZiDJZNK4AcLdFpfnwy2Za7H4uRGtSGj5f1kmjOEfz5Tt
         3A7CC88nD+3BHJZ+18FgLxP0Vl6f+AY7BmIDbMTP4sb8eLTGRV0ktxhbaY+63nCDvHSy
         kLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746803003; x=1747407803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQiFFuScfd5dCfLqbIMvHH7iiUCGOPigyCmpeTdBJgY=;
        b=NvHApFam0P9EFb+w+8CZG2pazivYjp2kEAIXfsjFiiMe7PC0T3bLHu/fLCJQni5ae9
         U1GY4wxz6Hov+LlGMOymS3I1JiHLP7aFKtYwWxbFeNB0WaZoOnpmMnfZnf4kNLOMD9/X
         FAzRIUo9NOUHUeHnFXVNhqWn69VylUnlNonUx4tzxrYZ1a7/DwXHrjbL5bW/HfEQzLCa
         KFKt8ZpJL66LD3GyF+EwOLvliNFcSkNX0s+zxmf5KnzJ1BMPeZ224zmijkPXOqoRI/1S
         Z7oLmLZtPg8Es2c/uvHGBT4hH8zx6X0UnfCzOABpobb3HV4Hr3uMPxpgdtwPwwCE1+LD
         onaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8jAN1jeDEvhtZtXlC3BjGv4uyC/0HfukdIj/H9oOf3l+9rqtw4t738ngP+KzaixDUPSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQU+QTZ+OKP59NC/rlxokScQjtmrLb87dtkj/k/MDVhampxdY1
	tBvPmUUZ+x/xaETraIpSXA6AkVH26Lg2eMsmqUxuk+/ne3cFxM7KXgunZTVH
X-Gm-Gg: ASbGnctYaZomDthRH0Hpdl9ZoBQHEuVJvO+E6u3s2wbALYOXukDlzUsex+iANYWIcIZ
	Rr8FB+fOPqLaxl/VB10WkzWqqQrta8rQdgGbHkjQ/Jy+IzIr5FiLD4q9XFdda1IeoUaby+vRDtR
	3ij/oNdSjFv0H/7NGpaWgZ7S7StsOHOc8rluD9BDeQTG52U3kdVEaJ/ALhdK41hdKJbG157sFxU
	V8QzfmBHcmqboCRT29vyW8kzFg6chts8s2GU+9g3+ndsh/OCp/xZJc503zyhg1slqeAStXQ4stU
	aRlA7b0zXoOBkfmINmWosKkp7NwPM3xOjCrTVhPDDySIUQ8=
X-Google-Smtp-Source: AGHT+IFDOWrcBkPH+W0VfLlAw1UpUkQTvMUSQvt0pq2QopNzCw0XU2MNiyzFnqsjL3c9nl/WhDS4jQ==
X-Received: by 2002:a05:6a21:b85:b0:1f5:7ba7:69d7 with SMTP id adf61e73a8af0-215ababbfcamr4804060637.3.1746803003169;
        Fri, 09 May 2025 08:03:23 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2349dd1fcdsm1358602a12.18.2025.05.09.08.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 08:03:22 -0700 (PDT)
Date: Fri, 9 May 2025 23:03:19 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 3/4] packed-backend: extract munmap operation for
 `MMAP_TEMPORARY`
Message-ID: <aB4ZN5IY585Qlz9r@ArchLinux>
References: <aBtzn4nwLsI9p5Cp@ArchLinux>
 <aBt0BDTuOfUuCHE4@ArchLinux>
 <20250508195714.GA18229@coredump.intra.peff.net>
 <xmqq4ixu6f6q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ixu6f6q.fsf@gitster.g>

On Thu, May 08, 2025 at 01:05:49PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> >> -	if (mmap_strategy != MMAP_OK && snapshot->mmapped) {
> >> -		/*
> >> -		 * We don't want to leave the file mmapped, so we are
> >> -		 * forced to make a copy now:
> >> -		 */
> >> -		size_t size = snapshot->eof - snapshot->start;
> >> -		char *buf_copy = xmalloc(size);
> >> -
> >> -		memcpy(buf_copy, snapshot->start, size);
> >> -		clear_snapshot_buffer(snapshot);
> >> -		snapshot->buf = snapshot->start = buf_copy;
> >> -		snapshot->eof = buf_copy + size;
> >> -	}
> >> +	if (mmap_strategy == MMAP_TEMPORARY && snapshot->mmapped)
> >> +		munmap_temporary_snapshot(snapshot);
> >
> > The original triggers this conditional whenever the strategy is not
> > MMAP_OK (so MMAP_TEMPORARY or MMAP_NONE). But in your post-image, we do
> > so only for MMAP_TEMPORARY.
> >
> > I can guess that the two end up the same, because snapshot->mmapped
> > would never be set when MMAP_NONE is set. But if we are going to make
> > such a logical inference, it should be explained in the commit message
> > (though my preference is to leave the code as-is, or to pull the
> > refactor into its own commit).

That's right, I made a mistake here. I somehow think that we should just
check whether "mmap_strategy" is "MMAP_TEMPORARY". And this would be
enough. Because when "mmap_strategy" is "MMAP_NONE", we would never call
`mmap`.

Actually, when I refactor the code, this one makes me quite confusing.
And I think we should not change. I will revert in the next version.

> 
> Good thinking.
> 
> An "extract" step that is meant as a preliminary refactoring should
> not make such a change.  The change may or may not prepare the code
> for better maintainability, but I agree that such a change needs to
> be justified separately.
> 

Yeah, sure. I didn't consider well.

> Thanks.

Thanks,
Jialuo
