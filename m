Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D748C433ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 03:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A89F6115A
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 03:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhDCDWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 23:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbhDCDWm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 23:22:42 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711D8C0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 20:22:38 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id d10so6007215ils.5
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 20:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O8925oh6s+fAUnbR8jUfbhzMdbI4FGJResN+yxXt1PA=;
        b=L3cwmnbD8XEn4DbL+6g9/dhLQiOWdOlCTIYb5wjLtWocG8QQkuh+5U9piZ/Q7EAfiZ
         sIPbbCkw0dK5qfzWyQCXEvZ6B7ZtHyjPu7swNSEIF+C91yU5tguz2EXaChqgSGLO79XU
         ch6OfL2O7mGk4jBgwBul+HZEFTEWgI/FAVd4bFrltVv9DQDEETbKUlTj4UsegqZw6TPI
         hr2rhJxGVic9UocbAlKobpi6+EIMIlJicQK9zmtrZRg50KI9lBBgzsxtl+LxutBBTpgn
         N6Cd26NmOwukJfqya5y2qVtRr7MOeRgHPajdaItqwfkljTzCwBkkHLl1EOGCaD0CYBom
         k45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O8925oh6s+fAUnbR8jUfbhzMdbI4FGJResN+yxXt1PA=;
        b=LVc907gR7QlSmQ8OW6jyWeGgv873VKsWXvYrlvQJcqerANl5/13D7X9fa9i+lhbE8i
         Yy0EVkZ8ufhJA/GPPMmsdlWJNUcUapInYVgGgC02ALq8ofKu1YD3GD1YYEiwNgFHstD3
         Hcjplxkos7PWpCTs1iN6AUUtWjKi/XqFJ7sSzaj+Gqmt8JnyLV8ef6SE8Sd87ax52JrF
         AljyuANAmX4T396k6HDgaUZykptCqtEm3OapgtO87GXLmxaQA7a+xySKN0MgjdOOrIvI
         DAJJ6AjpX4z0nw3cty6Sm+Ca8OW0+wG7A7qXNn5a0ZqJL5Gc89YTnNpJy5VlU0BD7ebz
         Wn9g==
X-Gm-Message-State: AOAM532pK6SDIYtTf+m+BM7p6kA49Sx79lUS5aweL+t4lioAWOh/UJya
        ippRZ2FNFDcIgifvW+zYYfrpmhlsmcyiJSqn8no=
X-Google-Smtp-Source: ABdhPJyvjfqVx7wSTHyWOJEwzQBXp7FZpQKgaYXDDYIP36aYIikiI3aZtfYeeyCwjx2PBgVXTUuaE+5qHbFnLMVXxuw=
X-Received: by 2002:a05:6e02:f41:: with SMTP id y1mr12286310ilj.259.1617420157829;
 Fri, 02 Apr 2021 20:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
 <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com> <xmqq35w82qvu.fsf@gitster.g>
In-Reply-To: <xmqq35w82qvu.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 3 Apr 2021 11:22:26 +0800
Message-ID: <CAOLTT8TaUkfdOhD4+P=VVxuy3dPCaf4KNC8+1hBQnxSjpvO4HQ@mail.gmail.com>
Subject: Re: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=883=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=887:44=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > The `trailer.<token>.command` configuration variable
> > specifies a command (run via the shell, so it does not have
> > to be a single name of or path to the command, but can be a
> > shell script), and the first occurrence of substring $ARG is
> > replaced with the value given to the `interpret-trailer`
> > command for the token.  This has two downsides:
> > ...
> >
> >  Documentation/git-interpret-trailers.txt | 82 +++++++++++++++++---
> >  t/t7513-interpret-trailers.sh            | 95 +++++++++++++++++++++++-
> >  trailer.c                                | 38 +++++++---
> >  3 files changed, 193 insertions(+), 22 deletions(-)
>
> Merging this to anything that has zh/commit-trailer (which extends
> the tests in t7502) seems to break t7502.  Running the test with the
> "-i -v" option ends like so.
>
> expecting success of 7502.24 'commit --trailer with -c and command':
>         trailer_commit_base &&
>         cat >expected <<-\EOF &&
>         hello
>
>         Signed-off-by: C O Mitter <committer@example.com>
>         Signed-off-by: C1 E1
>         Helped-by: C2 E2
>         Mentored-by: C4 E4
>         Reported-by: A U Thor <author@example.com>
>         EOF
>         git -c trailer.report.key=3D"Reported-by: " \
>                 -c trailer.report.ifexists=3D"replace" \
>                 -c trailer.report.command=3D"NAME=3D\"\$ARG\"; test -n \"=
\$NAME\" && \
>                 git log --author=3D\"\$NAME\" -1 --format=3D\"format:%aN =
<%aE>\" || true" \
>                 commit --trailer "report =3D author" --amend &&
>         git cat-file commit HEAD >commit.msg &&
>         sed -e "1,/^\$/d" commit.msg >actual &&
>         test_cmp expected actual
>
> [main 6b1e5e9] hello
>  Author: A U Thor <author@example.com>
>  1 file changed, 1 insertion(+)
> [main 97c7a39] hello
>  Author: A U Thor <author@example.com>
>  Date: Thu Apr 7 15:22:13 2005 -0700
>  1 file changed, 1 insertion(+)
> --- expected    2021-04-02 23:43:10.649082950 +0000
> +++ actual      2021-04-02 23:43:10.673085111 +0000
> @@ -4,4 +4,4 @@
>  Signed-off-by: C1 E1
>  Helped-by: C2 E2
>  Mentored-by: C4 E4
> -Reported-by: A U Thor <author@example.com>
> +Reported-by:
> not ok 24 - commit --trailer with -c and command
> #
> #               trailer_commit_base &&
> #               cat >expected <<-\EOF &&
> #               hello
> #
> #               Signed-off-by: C O Mitter <committer@example.com>
> #               Signed-off-by: C1 E1
> #               Helped-by: C2 E2
> #               Mentored-by: C4 E4
> #               Reported-by: A U Thor <author@example.com>
> #               EOF
> #               git -c trailer.report.key=3D"Reported-by: " \
> #                       -c trailer.report.ifexists=3D"replace" \
> #                       -c trailer.report.command=3D"NAME=3D\"\$ARG\"; te=
st -n \"\$NAME\" && \
> #                       git log --author=3D\"\$NAME\" -1 --format=3D\"for=
mat:%aN <%aE>\" || true" \
> #                       commit --trailer "report =3D author" --amend &&
> #               git cat-file commit HEAD >commit.msg &&
> #               sed -e "1,/^\$/d" commit.msg >actual &&
> #               test_cmp expected actual
> #

Little bug, Change it like this will work:

        } else if (conf->command) {
                strbuf_addstr(&cmd, conf->command);
-               strvec_push(&cp.args, cmd.buf);
                if (arg)
                        strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
+               strvec_push(&cp.args, cmd.buf);
        }

thanks.
--
ZheNing Hu
