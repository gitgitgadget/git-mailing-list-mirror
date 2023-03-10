Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E8FC6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 13:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCJNkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 08:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCJNka (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 08:40:30 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB7010A289
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 05:40:16 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-536bbe5f888so97776297b3.8
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 05:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678455616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YQflFf6IbLRiupQIGsMQqA0P01r/lIWYqj3oBx47uY=;
        b=Z/IHSqJDayJRy4x/Qs1Hnlfr2UZomA0EX/muUICe8DY/yQSveAhbmxJw0JeffY4v1O
         KW4TsBiPCZSWL2bscEh+I7nOoHCO/5AiHc10sYgp8x+ZDJIwqEZET7VxYVBI2cOik0a3
         jxAIMx6/Es1c0A4eewgzWIli3iUcSpkSxYn/U4QKgXl5H2e0pOVm0+rFTnBw5aaWHE0D
         ZfdL8RHkyRv9ksbdPFreXRVXRTmo447iEa6EXxCEFRyD6G75Fq7p4l5tdEd7aqHTsE/U
         5cRc7lmzHPXK7L7uzCGC5GQruiEjLkaQnD3p5mUj1jcKHEW8+uVPA6AEFvIHgKcKEN4b
         3+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678455616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YQflFf6IbLRiupQIGsMQqA0P01r/lIWYqj3oBx47uY=;
        b=x7iaGovLVdKUyJxWbVbMn1WMKcM/StpVR9cwzllGnbbkz6qw3JdGFU7nNTrGXtGGx4
         uGhba3aBLasiS2OkeKusZJNWxKCmu3MIBwxE5mGSodzXRXTbey/IKXYDc4BUN8v99Zm3
         /1fDVEi0kHaTFQpL3siCG2BEmHpoh2f/VbG0EArpmYNwpylHuojyv3VM3nASnjY2Crv+
         yWBvgAGRHv0zmZWNVmoqsRnQdY8l8dHfiNCKjbpz/ju9bIUEYJsN7huPCr6ERwCBQP10
         AUy575GiU0gd+T7/xlvFL9lgDrJSQlcJ1VCvjJmT6Iw0DpEgQRTlpfyBD/oESv5vhaMN
         S71A==
X-Gm-Message-State: AO0yUKVn92sl1q6NzHr8qW5cUmmXirlT0GJ64f8OSjL/hVVaiKXDJYti
        WyDs2mbj44cP5pNiTYP+czhyNhRvG5EJLvq1yQU=
X-Google-Smtp-Source: AK7set8FV6iVDQ+HUUWn+b5QHX3WyfkzMPu4q9BlieTV1dVYmCjRbGgnPVqq36fjentUNxB/HY4kfJfkgsUudlhQcs8=
X-Received: by 2002:a81:441e:0:b0:533:99bb:c299 with SMTP id
 r30-20020a81441e000000b0053399bbc299mr16716655ywa.3.1678455615744; Fri, 10
 Mar 2023 05:40:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.1465.git.git.1678453473484.gitgitgadget@gmail.com>
In-Reply-To: <pull.1465.git.git.1678453473484.gitgitgadget@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 10 Mar 2023 21:40:04 +0800
Message-ID: <CAOLTT8QKCoCdi8hBmrOYNchFEFKZ_MgPiOZY0N0VkE9RK07CbQ@mail.gmail.com>
Subject: Re: [PATCH] ls-files: fix "--format" output of relative paths
To:     Adam Johnson via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Adam Johnson <me@adamj.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Johnson via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2023=E5=B9=
=B43=E6=9C=8810=E6=97=A5=E5=91=A8=E4=BA=94 21:04=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Adam Johnson <me@adamj.eu>
>
> Fix a bug introduced with the "--format" option in
> ce74de931d, where relative paths were computed
> using the output buffer, which could lead to
> random data in the output.
>
> Signed-off-by: Adam Johnson <me@adamj.eu>
> ---
>     ls-files: fix "--format" output of relative paths
>
>     ce74de931d introduced with the "--format" option to ls-files. This
>     commit had a bug: using --format=3D'%(path)' with the "top" pathspec =
from
>     within a subdirectory would lead to random memory being added to the
>     output. For example, within the Documentation/ directory in Git=E2=80=
=99s own
>     repository:
>
>     $ git ls-files --format=3D'%(path)' ':/' | head -n 2
>     ../.cirrus.yml=EF=BF=BD=EB=BB=A4=EF=BF=BD=EF=BF=BD
>     ../.clang-format=EF=BF=BD=EB=BB=A4=EF=BF=BD=EF=BF=BD
>
>
>     This is due to reuse of a string buffer for calculating the relative
>     path. The attached patch fixes this by using a fresh buffer, the same
>     pattern used in other places where relative paths are computed.
>

Good catch!

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-146=
5%2Fadamchainz%2Ffix-ls-files-format-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1465/a=
damchainz/fix-ls-files-format-v1
> Pull-Request: https://github.com/git/git/pull/1465
>
>  builtin/ls-files.c         |  5 ++++-
>  t/t3013-ls-files-format.sh | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 4cf8a236483..02b9bbe7eb4 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -89,12 +89,15 @@ static void write_name(const char *name)
>
>  static void write_name_to_buf(struct strbuf *sb, const char *name)
>  {
> -       const char *rel =3D relative_path(name, prefix_len ? prefix : NUL=
L, sb);
> +       struct strbuf buf =3D STRBUF_INIT;
> +       const char *rel =3D relative_path(name, prefix_len ? prefix : NUL=
L, &buf);
>
>         if (line_terminator)
>                 quote_c_style(rel, sb, NULL, 0);
>         else
>                 strbuf_addstr(sb, rel);
> +
> +       strbuf_release(&buf);
>  }
>

Here I misused the outer strbuf.

>  static const char *get_tag(const struct cache_entry *ce, const char *tag=
)
> diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
> index efb7450bf1e..ef6fb53f7f1 100755
> --- a/t/t3013-ls-files-format.sh
> +++ b/t/t3013-ls-files-format.sh
> @@ -54,6 +54,22 @@ test_expect_success 'git ls-files --format path v.s. -=
s' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'git ls-files --format with relative path' '
> +       cat >expect <<-\EOF &&
> +       ../o1.txt
> +       ../o2.txt
> +       ../o3.txt
> +       ../o4.txt
> +       ../o5.txt
> +       ../o6.txt
> +       EOF
> +       mkdir sub &&
> +       cd sub &&
> +       git ls-files --format=3D"%(path)" ":/" >../actual &&
> +       cd .. &&
> +       test_cmp expect actual
> +'
> +
>  test_expect_success 'git ls-files --format with -m' '
>         echo change >o1.txt &&
>         cat >expect <<-\EOF &&
>
> base-commit: 768bb238c4843bf52847773a621de4dffa6b9ab5
> --
> gitgitgadget


I'm glad you caught that mistake.

Thanks.
--
ZheNing Hu
