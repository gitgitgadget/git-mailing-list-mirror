Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F963D64
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 06:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726987821; cv=none; b=sj97laLTU1QK36VOmeDo/8aD8AW2+h6tGYCLIpAyJgjCB0e4Cv1DtAi4hvY1Tf11Y/HYUJWinwy/YznMoCVhnUoTdrZCBBkcMIqRm/MNufbogF+W803EJ4DMQ3MMEwmSd+waDvyRkmEQeXNGYUrrXLIwXXUyWmicKCcfMD6lcYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726987821; c=relaxed/simple;
	bh=LfyW4oxCI/0HV23YfAIi5EfVtfy7/tXHqMY5We8rM6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKRWzBE8/lXQOd23TVJkbjr3BdCxU9wBpiWWWSyTfe9DTx37ZXxcKYo5VqVem9rdXODQh1FUkWUQg2+wBIHut0rYPyfiULNWVL97iW6GDzYS4x7PwK2GNmb+/Qfw7XIfba2p7EKxFFfAit1oD1qga7hMYI54YYiu5FlYZVfTlqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ri8k49hx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri8k49hx"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d88c0f8e79so2737429a91.3
        for <git@vger.kernel.org>; Sat, 21 Sep 2024 23:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726987819; x=1727592619; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a5etqgKi/IIn6tngE9X1sGwMr57CuSC70esQ3fNZshA=;
        b=Ri8k49hxn+v9eklKOoARGjzp8lIBjstOs7UDb9vdJOY/ZOuBPMAljJcxZj9N53Ng6x
         HtvJs5Myn734dM0etNBjIB2mHf47rzCDxOple6Gy7vUdh3AZlUhiTdKqlkz3VpG4gaRE
         L1ALxSVkjfEvpuGgV9Bbmo5prjGTEm4FHyU/YXl7YUpwpgf3xmHn+m7MHUfQd7bQioKv
         QDnSyzxhqOT3cPcqir/Et2oJgOslqthoNsNDA8i/YIBWo72DIZBTQ5w4LuXXG7O+c4xx
         9hHdlEmuR9lVZpI/9N3hVBzbnMrTcAMA3Rezv10jL2GZ3Ba9y6SdXT9rP6zymqlFM+lR
         kX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726987819; x=1727592619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5etqgKi/IIn6tngE9X1sGwMr57CuSC70esQ3fNZshA=;
        b=YN90aTc5ciLBjcSEDnZmZ6r+Kw02Gy/ld14YCq18iSYh6PPaSfDFJ+fDCrcrOS6oBw
         loilmb7FjDuEYLVlFF+BCD/Tkv2kM5OOb3lS6QjWkCNoda8eNiOvv5DAaEUGHjssthyB
         xYRueXqQ38KTduglJMY+hy6xbSYjhjTQkUM1dRz8mtEHrKNHAtaU6+KHpqV+sFHs5w7y
         xcub4F6tEF6Vs/9SK0qXxB/PPGwj/pc+47GmdUVJ9IZiCoenk/LvmR82dCibFsuIjD87
         dJ/qd0RM/KgL1OrbgH65nalZiKYSo6VPPr7qCVBAZFRRpM0oWfHkXY8BY1IHi9M+uVEs
         QOKg==
X-Forwarded-Encrypted: i=1; AJvYcCVVyFaUkmtzYrjg9vgEAeoN+u9yRfhbck2kvl/6CGpS0O6XxtQt7PKwT/ep7aOLt/nC4a8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7vBo9c/OJD0QIHh55PcESIbhKshnVqB/4Bx6nsMLZ84PKrzu2
	BKQzHT3QtxtMLFhjF92op2q1wLKNhXGivofRj3ChiQffB7ZaHG2oU9rCFA==
X-Google-Smtp-Source: AGHT+IGUvfg79rPmeDrSF4ix9Y40ih/vSTzpnDafWgWw3TNjx0851dmnAWCHCTkzk913EIquIRzZ5g==
X-Received: by 2002:a17:90a:a391:b0:2d8:bb95:56f6 with SMTP id 98e67ed59e1d1-2dd80c964abmr11315003a91.30.1726987819102;
        Sat, 21 Sep 2024 23:50:19 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ee98b8dsm7087884a91.16.2024.09.21.23.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 23:50:18 -0700 (PDT)
Date: Sun, 22 Sep 2024 14:51:30 +0800
From: shejialuo <shejialuo@gmail.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Ronan Pigott <ronan@rjp.ie>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: BUG: refs.c:1933: reference backend is unknown
Message-ID: <Zu--coU4qv6Z1SmD@ArchLinux>
References: <1b9fb3f3fde62594b9ac999ffb69e6c4fb9f6fd6@rjp.ie>
 <Zu7vpPs8fcqlMlNK@ArchLinux>
 <9fdb9561bb0ad85e55ca3253cc4db9b098641e30@rjp.ie>
 <9bf5c254-4d87-4f6f-b278-d9df4d7897b5@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bf5c254-4d87-4f6f-b278-d9df4d7897b5@web.de>

On Sat, Sep 21, 2024 at 11:22:04PM +0200, René Scharfe wrote:

[snip]

> I wonder if the BUG at refs.c:1933 should just be turned into a die().
> Or should ref_store_init() return NULL (or some other value indicating
> an error) and all callers need to be changed to deal with that?
> 
> Simply checking whether --git-dir points to an actual repo earlier is
> tempting, but would leave the case of it disappearing after the check
> unhandled.

From my perspective, it is not suitable to change the "refs.c". I guess
the reason why Patrick uses the "BUG()" is that it's an internal
implementation and we should tell the developer something is wrong.

In this case, because we use "include.onbranch" configuration, the
"config.c::include_by_branch" will use "refsc::get_main_ref_store" to
get the refname.

However, the repo does not exist, so we cannot find any ref backend. The
main problem is that we never check whether "the_repository->gitdir" is
a git directory in "config.c::include_by_branch". So, we do not need to
check the value of the option "--git-dir".

Thanks,
Jialuo
