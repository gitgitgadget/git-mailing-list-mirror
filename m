Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4D62153FB
	for <git@vger.kernel.org>; Sun, 19 Oct 2025 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760895824; cv=none; b=b9gF5fDh4bkakS6uvkrYmHBVqZ9ofXGbzZJ5MHOS4Eh8kskr96cZ1YgNOQiyz8srr6aHm8D6U1uoMEoX+gF+tYArnlgsxWtbth0yuInKhYQr0/4HF5klkjLzumwc1ToVL42r1V2FR/2NetvmyZlMIzCqpcNVzvsZRo1dnT+XqhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760895824; c=relaxed/simple;
	bh=MXDhrXtfhG/loxFVzmC2nz1mDZdy/yhRHfKR+0Jv5PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHeBuu0OFxbwIFhx6Xb4ctoxqhY2s2mmBNjryikaKU+78r7bV75o+B36u322X0PxA7C+VrpRAZ0xXD47416NHOate/ThJgJrfF6IybZxJ6BxdGqXXc/X4EFh0jeIHE+NqJe4dZ8WKzBHzIk5PrIi3T9DTZXHF+ErY4mnKSkRVUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geiIkBks; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geiIkBks"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4710653ac03so1731575e9.2
        for <git@vger.kernel.org>; Sun, 19 Oct 2025 10:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760895821; x=1761500621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ez8hg2IJz+5CGpYwCmCCsoXSMmEsbiH8AXU7nfXHgd0=;
        b=geiIkBksXbbvCf3JOSvuImQqXPdk1wIbGIVYf2xjl7XS1LNtnahDt6T7gstdkmJ0N+
         VO1iIV0Z1kuKpgxLUZ125BY8phcBH1O3AYEXOse45yiQOInUAJYQTGGswX5jwm0Kw2g3
         uOQ2m9UbWgQgMi2gsF8MOfHt/zSV6GrPVBSYvCZzNPKyhHe0NMxOaqmPzAeMpDHH0yiS
         Y+JckCv1mHZYJBOpreNOqVyGr4aw1EB551MxJyaGtAbrsZHXSjVG/IW2S6eHbGfYVFVv
         ZcQ3qxwOUdPLJtbpobVLviZjFZU6uzITbVD1ReAphM6eKUB32eR9+0SdZSVjXxnf5zAi
         ZkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760895821; x=1761500621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ez8hg2IJz+5CGpYwCmCCsoXSMmEsbiH8AXU7nfXHgd0=;
        b=desCllv7Glp7GDnvrItb//TeACSigPd1iEiyWZduc6ioNo/xbThKLDYmBGBMdHlI87
         ZCXyrYQbQjsSN5qinz6eZz5qMCUr4lYNJFxKb56+4U29HLuu1PjHKKaQjmQ9cdMWoGFp
         7ZINbow8/QKyNejOCpVZTYhISd4XEcRB0mrKY0Z/zXKeX7vAcvnU7rrxws3Y9b/AFTAl
         yTGXv4X0D4fSgN0kKtC4OrgVLFnO+aV7sxY9JEBAfR9zWQdROAZ+qKVi8IGKwK4cITWB
         UyHIH9qlNjurqZe7rGHFZVaU68ddNk+b0BAzJ+2dA3lboMUsg+/i1kMbySkkB1QGMXHm
         Zmmg==
X-Forwarded-Encrypted: i=1; AJvYcCXLy7MsSv1kTzg/Mt+EghnOAZdWsLNFEJ8Tvd30lZWJKkP2S09hHzr1LU7qfSstTCE4Nng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM2TgVuQoLL2i48J4m5fYwdbYZdHtqur8/eujv7XtbK1RTineH
	90J9LBhHzvJZ1lj1RstMyQbSUhSIN1HUig0eTu9qLhXefJOlEYWWomHl
X-Gm-Gg: ASbGncvBG06opvHHexpinJ7gtdcAhxz4OK+MZATas3hUueNvsMBPNOM67nqEo5MKGba
	sbZsSiujlO5r0HU0716nSGXdqd1lowIcW3cxOjMUxIfyjV8ubpueEIsl4AM7UHfbWrpGuf4tYIM
	gp6xcCtiDyApsmHEwpS5S3oQeNQiEym5JD8FyPuI9uM/0o2MJhr5bNiK1qigrI5RJBcCEEpzJPV
	DmhREJQaLR63oc30549xCWNnNxXX8jJjNZhgW8QSHYPNr8qheY9DveXE2CpneijBBYIORweBv6r
	/dVWN/k5akAQUbNOlifMJKvMgATxKK4vIPu/lwEAEbNNGAslX2GPdqumD1AI180GjdwmESd0kwP
	3xaiK+eRCPjp/+HUdpDdFSiBaZ+kvIB/nM2NJmbhdov1amEG/sfY7PFAX3XVHsnweXNLd2bziNr
	bVQ5KYIVMtmBwg2gw=
X-Google-Smtp-Source: AGHT+IGU8lkTfv6QoRb3TShDinDi8NVsceDSI6TKwS/0CZ1GhoMtld+/qBie8VEc+gBA/PUxOikWbg==
X-Received: by 2002:a05:600c:3b04:b0:46e:2562:ed71 with SMTP id 5b1f17b1804b1-471178787c0mr41199685e9.1.1760895820899;
        Sun, 19 Oct 2025 10:43:40 -0700 (PDT)
Received: from desktop ([178.255.149.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5d48sm192841875e9.9.2025.10.19.10.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 10:43:40 -0700 (PDT)
Date: Sun, 19 Oct 2025 18:43:38 +0100
From: Matthew Hughes <matthewhughes934@gmail.com>
To: Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [QUESTION] how to find options set by scalar?
Message-ID: <wn3jjekjibcxbuiieji5umijvx5gaesg7wpwnivc5ng66sqpa7@cybj6wtz2eq5>
References: <vppjutjcdglp44qvsk4qozphycyg663yrq5775zztim2oe7ty5@uttjrshb52bd>
 <aMkVqNbdgxqBJ9K4@pks.im>
 <evxbvwwyo4p4iboc4k6r2cd2cvlnm2upgxumqopdijwmvhxhxs@7xvg42heibp3>
 <xmqqikhf7bdf.fsf@gitster.g>
 <08deb8a8-6c34-4f11-a36b-93d151a56f9b@gmail.com>
 <aNDqnMTJIoHi7Ifc@pks.im>
 <ffa61066-7004-48dd-9096-85b305373bc7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa61066-7004-48dd-9096-85b305373bc7@gmail.com>

On Mon, Sep 22, 2025 at 09:36:00AM -0400, Derrick Stolee wrote:
> Makes sense. I'll pick up your patch into my series as I prepare it.

I'm not sure if you had a chance to start working on this (I didn't see any
other activity around this on the mailing list, but shout-out if I missed
something!). But I got curious and started looking into some of the options and
had some questions (I haven't do much archaeology on the original Scalar
repo[1], so if I should just go dig around there for more answers let me know).

Firstly, there are a couple of options specific to things outside this repo:

* core.FSCache: specific for git-for-windows[2]
* credential.validate: specific to Git-Credential-Manager-for-Windows[3]

Could these possibly be removed from here (I understand scalar started as an
external project, so these are perhaps a relic of that)?

Secondly, I was curious around some of the CRLF options, in particular, setting:

* am.keepCR=true
* core.autoCRLF=false
* core.safeCRLF=false

Is there a non-trival cost to doing conversions over a large enough number of
files?

GC bits: I there is some GC automation disabled:

* gc.auto=0
* gui.GCWwarning=false
* receive.autoGC=false

What's the reason for this? Is garbage collection expected to be unreasonably
slow in a large repo? Is it worth the GC still being run at least occasionally
in a large repo?

Index bits: scalar will set index.threads=true, index.version=4: I assume these
are expected to just speed up most read operations on in the index in general?
It also disable index.skipHash: the docs tells me this speeds up commands
that manipulate the index, but I was wondering if having this trailing hash can
make future _reads_ more efficient?

And more generally, I'm not sure I understand the reasons for the following
settings in the context of a large repo:

* pack.useBitmaps=false
* fetch.writeCommitGraph=false
* status.aheadBehind=false
* merge.stat=false
* commitGraph.generationVersion=false 
* fetch.showForcedUpdates=false

Link: https://github.com/microsoft/scalar [1]
Link: https://github.com/git-for-windows [2]
Link: https://github.com/microsoft/Git-Credential-Manager-for-Windows [3]

Thanks,
Matt
