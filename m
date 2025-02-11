Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBAB262D28
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302152; cv=none; b=qNcYYpyZNWTD1q8gg8ewO++S1wU78Jlp+ScirYObC9Qq6xW6MSRV1QNx1CJxNNXSEViiBGtvNidBauY2nceLxrZuzkGinPncKMccb92uppCsD3fNCw/ED+H4HM67+MzeieoQedvvsO0Z5SWTiYrTHCJRJM/ApluuRG46Hkr97k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302152; c=relaxed/simple;
	bh=lRzBUQTyLVCsh4Cx5zD33v/8EcHDgIo9TpbuCDkPxrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3pYszpm/sTojKpPcEx9ypOkHbKcdG672kCP5S8k41b0OVBWZYI+l0TZpC3HKd7GhQVgmuLM1kR4YIjhhrkUAUalKCmcBp7CqLRtFuTKIVx1s/1KkH8L2UdujSZgJCbDEqvGnXoOkxue8Gz0DBgKPj4ypZINd8a5JYoBqvCq6GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGtxeSYh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGtxeSYh"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dccc90a52eso9782430a12.0
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 11:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739302148; x=1739906948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSXi40GVFTONytUa9uddkYKiBdW7LMi86pIZ4pNCr3M=;
        b=eGtxeSYhM1cjQyHUOOz/fzhBCdHDi+PJ6PtYRP0SqtEiFs2rcpnbaWUQc0tvmPh/UG
         Q5Qi+mcwlGabEezQ5MgbW6y56BLA5cynUwkIZXxSJLYyFQvaTHDTIbl6EcQmUeFLCqvo
         Z/rUepaoTigf/tUkjylmkQi0yhnjIDTe7PuGg8qGzkhKf20lSBdw/8ZwnPVxywWh5iw5
         8UIvDqMVBTKo0ExPJAXU8rtCRzyST5a/uBxRsBuAZKZQ96jJlYrzwgHLX1I17GIXfpMa
         vkBRnGhZ3/m4mxH/RowpJXI0kI8lSENQkq38NNdoZonssUMbVV7a0cP3alo62osGP4/6
         S5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739302148; x=1739906948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSXi40GVFTONytUa9uddkYKiBdW7LMi86pIZ4pNCr3M=;
        b=EUu1bIt8OlQEx1hGB2l6NUQvkpMbXI0DqOOLsFA0UlCnx2fRFmVAUPGPJp3D7qyRCo
         ZnicFJy1NMIgtsJQLero5VYMhoeNdeyB5Jd5IYDfJK9xO7UtoNlJoRg1kBiW8+cthD4U
         F6yRGBHX198NTLROwjdjficlcLACzNv2Yco6R1pcRheQzsqjAVLMuK2MLwaqtPOJ83cL
         RT4XeABkCLcYVz+g2a8/gF22vpCeD46IqxaHbi//tzvlJd8+2fYatBqVwJk9h7UMSq5e
         Tp7V2jYS2lvl1MO+XiK4Q/UqpTWQqUlhLJO2mL9Ofh8fSLgo++zV4fahuNHOM9n/gq1a
         SbHw==
X-Gm-Message-State: AOJu0Yz3R6DKqNglSfZMEy/lQIdUnupbYrdIDg+Axc3Vfos5P/93SVCl
	ReRLeWuGFxk81B2idnunxAKJT2oNpPW3gqxK2bcXZUc4vYMbI9n3Dk3Kd4FBWQTVtkyLvhBkURY
	nQuDwJroe97qbztS4f0msbnwEzm8=
X-Gm-Gg: ASbGncspL4xyCg0J2haChFV9HWq1xwbt7i3HZEHYGZftuMxBZv2CQQIDnkzExj9mRS9
	/6iFCuWejAapws+4j7ReuJgsfFAXMiGJGZVFVPbA2/m+mrcP+RxqdiMZ1xEb867QJGY31w98bZ3
	iBhd4mr3ynN+T/FEIc5EnmTEHuQFMQ
X-Google-Smtp-Source: AGHT+IGWQzulSktdHnjpB9fJ5eFkkZylxDrn0fSQMxMWrsKAxt8MFZjursOvOKcpzwJbhAdvS98VeI7GyV4MCihTfMI=
X-Received: by 2002:a17:907:2d10:b0:ab7:c6f4:9522 with SMTP id
 a640c23a62f3a-ab7f334ac0cmr16742366b.9.1739302148265; Tue, 11 Feb 2025
 11:29:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210191650.316329-1-intelfx@intelfx.name> <CALnO6CAM7WCOJV8s8ZARi3BAFwkh0TNTCod_YH9s+EpO7t-Qtg@mail.gmail.com>
 <bc0de52b59f289e1388f1581fcfa49453365e21a.camel@intelfx.name>
In-Reply-To: <bc0de52b59f289e1388f1581fcfa49453365e21a.camel@intelfx.name>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 11 Feb 2025 14:28:57 -0500
X-Gm-Features: AWEUYZlzujRY-ly4cldpruEqAGmAB2GFDdzteTmPyQU7j8ypTvbxJAIQE7PRk78
Message-ID: <CALnO6CDN627+SUC6BWBvVjFnU5qKsBrfLkmX2okv8J8+wgDDRA@mail.gmail.com>
Subject: Re: [PATCH] rebase: add `--update-refs=interactive`
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Alex Henrie <alexhenrie24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 6:33=E2=80=AFAM Ivan Shapovalov <intelfx@intelfx.na=
me> wrote:
>
> On 2025-02-10 at 15:22 -0500, D. Ben Knoble wrote:
> >
> > Based on `git grep -e '--.*\[=3D' Documentation/git-*.txt`, I think thi=
s
> > should be more like
> >
> >     --update-refs[=3Dinteractive]::
> >     --no-update-refs::
> >
> > But maybe that unintentionally suggests that `=3Dinteractive` is the de=
fault?
>
> Perhaps --update-refs[=3D(yes|no|interactive)] then? Or is that too
> verbose? Anyway, I don't have a preference, I'll just do what I'm told
> here.

I don't have a strong opinion, and I think this is being discussed
elsewhere in this thread.

> > Should we add a test for this?
> >
>
> Any suggestions what exactly I should test here? I don't have much
> experience testing interactive CLI tools, so I'd appreciate some hints.
>
> --
> Ivan Shapovalov / intelfx /

Give t/README a glance; t3404 is probably a good place to start given
"git grep update-refs t."



--=20
D. Ben Knoble
