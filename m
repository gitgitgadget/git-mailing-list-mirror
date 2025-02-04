Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40B20D506
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738678001; cv=none; b=dv8Y4cIeBt+WKbenoEkyCYXYJL5+XcAbeEvxYziCUJHLShE+IMIT3o1r03D5eSEz+lByynDYxm/XlFihm2hQnOdBPZMs3Dx0QLjlrdAI721IYAccAYRfSTbxdbY+B8t9MbpEgQCs3cZJHt00JE4m9dI6w0qNF6riDRKHJ6+LyiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738678001; c=relaxed/simple;
	bh=1kNoW/HI1aoeDb0vGOVjwKUr4VFTWPoeTMqSfos3gOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLH5DyGBhCoDaBe1Pm8NNa4y7UfXNFw1W0oWfNv9zi1c95cOm3HPL5XXJwqFZ7f8XMJbTJJmxVhb3NSuZcykRNWpNwUn7QXF7uTkdCuN5nx0sZZsXBgMMnrksJBDW3Ftu66ej4jYLFYk1XiBHbENZp5shkIyKssMZhhSqA96uXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWvlj/HX; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWvlj/HX"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3061f1e534bso56910211fa.1
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 06:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738677998; x=1739282798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kNoW/HI1aoeDb0vGOVjwKUr4VFTWPoeTMqSfos3gOs=;
        b=JWvlj/HXXxpBJvPSLQbQJ4MgzCEnNrtOzf2kZRjO66OX2Dgds0QieLmpCHTGPwVx8s
         9lxNlDEmPkxc+eElW0Iw6AxbMvatoxsiZ4egrXybNCVYMvA3RpovMkMkpMxUB7vb0KoW
         3nHvWFVpgW/+g8rFOPfeOGLXvbhS/PpYrlUMS7HWMaOyWU/i8PTn2fPUcJRbvR4YHCGr
         LUs/cn06XfvlaejbfNXPYsQ2p46rU6w0yzCOwuSkonFmPGQTNqELWEAh8iolJ1/JCM2e
         3ySbd9Rcb5CxlmKTv3NqPI30r+ULwTIs7Pn98cVZ+9gzlElmmJbQlY8tVZVrxTYVdA8z
         3EIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738677998; x=1739282798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kNoW/HI1aoeDb0vGOVjwKUr4VFTWPoeTMqSfos3gOs=;
        b=pHJUl++5fVYVBeE7j8R3Lz918x2svgEczcu5kKE9TDtUgf+a9ndzp3LBUC92ZK8ixq
         77KRPbU9e3qUY18kCfnNYnCzIsYFkz7pOt8kKiCnYVTRTL85WOAmNQWp4YQhdvckvxfJ
         yHl05Jl1dKeQbftl+LpYZT6fBRpPpKjSs1NEHmfohf3PyW/3IpaKNErLCF2vzDtZzw2O
         /taCrLGWrhE9gTd2xOHEGhtoV3wjaVkzN9q4dUnGyxzSciBqK+fsyIcca/xHERw71EtW
         1A7Ou9WKUqVAPLWodtALjBbDm8B8B4xbnTuKpozjf1HaFiARaydM5w2LnKUnTXUurd14
         4vaA==
X-Gm-Message-State: AOJu0Yyyzd/GxZAo1IrrSzhQ7A+Qd71UgoeGXwdJ28k0hZxBm41oW2gD
	bxRP9Ymon9FKqspZNuYRsH136IV90cAgZqyWek+YgjrjnjgtNVTysjo+QGpWC/iBbOVykYNVeRv
	y7RUPwSr7HEUNQlHwiHr6+IctLcM=
X-Gm-Gg: ASbGnct8L5BPWl+pMyTBhex87QrqBVH6Pj8U+/YhfLFeVK6JO9jRqm5vbvkH0o9+x/l
	sA3KQwy5g0PUFxnPiY5tH8TdbMVqWoKr4afqN3L5H9RPP3AnZb8zd25El3iynQf1RNqGU8LZmMs
	4=
X-Google-Smtp-Source: AGHT+IFgTYer02uoxAqi0pjoLYVx6RkFX5uheD3ulYBzErqF16ITKftOtLzEHgXoh2kZo+k+sZ8l9aia2x+vLRyzhqc=
X-Received: by 2002:a2e:be86:0:b0:300:330d:a5c4 with SMTP id
 38308e7fff4ca-3079684813emr81928761fa.10.1738677996106; Tue, 04 Feb 2025
 06:06:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204041430.36035-1-meetsoni3017@gmail.com> <Z6HH8mWDpJUSHDd7@pks.im>
In-Reply-To: <Z6HH8mWDpJUSHDd7@pks.im>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Tue, 4 Feb 2025 19:36:24 +0530
X-Gm-Features: AWEUYZlFv99GCVZth4oCDHYMxX2CqETR8jEVcsv15v-ZCIBbBJwhi9d29itTqEc
Message-ID: <CAPhwyn094ySxG8=p3_jF+Z+0g6h4hL5ELBYhOLv+Th8zX04Urg@mail.gmail.com>
Subject: Re: [GSoC][PATCH] remote: relocate valid_remote_name
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Feb 2025 at 13:25, Patrick Steinhardt <ps@pks.im> wrote:

> Nit: you don't only move the function declaration from "refspec.h" to
> "remote.h", but also move its definition from "refspec.c" to "remote.c".
> So you might want to instead say that you move the function between
> subsystems, which would imply both moves.
>
Makes sense. Thanks for pointing it out.
> The change itself looks straight-forward to me. Did you happen to check
> whether this allows you to drop any includes for "refspec.h"?
>
I think you mean refspec.c, as refspec.h doesn=E2=80=99t have includes.
Yeah, I did check -- no include drop found in refspec.c.

Thanks
Meet
