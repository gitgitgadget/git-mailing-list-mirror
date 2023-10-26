Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A22F3E483
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3027D116
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:11:55 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5aa7172bafdso1186074a12.1
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698358314; x=1698963114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfUpLsXS7ZJQodZwC1Cd+GPC8y2J4Z8okoPnv9o8eBI=;
        b=M000Evt8FdCpbFykm9wcc9M1ynLDOnBljfg28wCuNtGVcpirO1FQJA23BghUz7Kn2m
         +4DjamEHcas6OpjH2WdJh8GbHSu6GS+QKsBtNfJbOGU8nfw3fadudHl6pC6DlNXE9za3
         1onAlX6FtiucYjnM+QPqI3vwC0EcUOQ8KqNNgAlefSLo921EsKViOv07gUO/sToF57gv
         Y2kCRIWw+czE903jpwdknOdRMu8thm+RwK9BXuzOAOzCfln4MN8gGXH3+q0Oz9XLkUZT
         K7tdO3rEnDikTUyS83pY0ZTAGwXhfX90lWxqs2FN3myDw6Srh5nblSZX31wkgtgBej7c
         6EQA==
X-Gm-Message-State: AOJu0YzLkQissuCEtuZnlXgvwu3OKtUw6c7+sfOG6+AQ3IhExieVQvdX
	zI91dpvlq6bDRjm5rPjZXb345IL1beqPlYjAYPA=
X-Google-Smtp-Source: AGHT+IEMCbknWr00yMuXULrI7g3fDONbXTaB3M7TXHChBaqwTVtdIDLvwCasu8xokw4WqtXX1n6Go+Rx/CS8hldQTbE=
X-Received: by 2002:a17:90a:1957:b0:280:205:9ba2 with SMTP id
 23-20020a17090a195700b0028002059ba2mr871252pjh.5.1698358314637; Thu, 26 Oct
 2023 15:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <849b6ee2-99f3-4aaa-835f-44d3e13befc3@gmail.com> <ZTpJFUdE2U6pbV--@debian.me>
In-Reply-To: <ZTpJFUdE2U6pbV--@debian.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 26 Oct 2023 18:11:42 -0400
Message-ID: <CAPig+cSsB-2xxF7uQRU2h219+0-9++M_woLX3vNwiq1Uj1SiQQ@mail.gmail.com>
Subject: Re: git diagnose with invalid CLI argument does not report error
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Sheik <sahibzone@gmail.com>, Git Mailing List <git@vger.kernel.org>, 
	Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Alex Henrie <alexhenrie24@gmail.com>, Derrick Stolee <derrickstolee@github.com>, 
	Victoria Dye <vdye@github.com>, Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 7:10=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
> On Thu, Oct 26, 2023 at 07:49:58AM +1100, Sheik wrote:
> > Hi Maintainers,
> >
> > Running git diagnose with an invalid CLI argument in a valid Git direct=
ory
> > does not report error. Expected behaviour would be that it reports an e=
rror.
> >
> > #Example shell commands which should have reported an error but continu=
es to
> > succeed
> >
> > cd $ToAGitDirectory
> > git diagnose mod
> > git diagnose mode
> > git diagnose mode=3Dall
>
> I can reproduce this only when the invalid parameter is a normal word:
> ```
> $ git diagnose huh
> ```
> But the command errors out on invalid flag:
> ```
> $ git diagnose -m
> ```
> Cc:'ing people who recently worked on builtin/diagnose.c for help.

A patch by Emily to fix this has been submitted[v4].

[v4]: https://lore.kernel.org/git/20231026182231.3369370-3-nasamuffin@googl=
e.com/
