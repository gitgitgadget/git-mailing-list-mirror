Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8EF154423
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728219779; cv=none; b=SEaTPJiGWElcyhODG/NNyQju1w+vVumdgxBqYCV5ubeDWOgayy5RX3X76a5CQD/31703SM17gu5zsGlon0zhJUJmQ4/Re2trDBBqlAq9wdRAlSxNurMBsxz6mVI6QE8riYrWyx5H2361EHdw9v38SkCraSqQ9kDXhBZgkZTkgPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728219779; c=relaxed/simple;
	bh=qt8prmAk3/UifdL+JmxYWlwTknQu1F+6wApUUcHRtBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIAT+0lJTVYPkzkQK/4ZslPUkcFBdIf/NZF/V1vu6O507gQWCtD3X1/c1tz1IWPvNDy1oAUg0jlDhhslaKzG/0+zoEZHhUG0u/ooIeWpNd1OpvllTK+kJhCDxlnc4YDVvBm3L7sl1L6wgqxf9j49j2mQHEJVhxJ4h6YoK4JHWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUESdGfZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUESdGfZ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b0b5cdb57so33828025ad.1
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 06:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728219777; x=1728824577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DDVeeo2rxudoDqls3sBlXRP1harle2HqbmruGdldGyA=;
        b=NUESdGfZr2H4bFm/i51MYYZRnGofEnhp6fCNLykywmsaSArG2J2GcqAqpfbo7NzjrY
         GRwdskrEwhDiadPY2ZVK3vcqbOmywZrR+Zpxngxh0kL1l6rfIHMjWz5gf46Yzp/snSXr
         eShNcIYUFU7if+pStcM0rXiZ+1oN7TmHFi/XqBwPv06lcWpE4Dac0XHXb0kl+Czyt9/f
         8GoItNbHBVqqAQtHB/9FgIaFeq35k9iOJxq/g3bigE+04kAVOJx8zsyaxYW93Ty57k/O
         v57oByZlCmEyc9KigRy1Fod3l7y4v6e/XkfNIQyM/qF4WDiWJRHZUaOl/ezL3j52cUrA
         rbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728219777; x=1728824577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDVeeo2rxudoDqls3sBlXRP1harle2HqbmruGdldGyA=;
        b=TURSEDT0bHn9DoKrw0AOhVm2MTbZajtShS0lUBqTpfXLh6pHhCeELVsacbSQBtmMN0
         IySb+tO/hzTQFdEf/lCkumrowswWoTZZQAOjk9I4t3zQ8t6gGw4yueuDrSbRidxufQX7
         +Twf62VoA37wYuxOBHmnpGRs+OY3hGFJGDu/nmbl81zZXVmZ3IMrEk9CTCGTCaDNWIAM
         uorIcb4G6DkB0/kcYltXKftX743VnBqi/3SbWev6fcrK2I4Cb7wERveB9euFg6wToGYF
         /wWlSRYG6vmEwxAWTCKGsmXBvjypM1DdpwLbHZ2huLni++PCaN1nmgELo2MNlMOkfuxZ
         bEkw==
X-Forwarded-Encrypted: i=1; AJvYcCUa5PGkhwv9KPNe88V8wViKDd95oNeMgEYbRtfN7ROHF793BQYP0/Om3TGWP3eoV97pGIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmznAGp62j64aodc72SSUwGt4P/NedylO7/+SeUn1RDYlM8V2m
	zNr4n7rs55+O1gl3i9uVsTffPbYmqQ2a10XVcD/ocNhIDCQ7w+XjgXc6/w==
X-Google-Smtp-Source: AGHT+IHAsL8nQmDbgaF8uVMGBV2ex9osDqLoUpk0v+NU33fpcl/8GhfL5rej7PycG7nHb1w5ItUXHw==
X-Received: by 2002:a17:903:41cb:b0:20b:a8ad:9b0c with SMTP id d9443c01a7336-20bff37b136mr134490595ad.3.1728219777056;
        Sun, 06 Oct 2024 06:02:57 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cff51sm25199575ad.87.2024.10.06.06.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 06:02:56 -0700 (PDT)
Date: Sun, 6 Oct 2024 21:03:03 +0800
From: shejialuo <shejialuo@gmail.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] [Outreachy][Patch v1] t3404: avoid losing exit status
 to pipes
Message-ID: <ZwKKhzbeyQ5e_H9Q@ArchLinux>
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
 <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <CAPig+cRePbX6OyE6WhFp1GEZenZyC7HFeA3188F_nErt7Gin6A@mail.gmail.com>
 <ZwJwsuf5ZOKiWbS1@ArchLinux>
 <CAPig+cTVf=W5KXkE2iTxCSPmZjOSbmf90J_JugDuTH_xudcW2g@mail.gmail.com>
 <CAPSxiM-bx7KdhP0OyajfiTczg-WqiJDPso1EAxLzntLqcuOUkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPSxiM-bx7KdhP0OyajfiTczg-WqiJDPso1EAxLzntLqcuOUkA@mail.gmail.com>

On Sun, Oct 06, 2024 at 12:28:26PM +0000, Usman Akinyemi wrote:
> I am a bit confused now, I am already working on converting the
> test_line_count right now. Can I update the patch or do something
> regarding the first patch ?

Hi Usman:

I have just scanned the review from Eric.

> These days, instead of manually using `wc -l` and `test`, we would
> instead write:

>    grep ONCE output >actual &&
>    test_line_count 1 actual

> However, that sort of change is independent of the purpose of this
> patch, so you probably should not make such a change in this patch. If
> you're up to it, you could instead turn this into a two-patch series
> in which patch [1/2] fixes the "Git upstream of a pipe" problem, and
> then patch [2/2] converts these cases to use test_line_count().

If you decide to do this. As Eric has commented in [1], you should add a
new commit (a new patch) followed by current patch to convert to the
`test_line_count`. Then you should re-send the series to the mailing
list. And thus you could enhance the commit message of the first patch.
If you do not decide to do this (the current patch is enough for the
microproject), you don't need to reroll for the minor things.

So, you should never update the current patch for converting the test
using `test_line_count`. Instead, create a new commit to do this. and
BTW you could change the commit message of the first patch if you want.

Thanks,
Jialuo

[1] https://lore.kernel.org/git/CAPig+cTb4mgpXnN79UrXvjvCnqGZhaR51oZX_Ds=HwdqQYFN9w@mail.gmail.com/
