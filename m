Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828941F80A1
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020453; cv=none; b=IRlC/8LCYprTjR7iHXoXR82MV7jIhUFzMw/X41s7XQqju6tkPvE0IJUF25c6mR8aj1R6GN++nD3qfs2nB1T46b/qfLL/sdVRdq0Q1OQkNiTV67aRDDzAieI7wWojOJ4+V/VCCKOFrD6g6OjRWLJYCHn8LmLyKYGIHyvq04IfM3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020453; c=relaxed/simple;
	bh=lYwhcAqrrMRCjhLzWiM+zS6vDrRHMkqpKEpj6LVHouk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmNbknaK5CBqV4wi3+HWvgrqUvFoq/QhmDpMAkToDhMSmbaS4sWe9iNqg4yyt6Qirp6P0GkRWPAgNfQ4GvUciPcQLUbnCb0sCd3753QhbZpkkznVbenaPRdjiTajZjD8C8QQNwX0kzfF2M2sPPboA7VgYn/wK3/KaIqx8EIyTxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Q7ohLQyC; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Q7ohLQyC"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6db20e22c85so44374897b3.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 12:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729020450; x=1729625250; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lYwhcAqrrMRCjhLzWiM+zS6vDrRHMkqpKEpj6LVHouk=;
        b=Q7ohLQyCoUB9G2OPcLl2FhNl66SXwuHC0XQlyrR+qrvMVR4dB5FbPdhiBV8YhaTKKO
         SqNHMqdoG5XQocCazyNHCneTE6M7IKd/8yPfprKiKE7AaYjovT+wM8l1aZRg8zCkeg5J
         8EAbbHdU2ek0brSB5btKJsjn0NijuJiewmxnJcozNWgwobMh/YToUCnmOKbelJBjlNax
         WD6IeMf7JFQfLAN+Tk4Le8/WqMuQUcbSqKNc9SQTB4AXJbqOMQa8tFiWLdlSZeWrDDbq
         Ny0s44GJKJZz8t+k1MJP2I8RiiLnlslfPwsgs6++JtGGwnpKlek2r/5RADlfltN2BquS
         oBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729020450; x=1729625250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYwhcAqrrMRCjhLzWiM+zS6vDrRHMkqpKEpj6LVHouk=;
        b=RpalCMeDnvKdLDRQESf4Le1qqNlzMD2Bb57u+FtitjdMq6itXvUauJFNv5td+j2jph
         TRk2oFAj2F4+VHY0UnV3BRGz/HpgWvU8dJKJ8+cQU9cNQ/n5Hksisjo0tyG4PjDWn85A
         foucBoQ6Sb9fEowLfn4867zrjJc5WKHlxp/KbVcQ/YaTNyhEgJkL0NWiZQ9YE/Y+jKmg
         TSCrOIPb8ze5zT0oB3etQTlPWUz76PiCyRjOuXJLaKgKnlwc2CUrsZfJJIAeyrXrJJs7
         dHXpZ4bbxJFl2KpMwQKijWs0D58nql9eI3XCcblK0WkyEqaVnV9li5wcLJH7eDqFEe12
         wWiA==
X-Forwarded-Encrypted: i=1; AJvYcCVu8Hb1cN1b1A/MztyxkjAjzic9DVQ9yPPcHaAOUBf3b0c7NC2LJ8EwMb6vDL66YKLNU+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfsVs32KxjkxxNTyVEPB9lQi4abAg0SuK3KwjEcA1yF3jggml5
	09f7XYVuNXV6CKRVt072CmV/U8UC1321cLtvnZV75KArpoOzuWZ6YGe0qSt6axo=
X-Google-Smtp-Source: AGHT+IFNtbJs0mCGJSqn3sF6VKJEuNt8908gJXpGQQdPJHAIDm1JgJZMXauZI80sxOIoZ4qbmw1yKQ==
X-Received: by 2002:a05:690c:3504:b0:6e3:29ae:a3a5 with SMTP id 00721157ae682-6e3d41c6e62mr21277837b3.34.1729020450475;
        Tue, 15 Oct 2024 12:27:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5b8761dsm4095107b3.73.2024.10.15.12.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:27:30 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:27:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 03/10] reftable/basics: provide new `reftable_buf`
 interface
Message-ID: <Zw7CIRoXrLr5pd5A@nand.local>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
 <0ddc8c0c896a006e4cc094390125efcec0b3cdff.1728910727.git.ps@pks.im>
 <Zw2cjxpDf6MowCP+@nand.local>
 <Zw3xhwLFlznU_JvK@pks.im>
 <CAPig+cSXJaETg4Sq3Zw8=37M15CdLEUkdMb2U2X4NPSOAFwmyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSXJaETg4Sq3Zw8=37M15CdLEUkdMb2U2X4NPSOAFwmyw@mail.gmail.com>

On Tue, Oct 15, 2024 at 01:10:59AM -0400, Eric Sunshine wrote:
> On Tue, Oct 15, 2024 at 12:38 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Mon, Oct 14, 2024 at 06:34:55PM -0400, Taylor Blau wrote:
> > > On Mon, Oct 14, 2024 at 03:02:24PM +0200, Patrick Steinhardt wrote:
> > > > +/*
> > > > + * Add the given bytes to the buffer. Returns 0 on success,
> > > > + * REFTABLE_OUT_OF_MEMORY_ERROR on allocation failure.
> > > > + */
> > > > +int reftable_buf_add(struct reftable_buf *buf, const void *data, size_t len);
> > >
> > > Is there a reason that data is a void-pointer here and not a const char
> > > *?
> >
> > Only that it emulates `strbuf_add()`, which also uses a void pointer.
>
> The reason for that is because strbuf is a generic byte-array which
> may contain embedded NULs, and the `const void *` plus `len`
> emphasizes this property, whereas `const char *` would imply a
> C-string with no embedded NULs.

Thanks, that was the explanation I was missing. Perhaps it is worth
re-stating in the commit message here to avoid confusing readers like I
was when I first read Patrick's patch ;-).

Thanks,
Taylor
