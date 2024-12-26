Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F2F45038
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735194012; cv=none; b=toFLOQFfCUHwdgofO7OO3m1uty17C+ln/Et3C+UoBVPlzw/rO7hq1xC6x+OihR8FRm3b8InJi36r+nrHuV/GywSSzd3L3IHv3fWFKf3Fz1N2G0La//sZMY1krNdsCTkLrofrO4z/cGVRdcqno/douDOJK+BXWD4TOowS2tZhbqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735194012; c=relaxed/simple;
	bh=aTP8BXRvQ9CqILYq9vz661cS6qE+g8Cgw46iXX0koHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=er2lrlUhmqB2LZWmWCRAKZF9T0162DlbWD7CF2o32uxaBzQP6HHcIa4c6NLAt3e2+EZ8aA07XXNKtZ0JWACIwy23lal4JdiqIOjAIqkBVKpfIOLDjQa7VOBZPw6BMxvklMAWsge2xE+6f/XHxDtVoDG8aN12onxPSUCu11PBvzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFWkRbNR; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFWkRbNR"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso10966141a12.1
        for <git@vger.kernel.org>; Wed, 25 Dec 2024 22:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735194008; x=1735798808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTP8BXRvQ9CqILYq9vz661cS6qE+g8Cgw46iXX0koHs=;
        b=BFWkRbNRKX5pbCyJstWul3tEY5ffw6+8WktORTcYrz+UYe8/z7TmnnlplGwh2kWKPY
         mxXMho4ksXeXIXOUzxrlW3893KGDZpbbQsl09CXyxgP601KtXRNFYbHneYOhXMJoYERt
         iu7ns9cj6RcYyuL2QtOBkZ/zQdhoFKhDCEXjYsA5S+Q9YStIp06EpmJ/C5M98IQYB4nP
         3eAgqDSuuMmTByGZWgRwAb2iH4xYv79ALGmjz81OdfoKvHnSce5RhqHg99bNxkXnpLe8
         9+fYaiDISIgoBgP16/klOtkHaTV0M0TKAKvtNxP8C22bDO2Z2iqoZJcK77T9SF8Ioe//
         kHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735194008; x=1735798808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTP8BXRvQ9CqILYq9vz661cS6qE+g8Cgw46iXX0koHs=;
        b=Zg0NPJS6AVHW77xHUWh0gueIYyFsGyjG0XWDgWWCV9p90VY7qU+NMdGmVfG5+3u7qY
         H+0+lKckRhWHkfvt9GHPtwpeQ5Eroc358qiq9aQQ4Mst0ae6oZgJSo9HATuEDFh12r1Z
         lRjsV1nX0fI+AN+ZFVLGYwI89j8P/6biENGHqShM1xaLGipBHxo+o31g7WJC7dnV9NTx
         Qfmo56bpBvoHMeXU22MHN0DFr3WPKtJAPs30jRkKkiboUU+Iw5jrn+aaStllX1twwk7o
         Vo5pCliXjXrvpcZCrQOyQ7u3HhbDDY3UCcIMu+VAF9gtQJ3zlMXwMpTBbq7rTlDypXKl
         YsJg==
X-Gm-Message-State: AOJu0YxjB84wojxXv5k3eDIF6O47SYDsgmNPJ0jGpWGfQLuoH8cVKjiR
	tTshPdYD4v8hjtpetdA9xclaTEcQMB/QI+IEnXDSV3+M/qBkSAbZohBJZx2lJvqD8aDSzny6ryU
	JURbwvEOAgUCOwDM9M4uqB3kUGZX2Pm8CQSYvcA==
X-Gm-Gg: ASbGncsbT5S8TgAVJ7fWx6tM761fpRu/h59kD8gErWw6ZUoh8+FBCMduLSEgoiq10LW
	Uw8qE2axuHeCgOP8jPyRepvMK/rr1iIlAEohTvg==
X-Google-Smtp-Source: AGHT+IFauJoT4UdH886C8a+xpxmNJayUjkEyzOutWmtOC3D7AbYFF5khYNGIYwlhrMQUhssu5DN2kK/lO98NbE0EOY8=
X-Received: by 2002:a05:6402:4304:b0:5d3:d2d0:12c9 with SMTP id
 4fb4d7f45d1cf-5d81e7507c9mr18309125a12.8.1735194007739; Wed, 25 Dec 2024
 22:20:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLTT8Q0cH3Q=yPnTYKAwn8bC+iDW7onibsLF=bzVr8tGw5J0Q@mail.gmail.com>
 <CABvF+3ZU=96jQBmGw3eWmAQ4DjCdcm1VT7fHMVz_MxvW2xxPng@mail.gmail.com>
In-Reply-To: <CABvF+3ZU=96jQBmGw3eWmAQ4DjCdcm1VT7fHMVz_MxvW2xxPng@mail.gmail.com>
From: ZheNing Hu <adlternative@gmail.com>
Date: Thu, 26 Dec 2024 14:19:56 +0800
Message-ID: <CAOLTT8TraRjBObcLotNr7+a9Ap7Fy8VVy7HjHLLWwEB_LvBrUQ@mail.gmail.com>
Subject: Re: [Possible Bug] --cruft option not work with git gc --prune=now
To: Taylor Blau <me@ttaylorr.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Taylor Blau <me@ttaylorr.com> =E4=BA=8E2024=E5=B9=B412=E6=9C=8824=E6=97=A5=
=E5=91=A8=E4=BA=8C 23:39=E5=86=99=E9=81=93=EF=BC=9A

>
> On Tue, Dec 24, 2024 at 08:07:16PM +0800, ZheNing Hu wrote:
> > I am trying to use the --cruft feature of git gc, and everything works
> > well, but when I combine it with --prune=3Dnow, I notice that no cruft
> > package is generated, which is very strange. So I turned on trace and
> > checked: instead of executing `git repack --cruft`, it executed `git
> > repack -d -l -a`. Is this normal? If `git gc --cruft --prune=3Dnow`
> > doesn't work as expected, it won't be safe to further execute `git gc
> > --cruft --expire-to=3D<dir> --prune=3Dnow`(in my another patch).
> >
> > I checked the code, and it appears that add_repack_all_option() first
> > processes `--prune=3Dnow` before handling `--cruft` option.
>
> That's right, since --prune=3Dnow will cause your repository to purge any
> unreachable objects immediately, regardless of their mtimes.
>
> So after a 'git gc --prune=3Dnow', your repository will only consist of
> reachable objects, meaning that there will be nothing to put into a
> cruft pack.
>
> Note that 'git gc' does not support the '--expire-to' option, but you
> can use it via 'git repack'.
>

Okay, I know that gc doesn't have an --expire-to parameter,
but here I was hoping to use git gc --prune=3Dnow --expire-to=3D<dir>,
where expired and unreachable objects would be stored in <dir> for
easy recovery in case of repository corruption. Moreover, it's more
convenient compared to using git repack + git prune
(isn't a single gc command much simpler? Plus, most users are
likely familiar with gc rather than repack and prune).

> Thanks,
> Taylor

Thanks,
ZheNing Hu
