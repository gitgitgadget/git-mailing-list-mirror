Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD92322068D
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080700; cv=none; b=S3my0XnkgfI1LNP7MyoxA4ecDeOx+iEJwpapWgZldeupEYBotvbIguXAS/qJpKpwpu2tGxhVo3Ywtrgn5TErqruzgSjN1E+oOIE9fY9tK28zA0CzOohxEtwl1HMa2jA6LoA+lgK2sFzK7M2ikq1PbDrsaU6DaeLbUW8MVlDR64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080700; c=relaxed/simple;
	bh=8Zqzx25tFRQnTKMEZpTqeCSVbCokzTxySy6/LMOwZdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPxQZUxTlx/4WotRKhBUPm9bdRdF4K4hAJcK1csXkwpDdajZfvtkSb64tCbh/EVwVNM6ifNg8XEufYqCv75EDQRUkNmhoPmnfEML4j14ONmT0sN0VYroJNTMwNJeIIqjVBygY6vHUOgF1EO3+KznKw2rXHmaoPISmi2qvLukBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSKor3dN; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSKor3dN"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b3508961d43so180644a12.3
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 10:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752080698; x=1752685498; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FDhcWY/Sh8r5Q0K1H4DQHCiRuv6tpezjJz1ZNEQZqWs=;
        b=nSKor3dNVO76RWz9bDWGzpuuaHJoUwZ32G2dwHLfu247uVaVipoMmsx3HA/aFHA8yl
         nb5iiAkLie1gArLVPT/TJjEehq3hzVJoXxUd55HwKGiD6CMlyM11BfGqiFFbXMdAYcUT
         7KusDafRINxB4aEAaUp6FbQzeTgwPx+yE5AShZ2RJjYGBUYV+zTbPG1uVqxZ4SJuOyBr
         PlsSumznhz/Jt7iT9ngo+i7SjXfyLg4w2rNhQBYkuaSa7kmfE0/DEHspp0mYFDXRkNW6
         qPm6gEgBY6bd60/PbumjPgIQvz/J9FML7IxRynZ8DSVlsmYoEKAajPPnhtAkNHdQSATr
         A1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752080698; x=1752685498;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDhcWY/Sh8r5Q0K1H4DQHCiRuv6tpezjJz1ZNEQZqWs=;
        b=RAPfvtEkAPSWP1DEJCh5rl7SOeLXnYdxeqfO3opyzIfNXKwRpkRsSV839zekgCZemQ
         k0WiL3ZBg7y6uagOTE92QEjxnb2b41UjS5GbJa8LyZ3Il8l/Da6zo0wadZFkn26jd5Cs
         3q+n8IM7kBFJF0RAbEiCEIyKojvk0bADyr5izupQYEO6WRO+gpJ2/wZI0B14xmYBavam
         4EhXq40R62rRYi6vkkk3dwl0bWcNCxjKQv2jfYeNiiqHfoF+TU5lBuySrH7kiQOT/+1z
         tsj07FmmIPM42au6XW/WkvYCilfHvKYt47BZ9DMiTzpSat74uR1nqNzxRXyI8EoyEqeo
         adCA==
X-Forwarded-Encrypted: i=1; AJvYcCXlHasZ+tHxDukBt5z7HSMi7KG23yXAHgrsagVVakKjFssnCWFFaKT/TMZqh2FBRkZdAMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA0XROmHK6SMKOUCagfknb7+mvPPC9KO7kIUFI2jELsDEpMEr9
	YCMl+nO6OyX4wlHPyeNecDmfdfoJaeFYdOH4MbqOeNuZxnh0pRkCrnxI
X-Gm-Gg: ASbGnctWavX4Ffm1IuumLxzWaKeQArjTP9ZXPJe6JaeMcBM/lPsVaBAxzrzfcLfKSQ5
	zXHy0NwP0SYZK1ulqkSYJwC1jJCDNfrwMPaq/00dXrEAOA5JrnmhG4ca+rC1k+Pz+aK+kIUi6fC
	7vAK+JfE9iAE79GqMxtheoOKwiImC/dqs/sWik1L9pKgfjE17Fr1gECiwyj+LW7FEfRkTbu+0jM
	xdr8VTmAO/MGRjHa5CZmqNglPGzvgJEGuV5CMHRcYgCZjYm5iEr03WzH2KLC3ga7SLvuS4gCnSM
	IxaF3U6mJ6LzpWe08IBEWFV1z7PDPeD3jDB4WvbH8j0bxmTESXdzuAwVWrTh4CLsRjFvjt80u2V
	hRx1Aqfwll564ICfilEK5gLirdDB6Uk8I+g==
X-Google-Smtp-Source: AGHT+IFovWKkCzQTsbwtuDtjW+EqzWmatqrgXB6qaLnh6GtY80pMnVbIBv3AAaSwq9f4DPqmIGcFVw==
X-Received: by 2002:a17:90b:4c84:b0:311:ad7f:3281 with SMTP id 98e67ed59e1d1-31c3c29beedmr1031984a91.12.1752080697825;
        Wed, 09 Jul 2025 10:04:57 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:ed82:7a2e:d82d:94a6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3003e413sm2674389a91.9.2025.07.09.10.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 10:04:57 -0700 (PDT)
Date: Wed, 9 Jul 2025 10:04:55 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v3 0/4] daemon: explicitly allow EINTR during poll()
Message-ID: <fqqx2jvtwlsqghgjxrp5e4q2ti5mjbwg52ttcbaabmtrlacrpw@t4pbsdiebeft>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
 <b1027221-3e17-40d2-b293-4b1625fa095d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1027221-3e17-40d2-b293-4b1625fa095d@gmail.com>

On Wed, Jul 09, 2025 at 03:12:43PM -0800, Phillip Wood wrote:
> On 26/06/2025 09:53, Carlo Marcelo Arenas Belón via GitGitGadget wrote:
> > This series addresses and ambiguity that is at least visible in OpenBSD,
> > where zombie proceses would only be cleared after a new connection is
> > received.
> > 
> > The underlying problem is that when this code was originally introduced,
> > SA_RESTART was not widely implemented, and the signal() call usually
> > implemented SysV like semantics, at least until it started being
> > reimplemented by calling sigaction() internally.
> 
> I'm all in favor of using sigaction() but I think the SA_RESTART parts of
> this series are an unnecessary complication that has the potential to hide
> bugs as we support platforms without SA_RESTART.

True, but those platforms (except for Windows, which is otherwise not that
relevant as it doesn't fail system calls with EINTR anyway) don't have that
many users and are therefore less likely to uncover any possible issues with
their use cases.

I know patch 4 looks silly, by enabling SA_RESTART just to disable it around
poll(), but it addresses the root cause of the problem stated originally,
which is that we are very likely to have SA_RESTART enabled on SIGCHLD and
relying on the system to excempt poll() from it.

Carlo
