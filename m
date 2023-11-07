Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F1F20FB
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 02:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcLclO0s"
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8ED98
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 18:44:04 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a0907896so6541391e87.2
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 18:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699325043; x=1699929843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdYyLkBkD8wIE7HwmegXcCtY4IP5UdvYpvT+z4o2JVY=;
        b=YcLclO0s1/sGPDuSRuMx/+i4E17zMLLr5zKPb5NJIALjjujkfJtEpdkDVIy2MlDrMu
         ur3/aVV0pDT0+g+R39feVFbmJ54CpO+yfnWmyuC1PoQJHYaQUfvfjinf6lyQwEFy94dV
         RDYcCZUsVT/XLmA8orUNY7yhUe8il0prUKeVFTfL8hcO5xUPdz/p2n2fml+Wm4CLiHvR
         VPoQhH9Fv4LTn1uVGW80zrG/BfojMlclxQIcfKKDzSc3mwbHIB2Xe3M6MruFG+EH/l8X
         2fB67WT/hrmW7CZQAK3X1kWOSIwVhZGCrIs6jdn4MhACDVksfK3wMP0BxBHiunVb4LU4
         d4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699325043; x=1699929843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdYyLkBkD8wIE7HwmegXcCtY4IP5UdvYpvT+z4o2JVY=;
        b=fTQ3PWiKaxpg+H/3TpWdRAy2Y/VWihMJBfpWbJb8znGV5uFjEj7ZryWvHAx8FOtKPK
         wzF9gx2wwset++vvXbd2ZTzUEoPPUSt9vUxQzjTraaj/G1+y+53ytQAS8WLrY26exUjD
         J61HFktmtbK38uVaCoITmkeVRnX2Rjw0O9gLr6YoFHWl6oz5LUQFnIf0tlRF2UwDMnkw
         4IsPEg0YGLWSlf2glEVu3nYkaOO8U7GAGQAxL5qvz0jLvLqs3I3ZdI++jKQ8AjmX3/Yq
         MYeZoCO7NoBcmEqqJAc3I/Fww3TjTQaROhBz8eq5y9oCxbpB6CSU5wmAL4gdf4TFySrA
         1+vQ==
X-Gm-Message-State: AOJu0YwqIbYShdOzyNkqLiyDS6djuGuDxfpuP0PDv1HkxN7v1G8UhLJF
	5I9CbQh5fVqGpTp57NIPTVI21FVVKDTlsORLIp+sx7Dbkz02Bg==
X-Google-Smtp-Source: AGHT+IGFT/P/tAiaMzUwauVwzV0tZzBep1o3Zryyn9qqXVLo8C3lqH3+84tMui1Yfz5gqqeh3XUGydJJaBC5AH3l5Jw=
X-Received: by 2002:a19:ac0d:0:b0:509:5d4b:742f with SMTP id
 g13-20020a19ac0d000000b005095d4b742fmr6243393lfc.20.1699325042697; Mon, 06
 Nov 2023 18:44:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010123847.2777056-1-christian.couder@gmail.com> <20231102135151.843758-1-christian.couder@gmail.com>
In-Reply-To: <20231102135151.843758-1-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 6 Nov 2023 18:43:50 -0800
Message-ID: <CABPp-BE6G2qaF50bhz-CwxSsvxGDHzwvsWtfQO4zVcX6ERppLw@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] Introduce new `git replay` command
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, John Cai <johncai86@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, Dragan Simic <dsimic@manjaro.org>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Looking good, just one comment on one small hunk...

On Thu, Nov 2, 2023 at 6:52=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
[...]

>     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, cons=
t char *prefix
>      -
>         strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL)=
;
>
>     ++  /*
>     ++   * TODO: For now, let's warn when we see an option that we are
>     ++   * going to override after setup_revisions() below. In the
>     ++   * future we might want to either die() or allow them if we
>     ++   * think they could be useful though.
>     ++   */
>     ++  for (i =3D 0; i < argc; i++) {
>     ++          if (!strcmp(argv[i], "--reverse") || !strcmp(argv[i], "--=
date-order") ||
>     ++              !strcmp(argv[i], "--topo-order") || !strcmp(argv[i], =
"--author-date-order") ||
>     ++              !strcmp(argv[i], "--full-history"))
>     ++                  warning(_("option '%s' will be overridden"), argv=
[i]);
>     ++  }
>     ++

Two things:

1) Not sure it makes sense to throw a warning with --topo-order or
--full-history, since they would result in a value matching what we
would be setting anyway.

2) This seems like an inefficient way to provide this warning; could
we avoid parsing the arguments for an extra time?  Perhaps instead
  a) set the desired values here, before setup_revisions()
  b) after setup_revisions, check whether these values differ from the
desired values, if so throw a warning.
  c) set the desired values, again
?
