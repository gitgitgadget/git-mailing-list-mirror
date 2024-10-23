Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53F1E2826
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704305; cv=none; b=tKCXLFrIVuvc393sFNHwzsjaWEnbFQzR/j3fR8uTVKd4EvTcBfKjteOJdKmn2AMj4zmNEsy0qidaY7ttdu9MueuqOeJHII3xUQ1GtKWB0BnGbTTVvRC7uxYbE+1CeHIpQ8tDHpnTzWHWOT2hSFipmrwziKMMjv1LWIFkxNZh2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704305; c=relaxed/simple;
	bh=/aogvhYaJraYkPaX3NWhuE3t/pwGkYMvzRX6gP/WNFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arjXXbNpa6pBS1OCawuvP2dA2QkhP6dyEpI3C6gGxQ4lVEK37K//GTlyfb6Rq5W0112KuytXQCvhzK4x4RRs37RuuVnkzijv9OMff86RWnGnyGqnf+FTmW/MSoY0yrcyd6kXbMXDU8cw5XIKFDpWd7cQQ1QAd+gOxC4KYC8emII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=L+XlKdwZ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="L+XlKdwZ"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e2e33f614e1so38789276.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729704302; x=1730309102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YzwKtke8Vqk0VSOxNrjvRlFtuKwYl2tgWa7lA0xVtBE=;
        b=L+XlKdwZOvBk8cGqMS7UPCT299awXRl6+l9W7bQ5RCQh2e3QG4qqZ89IaralRhb4bq
         WJI650aJWeWnRQHwcP6qIN7xMnw6VI3UEZjF2WALnPJ6e+YDwr1LQKm8491ONqhPxafI
         jCQ4lpwNoc83zTE35nBkKyayBczhsl61ZyGM5yid6dTcrL7HLF7Bl+rKAwLf7LGjh9FZ
         qHYhTlDU1+CNSq9MuNiWn9EEEFqVxYhpSUVTq2JeuGsVqVxQ0nyAIUkPTupq9jJP0s2s
         s5uPgr0XJqPzlvl1tX/W4+glRVvVDhl8zovBeXkZaPkBbMPWNTgawG1JTETpilSxkkWn
         2voQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704302; x=1730309102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzwKtke8Vqk0VSOxNrjvRlFtuKwYl2tgWa7lA0xVtBE=;
        b=hqnMDHnreDibcZ0i7XpQaBeEdooIq48hSKoITbK81JBKrI0JhVDG+YdZeASO8GKYJV
         rYOVW4nLrC7YVN87+WI/yBX8y0dLuWbQEBwAA0wyrSNfqhjpVqULdHIiWqBm1AP4YPXV
         kZWb0y5+T7popGApZLjJFFaEy7vP0m4BDdFKPlz5P8YZYWCXqPoY6dBuOBmwIpiYZA/R
         Ad5GAu2FqTnfiG6kmfhpV5yzBgoYY67x8VRDCe35aQHK2Jd2IJYUIo999wkhiooXD+VX
         buasXiEFIGPbT5HuGXv7kkCWmOLty9BHLd01g2rNFpLJ06/H5JWkC0Gz/+FDllsRMA4o
         Y/iw==
X-Gm-Message-State: AOJu0YwuDoGqFcmJL9e32jfs62LfxVg1qAbPeIFPZdMkHFScL6eZ7qSK
	+laa1Kn/iyNXIXt6QorCCZg43O/e5kT4w/JhXKyiW42qxphcRv9mz6qlc0Hl9zdJRYd9hrc0UcM
	ELiE=
X-Google-Smtp-Source: AGHT+IHD599e8YTRpLxkh21JAwgM12a2wuDvI3tdkJy7ef4hv7JjsKkm8CSFwT94heHbsF2wY3BABw==
X-Received: by 2002:a05:6902:2b8a:b0:e29:e81:fe45 with SMTP id 3f1490d57ef6-e2e3a6cfe7emr3408958276.35.1729704302403;
        Wed, 23 Oct 2024 10:25:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdc9b61b4sm1539377276.37.2024.10.23.10.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:25:01 -0700 (PDT)
Date: Wed, 23 Oct 2024 13:25:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/3] compat/mingw: share file handles created via
 `CreateFileW()`
Message-ID: <ZxkxbAjPqr+t+ssP@nand.local>
References: <cover.1729695349.git.ps@pks.im>
 <907576d23d1dc39b679a323e74b6bfb227d6c17d.1729695349.git.ps@pks.im>
 <ZxkxAvLeMtxstVdS@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxkxAvLeMtxstVdS@nand.local>

On Wed, Oct 23, 2024 at 01:23:14PM -0400, Taylor Blau wrote:
> On Wed, Oct 23, 2024 at 05:04:58PM +0200, Patrick Steinhardt wrote:
> > Unless told otherwise, Windows will keep other processes from reading,
> > writing and deleting files when one has an open handle that was created
> > via `CreateFileW()`. This behaviour can be altered via `FILE_SHARE_*`
> > flags such that other processes _can_ read and/or modify such a file.
> > This sharing mechanism is quite important in the context of Git, as we
> > assume POSIX semantics all over the place.
> >
> > There are two calls where we don't set up those flags though:
> >
> >   - We don't set `FILE_SHARE_DELETE` when creating a file for appending
> >     via `mingw_open_append()`. This makes it impossible to delete the
> >     file from another process or to replace it via an atomic rename.
> >
> >   - When opening a file such that we can change its access/modification
> >     times. This makes it impossible to perform any kind of operation
> >     on this file at all from another process. While we only open the
> >     file for a short amount of time to update its timestamps, this still
> >     opens us up for a race condition with another process.
> >
> > Adapt both of these callsites to pass all three sharing flags.
>
> Interesting, and especially so noting that we *do* call CreateFileW()
> with the FILE_SHARE_DELETE flag in other functions like create_watch(),
> mingw_open_existing(), mingw_getcwd(), etc.

Heh. mingw_open_existing() passes FILE_SHARE_DELETE because you added
it. Can you tell which branch I'm 'git grep'-ing on? ;-)

Thanks,
Taylor
