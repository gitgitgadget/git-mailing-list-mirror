Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75C8633F
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752608529; cv=none; b=Slks9IALgaJGSgX9yNbOYa37QwdHqRE1TYUDQY/yQ5THHYa3kB5kH1lqsqMBjDL/27PbvMvtzjN8LKH7E4co+euhgel0ecPC0+VbESPsylAgD9Pqo+GQ2v+UwW0JYIqML3BA2AQYIYWCNMUg8rimaEjfoEnqlSpqwyYqmmd1N84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752608529; c=relaxed/simple;
	bh=xyo6WDPXMH0keG33WwMCZCdVBelbfh+6IXFiCOTKYo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExyWEv9PNBIuaeHD0dKC9KJqOOYuuNI0/hf8/4v81Po9gjV8ruD6OdxUazVoYX1GRW8lR/zMn4awn1MmnN9ABczBm7pprij+/lxpIlYE7ne6KLq3wAcxSgIWGDqW01Zo8HR8oDyWxZhD8SriFPkAsNIZVQgh+WmMKlHIBO5gjiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+nWvxRm; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+nWvxRm"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-73e650f3c31so47086a34.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 12:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752608527; x=1753213327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tm3H4aQ/J50ZWRWBm4Y4Gvy9p8GmwxhdSW1SF6AFrOw=;
        b=C+nWvxRma3ex6iZoSK7DReLJvGQr4oDTt/tmLQtBjm2zg72CT7ZM3Adqd185sMlIiK
         LdskqtdZtuZXXZOl7xP35IeC9RMWxIfXaSPx0rNW8oAMGm+NJ+QrzD0FFIbiF+OSJDzt
         ySSqhbsEIwE7QFkN8VeB1Q60mu1tSzqdf4NNAL4Vs593+puyMmFXYHalsB2xPmPIkt/C
         9Hu89eEXIjOBjELKMQLoTU8rfMoCZ+5DGAC6KiYP477sH2oWnRi/ohzczifNMwy2vHbu
         EU52l5BDZjF/SZSmnzocB8GTezlk91gqkDRQt/oFJqowOYacT/NhRipjaQwNF0Ih/EHz
         +3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752608527; x=1753213327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tm3H4aQ/J50ZWRWBm4Y4Gvy9p8GmwxhdSW1SF6AFrOw=;
        b=cQNNUdtWY7yrR5x4+zfDTk6S/d8DmKCIo6jsRVbIqW4BHj6Sgywa7OtIFeKU7Q25Wu
         AMvWto5XMbvhGfGHGHV20mmCqkmcwxV338qe3Lohph/VjOqUC130ee1zooLj2z1R52tP
         5sSg9O9MJDsLZH4TNccIMKPe/Ha+/Lq3rT18uv2MaGgcP9qgKUtuHZbBIvNUf52cetsy
         Xpl04utL2MuMwpc2BltMNLtkDoU7EUVFZWBTyMWZ/jcp07UgsIsr1pHAs0ap2cqe16vO
         d2vMFhV+6y86eoR+9sm8eM0jLUwIixBy4+HRBNBtQQOP/cH3IF6T8Gv0+eKONsUxNbf+
         2puw==
X-Forwarded-Encrypted: i=1; AJvYcCWaIfuD0b+uQyOL6mwaR0hLlMKdy5D2A+YpCm7jxfG5vD7VU+2c7f+Qri1ovS5BlCjIJaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcNIFrVITVKeWdMcgBrmsrClVKu+XY/QF+LdYKqL17McyO5iRc
	kBf8Y1ySNVMEMV7v6vokk2FBPNtMj6FJUYaplrpUTlpxHv3sTdf6a8QA
X-Gm-Gg: ASbGncsyNE45gPa5PSVLsY55jFYuCFiBJUk7X2oEqhXTh/rBLeuTHPCOb0VMHOiFJ2W
	2Ag29pVTEuYITZfGPq+hJGGD1VOWQ4IoAsGenky1QW7xqBu1v4urGJSrP+D1Vb2laV6truT5jdL
	ugCWIUaY3txAh9DYbSzzfKk3KR8cX0+thvUtpe66UnAn4H2V/4/E4qE3oaGlx8VZUPJRREhlHO2
	IL9EEmqr+uv7UgiHLMZb2OKO51aXN8gt50K+Lc99JBt2aCNaEIr2eyd/AwHc/yIqPxCCvrvqb6b
	L+6Hs7JnIvLK5/Js51qQZhuDtBAdEi10SqodlRM82sMxb4x9v9tFc6sB5YWl1XqD75A9wYyxQz0
	ZqlGuWjOXQ2p2dBQ=
X-Google-Smtp-Source: AGHT+IGcWNWe612dWjSqjbDbicUCcWCq0NxGW5sEf/Fs/ZFwxPX2y4YxIKgpeJHe3iOQ3nFzlKMLhw==
X-Received: by 2002:a05:6808:384d:b0:40a:5356:656d with SMTP id 5614622812f47-41ced99740fmr284493b6e.7.1752608526833;
        Tue, 15 Jul 2025 12:42:06 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41418c0b8a6sm2163025b6e.3.2025.07.15.12.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 12:42:06 -0700 (PDT)
Date: Tue, 15 Jul 2025 14:36:24 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, karthik.188@gmail.com, ben.knoble@gmail.com, 
	gitster@pobox.com, phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH v4 0/4] repo: add new command for retrieving
 repository info
Message-ID: <o3hgyfke3tq3fjn7bl7iamq34k5kczp52phr2zvidlogcntk2z@dgts2mw2ius6>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <aHYuwlWlbkc600Ps@ugly>
 <aHZCfynoeMDRdN4X@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHZCfynoeMDRdN4X@pks.im>

On 25/07/15 01:58PM, Patrick Steinhardt wrote:
> On Tue, Jul 15, 2025 at 12:34:42PM +0200, Oswald Buddenhagen wrote:
> > On Mon, Jul 14, 2025 at 08:52:27PM -0300, Lucas Seiki Oshiro wrote:
> > > - Renames the command to `repo` instead of `repo-info`. All the
> > > functionality
> > >  of `repo-info` will now be under `repo info`. The functionality of `survey`
> > >  will be moved to another subcommand of `git repo`.
> > > 
> > this strikes me as a bad idea, given how established the `repo` tool is.
> 
> The `repo` tool wouldn't be executed as `git repo` though, would it? So
> I'm not sure whether that really is relevant at all. On the other hand
> though I do see that it might be confusing when you interact with the
> `repo` tool on a daily basis.
> 
> > without much thinking and reading prior conversations, i'd go with "query",
> > because it's a database-like metadata ... query.
> > the obvious followup idea would then be "meta", but that suggests that it
> > isn't only a read-only command, which i think it is supposed to remain?
> 
> "Query" is way too generic from my point of view, as it doesn't say
> _what_ you query. "Meta" might be a bit better even though it still
> loses the information that you act on the repository level, which is a
> bit of a shame.

Agreed, "query" sounds too open-ended. Since we are only targeting
repository level data I think it would be confusing.

> We could of course adapt and call it git-repository(1) to avoid any
> confusion with git-repo(1) and repo(1). It's not like this is a tool
> that users would typically have to run daily outside of scripts, so I
> don't think it hurts much to have a longer command name.

Being that git-repo(1) isn't really intended as a common user facing
command, I wonder if there really would be much confusion with repo(1)
anyway. Personally, I perfer the shorter name and think it's fine as-is,
but it's not a big deal either way.

-Justin
