Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F78C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 20:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04E820702
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 20:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="BMyf9sbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgA2UnK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 15:43:10 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34184 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgA2UnK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 15:43:10 -0500
Received: by mail-lj1-f193.google.com with SMTP id x7so900347ljc.1
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 12:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kg2O4NEG5TSK+ezP1YUyeJ5l5IY/DIGIbvDkIeYdbz0=;
        b=BMyf9sbFT/MP+5PQOETnregS7yjbBZkjtQt6Ueq2CHfbk+LIONBbsfN8MWhwqJRAF8
         4t9wA94LdoEWGl4WNoULcb0oZ6Mdyv2PXegyp8AzPMgSapbGQX3TL7R7DzkJlH6GiU4y
         rcDf2DynZQtTvH7q1m8iHKBe3k0zCwFgjZnGVio+kBao4BkBn55exGFIVkc+SOsQhwiw
         jMZsx9it4Dcwiz+86CTVOT9URVImNFrx8ITu8NtazsQtQrM/G04qUMt2ZBVCvqj5L8uO
         va8o84iNnE2UMAuaTnmhH7+cdziddT3AWoEA7HXjVteSuWnxy5ujad3PVvgJELD0OkOy
         PAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kg2O4NEG5TSK+ezP1YUyeJ5l5IY/DIGIbvDkIeYdbz0=;
        b=NJmSceuYIvM6IJEn6ZGgK/euoPG+AhIV3lF8bvtzR+dzyjxg0nVRgklnxlpgOszNOU
         +mQogLKRzgBHCtixcPmqix/61xijv3NRfdMnEx7mWmZT0HCrkwvHUSLc35FTOE1FDjs7
         tqw0KQF06A6kSgVXqZqUHihH7we9IF8QBC4BCzEwJxUjkn+HyZ0fyvVOs2WXNphnJ1Rg
         OIX6fFnVZ6J+POtpm6KaOxJ0Qdk25gyBhn1YC+TyOtNUimbxBUCVfjx0+ex0GqMoUweE
         kSqH6ZE9NX/peDoMvaJ4VF7Kys5hwIxUWhTG/3pEGnajBDWVCuhNoJMjWuZcMD0zA3ct
         DGmA==
X-Gm-Message-State: APjAAAU6lpGU8vEaZidAL35dJMt3S3A2ppTxCWoRUeVIaz2Ge8RkV+vb
        XxuR3vnjocUAkSCrIAhGtxeBAvSKQgChy+D7GCtONA==
X-Google-Smtp-Source: APXvYqx3qtwyg1LoAK/uLT1+FD8Q99CkEHY/FN+6/iaU/xWITWHT9SqbmcByniD/gJh9+nRkmoQmTJnKXtvZ1G2MQwU=
X-Received: by 2002:a2e:8646:: with SMTP id i6mr626080ljj.122.1580330588431;
 Wed, 29 Jan 2020 12:43:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579141989.git.matheus.bernardino@usp.br>
 <af8ad95d413aa3d763769eb3ae9544e25ccbe2d1.1579141989.git.matheus.bernardino@usp.br>
 <20200129112613.GE10482@szeder.dev> <xmqqy2tqdr9t.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy2tqdr9t.fsf@gitster-ct.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 29 Jan 2020 17:42:57 -0300
Message-ID: <CAHd-oW590ZnNnCdD5LLiBQB73LRUVEf41wv7FLJvGMwd2kLYww@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] grep: allow submodule functions to run in parallel
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 3:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
> >
[...]
> > @@ -1071,6 +1072,14 @@ int cmd_grep(int argc, const char **argv, const =
char *prefix)
> >                   && (opt.pre_context || opt.post_context ||
> >                       opt.file_break || opt.funcbody))
> >                       skip_first_line =3D 1;
> > +
> > +             /*
> > +              * Pre-read gitmodules (if not read already) to prevent r=
acy
> > +              * lazy reading in worker threads.
> > +              */
> > +             if (recurse_submodules)
> > +                     repo_read_gitmodules(the_repository, 1);
> >
> > ... and eventually reach this condition, which then reads the
> > submodules even with '--no-index', which is just what a7f3240877 tried
> > to avoid, thus triggering the test failure.
> >
> > It might be that all we need is changing this condition to:
> >
> >  if (recurse_submodules && use_index)

Yes, I think that would work. I was only worried that, in case of
!use_index, the path taken could somehow lead to an unprotected call
to repo_read_gitmodules() (with threads spawned).Then, since the file
would not have been pre-loaded by the sequential code, we could
encounter a race condition. But by what I've inspected, when use_index
is false, grep_directory() will be called to traverse the files, and
it does not have repo_read_gitmodules() in its call graph[1]. So the
solution should be fine in the point of view of thread-safeness.

> Hmph, I wonder if "ignore --recurse-submodules if --no-index" should
> have been done as a single liner patch, something along the lines of
> "after parse_options() returns, drop recurse_submodules if no-index
> was given", i.e.
>
> @@ -958,6 +946,8 @@ int cmd_grep(int argc, const char **argv, const char =
*prefix)
>                         /* die the same way as if we did it at the beginn=
ing */
>                         setup_git_directory();
>         }
> +       if (!use_index)
> +               recurse_submodules =3D 0; /* ignore */
>
>         /*
>          * skip a -- separator; we know it cannot be

Yeah, this seems more meaningful, IMHO, as we can easily see that the
recurse_submodules option was dropped in favor of using --no-index.

[1]: Well, in fact repo_read_gitmodules() *is* in grep_directory()'s
call graph, but the only path to it is through the
fill_textconv_grep() > fill_textconv() call, which is already guarded
by the obj_read_mutex. So there is no problem here.
