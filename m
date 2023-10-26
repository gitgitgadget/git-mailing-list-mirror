Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B97BC12A
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFF8CC
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:43:32 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-773ac11de71so104759585a.2
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698360212; x=1698965012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYQ2bb90Vp6Vkck018GTLAch3T5ig6c0WP2gcr4JO70=;
        b=q8gaGguvDc/fNWdFX0OLIHgC5BI9xegkSPqvPA0Sf7+lMLn8vVAQuUyKBFhqy6UwHX
         da/+wqMzC7nP+ogAj/IvmVfQyZ06sKvaa7yqkqofUDjImMxwrot+Wx2/ushj/ZbOHci8
         Ujj5z/vq3IVpce0SCerRFmT3HV8xfaZ1GKPDaL0dUxrLlBynrjUrVgDuM1JCxGu/gBj3
         DVGZr6vnlJFuMW8dJHB6VzLkpmI0/MXcIw//RPx4lbPEiYi4gT8LaM75DQvcE9QZjTqK
         XrFjp5z4pTwpMtnj76L7DnNLPbPbkktNQsaSAoFiYCAkjmbB3BSnzLMOSKDmIXjqof6R
         tlqA==
X-Gm-Message-State: AOJu0Yy5T8wDLTKHfKPo0wxdBJrDNQhjYNpTtOWzNvRZvPmAM7zTNThX
	DvvyO03TmWOnX2MBrMbpcSIN1dZsg8WiPqZVZpY=
X-Google-Smtp-Source: AGHT+IFlo6VouuBmWdcFBQwADnUJvOA+82oZzVGuY+ap5U0fwCrntr2lM+BkuyYvn821bf8wSQKV2i7glKps1Axd29U=
X-Received: by 2002:a0c:aad1:0:b0:66d:a1ae:e762 with SMTP id
 g17-20020a0caad1000000b0066da1aee762mr947257qvb.14.1698360211864; Thu, 26 Oct
 2023 15:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <849b6ee2-99f3-4aaa-835f-44d3e13befc3@gmail.com>
 <ZTpJFUdE2U6pbV--@debian.me> <CAPig+cSsB-2xxF7uQRU2h219+0-9++M_woLX3vNwiq1Uj1SiQQ@mail.gmail.com>
 <CAJoAoZ=a30QsMXHz+47haZ=QGkY8-QYccSuY_94mi9h9RMiBFA@mail.gmail.com>
In-Reply-To: <CAJoAoZ=a30QsMXHz+47haZ=QGkY8-QYccSuY_94mi9h9RMiBFA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 26 Oct 2023 18:43:20 -0400
Message-ID: <CAPig+cRU5bU-QkX3au_+DvM8KiKHLNeB1u+PB2LXgz6gu-4qzw@mail.gmail.com>
Subject: Re: git diagnose with invalid CLI argument does not report error
To: Emily Shaffer <nasamuffin@google.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Sheik <sahibzone@gmail.com>, 
	Git Mailing List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>, 
	Calvin Wan <calvinwan@google.com>, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Alex Henrie <alexhenrie24@gmail.com>, Derrick Stolee <derrickstolee@github.com>, 
	Victoria Dye <vdye@github.com>, Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 6:41=E2=80=AFPM Emily Shaffer <nasamuffin@google.co=
m> wrote:
> On Thu, Oct 26, 2023 at 3:12=E2=80=AFPM Eric Sunshine <sunshine@sunshinec=
o.com> wrote:
> > On Thu, Oct 26, 2023 at 7:10=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail=
.com> wrote:
> > > On Thu, Oct 26, 2023 at 07:49:58AM +1100, Sheik wrote:
> > > > Running git diagnose with an invalid CLI argument in a valid Git di=
rectory
> > > > does not report error. Expected behaviour would be that it reports =
an error.
> > >
> > > I can reproduce this only when the invalid parameter is a normal word=
:
> > > Cc:'ing people who recently worked on builtin/diagnose.c for help.
> >
> > A patch by Emily to fix this has been submitted[v4].
>
> To be clear, that patch was for git-bugreport and doesn't cover
> git-diagnose. I assume the fix ends up being pretty similar though.

My bad.
