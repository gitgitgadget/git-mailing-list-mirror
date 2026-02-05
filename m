Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA4199E89
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770315542; cv=none; b=fNOGNTCEEgue0AYkp9YCjsnAJi7pZNH6UJ6Gq3ePhbI4PeozaHLM2sX+IuhSji7Wra+P/O8UPHsIk0u3H0Mi0TIqdh9xwdm1lURN6NYfpaLkL2+UVOnPKX2LnIEiAXwn9KaYXdIsiTH/RoodxMntQNpOspv7kL/Cxuiqbt3B7S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770315542; c=relaxed/simple;
	bh=/3TeWhFCFpF4sfT5xNVB9Oh8eYlXtPEPrbt743BY0dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFxHB0PPyp2DUnwKZXPUl63RMN3hulCmIuaO2itZXVhtd/DtPeqI2SUxbBTeuMS6nE4/tiV9nsCFu+ZK2jLFRjAlrBYwcqj5aQlroZVQpBnoUxXn5ILgYFM/jTBi+VK2cK3Llcb4tNpfgSdHpWDrIVsV+YRRMWkzrLahMGQ3Ww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUadmQ5a; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUadmQ5a"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82418b0178cso798634b3a.1
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 10:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770315541; x=1770920341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4nuWr57mSd/HoiY8tiS1M2suqY89Ksj1afGBViqJI0=;
        b=OUadmQ5admOB0QMplVqBCzkBvP5OpjUrSol4EyYfFFz9xi8ttGZs0Zzn2myXEgtIFQ
         gNO4ydBzeK0QtXmsh1zMv2UBLNzgilv1wXiz40f+/O2rud33IvLOAiTltD2WoGZfX48m
         u0SADct2Sw14hpD+MmR0SBPh0ZBZSuzFJMy0vUsAaQlm+G7gVXQJUB4M/Cc/QH3Dw+Wj
         oiXr/mX6mErS9XRNpK0RG/cvY9bFvxNaCigo8y+wac0dWdpyKxfernzj+EfVhK3P9YzH
         GvVMt9dgvRdikRlnFQgrH0PnGCi3TZVrssqNgm6po0IFn8rFQB2BJcAnhMNsjf1UZX+9
         fBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770315541; x=1770920341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j4nuWr57mSd/HoiY8tiS1M2suqY89Ksj1afGBViqJI0=;
        b=DHAkBqpfNF+YNLA8R+JMzLbgfPbrqnKdEYb4juHrarzgg7eoDboU8F0uTaIJALA6bz
         S/kEpXLNl/6TLbu7cFn6Lutr3r8I5eYSaH1GLZ6XBKkP030e5yyFEoXHjc97uks0nekE
         Y3hTPPuHYH1l5/OkkpviHhG0LJ06+VjiX2t3Hpa4KrQaSpW93jQZYbnOJFmKID8w3D8g
         lI0SfW7vzbkmrqFby/CeXOeY/DJNd0BHwldOYeNcVugBJiDvTptX89VJOyTBCuP8xtAq
         Dfg/SiLl8RCUvjSvvYNONj57gISKMhA69WeZRrCxT6q9/JODx90/7OYOr8ODmq8dUozg
         PpBQ==
X-Gm-Message-State: AOJu0YxcgGfQIOSrSIHQ/+RO+Ws83O15FbIsy/waM9gPNTwOAj2daLhD
	eCpgrjdkS2Op6cMUZMpaIwx61Pb7r613op2RdjQsSQxWV5g9tOjvojsZKcQCeQ==
X-Gm-Gg: AZuq6aI+0k3xEc4RYQFrloJsl4nuduNvc7Rq7tyjnjTsYULezSYxpOmI3J2a/WzEO+d
	WUU+A3nCnm873xJtRVugUHSk6EfqmwMb6oJIMP6HmI/y5PreVF/mvSqkJx1lVvoKRV3RzKd6/mK
	7bfD/5/oWpzENMujj61I0w7SLGp5rxduBAENWjISgyeaUykT/3QVLkn3VOVSEagHNMg53LSLF8e
	NOJGK+POOZ1kgOUKcsHZuILvTcFoM0HLn1r7JzuRxpNOCxmRDx5ksVkoonD35bmUte5gaBajEAX
	Ald83QUCwrCxfNLIe8zQlXgSIsNb9FtciBULV2hwaGnwdKfxzZsRnvuV9jN6/RzbAHCmxtVjq6b
	SNjGEnHD9rEGp8CSQ23Fwf5Y4m+QVR68Ru69BuKAktc77OWfVrHQeQa8dNBgHVowOSapmdGnpAj
	RlwjKDiqeyqVogM7Z22XVtqFdTkmiRyhWY2d20aiFMccy0Neg=
X-Received: by 2002:a05:6a00:140e:b0:7b9:4e34:621b with SMTP id d2e1a72fcca58-8241c1f5863mr7422298b3a.12.1770315541410;
        Thu, 05 Feb 2026 10:19:01 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:92cd:6412:7a93:e84e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d487886sm7952502b3a.59.2026.02.05.10.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 10:19:00 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH V2 0/3] wt-status: reduce reliance on global state
Date: Thu,  5 Feb 2026 23:48:43 +0530
Message-ID: <20260205181848.68421-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20a892fd-ca59-49a3-afca-07cc003af052@app.fastmail.com>
References: <20a892fd-ca59-49a3-afca-07cc003af052@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> On Thu, Feb 5, 2026, at 18:39, Shreyansh Paliwal wrote:
> >>[snip]
> >> As well as describing the changes it is very helpful to include a range-diff to
> >> show what's changed - see the --range-diff option to "git format-patch". I've
> >> pasted the range-diff between V1 and V2 below
> >
> > Thanks, I will keep this in mind.
> 
> I’m personally a happy user of `--interdiff` in addition. It’s a nice
> supplement. :)
> 
> https://lore.kernel.org/git/CAPig+cSErj4ZB9bHB8mZfzNkiaN_EpjT6b4b=cfsf_+KMqytiA@mail.gmail.com/

Sounds good, I will try out both in the v3.
