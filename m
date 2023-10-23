Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB2A18C30
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBF1C5
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 12:36:43 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-66d332f23e4so23328416d6.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 12:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698089802; x=1698694602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTEVNA7NQ/+bqNo6SZluFgH4MzgHVTen/9pcl6q71aU=;
        b=Zdmc9lgEHLomZOF9+MQNLsl+ggaubNQh5NLOy/ciqtph/XOa84ylsBOPBw6AfMs4OQ
         jMMbr/Yicf260mvxWOOAwOIrz0Wf3wGkbc24wt3foWZxQQXJa6dB/UkVNA4AxCMiFS6D
         tPYPzYaecnTMZnPtWANKs6vdDiLmg/6iBSzAccSTWyBA+MFFJeYe6C7xl+NPCdpoW6xC
         zyeKYzvj5Z4gSn0xOF5yM2HHPgJVIHOImqk1J4WeHVy6eWDXRaSo7abwmDtAcTECrJzZ
         30F+T02JSUDTJMgu2OvkDobA2iDVQhh/nou6FW0jfwTY35+NU4fDsXbJ170+U0rY6gXc
         PQ0w==
X-Gm-Message-State: AOJu0YyYkc1KYssaywzxzDH+rzADuuSGdb6gfS/HwlZ+Uzi7sHs6Ax88
	IZu2Nw8bYqbbOi3uLfSILeA35rB0MqWl/a+DpY6YDUjiA2Y=
X-Google-Smtp-Source: AGHT+IGYRwMgyFapxgJS0xw49okLS4EDcf3jqg0Oi9PI9aKJPC3HkzTFsgEX/n0rnQQIKqexjkI7NRaVX32tSsSP2wE=
X-Received: by 2002:a05:6214:224c:b0:66d:a1d3:fd94 with SMTP id
 c12-20020a056214224c00b0066da1d3fd94mr10035815qvc.19.1698089802508; Mon, 23
 Oct 2023 12:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1602.git.1698004968582.gitgitgadget@gmail.com> <pull.1602.v2.git.1698088990478.gitgitgadget@gmail.com>
In-Reply-To: <pull.1602.v2.git.1698088990478.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 23 Oct 2023 15:36:31 -0400
Message-ID: <CAPig+cQuBwzaG7ZssGUY6k8wf8pcGZHAGLnbRy579uTPMKqwKQ@mail.gmail.com>
Subject: Re: [PATCH v2] doc/git-bisect: clarify `git bisect run` syntax
To: cousteau via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Javier Mora <cousteaulecommandant@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 3:23=E2=80=AFPM cousteau via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> doc/git-bisect: clarify `git bisect run` syntax
>
> The description of the `git bisect run` command syntax at the beginning
> of the manpage is `git bisect run <cmd>...`, which isn't quite clear
> about what `<cmd>` is or what the `...` mean; one could think that it is
> the whole (quoted) command line with all arguments in a single string,
> or that it supports multiple commands, or that it doesn't accept
> commands with arguments at all.
>
> Change to `git bisect run <cmd> [<arg>...]` to clarify the syntax,
> in both the manpage and the `git bisect -h` command output.
>
> Additionally, change `--term-{new,bad}` et al to `--term-(new|bad)`
> for consistency with the synopsis syntax conventions.

Makes sense to fix this inconsistency, as well, though the patch
subject becomes a bit outdated with this addition.

> Signed-off-by: Javier Mora <cousteaulecommandant@gmail.com>
> ---
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> @@ -16,7 +16,7 @@ DESCRIPTION
> - git bisect start [--term-{new,bad}=3D<term> --term-{old,good}=3D<term>]
> + git bisect start [--term-(new|bad)=3D<term-new> --term-(old|good)=3D<te=
rm-old>]
>                   [--no-checkout] [--first-parent] [<bad> [<good>...]] [-=
-] [<paths>...]
>   git bisect (bad|new|<term-new>) [<rev>]
>   git bisect (good|old|<term-old>) [<rev>...]

Upon first reading, I questioned whether changing <term> to <term-new>
and <term-old> adds value since the option names --term-new and
--term-old already provide enough context for the reader to understand
the generic placeholder <term>. However, then I noticed that the
following two lines are already referencing placeholders <term-new>
and <term-old>, so perhaps this change makes sense. But...

> diff --git a/builtin/bisect.c b/builtin/bisect.c
> @@ -26,7 +26,7 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BIS=
ECT_FIRST_PARENT")
>  #define BUILTIN_GIT_BISECT_START_USAGE \
> -       N_("git bisect start [--term-{new,bad}=3D<term> --term-{old,good}=
=3D<term>]" \
> +       N_("git bisect start [--term-(new|bad)=3D<term> --term-(old|good)=
=3D<term>]" \

...now we have an inconsistency again since this text just uses the
generic <term>. However, I haven't convinced myself that we need to
care about this inconsistency.
