Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEA9C33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 13:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9819206D5
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 13:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHN8RqRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgAPNLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:11:14 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36119 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPNLO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 08:11:14 -0500
Received: by mail-qk1-f196.google.com with SMTP id a203so19023680qkc.3
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 05:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dq/OvAip84vdUNYL2cRs8FdI9UBxtQE+XIF42QvEbd4=;
        b=LHN8RqRlfLALCCyiB5dOtA740o8Hq0ZcbV582WzbSakLvFtGnBHMJnEJgXcOOW3zFH
         dq7aaBD4gKpy3cUk05xtlVzIin78WqoJqP23iwXC+ZoCfwsSFABgVEtLxWT6tcJrP8/U
         BNT5nrWJ+XZxXrBHnyggD6wjfXV8ra9ccUFeuQAtfZn127tZN2f646VxDiBBgXlCREj/
         /JyAdmTNd1jsFzz1gXogRuj4YB3Y7Z4DSJDEpVloiccQtYupOnxNpsgyLacLn4eTZOWV
         1mRD8Loye7R/CIEgXTIYqmiq0UdhaKI48RV6jxY9BrkzpZoQoqYC3PYNOtWIJMMLYF57
         bC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dq/OvAip84vdUNYL2cRs8FdI9UBxtQE+XIF42QvEbd4=;
        b=BB7vHGXHfPDGX2E79FStHZRQtlE4gKf5jIbc3a1KTJrQDbxrcI2VxIHXh0W/X2FIPH
         KRAAQT4yiVBQwTx32FxuCTBmIZksvX2MFJw9uFXCKSqOWjz44XGyeuMQFqXVnV8v1cxT
         4j7dRiP5W+3ZjR9e0R6M1jWTjUtwE895a0B1KGW8REACUrIjNVUxIrce1mrJ2KQ6GDJm
         KhwuMSL3wdegO60x3e+ztBA5YSlDp/soZCXKUbbj9dGRSlAsg7oEYW5d5AnF4YE+gzIL
         0D5yawO9po6tygsHJuUoKATA9MbD6/GPzVe4LpjhGMwOIJwOWf/BAAEUWS+JwLUlnZm5
         kdYA==
X-Gm-Message-State: APjAAAWE4YYB0PBsf9UHPB2ZzjrHtXeHCORtZYS+i+HYm+0u+dDbIt2p
        Br5SQVhTPVlsuKScgUNMvGtkZsmWNHXRfZ6ioOY=
X-Google-Smtp-Source: APXvYqwPu92ro199qz0P9cDa0V7vRJSiph0rWzg4NEhuLb7HozIS5wC3/gCRi8nPB1Jbj2bRJq7jHbl189yKwOZnl/A=
X-Received: by 2002:a37:a953:: with SMTP id s80mr28018098qke.81.1579180273200;
 Thu, 16 Jan 2020 05:11:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579141989.git.matheus.bernardino@usp.br> <a5891176d7778b98ac35c756170dd334b8ee21c7.1579141989.git.matheus.bernardino@usp.br>
In-Reply-To: <a5891176d7778b98ac35c756170dd334b8ee21c7.1579141989.git.matheus.bernardino@usp.br>
From:   Victor Leschuk <vleschuk@gmail.com>
Date:   Thu, 16 Jan 2020 16:11:02 +0300
Message-ID: <CAGuA69ujsOBm2+RKEkGu8wLoEVvKxivY762Zokf9MWxDWrwWFQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] grep: use no. of cores as the default no. of threads
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git List <git@vger.kernel.org>, christian.couder@gmail.com,
        Junio C Hamano <gitster@pobox.com>, jrnieder@gmail.com,
        olyatelezhnaya@gmail.com,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Victor Leschuk <vleschuk@accesssoftek.com>,
        Eric Wong <e@80x24.org>, Matthieu Moy <git@matthieu-moy.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Grepping bottleneck is not cpu, but IO. Maybe it is more reasonable to
use not online_cpus() but online_cpus()*2?

--
Victor


On Thu, Jan 16, 2020 at 5:41 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> When --threads is not specified, git-grep will use 8 threads by default.
> This fixed number may be too many for machines with fewer cores and too
> little for machines with more cores. So, instead, use the number of
> logical cores available in the machine, which seems to result in the
> best overall performance: The following measurements correspond to the
> mean elapsed times for 30 git-grep executions in chromium's
> repository[1] with a 95% confidence interval (each set of 30 were
> performed after 2 warmup runs). Regex 1 is 'abcd[02]' and Regex 2 is
> '(static|extern) (int|double) \*'.
>
>       |          Working tree         |           Object Store
> ------|-------------------------------|--------------------------------
>  #ths |  Regex 1      |  Regex 2      |   Regex 1      |   Regex 2
> ------|---------------|---------------|----------------|---------------
>   32  |  2.92s =C2=B1 0.01 |  3.72s =C2=B1 0.21 |   5.36s =C2=B1 0.01 |  =
 6.07s =C2=B1 0.01
>   16  |  2.84s =C2=B1 0.01 |  3.57s =C2=B1 0.21 |   5.05s =C2=B1 0.01 |  =
 5.71s =C2=B1 0.01
> >  8  |  2.53s =C2=B1 0.00 |  3.24s =C2=B1 0.21 |   4.86s =C2=B1 0.01 |  =
 5.48s =C2=B1 0.01
>    4  |  2.43s =C2=B1 0.02 |  3.22s =C2=B1 0.20 |   5.22s =C2=B1 0.02 |  =
 6.03s =C2=B1 0.02
>    2  |  3.06s =C2=B1 0.20 |  4.52s =C2=B1 0.01 |   7.52s =C2=B1 0.01 |  =
 9.06s =C2=B1 0.01
>    1  |  6.16s =C2=B1 0.01 |  9.25s =C2=B1 0.02 |  14.10s =C2=B1 0.01 |  =
17.22s =C2=B1 0.01
>
> The above tests were performed in a desktop running Debian 10.0 with
> Intel(R) Xeon(R) CPU E3-1230 V2 (4 cores w/ hyper-threading), 32GB of
> RAM and a 7200 rpm, SATA 3.1 HDD.
>
> Bellow, the tests were repeated for a machine with SSD: a Manjaro laptop
> with Intel(R) i7-7700HQ (4 cores w/ hyper-threading) and 16GB of RAM:
>
>       |          Working tree          |           Object Store
> ------|--------------------------------|--------------------------------
>  #ths |  Regex 1      |  Regex 2       |   Regex 1      |   Regex 2
> ------|---------------|----------------|----------------|---------------
>   32  |  3.29s =C2=B1 0.21 |   4.30s =C2=B1 0.01 |   6.30s =C2=B1 0.01 | =
  7.30s =C2=B1 0.02
>   16  |  3.19s =C2=B1 0.20 |   4.14s =C2=B1 0.02 |   5.91s =C2=B1 0.01 | =
  6.83s =C2=B1 0.01
> >  8  |  2.90s =C2=B1 0.04 |   3.82s =C2=B1 0.20 |   5.70s =C2=B1 0.02 | =
  6.53s =C2=B1 0.01
>    4  |  2.84s =C2=B1 0.02 |   3.77s =C2=B1 0.20 |   6.19s =C2=B1 0.02 | =
  7.18s =C2=B1 0.02
>    2  |  3.73s =C2=B1 0.21 |   5.57s =C2=B1 0.02 |   9.28s =C2=B1 0.01 | =
 11.22s =C2=B1 0.01
>    1  |  7.48s =C2=B1 0.02 |  11.36s =C2=B1 0.03 |  17.75s =C2=B1 0.01 | =
 21.87s =C2=B1 0.08
>
> [1]: chromium=E2=80=99s repo at commit 03ae96f (=E2=80=9CAdd filters test=
ing at DSF=3D2=E2=80=9D,
>      04-06-2019), after a 'git gc' execution.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  Documentation/git-grep.txt | 4 ++--
>  builtin/grep.c             | 3 +--
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index de628741fa..eb5412724f 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -59,8 +59,8 @@ grep.extendedRegexp::
>         other than 'default'.
>
>  grep.threads::
> -       Number of grep worker threads to use.  If unset (or set to 0),
> -       8 threads are used by default (for now).
> +       Number of grep worker threads to use. If unset (or set to 0), Git=
 will
> +       use as many threads as the number of logical cores available.
>
>  grep.fullName::
>         If set to true, enable `--full-name` option by default.
> diff --git a/builtin/grep.c b/builtin/grep.c
> index a85b710b48..629eaf5dbc 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -33,7 +33,6 @@ static char const * const grep_usage[] =3D {
>
>  static int recurse_submodules;
>
> -#define GREP_NUM_THREADS_DEFAULT 8
>  static int num_threads;
>
>  static pthread_t *threads;
> @@ -1064,7 +1063,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
>         } else if (num_threads < 0)
>                 die(_("invalid number of threads specified (%d)"), num_th=
reads);
>         else if (num_threads =3D=3D 0)
> -               num_threads =3D HAVE_THREADS ? GREP_NUM_THREADS_DEFAULT :=
 1;
> +               num_threads =3D HAVE_THREADS ? online_cpus() : 1;
>
>         if (num_threads > 1) {
>                 if (!HAVE_THREADS)
> --
> 2.24.1
>
