Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C46323BD1A
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768521639; cv=none; b=W3NZCT02GKAjeI4R8lsLx6cpuF1TSpMQGsJDk5ZKYR/tBNrwXqW3JKDVmwnkROR+5uVUDTHqgBh233NDZ6wvXKf5XtYxYjcVfT2zl1OAKxyGl8i0bKg1ZgrJFibB59J0jyEXPgnoC9GIdiui+vygSQ1NHCPCPjI0g+tUAJYBpSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768521639; c=relaxed/simple;
	bh=HwKzs4eoUS3dnH74WmSEVQC9vdKduvuE616ZO7AvIhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/nUpOHm+7Z6otpOVIlzsK05kc4uCBkEIFfwIWfRYHRIRuXzdl7Vj8Lud+euMKVZWwn0zVZBtJz6UkX7CloMxMCQF3QB+vGRHdRi3a/7ZZkmdOO3n4oyYHiiqqDAqLB/tnrk/dkjzh6gdza+nJ7U9OaymoWNpeJCvwzK8eYGFxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPVXSXXX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPVXSXXX"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8719aeebc8so270078766b.3
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 16:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768521636; x=1769126436; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=weJ620R/AOJpkdZ2rVokKs/LeCNkiPu5au7logahH+Y=;
        b=OPVXSXXX5NMNhOPWAsIMoO2chWTqRNk7cKokPPwPfTdoGlLzFOZm82mEXnTD+Hvshc
         ajJcNI/n3W66KmkvnvW9yDgBjZApEKRHBjeMgzTlqaKi6U/kFsIBvuI9AZtmWBUGFK9V
         nLpbTaqxUew+0lq6iozyn0NGa4XA+deKUF91K048b2i6+AgfNmhxokk9u8yKC/hNncoh
         rDaGvB0y6cm+BIb0lCHDlJohRl/RtF9fXNugg3n1VOUe/jegZsKaPfGY2XwNcy/xWJfM
         eBab/nLK22K5fDjcOfcMIEug9r8+woCxf6Ey80ZlnveQND4vZJuDWAGCvcX3++7uV7kF
         zhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768521636; x=1769126436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weJ620R/AOJpkdZ2rVokKs/LeCNkiPu5au7logahH+Y=;
        b=eiuurE3YmqSAg4mtaIlF+EfuwfuOVYIv/grYIw0VJgJScmsLWs4i0+/ChpppmzfYw3
         L4PNRIkHVpUwTWYKYafoEt/ab50YBrhzuxxz8HTYMpE2orS2+CfybMrHwMyGeORJ6lCR
         i4aSLyGDdWQoiZhrP9xNFichde+WV88ky++NRIO3spTGB8atJjBHsWnE4iA32qbcICwa
         5qC0n0qfcU1Q2ANghLxEn639Ed5hTZHV8OWDydBxuvGdqhZ1Jr0I0j+MqYTpakozCpfu
         QagnjYsb0OhnGJw6Up8azk+wKW3swmFkDWpxZO3FuLCgOf+V+5Z4q7w1e7yEQjzTuzad
         4oiA==
X-Gm-Message-State: AOJu0Yy+1xQ/ab6J3ugw858OVll5A5CsnBuokswM88OpwMHfEUO5GE6S
	QVT8lm4C0fbRyaY/iLzjY11dVKcnSS6fiFGp+oIUKiPDFhh9ofseAGiVgyOCjL9Z
X-Gm-Gg: AY/fxX55Qn8Pi9SoJJOSJW2NCyaDBYKHKoeDfidjnJhZ4GKDNn3IAKb/Pkv5SBQBQj0
	7WQhMVUkw7skbtRhT/Ioim7SfdUezPePhAa4idFzX6ZvYOKXMJ43NrnpQldajC2sIMubWPyVDsH
	vvPJqwkGXWORrGHo2c1C7gvqcWLPHb+krneh0iqnidDmhmLV0NadYkMtmjIck1yZ1SasBt5czzS
	+mR2R+SsmRGtf1JxVEa65anQ6v9NQufuWEFthrWemQojZf/TzeRi4VyGt/m7M/Jv7arJUJi87EX
	a6KQj0OYbLRRU/UIX4wH7LyIRwyS84HfTLwzMr3aTeq/cYZ/+aDZjh6x7MkSr8bJHx8UuCX669A
	CzYFGIR8N7NsPCL//kq70nVqY4K55BDllzOWh5gR5ctUO13xlpjZPTnUXg4EGczQqUpP4tKDFkQ
	B+5kC54WLMixP7sEbB6fPL
X-Received: by 2002:a17:907:1b20:b0:b87:156d:519 with SMTP id a640c23a62f3a-b8792feb142mr123350566b.56.1768521636134;
        Thu, 15 Jan 2026 16:00:36 -0800 (PST)
Received: from lorenzo-VM ([84.33.162.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959fa522sm76639666b.46.2026.01.15.16.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 16:00:35 -0800 (PST)
Date: Fri, 16 Jan 2026 01:00:33 +0100
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH 1/1] diff: improve scaling of filenames in diffstat
 to handle UTF-8 chars
Message-ID: <aWl_oeJJxtwsUyR3@lorenzo-VM>
References: <aWgYRkv-YsuekdR_@lorenzo-VM>
 <xmqqikd3ermt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqikd3ermt.fsf@gitster.g>

On Wed, Jan 14, 2026 at 02:50:02PM -0800, Junio C Hamano wrote:
> LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:
> 
> > The `show_stats()` function tries to scale the filenames in the diffstat to
> > ensure they don't exceed the given `name-width`. It does so by calculating
> > the "display width" of the characters to be dropped, but then advances the
> > filename pointer by that number of bytes.
> >
> > However, the "display width" of a character is not always equal to its byte
> > count. The result is that sometimes, when displaying UTF-8 characters,
> > filenames exceed the given `name-width`, and frequently the bytes of the
> > UTF-8 characters are truncated.
> >
> > The following is an example of the issue, where the 2 files are "HelloHi" and
> > "Hello你好", and `name-width=6`:
> >
> >     ...oHi | 0
> >     ...<BD><A0>好 | 0
> >
> > Make the filename pointer move by the actual number of bytes of the
> > characters to drop from the filename, rather than their display width, using
> > the `utf8_width()` function.
> >
> > Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
> > ---
> >  diff.c | 15 ++++-----------
> >  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> Two comments and a half.
> 
>  * The change needed for this is surprisingly simple.

It is indeed surprisingly simple, I agree!

>  * You already know about samples that may exhibit the issue you are
>    addressing.  Can we add it as a test case somewhere in t/
>    directory?

Yeah, we should add a test case. I will do it in the next reroll.

>  * The NEEDSWORK item addressed by this patch is one of the two
>    NEEDSWORK items added by ce8529b2 (diff: leave NEEDWORK notes in
>    show_stats() function, 2022-10-21).  Makes me wonder how involved
>    the changes would need to be to solve the other one?

Mmh, I see. I'll take a closer look, but at a first glance it doesn't
seem too involved.

>
> Thanks.
>

Thank you!

> 
> > diff --git a/diff.c b/diff.c
> > index a68ddd2168..271ace5728 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -2859,17 +2859,10 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
> >  			char *slash;
> >  			prefix = "...";
> >  			len -= 3;
> > -			/*
> > -			 * NEEDSWORK: (name_len - len) counts the display
> > -			 * width, which would be shorter than the byte
> > -			 * length of the corresponding substring.
> > -			 * Advancing "name" by that number of bytes does
> > -			 * *NOT* skip over that many columns, so it is
> > -			 * very likely that chomping the pathname at the
> > -			 * slash we will find starting from "name" will
> > -			 * leave the resulting string still too long.
> > -			 */
> > -			name += name_len - len;
> > +
> > +			while (name_len > len)
> > +				name_len -= utf8_width((const char**)&name, NULL);
> > +
> >  			slash = strchr(name, '/');
> >  			if (slash)
> >  				name = slash;
