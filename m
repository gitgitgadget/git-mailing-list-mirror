Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3F02F2A
	for <git@vger.kernel.org>; Wed, 14 May 2025 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227884; cv=none; b=ZSgE57svw8YHpwRoUAKG7p1IOJBy0ZYbGTsEMC9tQ6oKyoSXGzXy+9QBJ+u91rn19hVCTiIYsamtfbplddCcyzW4RGodG4CppW2ygGgSs1iEgrgyvJWiHVd3jxY1dwa78V52hckA65EiaJL7UNv33UThCo7zKljS7VjsVlMT58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227884; c=relaxed/simple;
	bh=SuauT/dNq8K39dux+2S0++WB1m1V+VBWCjix+1FOSwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIkBHgL35h4MKARakn0DJQ25Tb+ODdTBdc7r11BD1xlECG0pcqsDXuyYbIHWO8GMUOb732w1rVbn9KuBXJ9tR2feKvwUvtiTy0l7VF4IrmzMoin3Vl+e1p8o+NrIwiU1AFn8jOYqlhtzjlIo4PhXHGGQeuh6e5b/q1Nslg4dHuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKomoPr+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKomoPr+"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so6786945b3a.1
        for <git@vger.kernel.org>; Wed, 14 May 2025 06:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747227882; x=1747832682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MyKwOV+sANAXnTw8R3FF+VAo+SXbCdus9qH8L+ntv3c=;
        b=jKomoPr+/NlAjU0oa0IHcLZI9N/AtMViBDm1tLaPYmGP6TZtcQ5kO5ZvQZQgdu2OIX
         4HvQFx2+CFd+bhhUxYBkK7JJJTCu2rd1WLE0DYxCZUQKAvSRyANxExb5XSWWDjClip6F
         Ovps/dhfvFvFpiOw9vPRACUjZbzAmccetjK7s7/Dr1LAgkTr1l597fLf22q/EayiXiPs
         LqJHDJWUWY1TROOPe1NaudMsCqIJT8whMeDzsTtWGAWU0u+2OFhuKsdx2N5EOPD44MYb
         ObPT7PddAkTDMC1uqJaIlD19t3y+PBcze5RVR0zRa3IO+U8eRbcSvNRlhqyYvvHLSZzg
         q70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747227882; x=1747832682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyKwOV+sANAXnTw8R3FF+VAo+SXbCdus9qH8L+ntv3c=;
        b=Xs9edbiFe4eikZfz0YkQJtJ3mnegQBa8jDOhjXSigqGXOFkcxwNntnTOQQhrjFKWTR
         vo4AyxbilkjkAvm6MUNssD7YmtBEZF449qSGZXIt6E7/3MFImYNVVcWFntHU6r/5Ih49
         h5cHnSQULhNVLKR5WysDcFXyi8jqxao9a/yrOshf4ojZaKeZ9mS95v+GFPCMndzwbS5/
         q7nWgFZ/MIwIHa6nNkA1SlzmFAD3CEXXYyiV0hFTedWjQjvLOv5h1jUq1dkN/sT7Qbn1
         HWm7Te46rMsz3nY3U0l578nWlrecnvvIBiCnDUj+AgPXbHGXLzKFzP3lDLg9LylQjc59
         QRig==
X-Gm-Message-State: AOJu0Yx+7/tMkWC0gP8EjVPZeIVLyCCgvDVgfQznDwste7wxb7s1UsmN
	+papaOltiLxSwlM2k+YmWXTT6kSZklPHZotKF8uNO+IhcYhSNRAFVVG90A==
X-Gm-Gg: ASbGncsPFRwpygJHnsQKrNYIT/b0jkGaWGRX5YWrhUEJtvO/abSbPZ+tARhdb5khFfn
	j2OztykfEAckpMNIUVA6qPeswS3/hbIQ8WItoNGw7wJvNFGmGy/JHNozwh2za9+b3Flwlv0apno
	lbLkZBU91kXlqnvlOCRyfZnXjvQaQnOKYLkHrePU+2uPKHOiv40/0D27T5F7YqnN12BH+4M6bdW
	pfHwcTe7KDDQyh5T/XKzyWdY9naeQunhV8H1IE43R0FdvbVz5gchB2IJi+i0xUSXVOMB9NRdvXK
	f0SEPRku2vrw3kkUqqrAjTJUU5K9BBlIcrtZtnEOvfSckMQ=
X-Google-Smtp-Source: AGHT+IGhJzYHer10pX9MxtQV6w0GZvBw0h11VwRxngBuAM9Hw9CkiKtyubGQ2rTdnPuUEHhvWvCeeg==
X-Received: by 2002:a17:903:120c:b0:22e:40d7:3718 with SMTP id d9443c01a7336-231981cf6b6mr41597945ad.47.1747227870999;
        Wed, 14 May 2025 06:04:30 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc82bd34bsm98950855ad.243.2025.05.14.06.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 06:04:30 -0700 (PDT)
Date: Wed, 14 May 2025 21:05:02 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 3/3] packed-backend: mmap large "packed-refs" file
 during fsck
Message-ID: <aCSU_unPGsUAZ0CM@ArchLinux>
References: <aCMnrwkoJ2WyqGZT@ArchLinux>
 <aCMoD-c_oHlu0c5c@ArchLinux>
 <xmqqcycch2t3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcycch2t3.fsf@gitster.g>

On Tue, May 13, 2025 at 09:51:20AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > During fsck, we use "strbuf_read" to read the content of "packed-refs"
> > without using mmap mechanism. This is a bad practice which would consume
> > more memory than using mmap mechanism. Besides, as all code paths in
> > "packed-backend.c" use this way, we should make "fsck" align with the
> > current codebase.
> >
> > As we have introduced the helper function "allocate_snapshot_buffer", we
> > could simple use this function to use mmap mechanism.
> 
> "could simple" -> "can simply".
> 

Nice catch.

> > Suggested-by: Jeff King <peff@peff.net>
> > Suggested-by: Patrick Steinhardt <ps@pks.im>
> > Signed-off-by: shejialuo <shejialuo@gmail.com>
> > ---
> >  refs/packed-backend.c | 19 +++++++------------
> >  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> Nice loss of line count ;-)
> 
> > -	if (!st.st_size) {
> > +	if (!allocate_snapshot_buffer(&snapshot, fd, &st)) {
> 
> It is a bit funny to see that a helper function that works at a much
> higher conceptual level treat an empty file so specially (namely,
> should it be different from a header-only packed-refs file?).  If I
> were doing this refactoring in 2 & 3, I would probalby have made the
> helper return "void", and have callers who do care about st.st_size
> check that themselves.
> 

This is a good question. Actually, I intentionally design this. In the
very first implementation, I use above way. But later I think this is
inappropriate to let callers check `st.st_size`.

The reason is that we would do the same thing in "load_content" function
and fsck function. But after thinking, I think we should make the
runtime behavior and fsck consistent. That's our goal. And by using
this, let's say if one day we want to tighten the rule in the future, we
could just change `allocate_snapshot_buffer`.

I agree that introducing side effect into a function is not a good
design. But in this situation, we could make things consistent.

Thanks,
Jialuo
