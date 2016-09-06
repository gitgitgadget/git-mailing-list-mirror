Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,URIBL_RED shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5F3A1F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 18:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940542AbcIFS3c (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 14:29:32 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:35403 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939089AbcIFS3a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 14:29:30 -0400
Received: by mail-yb0-f176.google.com with SMTP id g5so31735064yba.2
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 11:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JxQxfqS6Zoya0EZpJWM8tt311C5GGTeXpacuDMGVVBA=;
        b=nTqRcEh9OQfgIp7InPNbv6BeED7yNoRN4vIhaFQ2xygbCyCHcDqKYprplDQsSmHe4N
         PqrU/HujrApxcN8qLGp4H5vnqC6CQLS+1cthGEvz9mlXRXzmqzwgRGYJnz5eCiqFcI3f
         YHhCAT/d0HtENJH0tkxduU1cSHpKBwfkPyu3WpW5V4Bu6yyuWqzCzFibIS0DC5bvVMud
         JPCDRSJomZgqkE7BjamUU4LmKuURfbZqDeFWu06YSkW8mJyfSDetrXMndLMz6K3txZ6h
         aLIZEh8yjoNGJ0TL5wfO28KC3aGcrriX0C+faCtefkTVJBv/tyE+o3cD5JULfnmNJfch
         FUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JxQxfqS6Zoya0EZpJWM8tt311C5GGTeXpacuDMGVVBA=;
        b=XrFeZMefFiuSg+tYN4sNzLcD6FOzDDBywvs1yPedO9uEnGfSjHc/XyiZ54GL/FH2gw
         Fw8ihS0LY00O3rfjazJLhfjJRluLREWkUieMp+ckGsMemhnXdBPMxjbmJBDJ/itzZIeM
         R3v/jSaEzdqEJDiyF3+05+zRHe2zGq14Cgvo4P7eBE3nnlhxlA6idIOkpR6q38BjpDUL
         UoiyeApjYbfuKgBCpjTAS7KWET7L8+tojCjulhn2ca5tN9pN7eEpj02BjEWgLdFzFEwt
         WeQaoPRC3y1V/xKwl3hQlM1yNk4tgfY4YDdrW7E0vJqQ2rSF5qLeuO+vfjA4G//1LHzh
         L2hw==
X-Gm-Message-State: AE9vXwNDwcz64ICgWts9tbRI2leD4iKczZEXF9TACM+CwZ8MVW+Of9/+LsugncgL1PSO711LuWOv58DMz3DoiUBQ
X-Received: by 10.36.107.82 with SMTP id v79mr140074itc.52.1473186552138; Tue,
 06 Sep 2016 11:29:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.43.140 with HTTP; Tue, 6 Sep 2016 11:29:11 -0700 (PDT)
In-Reply-To: <20160904201833.21676-31-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org> <20160904201833.21676-31-chriscool@tuxfamily.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Sep 2016 11:29:11 -0700
Message-ID: <CAGZ79kb5jOpMXhLe_7tGdCAq51p5F07=fv2pR7FohCZ53SFswA@mail.gmail.com>
Subject: Re: [PATCH v14 30/41] Move libified code from builtin/apply.c to apply.{c,h}
To:     Christian Couder <christian.couder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 4, 2016 at 1:18 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> As most of the apply code in builtin/apply.c has been libified by a numbe=
r of
> previous commits, it can now be moved to apply.{c,h}, so that more code c=
an
> use it.
>
> Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  apply.c         | 4731 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>  apply.h         |   19 +
>  builtin/apply.c | 4733 +------------------------------------------------=
------
>  3 files changed, 4751 insertions(+), 4732 deletions(-)

So I wanted to review this patch, so I wrote a patch to review this patch. =
;)
https://public-inbox.org/git/82367750-adea-6dee-198a-e39ac7a84b31@gmail.com=
/T/#t

> +                       if (!state->apply_in_reverse &&
> +                           state->ws_error_action !=3D nowarn_ws_error)
> +                               check_whitespace(state, line, len, patch-=
>ws_rule);
> +                       added++;
> +                       newlines--;
> +                       trailing =3D 0;
> +                       break;
> +
> +               /*
> +                * We allow "\ No newline at end of file". Depending
> +                 * on locale settings when the patch was produced we
> +                 * don't know what this line looks like. The only
> +                 * thing we do know is that it begins with "\ ".

The previous three lines are white space broken AFAICT. The seem to be
white space broken in the original location as well, so no need for a rerol=
l
just for this. But in case you do a reroll, you may want to fix these
on the fly?

> +
> +int apply_option_parse_exclude(const struct option *opt,
> +                              const char *arg, int unset)
> +
> +int apply_option_parse_include(const struct option *opt,
> +                              const char *arg, int unset)
> +int apply_option_parse_p(const struct option *opt,
> +                        const char *arg,
> +                        int unset)

These three functions seem slightly different, not just moved.
Oh you removed the static key word!

Apart from the one minor nit and the removal of the static keyword,
the rest is just moved code.

Thanks,
Stefan
