Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F8248F6F
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 22:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767135217; cv=none; b=uZWN+v6rnFTIk4unj8V069cu7pAgzgB84VufmSmlYuL1/ix/J31531gvbtZP8VjwW5P+3DbiWUUNMiDKvLXxn2SITEHyI5FSM3muywDeK1Nw50apBFAWn87ZP1et+ag7Bwc+CjgUKfJBh+qbV9cfb6k6hk1VDTPG+4sUWCL2Xc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767135217; c=relaxed/simple;
	bh=bn45dF/7pB7nUGZE+7zOhzvUXxbBYm72Izd9H8FgQm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGeiqnNaPm2zkqLD9LjAL4rovDlyLnq/gi3e/UH76dg1A0X0QlmtChxUi5eAmxEf6y40vl0x8ZwCUxDdMam7c2+wds3+wLxg2Ge+Bre2iXLXgob9OTlz47x+38jSHFAcmYqZGaVQVOxAsjtILOXs41gtLRQANzJ//5GVv29rOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YypULK4H; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YypULK4H"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3e3dac349easo11154099fac.2
        for <git@vger.kernel.org>; Tue, 30 Dec 2025 14:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767135215; x=1767740015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxrDgUhWDqaqkjiEayTW+Z5dIogAsBr+A9zDjt6T85I=;
        b=YypULK4HEMyS+PqNBi4+gYJjiLYj1rs9C7UZDOVSZC324HUFQzRk3Kd+ALqWwNYocZ
         P2PzUxTcbKmqaKBuf3crQ10khODxLXsUDL5BSoJy4lH5UXKrDp0QnzPhQPsBLlDr/lG1
         n6YG3EssfoidBTDSiNqY19DaBF5Fe61RLUPQclHYQif2fEgIpbAEzibKd3Y0xJ6++nA0
         +EabaW/O2P7wxJZGxnIlFYPlcn/NWij4MyBMQYW0v5zDomBGjiHBt5tohXY8ZkVH2J/O
         Ex3syE+HUM0vggWmP8kh4dq1n995ToSrZ4ihstMadA1i1iZufmLyJUwXV1m0yTlaLbz2
         5K4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767135215; x=1767740015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GxrDgUhWDqaqkjiEayTW+Z5dIogAsBr+A9zDjt6T85I=;
        b=aGpdN1/0aGLCDeAUSBIsQ08MpGwuqtu4/1AltZTeANneFOl0FB7hJ9uWt4odNDqgFs
         D5mHYTsDviRcHzRSD/2utM/vFTF04zwHUULFh/S2sHkxJFz+uzNUwOYw1TM1S03mAC3l
         Vp93XgMRI8FyK2LxGpM8Odu4cIarBvo/c7Swr/XxHg9XgQoLiRLwSWx2r2CBDF0kgWjv
         SdbwgAwwLdmEyZt3I4rSm+mj3RG+2H6GObLnx85zG1C+ZXU1Ml6uA5gdykrlLQYGA5bi
         +UBPzy0FM/IIdOzcj3R6Rt95R2KEDp/XnEbs7Kr6WcdNJenj0leNSfeja55xhww/i1t9
         fxUg==
X-Forwarded-Encrypted: i=1; AJvYcCX5mXPC7jfrZawl2j67XkIBxvKzjiRxkvE8fb4lRiDI4L+1nFd7O9DP6tzgOEXFXlnDt5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLGYcYdFWfTgzSdRlj/0sRMdJE3sFtZ4JcQy0HMP+e7gRHq6AF
	OXnY64MPSz/DjARBJjTetpEdOk++gjvPYVqlbo9Gz5WHW1DUF7PI6ntzEEvgLVn/v0zi07iFMMS
	zE+lGTAY1+jr6jmFjBKYlxCiKBGOKP3I=
X-Gm-Gg: AY/fxX5AbND8Awgq4QMXb5scoeEsmy+9nVRpwI9LHSwYLrwuHkbvHC25C7UGqidhGYb
	jkYGWclEEUuE8vpPcB06nW5dpGBj/eXJPXWnH9DpiHEhlQ0aFb0W+rCN9aS8Anlm0JI3pZeb0WS
	9UL/TRGoiDXxpgIQD1oHO9eInMu901FSRoHp84ZI4Aq33hEpjoMIn6NSDhUlcN4Sh+YTmHi1SMb
	nUXTEe461ZwS0VDz0xJMCkxAYZFVjpc3YDuTJ2xXqAFQzyx1tVIAklqiZ9xetEaJIlBsq7g1Wge
	meOnSlcpodQxJ8CTflu2iHG+4gaK
X-Google-Smtp-Source: AGHT+IEa2v97WuuoBGxO3ZQVWqkwnB7xzz6tTMUXFAnIwA3SKRTnAUFqeTdqKNa05zJY+8gUB/GnMNWcFrAnKL50MEQ=
X-Received: by 2002:a05:6820:1506:b0:659:9a49:8e07 with SMTP id
 006d021491bc7-65d0ebd6823mr17964180eaf.73.1767135214846; Tue, 30 Dec 2025
 14:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2023.git.1767033783800.gitgitgadget@gmail.com> <9fae6398-cdc5-4ccf-8bd6-47425efb0c5b@app.fastmail.com>
In-Reply-To: <9fae6398-cdc5-4ccf-8bd6-47425efb0c5b@app.fastmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 30 Dec 2025 14:53:22 -0800
X-Gm-Features: AQt7F2pIbISruaZGwoT1YT_ZMcCT4ZeCMnXF58IP9g0MVGvwKuoQIwvns0AHLlw
Message-ID: <CABPp-BEQ6hyUpjsK18dKwHmZ+cjDm8-ah8472+JOpKh65a-W6A@mail.gmail.com>
Subject: Re: [PATCH] merge-ort: fix corner case recursive submodule/directory
 conflict handling
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 8:04=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> > [PATCH] merge-ort: fix corner case recursive submodule/directory confli=
ct handling
>
> s/corner case/corner case in/ ?

Sure.

> > We would also be able to do tree-level merging if we somehow apriori
>
> s/apriori/a priori/

Thanks.

> > which was implemented back in 7bee6c100431 (merge-ort: avoid recursing
> > into directories when we don't need to, 2021-07-16)  Crucially, this
>
> Missing period before =E2=80=9CCrucially=E2=80=9D.

Thanks.

>
> > restarting only occurs if the number of paths we could skip recursing
> > into exceeds the number we still need to recurse into by some safety
> > factor (wanted_factor in handle_deferred_entries()); forgetting this
> > fact is a great way to repeatedly fail to create a minimal testcase for
> > several days and go down alternate wrong paths).
>
> Missing open paren?

Or just extra closing paren; I'll remove the final one.

> >   * do not pre-emptively mark the path as cleanly merged if the
>
> s/pre-emptively/preemptively/ (according to Merriam Webster)

Looks like it's not consistent among different style guides, but I'll
go with your preference.

> >     remaining path is a file; allow it to be processed in
> >     process_entries() later to determine if it was clean
> >   * clear the parts of dirmask or filemask corresponding to the matchin=
g
> >     sides of history, since we are resolving those away
> >   * clear the df_conflict bit afterwards; since we cleared away the two
> >     matching sides and only have one side left, that one side can't
> >     have a directory/file conflict with itself.
> >
> > Also add the above minimal testcase showcasing this bug to t6422, **wit=
h
> > a sufficient number of paths under the folder/ directory to actually
> > trigger it**.  (I wish I could have all those days back from all the
> > wrong paths I went down due to not having enough files under that
> > directory...)
>
> :)

Thanks for taking a look!
