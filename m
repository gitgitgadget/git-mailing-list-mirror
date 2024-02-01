Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18D341211
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 23:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706829268; cv=none; b=FIQk1qnsN+E72dq7uUvwarMlo6l1sS1DNywhRs1pagx1sIlwz7Di1rlWwQDqe8PIIsboTOMTTYEwfQl9b/ffhEbDXiVdP+0SUHvP/iKkE4JxxJIdxGARILm5iVzJ5rJnmzrYr7RZalC8Bo3jKtRr3bg9j7BCWyqAl0LL3LgpGOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706829268; c=relaxed/simple;
	bh=GrB0yEnQwDT3zBjQ9gPPR9DkHyKlpPaq/bhVLvM7TgI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwvFkUm7HZzQXxyxAdjR243lDHy38G7pVyGZiIVGRipSDR+PMMl2vWfaKBBcnDLWaV+Bvf+xO4k77ERdldpuWnlmODUcC3rTbv50NTFzYv51roKa+tNKSW1RxTWifmiGOP2qKprYDtzvgMgCCiw7UWWxvSi9Z63l7NMQoPsN2h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ngyP+JKc; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ngyP+JKc"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bd72353d9fso1179657b6e.3
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 15:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706829266; x=1707434066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g0falWkX+a15LmlX9//qV6j+b0GeiolYs2FhWNjQuWA=;
        b=ngyP+JKcCEUbaHFY9tnDZRMcx7lw2xpT+3armWRR/+OlTED8Z5OpSKI0RXOwI2bSa1
         N7Xbjnk3XxysIzSJ3J/beg+aXRqojW6EZF2wiyPuItLKSrzAkDd+AYho2EuDhvu/JYcz
         w46DkKiZbhrwKqj9w745Qcmlr0wNhGmo6RaSmEIBjz72qsU55TXyBzC7IYkyw4Xrv77b
         qBnhFn3mVSibaDPRkzVWHbHpQxN97x/S3mREsOC1fthlcHl/Swajiaz7u1NubRrcfnnu
         ypD2qHJx+L+d9JDTTQMRxLkrqe0NzFJKXj8uiWGUQVoaj/O66yLZC0uJvWVnxcyTZHU8
         BA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706829266; x=1707434066;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0falWkX+a15LmlX9//qV6j+b0GeiolYs2FhWNjQuWA=;
        b=oxDR0l4rhFLm8Aj2j+7Q6UqaNvOzWhLcH2H0teg0u+RkJfLf50CkW7qmlnsAB+ah98
         3mNCGtx3h1dp+DBHyE72ik6PGRCbYVC+d/GT1LMrE7ipf+Ltf4Dj+Cil59dvH0E4q9Xl
         ULIj5ZlVrUhtf83kQzmxALWzcz0QxE0P2EjVAs13gW1Lat7LotEby/wBWHgM82YJkw8a
         F7BmY7+xqkxooPghD10+wfcGxQYpKKN2gdh1yo2FxUQKXtq93gUlDGBEYNMPx4V+VsiB
         B3MIxht7BA/pV7mGl5EYnMetb7OOaxMa6PcU4tEHpqgqc+KjhGBhVMxBnFhK71ftYY60
         SWkQ==
X-Gm-Message-State: AOJu0YzPPOEXtzRj6bUm0Gop6p33XqkUAw1D+cg8DVDKQbMUiIn/f+Bw
	Z11IXjXEn0ZIZEbRJJeKvw143bYaQqcwKEOw9TeOcb6JbqfNgZDsBTC6vwYAmQ==
X-Google-Smtp-Source: AGHT+IE352kccgDI/jg6uitmGi7rKADh+9AKzW8BnasS93zbd44r3/houj7IqyiSNe+kDU7zRsiQlQ==
X-Received: by 2002:a05:6808:19a7:b0:3be:3de9:68b0 with SMTP id bj39-20020a05680819a700b003be3de968b0mr7830200oib.5.1706829265674;
        Thu, 01 Feb 2024 15:14:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVFAbeBhbxX7A6mIGkrvgLIZG1x2hl4cO6+7WquXPGKl5SfX/nS3XheyfT6LKuKqEF3X3sROA7yP9XceHcQaMDc0LRGyk7mMFUOlK4rtTnDQB16LTKe9zsSXiwrWfUiGbmNqIQtTpfTi32SUhAHrIemVvhFHDC5NlBABuQS+dJuxf54c/lsjqtTqzA=
Received: from google.com ([2620:15c:2d3:204:4b5e:af03:86e9:bc80])
        by smtp.gmail.com with ESMTPSA id b12-20020aa7810c000000b006dbdb5946d7sm290865pfi.6.2024.02.01.15.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 15:14:25 -0800 (PST)
Date: Thu, 1 Feb 2024 15:14:20 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 2/4] test-tool run-command testsuite: support unit
 tests
Message-ID: <ZbwlzPWVtYuXy8rY@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, peff@peff.net,
	phillip.wood@dunelm.org.uk
References: <cover.1705443632.git.steadmon@google.com>
 <5ecbc976e6216b941e760e096e166ab432ee7784.1705443632.git.steadmon@google.com>
 <xmqqv87sx3y2.fsf@gitster.g>
 <Zbwki_Dk2hGRce6Y@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbwki_Dk2hGRce6Y@google.com>

On 2024.02.01 15:08, Josh Steadmon wrote:
> On 2024.01.16 15:18, Junio C Hamano wrote:
> > Josh Steadmon <steadmon@google.com> writes:
> > > Second "--(no-)require-shell-test-pattern" bypasses the check that the
> > > test filenames match the expected t####-*.sh pattern.
> > 
> > This one I am not so sure.  Do we still have situations where
> > erroring out when fed a non t[0-9][0-9][0-9][0-9]-*.sh script is
> > problematic?  IOW, do we need to keep it as conditional?
> > 
> > 	... goes and looks ...
> > 
> > Ah, this variable/option is misnamed and that is what invited the
> > above nonsense question out of me.  The logic this option disables
> > does not "require" (and error out if the requirement is not met); it
> > is used in a loop over "ls *" and "filtering" files out that are not
> > the numbered scripts.
> > 
> > But that confusion makes me wonder if non-script side of tests would
> > also want some filtering in the longer run, even if the directory we
> > feed to "test-tool run" happens to contain nothing but what we want
> > to run right now.  I wonder if we instead want a variable that holds
> > a pattern used to match programs readdir() discovers and skip those
> > that do not match the pattern?  Its default value may be something
> > like "t[0-9][0-9][0-9][0-9]-*.sh" but alternatively you can give,
> > say, "*" to pass everything, or something like that.
> 
> The original implementation and this series both still allow passing
> additional patterns on the command line. Only tests matching the
> hardcoded t[0-9][0-9][0-9][0-9]-*.sh pattern plus all the command-line
> patterns will be run. The new flag just bypasses the hardcoded pattern.

Actually, I misspoke here. The test must match the hardcoded pattern
plus at least one of the command-line patterns (if any were provided).

> Given that V2 will already be changing in non-backwards-compatible ways,
> I think it makes the most sense to just delete the hardcoded pattern and
> require callers to provide it if they want it.

Given that it sounds like the testsuite functionality is not really used
at the moment, I still feel OK with changing the pattern matching logic
here for V2.
