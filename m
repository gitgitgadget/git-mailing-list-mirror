Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DBC22095B
	for <e@80x24.org>; Sat, 18 Mar 2017 17:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbdCRRpC (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 13:45:02 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36411 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdCRRpC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 13:45:02 -0400
Received: by mail-vk0-f65.google.com with SMTP id d188so7192956vka.3
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 10:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bxF35VL/r5LgGjycgKslcYJ5BkvEd6dn7F81OxLvBGc=;
        b=QdOa0JcfoJiMNea8Pvd/CfXfEB1NHbhcpR+05YQFqUxjULTy5PORb6A3ZIgDO/hcpw
         pNflT/6S3aN5I8Pv0MAv9i8mFJ7zyUgqkx+/Xb85W1yQ9yatjt7K1atGrAJ7adtuXgSw
         DMQUs848a/w9JK1Jg7UctuMfSH7k4X9hBkmyG7Q3wWyff+x0OxcGqls+RwtRF6kEMxal
         lrg5Zu2V3YNJtidRPbWPxsJNPx+tqBpKfrPUdZyewF22gauX49Hxqid8up+0HhacJ5TY
         c9zeNfkwF4gemSl/6542DN8kEzbk1w7Og6aKBgk36G10eiQk9He/Eres13vrDES4JoX/
         7S/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bxF35VL/r5LgGjycgKslcYJ5BkvEd6dn7F81OxLvBGc=;
        b=bu8ov+T6AJGmi3Rgnq/8XzGuX5K6wfbqKLptavm1JdOcB0mau4mI6t2aYUuXsFwqKU
         TXSknNcYb61ulOy7Sd3zzWlKYQg0XvakZuXPMPtRNtln+sLZFLqEe/N4D0nEkGu0PnnB
         w9Z+uUe/OmnLaVpX4oSJ5LrU1HhoHGvRRRhrIRQooUIeZG2VhakfFZ6ru4Lx3lNiDQpV
         n4Y5xv5vibGtVxjw9ND93R8hHksWifgAEVMtsuteniKb0cNRGI5E/5pciLrrtj7/nzWb
         6CuJclyB7WFD/d4bTlXX/0oLwCnxcrK8adkHJnCSy4Lu1NTJl2tvzDrdShZUPTNwvYpa
         w60g==
X-Gm-Message-State: AFeK/H2j4J9Omx/MURxsDmEtwnvMlgZtZMQ8KZfMydwLOOLvopinCpyB4O6u02IvXN8DmO5pUJivzGkN0gT+5g==
X-Received: by 10.31.217.7 with SMTP id q7mr6669611vkg.32.1489859100501; Sat,
 18 Mar 2017 10:45:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.7.150 with HTTP; Sat, 18 Mar 2017 10:45:00 -0700 (PDT)
In-Reply-To: <20170318151239.17196-1-szeder.dev@gmail.com>
References: <20170318151239.17196-1-szeder.dev@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sat, 18 Mar 2017 18:45:00 +0100
Message-ID: <CAM0VKjknLpCyQfY+ie3sfGemwhyad3Tk-5fHdeTSz2-WTw7NoQ@mail.gmail.com>
Subject: Re: [PATCH] pickaxe: fix segfault with '-S<...> --pickaxe-regex'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 4:12 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> Make sure that the buffer size is reduced on each iteration as the
> buffer pointer is advanced, thus maintaining the correct end of buffer
> location.
>
> The new test is flaky, I've never seen it fail on my Linux box, but
> this is expected according to db5dfa331 (regex: -G<pattern> feeds a
> non NUL-terminated string to regexec() and fails, 2016-09-21).  And
> based on that commit message I would expect the new test without the
> fix to fail reliably on Windows.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>
>  diffcore-pickaxe.c      | 5 ++++-
>  t/t4062-diff-pickaxe.sh | 5 +++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index 9795ca1c1..03f84b714 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -85,8 +85,11 @@ static unsigned int contains(mmfile_t *mf, regex_t *re=
gexp, kwset_t kws)
>                        !regexec_buf(regexp, data, sz, 1, &regmatch, flags=
)) {
>                         flags |=3D REG_NOTBOL;
>                         data +=3D regmatch.rm_eo;
> -                       if (*data && regmatch.rm_so =3D=3D regmatch.rm_eo=
)
> +                       sz -=3D regmatch.rm_eo;
> +                       if (*data && regmatch.rm_so =3D=3D regmatch.rm_eo=
) {
>                                 data++;
> +                               sz--;
> +                       }
>                         cnt++;
>                 }
>
> diff --git a/t/t4062-diff-pickaxe.sh b/t/t4062-diff-pickaxe.sh
> index f0bf50bda..7c4903f49 100755
> --- a/t/t4062-diff-pickaxe.sh
> +++ b/t/t4062-diff-pickaxe.sh
> @@ -19,4 +19,9 @@ test_expect_success '-G matches' '
>         test 4096-zeroes.txt =3D "$(cat out)"
>  '
>
> +test_expect_success '-S --pickaxe-regex' '
> +       git diff --name-only -S0 --pickaxe-regex HEAD^ >out &&
> +       verbose test 4096-zeroes.txt =3D "$(cat out)"
> +'
> +
>  test_done

Hang on, this new test does fail because of a segfault _with_ the fix
on Travis 64bit Linux and OSX builds.

Oh, well.
