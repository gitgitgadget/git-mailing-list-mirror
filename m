Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C91BE22B
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726670747; cv=none; b=bgddsC6W98k6RJXrbBvqPrvSMzFN+PSiCXgyeCy2G8n/i5liDaUBGVexy3wSWpBq/0TSY1i6v6JXXKCltH4nwavaUjB78k5UWeHkqNEvSgxNIE8KYBX5BWXusKQy/Ychd8F3gds/BNcpKMCoQ1ykOXWY4+1cD/Qe3ZwfoytUNT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726670747; c=relaxed/simple;
	bh=q4YTpYxmE0AFGLxN7b4y18Nsb3vj7hjzpsKq9FtSxtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErIGIz5ugYuvNrTbUKgK7XZWPJusFhYFl8bSy3I3BBvhdeaFfzDDJaSPMb4BaJViLVOwiKQEFaJYQJdkYs/SbBEYj58UpjKJSgO1MyrSRU8/JH8cVLt50hGXUAajCtLiRYHBFrFDlrWuGbkIq/YhohKbdkgCXQHDJTtAUNwVy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=precisioninno.com; spf=pass smtp.mailfrom=precisioninno.com; dkim=pass (2048-bit key) header.d=precisioninno.com header.i=@precisioninno.com header.b=CxOU7nBA; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=precisioninno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=precisioninno.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=precisioninno.com header.i=@precisioninno.com header.b="CxOU7nBA"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-277e965305dso2980897fac.2
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 07:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=precisioninno.com; s=google; t=1726670744; x=1727275544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7U8htzVkCMHnE5KroEW5bWPN5l5HWCoFzGQ0cadFSCg=;
        b=CxOU7nBAjBLmj4CY2DsGtZavLiCYshNKXqpqvDk6YY4dkCYo2pCRKAdO+3ZpZoKvM/
         FwuMdngq8YV0xLsM9tVeKXZXeUodYZBLXpr0UOdAWIoDN1UVMYyEe5er4ir/QSGtFJtf
         WOIfuH/TM9Nm3pE1z7yd9f8B7IDMxwqsd8tBuQd2LnW3X73zhow3QpJTmBuXIo8J2ynR
         96I6lcUjT7Sdm9XFgRwZuQf8WjAA5Mgi9VYFliB7w9T4rNzDIGoSgmasRM2wRAIndTta
         2taymtAbUQhaWFJuf5JqXXWmOSMv8dw4EmY/rvnvzMkIRsf0O/jAWMGhLvEOAfJVmzGA
         AzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726670744; x=1727275544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7U8htzVkCMHnE5KroEW5bWPN5l5HWCoFzGQ0cadFSCg=;
        b=mcTWac4V8FAb5VQNgJNRta4iK7rkj4FnhyP0YSpO6jInNRoCfzCzsj0YTEPXzKzHDB
         j3K1nHVrjv3NWvP0Z5gld1mOa/mGFYGcegH73TAvHiAeETjj82wvoQm3IDnz8iOz43rE
         YbeQf/DkLf/vl/j2Xd0DV8Uug7oa72EdUQNVpzw0bojRbIKD4ZrKyWjshiZ4OwbQE7R3
         U6MEg652U+2NTByV+jscjMRafPc9EFNjfO8NXyc4W0qs95j0lBQVf4jnHV2udO8FwyN/
         vxafWqWVq2rHMPccvax5HBmak4mkYkdP/0fC/gTOGwb3A+emb4RvyLUI2BBCsnVUkv62
         wrNA==
X-Gm-Message-State: AOJu0YwO2VhWD4ran0xuR9s+KWvQkr4+RFxgxFLeRToBIrFadVNdB9hn
	EtGtzABbbfUFxxC2Z9gCFShD8gnhj+GQ7Q/i5SHOkczkTp+YDTN0kHlpp6tI4mVPRWVBfJNfiMw
	C3pIh/1bppWAK5nWjkFWpJJP/4d8cr+3nnUShTMJ8PU1lK7o+9JY=
X-Google-Smtp-Source: AGHT+IEAy8IUosPjW0h4JIqiF7Zea/tPGIX85249nSX2Dsoak9TSjVyNUG3NsjpPWS6WnaQddb+bYXE0JsenZUpr9JU=
X-Received: by 2002:a05:6870:420c:b0:270:6dfc:b145 with SMTP id
 586e51a60fabf-27c3f26c387mr14633082fac.16.1726670744236; Wed, 18 Sep 2024
 07:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKDm0rNaHbzoiPg=DeuCoxzooNAsxw2BJfc0wg7fC_-=o9uJ7w@mail.gmail.com>
 <7b4ce2fc-3763-4881-8459-e0c1f2cbc69d@gmail.com>
In-Reply-To: <7b4ce2fc-3763-4881-8459-e0c1f2cbc69d@gmail.com>
From: Matt Liberty <mliberty@precisioninno.com>
Date: Wed, 18 Sep 2024 07:45:33 -0700
Message-ID: <CAKDm0rNjAYMu8=h8ApvEHw71fgH2VW0iCjTMqvysQ7YBUnJZyw@mail.gmail.com>
Subject: Re: fatal from submodule status --recursive when used with grep -q
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm not trying to capture the exit status of git but of grep.  Compare
it to "yes|grep -q y" which doesn't generate any error even though yes
generates endless output.

Thanks

Matt


On Wed, Sep 18, 2024 at 3:05=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Matt
>
> On 16/09/2024 16:08, Matt Liberty wrote:
> >
> > If I try to grep the output I get a fatal error:
> >
> > % git submodule status --recursive | grep -q "^+"
> > fatal: failed to recurse into submodule 'tools/OpenROAD'
> >
> > I didn't expect any output but did want the return status (0).  I'm
> > guessing git is unhappy that grep -q exits on the first occurrence of
> > the pattern.  I don't feel fatal is appropriate here.
>
> I assume git is dying with SIGPIPE. As the only purpose of "git
> submodule status" is to write the status information to stdout that
> sounds reasonable. If you want to collect the exit status you need to
> consume the whole output so that the command runs to completion.
>
> Best Wishes
>
> Phillip
>
> > I can work around this by writing to a tmpfile but would like to see
> > this addressed.
> >
> > Thanks!
> > Matt
> >
