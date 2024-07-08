Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF66811EB
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440753; cv=none; b=Zbfag00jm6WOymWDKknXWY/ivQP/08or3S6vaXpmslIZhrocaTipAtU/ZSlZ0/1zszkt5fc62xfRp6PU7rtHbmMRes4HeJMLkcS4zCW6/esmY+GJs1zU2JKTP7hwOd4TqdAdDaX7Xtqj6/4rFqM7rxzEtswxjHS6rG1kXYwJ2Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440753; c=relaxed/simple;
	bh=nNiQBZ1BLn9hZ72TM2Uad9KLFRBBTJRcdzQJdLyay8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bV0OUaXnRcnHkHlInX0J8yy9RS2sNRrjGF1tdE/ZoRTqoIb3UpCxRM1dnlMZGY/HN67hMPZEFhCH3sGs7CHbd8rBWG+DWjQ1Ri5nUPMdsjPAnur6iNksK+WwKxKpQ5cmjos1GYyowrJ5A56a4BxsdFeKUyu6vjG9Vu9BT+LVaZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HK1b5sUd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK1b5sUd"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f9de13d6baso21199695ad.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 05:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720440751; x=1721045551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKgoHbHbGGUn2gW+g8O68jP2+nQV0sfv2CZBeA6SLGU=;
        b=HK1b5sUddDboq8upjdF999xqM4sMaHKXqpzGBFl/PqkZ/YQl9UfOQRCAkknGE7YVwe
         Nbp3Z/1EWom5NMpRy4jmxXQYqjlxhE55fJG+vpCJuC+HmRVhgUbrk+zo9Vz7OBPY0a6b
         D3ndtOs+iWvOcs8l31q9Wbzt633ifKsSVrldcbnD1B3SA8vsYpnvUdYg28YuIcFapYuN
         jlLLJ0/YZeEyRYDZ3HuuRRYf1AxFI/X5nIWqpB6ydPgGghgp5OyQRC6mjQl8ZLhR6KMK
         Uopqcy2Pvi6GT5NvRESVq+s6hfXlVZNIqCASK1qG4Ea2jwk0CuXul8WPVmlCaS80Eaw/
         OPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720440751; x=1721045551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKgoHbHbGGUn2gW+g8O68jP2+nQV0sfv2CZBeA6SLGU=;
        b=P0K1O5e8KUmTUE6gEeutFwP19h4OHj/JH+dLyStwbTaNrU2tvkQLz2HMh/ydBqqkgC
         AHFitLO270LTkKbp3H2PbwseQmXxvkOfPvGocwTxnohDu+Rc2FpCLRulSawV3FMB1DZC
         jB8LYusDCcU+exLd+wRyk9oSqahHNIS3oZkRv8DXKC0+UWz56Yo1prDmkzJ8uNvd5yf9
         YBuDPLHq8rV7br+mRZyniddCjFfjSjFRl+YDZXxHSR+d+W5GQEDjPfO8uwDZXiUvDXBW
         RPajmmsZWsa/qXBmajO0xdrtMHm4jAURP0hcBXM0kF7xkTnCDTxyqWzl4k1qkotDu00Z
         aZxQ==
X-Gm-Message-State: AOJu0YzdtMUBAQPN1SznO16kY5ghpg/Pd5HOP0IClNOOMC02rnSeiH0l
	XEmOxa6xpRFQAKt9+AJ1zWm04802qclfjGpE5qHaM1MKjEWOTEDv
X-Google-Smtp-Source: AGHT+IHsG90pzHWvQt2wGKgof8Qk+QcXp9x2evMCqV7xGYTGG5xefzSi9kw9jicz8fg2LQrxkQmm1Q==
X-Received: by 2002:a17:90a:d985:b0:2c9:8b33:318f with SMTP id 98e67ed59e1d1-2c99c561ae0mr6694797a91.11.1720440750544;
        Mon, 08 Jul 2024 05:12:30 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a980b37sm8010542a91.24.2024.07.08.05.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 05:12:30 -0700 (PDT)
Date: Mon, 8 Jul 2024 20:12:29 +0800
From: shejialuo <shejialuo@gmail.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v7 2/9] fsck: add a unified interface for reporting
 fsck messages
Message-ID: <ZovXrXfDfBJHa_Tg@ArchLinux>
References: <ZoVX6sn2C9VIeZ38@ArchLinux>
 <ZoVYn6C-QOuHM2sC@ArchLinux>
 <adijctr2gmmyydpnnrmnu5p5n7mambfrd2ylqm6jtmvv2jdlxo@fbmhti7b4tks>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adijctr2gmmyydpnnrmnu5p5n7mambfrd2ylqm6jtmvv2jdlxo@fbmhti7b4tks>

On Fri, Jul 05, 2024 at 05:43:37PM -0500, Justin Tobler wrote:
> On 24/07/03 09:56PM, shejialuo wrote:
> > The static function "report" provided by "fsck.c" aims at reporting the
> > problems related to object database which cannot be reused for refs.
> > In order to provide a unified interface which can report either objects
> > or refs, create a new function "vfsck_report" by adding
> > "checked_ref_name" parameter following the "report" prototype. However,
> > instead of using "...", provide "va_list" to allow more flexibility.
> > 
> > The "vfsck_report" function will use "error_func" registered in
> > "fsck_options" function to report customized messages. Change
> > "error_func" prototype to align with the "vfsck_report".
> > 
> > Change "report" function to make it use "vfsck_report" to report
> > objects-related messages. Add a new function called "fsck_refs_report"
> > to use "vfsck_report" to report refs-related messages.
> 
> To restate in my own words, the existing "report" function is checked if
> an fsck message should be returned and also formats the message. It is
> currently setup to only handle object database related fsck problems.
> The `fsck_error` function type is generalized to also accept a reference
> name enabling fsck problems to be reported for references.
> 

Exactly, I will add more information in the commit message.

Thanks,
Jialuo
