Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5944C839EB
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250443; cv=none; b=EDAtd1m+3XmbuGAXIauou0aThq5mq0wvM9Gaz4bQzbuWptqqeY5O6/NKzGB7oyY7CHsTUBf5PlIBdY41QAh1S1q6JGfia/8U1cGRnU/5eSPN0vZIJJYp2UUu3joyJK5owi7jPl3Bja6ZvkWtPy11Dnpw9mJtaGxIkV4JWw582PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250443; c=relaxed/simple;
	bh=nKn+oJauyEG1v+8uubMQMAvKlOI1ZCq5HRPRACHCSEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hA7+Qp99Dl/c0Sd77vZIw1+/hRfOAc4EzowmlZzEGLTr5lHZfBxfTG2tXzQ98mmnwKw8sWMp2nJSXTwyB2YeprnKZ1OTvJaMxFFY3Npai6Fmjx/sIh4SrfBA/FOeF/5QiuaznMATkFWUgDFj5WfcxmmsRDMT2zdYbH0QxPt1BPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKnE0MAd; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKnE0MAd"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1a80979028so2445397276.1
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 11:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726250441; x=1726855241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzJo7hhwgzqtiJoTPGlpbB8coBRXCYutfNpcWN8Il30=;
        b=hKnE0MAdSdRZJPB8JlJ9HOdu3oMRoh9QU23E00FDvlpQTegEKDRTNChUgFZf8d8ACK
         Jb890XPoXlhcETducvvuQKxMyoHUM8Jd261nTJIBNldJ11fcP9JfXxHy18wX3P66rRaU
         rpsacaOQaBxDtQYFfIliMIFLDnB1vEnRXZ1P6NkdY+LiXiI5Ld5F5CyKyOhAfMG8aQme
         lcr93QaZx9c153XwR3/Ciyf19B9Xzm0QEH3OafILhBm2QveGfhQ8x+piglgu83XCG+Tj
         /mAUJl5c9DRieo3C8XYLQPQ33aMazHD1oAcv5A/6p4T6NeAtZY+DSSa3jw/a7K+BMhSV
         fMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726250441; x=1726855241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzJo7hhwgzqtiJoTPGlpbB8coBRXCYutfNpcWN8Il30=;
        b=HEpbeo9hSTF/R4b3NznKuVT38zDaFtJ3NyM0eVczKm4F/075/ynmTxD0VtEuwPivq9
         6b6iJESoT8kjMXk3sEPjxMDGibRjdhrCYYsq2PgQZftcuHX78AevbmNYm20FbB4C1SiK
         39Z2PBmFa4nkylCuegZ7IwtjxMyImIkOSy7KA1k3IkyfPUUwkE56LGN7LLEXHobIqmCJ
         mpxEghYU1dbpdKuHLoL5AifFgsSKiai+2lQop0FfTFuHetzWbu1fQtPfVii35E0i5YR+
         hoUqiLMKW5nLfzCQTIfeGkisVlePXyHJv/chWdBdMPEl1eHS+OEGYrNXBSl93MY76Q+7
         nvkw==
X-Forwarded-Encrypted: i=1; AJvYcCWiYLX/1CYh30HE6Wuz/EQadqSTtd0of55gl998Gg0d1H2YPT99FqIZ/mpkza42bDBdAg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwssdRHh2PGABOJi25zbOSoN3vc10rhS/wWHK56LOHCEd9qfm/7
	J/fGG3U6RjrJMPK2VHMfZyoyc8wHX25uNW2x1PbdrgQlE68NX5i6WKAGHCexJzE7kLbcq1716bW
	dNIiXK+bzxUscjkTL6Vr6A51AqUI=
X-Google-Smtp-Source: AGHT+IE6ucVzyv+A9vBRr70k8olUsGwGh2iu8T5vJFgyZLkea5vQjzOmanacCjNVn79tvYJmu0egvbQyRivUXI6P6ZQ=
X-Received: by 2002:a05:6902:2682:b0:e11:7b5b:18b0 with SMTP id
 3f1490d57ef6-e1d9dc5fee7mr7146035276.47.1726250441287; Fri, 13 Sep 2024
 11:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
 <pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com> <434c8babbb140b7e66321deec0cd8e8a0d706475.1726001963.git.gitgitgadget@gmail.com>
 <xmqqikv26oq4.fsf@gitster.g>
In-Reply-To: <xmqqikv26oq4.fsf@gitster.g>
From: John Cai <johncai86@gmail.com>
Date: Fri, 13 Sep 2024 14:00:31 -0400
Message-ID: <CAOCgCU+Fh_mpRsx_wT72j0_m2Pk4Zuri+zfu8W2qeQ1bUZjd8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] builtin: remove USE_THE_REPOSITORY_VARIABLE from builtin.h
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 2:15=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: John Cai <johncai86@gmail.com>
> >
> > Instead of including USE_THE_REPOSITORY_VARIABLE by default on every
> > builtin, remove it from builtin.h and add it to all the builtins that
> > reference the_repository.
> >
> > Also, remove the include statement for repository.h since it gets
> > brought in through builtin.h.
>
> Can we have _all_ builtin/*.c files that include "builtin.h" to gain
> "#define USE_THE_REPOSITORY_VARIABLE" in this step to make it more
> mechanical?  That way we do not have to go through this large patch
> manually to review it.
>
> Then another patch can immediately remove the "#define" (and doing
> nothing else) from some of the files in builtin/*.c with its commit
> message saying "These do not need implicit or explicit accesses to
> the_repository as-is", which would make it trivially reviewable,
> because such a claim in its commit message can trivially be verified
> by simply compiling these files.
>
> After that, manual work to remove implicit or explicit accesses to
> the_repository, which would remove the "#define" that becomes
> unnecessary, one-patch-per-file can build on top.  Each of them
> would be reviewable again.

Okay I see what you mean. Yeah I can do that.

>
> > The next step will be to migrate each builtin
> > from having to use the_repository.
>
> I am not sure what this "to migrate" refers to.  Is it referring
> exactly the same thing as what I called "manual work" above?

Yes, by migrate I meant the process of removing #define and passing in
the repository
argument through to replace the_repository global.

> Thanks.
