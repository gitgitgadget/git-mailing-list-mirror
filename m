Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GM2ysUtH"
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93129A1
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 00:52:38 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9df8d0c2505so108353866b.0
        for <git@vger.kernel.org>; Thu, 16 Nov 2023 00:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700124757; x=1700729557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRyAdckeFwV371diyRLCtOtkGqMTmKZSanAfKJFVqWM=;
        b=GM2ysUtHdqRKTFnps3fOz2qhCfcx87gq76JYSggzbX5zQ7EsPRBHNaFsQFudxz25zE
         z5XjsBzzPntIl9J0N6ArVCOOy8bxw7yojosKv/dSAfPtQPmj/7NoH7HZDPAHXeQxR5nr
         BIAz7htxrnQvcFJcf6MSI3Zb1zudYWB4MZNHp4SBoefb6pOV+Vd4z14flT7Jy+Ed5bfe
         WlOYUq9riQPm7etHQkgycMKKGOFyBaBOJcavOpuk1BxigpEpPq+xvR2JXIVxmbocOjn8
         ypKkvnWIOyjwse4xNfla+mGNepotzAcajS5G2UbYkGiVNzBDPcJBXtUTRN1jMbVVXoDe
         m45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700124757; x=1700729557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRyAdckeFwV371diyRLCtOtkGqMTmKZSanAfKJFVqWM=;
        b=ZECpAnBWFJRC3a2HD04TBubP7fExDW2/4unpBPwyE/bp7vQdR2VSpln/52fLzRUyJR
         2ypRVtZJe6Nvgazp0C7J4XK9ThHTEHHGqjPWVvwsO+ROvCoXtwKjxrNmBrSsIGkHeX6e
         6zbppSYyVI7lj+Z6Tsnso7qSnnSjZ16z5l4VaSkRfKLFk8+VsT6GOrLch2lGuNgR/LM6
         ovsphpNtwcCCP44Z7o358/KuHug1Y3MOh5MBYzeDLh8tvaQa2nWYwYGVjARMRFo5LlW6
         oXa9U1F7aoZne3Tk08sqCYmaOSYIRThvSlBFtlJKsMRp1eWMqkYdToH1U+EuyAJoHrws
         sPVA==
X-Gm-Message-State: AOJu0YxokuuUhGrBjckQ0Aqq5c5plp++ZZTr6kpz4BjmgAKGH07GpXG4
	Gvn0nJrl0HnTqOGW9Hh4QBXhFbEgaxoanapPl0K1NVX3/+k=
X-Google-Smtp-Source: AGHT+IE9g3Fxy8qo9vvkMuL7iqzrueP03NxYaOON/TRvd93mctfB2U8ZSo4TSxrmv8gjaPhrFx0kLXciaAFj8OH2WC4=
X-Received: by 2002:a17:906:f197:b0:9f4:53d9:2d66 with SMTP id
 gs23-20020a170906f19700b009f453d92d66mr1061197ejb.5.1700124756643; Thu, 16
 Nov 2023 00:52:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010123847.2777056-1-christian.couder@gmail.com>
 <20231102135151.843758-1-christian.couder@gmail.com> <fcfacd1a-cf5a-a393-d2e0-3c0388ae3529@gmx.de>
 <CAP8UFD0Es4qai98WB6bpykisBT628JndPXG8jg1=_uUbn4zogA@mail.gmail.com> <0ddca907-6e64-b684-2e08-c7e95e737a3c@gmx.de>
In-Reply-To: <0ddca907-6e64-b684-2e08-c7e95e737a3c@gmx.de>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 16 Nov 2023 09:52:24 +0100
Message-ID: <CAP8UFD2hB5j2rZ-+WTXgju4mf58HGtEJR87LB08g3Hu3-G2joA@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] Introduce new `git replay` command
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Elijah Newren <newren@gmail.com>, John Cai <johncai86@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, Dragan Simic <dsimic@manjaro.org>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dscho,

On Thu, Nov 16, 2023 at 9:45=E2=80=AFAM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Wed, 15 Nov 2023, Christian Couder wrote:

> > I have fixed that in the v7 I just sent with the following:
> >
> > +SYNOPSIS
> > +--------
> > +[verse]
> > +'git replay' --onto <newbase> <oldbase> <branch> # EXPERIMENTAL
>
> I still think that the following would serve us better:
>
>         [verse]
>         (EXPERIMENTAL!) 'git replay' --onto <newbase> <oldbase> <branch>
>
> But if nobody else feels as strongly, I won't bring this up again.

For the tests to pass, the SYNOPSIS should be the same as the first
line of the `git replay -h` output. After this series it is:

usage: git replay ([--contained] --onto <newbase> | --advance
<branch>) <revision-range>... # EXPERIMENTAL

As the usage is supposed to describe how the command should be used, I
think it makes sense for "EXPERIMENTAL" to be in a shell comment after
the command.

Thanks,
Christian.
