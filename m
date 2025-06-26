Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6BA218AB0
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927852; cv=none; b=lGlI0NmULM/VrfflB0UHTgdOgo6Zv0C2Kc3G+lWK/84qsY++7eFQ19tt9ZzFouN8CYjZbewqYYkSlGwgCEwIIEly7JGN3H/G/FWMGkGKvtAFZ7MGsEr22fPgvTlpepA+zI3OgfIc0IFF3t0l+if0e9oZUpwqyEcpHxAxrMMBljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927852; c=relaxed/simple;
	bh=3dL9+YI/TVs7ypsv9/jahYTx5bvvvvkLTfx7DkX00OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AplxMZ4/QWcnD7FPCJ17pUzOHAp8bLxRGPpFSXG4yqYaoGEFc4Uf3ZFxy6c2qaac1k38+XlYKuZw0V1KOKzZ2DeWrm0zvXpSIERYJfBnAhhFvcaElWTWgY2NIeBQRMSsdFGVWE91he00wz7AS+t5RGB/NI/DMxibzdcigMfRISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njc3sr+E; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njc3sr+E"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so663271a12.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 01:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750927851; x=1751532651; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DnT8o6ci7P6M5KoMeB68KXdlPiG1C82wn16yLi8mrKA=;
        b=njc3sr+Ew++gxGP6K1CFeSQOiRRz8OqbUFLr0idI5NSBtEQVpLgWwQuRGBEbXfUyY6
         hu1T037HFat0m8CKhjOfYuEISh41HKh9mjSPP+lu8tP6WTXgFZJPXhYuFWyFhW+cIssU
         HHp7sIM1z9wIGxrlBRuDUj/0Qmli/YKrGNXL5t5pXgZBBtT6awNF5mMXQsfnWDIrOZAw
         pP7gBI4evFqpk8Vpzx/B01bAATJ5VbpFCL6G61x6Ia5QHX/v3/12xZFt5P4hjxqBv7uR
         y9KPanHjvaTT9AAPDwJkDS5klfIbFhbQi/r3YmYoh3vEPIkR242P4oXaVFC3OIXOESmQ
         usCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927851; x=1751532651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnT8o6ci7P6M5KoMeB68KXdlPiG1C82wn16yLi8mrKA=;
        b=wW/Osizfo0K9bmESCjhcy3ER2QHxp6Z6zGkM68VdxU/wPOiwZOyDUk5Hycd/i1QQ/y
         5EpX3mDuRHumtbevvhcgME6yT5s7je3nWuBJm7Y6T9vsYFJR7K5GZ8E2P480Ec/I72QF
         ETTFhqTPp6ampaUH/bzrcSZnw5S+73L/mhjFWgN/9bi090CbEzbscKhDF8dIqzpTbq2n
         OmmfwG1XCyXoapju+J0RimDKwP58XHJEo12kdXcQNMEGuB5zRkWuLu5eO2lRUoWURtdl
         yW+E/ggDEZ4r5WJ40uWTTaVOfkB+0Hkhp737x7dH86G4TnllFdsNPm3cf3oel3X0UREf
         yklQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd6phe6ys0phXkwfnBoIsb1QDcK58yke7XHNjxYI7xZ6QomyyNXIpLWHShAUZ69ZV6E2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoANwVmJQ0ia8Mw1PUqZki3gCjIrzZf7LEFQKN7WGLdTggulzg
	QCY7KZw5TXTtYD2NJMUls/+ibTmMGdbEVhgR5jQEF0yjHjTzC8jpQHvD
X-Gm-Gg: ASbGncusGSHLfVlwcZueFr47/t2HorTuWDol/e6RHqZoWzyjDkliuVskzesweGfXKtF
	ML2+Sz+DK4vYtzH0LJLlm+awR8lBMpExBLZtl28VCzABL7tEZrDo9YwM1As9cr1NusnrXOCxglu
	xnqfWYPuc7lVl6SMjSladQt5nE6mpskibj+fRHxR8RAtUPu7NxkCdCNIFrXjrVkvuwUUjfEGD+7
	9N8f2gFdzLouQlWYkL1CmSLjqu7yoF+D6iVuXwLbLOaX1+SVX5Yrs4tGIY9hkdVFxnDdeCez2Xd
	IC5ZgTiErBfk6dEZEQYrFK6hBrSYlkvKp/Y9AB8ADijabDQB1PZzBtmbHz5prSh5+FpWyjrWfN1
	axKlvSj2/BLU9F4STTABQi4U=
X-Google-Smtp-Source: AGHT+IF9C2agS8+zL0IpIbLKYUMbJ9wYKyE1ozVIU8WR1LaIaDb18c9B0zjkJGBe5SEmIuRe2K1wXw==
X-Received: by 2002:a17:90a:c10e:b0:312:f2ee:a895 with SMTP id 98e67ed59e1d1-315f26b3f3bmr7856621a91.31.1750927850546;
        Thu, 26 Jun 2025 01:50:50 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:a1d3:1456:244b:d366])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f53d83f0sm3686118a91.32.2025.06.26.01.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:50:50 -0700 (PDT)
Date: Thu, 26 Jun 2025 01:50:48 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/3] daemon: explicitly allow EINTR during poll()
Message-ID: <ypopyf663bxcj3lakoa3vmxinyj7ipcjtuwrbu3i4uhga7ono3@ubxgvqpntk7u>
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
 <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <xmqqa55vyfdc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa55vyfdc.fsf@gitster.g>

On Wed, Jun 25, 2025 at 09:07:11AM -0800, Junio C Hamano wrote:
> "Carlo Marcelo Arenas Belón via GitGitGadget"
> <gitgitgadget@gmail.com> writes:
> 
> >      +@@ Makefile: include shared.mak
> >      + # when attempting to read from an fopen'ed directory (or even to fopen
> >      + # it at all).
> >      + #
> >      ++# Define USE_NON_POSIX_SIGNAL if don't have support for SA_RESTART or
> >      ++# prefer to use ANSI C signal() over POSIX sigaction()
> >      ++#
> > ...
> >      ++ifdef USE_NON_POSIX_SIGNAL
> >      ++	COMPAT_CFLAGS += -DUSE_NON_POSIX_SIGNAL
> >      ++endif
> 
> The new symbol sounds like "POSIX does not have signal(2) but on
> this platform we have a usable signal(2), so we use it here", but I
> do not think that it is what we want to say (as POSIX inherits this
> from ANSI C anyway).  More importantly, this "USE_X" sounds as if we
> allow builders to set it and magically we stop using sigaction(2),
> which is not what is going on.  We have tons of calls to both
> signal(2) and sigaction(2), and we turn calls to signal(2) we have
> in daemon.c to sigaction(2) but on some platforms their sigaction(2)
> cannot do what we ask it to do, so we are stuck with signal(2) on
> these platforms only for these calls in daemon.c.  It may be obvious
> to those who develop and review this series, but not for anybody else.
> 
> Isn't the situation more like:
> 
>     We use sigaction(2) everywhere and have been happy with it in
>     our code, but this topic discovered that on some platforms,
>     their sigaction(2) does not do XYZ that everybody else's
>     sigaction(2) does, so on them we need to fall back on the plain
>     old signal(2) on selected code paths that we need XYZ out of the
>     signal handling interface.
> 
> What is this XYZ that describes the characteristics of
> signal/sigaction implementation on these platforms?  A name
> constructed more like SIGACTION_LACKS_XYZ (hence we have to resort
> to signal), possibly with a more appropriate verb than "lack", would
> be less confusing.

sigaction(2) doesn't have any issues and it is indeed a better option
every time as it behaves the same in all platforms that have it.

the problems we have come from our codebase:

1) we have a hack to workaround the lack of support for SA_RESTART in
   some platforms, which sets it to 0 and allow us to compile as if it
   works.
2) Windows doesn't have sigaction() and their compability version needs
   updating if we would use it for this new code.

Keeping the fallback to use signal() isn't really needed, and is indeed
problematic, as it crashes in AIX and probably other SysIII derived
systems because of the hack Chris described for non BSD signal().

Carlo
