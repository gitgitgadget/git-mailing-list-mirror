Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F2221F29
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752267427; cv=none; b=OcVnjJ5HF/ANHZKpqTqZNNV3K5Kh3JRl5fT51zBqOR23asoJcRKrAHRYYiBWyKMftpG74IcXonOHb4Z53YC+nCwxPeT0VnIxQhnpoK+v6i+A/toX1yOqL4SzZqYuOhUXpECnPv/LJfYxPEn+Wd0nPdpjT529bB0CeZXAsCV+LgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752267427; c=relaxed/simple;
	bh=8QAIE2GRQLz8SbVIwjoG5nd3ah8LSni8e7KZk4Gt4yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/uGVeSfLvLOTIPLubxDqmS3mJ7YMXY/FKESngkGSyrkN26xYzEhP/r46Q2ir9s1JqhS0oAWY8iI83aAhpFXtP1RFoukuMJbE5nFnLT+/QTkg7SXmmVPyiAfSiEwkg+WXFEOdMrP/C7AqANIR8U8XPuF5Bl68qmXnbwcAQcDz64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeWUCVlD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeWUCVlD"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so2185731b3a.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 13:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752267425; x=1752872225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ONi1eCB2iDfjMmDave02uUcS4VV7KRYysi2PeeOu5Q=;
        b=LeWUCVlDsxjF+XVXpKlod4p0VX8FFgjxrgqQnIFouTR3hE5iH0AkFTlwRDvdI4il29
         ISSSVY/c12JodwYgC9EI/jzduXRXg2GIVvRW6aOqOA6zjVCwDmQ7i7bXxcd0DTbTxp93
         qv0dpdWmxEnDZ1J5nlS7IO2/lXb8TliohLrRCzHUnD7k0nLsIgdqCGZtOZJZf6/y4iU3
         6Ig7GtZg4e3sFXdHZL7VuMPgtaHBRtDb8fl7XWLe4VsP2ocGARKV9JroO5BxC888BFZj
         U+pQFksg+xyhnS+2gZJtFLWSY42dT0QG/HHnhkpTwjjeYA3PlCH24ub0y02HQ8sEyVBR
         a26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752267425; x=1752872225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ONi1eCB2iDfjMmDave02uUcS4VV7KRYysi2PeeOu5Q=;
        b=Sf9PRLCP9cSiLsnY0R6i59p3UKE735C6D3NJ0K2V8DMvmkkUsGqFWu0HcmNSRgoV82
         JYMofrftiXFZlRJiJknbNCh9LeiweVZdtGIdQAxi4Cm1QRwwE3oYaIdW4AVUDyaQmDyW
         G6tQ60k2M83xyu6Oa9eE/RxVodTY62cW1lwPlSgTTNBDOVzjJYK/KmbjZM09Icf0WrwT
         XvmidbUeJrp99xY5EMdDio+s+I8CB8BaYLk5tu0zO1J4KZwhhCR/ykV7EYF1tpdbbuXQ
         PvG8QheNFym/V8c4Yma5EwYPCavz0oon3L+ZM5SZUjZS6p5DuOg3zJkRgMqb9mb4DpdC
         idQw==
X-Forwarded-Encrypted: i=1; AJvYcCX3uhpn3tL+NIB+mahgq3So4WD0oLCSi96avk/BVFFiwWew0uyKmRGbAGV3FGIwGtpVdGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyVQGy6BOZCez0QEsZ2W741bRRsznQjgADnJ6fFdbPePhSM8bd
	cteLH6t+eHUYyIem++WSNho9OvUQrQ3+zUkD6RJ/2ChAePsJ+B2AFW2V
X-Gm-Gg: ASbGncsj49D4VsTCRbnSKLqVKItJRgUzsA1tAq5UmDgGsvWhpUT4Vvbxk+dzOyTDC3m
	eEunxtBep7if8YwAbrb2aKXeeK7/jemca24ZBybHKa6kb26LFeV3nBEUWMc3spc8m/ojqH+TnPC
	vlaTzZo1TmCiyf2dE7+u0hHr5bew+PJo46xzux5xPmSuYwsaW7uwP9daozPkPmx1m3ocuArocQB
	5qwxhs2hO59JgHQ8rqDItnvPBri/MjiE2YVF7EmpxLLA+pq+ALzOPtD9tddfKm+q4W5J9wmQazw
	2Yp5CepT7hxgLzyO6Y6t/734BAXbG4zmbt8++EiB5aG89JNCdiV0hFlrRH/jw6gjKxt11Ia+fL5
	4+VtL/SbtCrw90cST0nlGCQ2nK5TGcbj6vmO2dkXfyAlYxWllynfRSysVFYw=
X-Google-Smtp-Source: AGHT+IGsI1UZEsyIvthl6HOG7lcPHshgs1Ps/uA0q4ZXUmSBSTmYRrk4d1f8j7vGQputzZkFaO+9EQ==
X-Received: by 2002:a05:6a00:660a:b0:746:195b:bf1c with SMTP id d2e1a72fcca58-74eb5ace4ddmr9280453b3a.10.1752267425351;
        Fri, 11 Jul 2025 13:57:05 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:b052:91b3:8fe0:c52d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f49f80sm5478617b3a.117.2025.07.11.13.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 13:57:04 -0700 (PDT)
Date: Fri, 11 Jul 2025 13:57:03 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: Justin Tobler <jltobler@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Taylor Blau <me@ttaylorr.com>, Yi EungJun <eungjun.yi@navercorp.com>
Subject: Re: [PATCH 1/1] http: don't send C or POSIX in Accept-Language
Message-ID: <idgdx2au3zgpowozspvu6ttvehybtwwuqf5kwqga4yok7uo2uj@wno7evyjg6pq>
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
 <20250710221641.857081-2-sandals@crustytoothpaste.net>
 <r34i7fhxwbxhppc4ia7lpyr3xqj4tgusaeikaaonpwtywlywxw@ygfmv3f3q67u>
 <875xfypsom.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xfypsom.fsf@gmail.com>

On Fri, Jul 11, 2025 at 10:02:01AM -0800, Collin Funk wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > From my understanding, each language is expected to be defined in the
> > following form:
> >
> >   language[_territory][.codeset][@modifier]
> >
> > When we parse the list of languages we only care about the
> > `language[_territory]` part though.
> >
> > From looking at ISO 639 language codes, only codes with two or three
> > characters are valid. If we wanted to be a bit more strict, we could
> > check the length of the language code (everything before the first '_')
> > and filter out anything outside of those limits. This would naturally
> > filter out "C" and "POSIX" without having to mention them explicitly.
> 
> Filtering out anything that isn't 2-3 letters seems like a good
> heuristic to me.

except that it would be incorrect, as language tags are defined in RFC5646
and are larger than that.

most importantly, deriving language tags from locales provides some very
useful tags when including the characters after the _, because zh_CN and
zh_HK use completely different scripts, for example.

Carlo
