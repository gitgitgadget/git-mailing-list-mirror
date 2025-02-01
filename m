Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C92B9A9
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738403314; cv=none; b=i+rl0ImldJQo+waDejMRd5pbDwrPNs2GkcDdTIAbJzfaKL5rtQ8cmj4dW06KCqR775cWv8aQnBgjFzwOLcnrSJbzKdqkuDH1N9ybiS4rjFePRdyvcWy9wPkL6Psi5Hg1F/01hjGwavk8qvtr1oWJbBnB1YenILhWN9G6Ml8p4lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738403314; c=relaxed/simple;
	bh=uNvHfHnhc9V9siR/utZuzD2iB3WDP80PK0huGO4ljZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nab99E8ZC3HoV3avAjK8wg3BuTpypbYDmn0Vf0NN5FmLK95jIYM4j7wm8aUJnnWRR87mTuz41YPZxu4Hw3evTaQgSg6dv+4Q+a16USceHUKK3rIDDHpPF18G8oApNCE/Z4QyvvhtBY8hjKNZay0gEto2R9oQctsnuoCVJnSyI0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wuv2bagQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wuv2bagQ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2167141dfa1so50025515ad.1
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 01:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738403312; x=1739008112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k9ejMNis7omR1x9hJu3SymH4PZfJkL8E8ijOAYhsfhM=;
        b=Wuv2bagQOpN9+pPcgC1njtqQnMn8gKomTNqg8kYR0x9krbSkciPHP/YvyXje8Ih/bq
         5qCfV6kRmK6KihXCh/aH3B9zXS0kV2a1VIe4FO3IeDlqrahu4sWOwwiZrzIOtHVsyDPW
         aOFCrz3LF3E+9tdivR7+BXJmZzeB+ki1eVbyOF1H5ogqz23QGmlZ5XC3Yf9u6wmoVORN
         E4YLRxU2+Tj8cxGMwka5W3ZP7Mns4JrToWheKW/kWadpufTGJHySkcC1579BOnJ+QOSt
         v/JQe8psfChW8upuLwZjeo6h3K8ymCjzEzeF6g9AHdtZaRhToZtdEcbEzO97mHxo8FAR
         gvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738403312; x=1739008112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9ejMNis7omR1x9hJu3SymH4PZfJkL8E8ijOAYhsfhM=;
        b=SwmKA1SZcW3WHmwVar0fzWt3habZHLg+5sAmuqlyu0SwH8ixzbMYjKbPmZGNyieC5Y
         gFugHgUYT2RItiPP6cluTAHJvJQ+mn92xTPbpfl0Ef97J7REz4ARiIFC5jLUwOoCgA/p
         k/XOWpV1TCuG6+FvNU7x3r0Ymb3daul9fV2JAJuor8HsKCHNeTBRDLaHlCUJQJiS2rfz
         N7Bvgnd+mtNHV2yDdGZgHclK/EK4B8Lc1jhSQYO2Kj55e6vE4c/IaYbyw5DZaWbJuVut
         8IYtSiPFXdoIYH2dIwWsU30Qy+p35YvykQjqOfcMio5cH1suNGdMRkJwm8tssg0BPj6R
         u0QA==
X-Gm-Message-State: AOJu0YyPpW/+i+L9z57DoqqlZC8urFsJK5LDTCE/vXJz6bnQSA2EY7qh
	1q7cgrCGsUp7F7RoWOdcsTVfTbrk2PlfDlO2sz7rYrL3PDkJBltsnHEbB5a7
X-Gm-Gg: ASbGncvJM+ln/9jbUao2vOSOp3i0ys06ZblE7W5I8w9U5JUWK7qfMsgvlvYo3EsMGlT
	bP+8p7EMVnEv/qdoeHIJzul0M8KW+G6pfkmWIRlHMsYJkbt6Xw4+HnycR7uAAeFSw/ne2lWH9VH
	HLguAg/saHrLnlEf52m4Oue40SBIrriVMadl6Uu1oFYiIQnTzCLhTp/PUYP+0ctan1P5DYEjzKt
	PjIpKrAZzsQdHS+UccyDSs8vsNJ84MZMZWjadV8hl74wbnrK/vjL6iCZ18+81Ih2+u3YQ==
X-Google-Smtp-Source: AGHT+IElMSjpwnCcsaTPq5TlW7UNE5Y6hv4IWgOER2CFgtWdCeVylswvRr6ARB+OKy7W2Tv3sdkxBw==
X-Received: by 2002:a17:903:2347:b0:216:33f0:58d5 with SMTP id d9443c01a7336-21edd84df94mr95581965ad.17.1738403311919;
        Sat, 01 Feb 2025 01:48:31 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21de32ef9c2sm42820925ad.114.2025.02.01.01.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 01:48:31 -0800 (PST)
Date: Sat, 1 Feb 2025 17:50:07 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 7/8] packed-backend: check whether the "packed-refs"
 is sorted
Message-ID: <Z53uT8BnepXEjv8v@ArchLinux>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
 <Z5r7KvL1bvSO4UQY@ArchLinux>
 <xmqqwmecceh1.fsf@gitster.g>
 <Z5zfx0E2neO5MNKs@ArchLinux>
 <xmqqed0j9clh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqed0j9clh.fsf@gitster.g>

On Fri, Jan 31, 2025 at 08:23:22AM -0800, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > On Thu, Jan 30, 2025 at 11:02:18AM -0800, Junio C Hamano wrote:
> >> shejialuo <shejialuo@gmail.com> writes:
> >> 
> >> > We will always try to sort the "packed-refs" increasingly by comparing
> >> > the refname. So, we should add checks to verify whether the "packed-refs"
> >> > is sorted.
> >> 
> >> Do this _ONLY_ when the packed-refs file has a header that declares
> >> "sorted" trait.  Insisting on a packed-refs file that does not would
> >> mean you are stricter than the runtime contract allows.
> >> 
> >
> > From my perspective, we should check whether it is sorted when the
> > header has a "sorted" trait.
> 
> So the three-lines you wrote is not accurate, then.  That is why I
> said that "should add checks" should not be unconditional---we
> should not check if the file contents is sorted when "sorted" trait
> is not declared.

I have made confusion here. Sorry. Let me improve this in the next
version.

Thanks,
Jialuo

