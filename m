Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE1C920899
	for <e@80x24.org>; Thu, 17 Aug 2017 17:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753005AbdHQRYs (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 13:24:48 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35296 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752270AbdHQRYr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 13:24:47 -0400
Received: by mail-yw0-f174.google.com with SMTP id n83so17260503ywn.2
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 10:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D/5Xnl6SqYnkuQERUEgEwoEF3gIoSzwLJP2nXw3cb2E=;
        b=sxCbEwtFwLIRtd20x9sBTtSMCCsrDfJaxd2Wi/JAMUTUbFfpDO9kyl6RcxaAVi6hFM
         doITdvs3RR2tscR8kH0COA7yDJXp4uVGsjKQ/4GYBhPBZx/bk6LdRiRtZbQCX/lbbJXF
         hfQKzBIPQZ+lR8m1+nNXvHK7s6QOZ9G+NVprtfCiKL0BFrLWOKylul1YgzMsqggQ2Hxo
         ttab6/3biYEeZF7WPIH5yi/SPjyJ4Yi6HqXEAEbn1pAHnk/t7dTj0aNQSOdmkxF03vtj
         EUUbLCU7U9uSzpWKtEn1M/QtOlt0leXfKwInQdZeCkjocrMI/1MD1crKZiqASsGNA/A3
         U6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D/5Xnl6SqYnkuQERUEgEwoEF3gIoSzwLJP2nXw3cb2E=;
        b=thq6rKzeySsi5z6XFfBkUVGBeWE/2RXxoN5P2t89tmVRVh2Q4DQPv5zCTMjaRp6i2V
         G5C2Rcadfu+Hs2Y1SZ4OFbiAmeknO6V6EroayIXM5XqdmnJUybx/KTsv6Zmnpg3xbrCH
         s4dec1aq8GEX9PM9qfqN48U0LhjUmd6XbDWuabbGCPTzL13gz0+JBeahQTmFT/uR9iry
         bcWdcpOL1Uip8QRCEcaMAVrHIgdL8tyG8RRQo3zvpqsscCZwkAZXhvA4r4Dw97me+XSO
         ASYoU7Fz6RQ3JY6Q1nDtB5k+M8zWcFis4O04NBOLqgyUnStvqEIP8B2nsy55oeZ7CDE+
         4nRA==
X-Gm-Message-State: AHYfb5hzB7ZtTYiROkSEP1N4469UuRpSnYxJaLWmoMQZfUBrlPuujGsp
        KWi9tpy/p9I9kLGeyDRfwuL9b/QNwQWT
X-Received: by 10.37.123.129 with SMTP id w123mr5262604ybc.305.1502990686712;
 Thu, 17 Aug 2017 10:24:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Thu, 17 Aug 2017 10:24:46 -0700 (PDT)
In-Reply-To: <20170817110013.GD52233@book.hvoigt.net>
References: <20170817105349.GC52233@book.hvoigt.net> <20170817110013.GD52233@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Aug 2017 10:24:46 -0700
Message-ID: <CAGZ79kZ2oOK_=jdKa9EMMUO8pi+v+f6tn83sSvafO1Jg5YOjew@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] submodule: simplify decision tree whether to or
 not to fetch
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 4:00 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> To make extending this logic later easier.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
> I am quite sure I replicated the same logic but a few more eyes would be
> appreciated.

A code cleanup is appreciated!

I thought Brandon had a series in flight doing a very similar cleanup here,
but in master..pu there is nothing to be found.

> Cheers Heiko

The code looks good to me.

Cheers!
Stefan

>
>  submodule.c | 55 +++++++++++++++++++++++++++----------------------------
>  1 file changed, 27 insertions(+), 28 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 3ed78ac..a1011f4 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1171,6 +1171,21 @@ int submodule_touches_in_range(struct object_id *excl_oid,
>         return ret;
>  }
>
> +static int get_fetch_recurse_config(const struct submodule *submodule, int command_line_option)
> +{
> +       if (command_line_option != RECURSE_SUBMODULES_DEFAULT)
> +               return command_line_option;
> +
> +       if (submodule && submodule->fetch_recurse != RECURSE_SUBMODULES_NONE)
> +               /* local config overrules everything except commandline */
> +               return submodule->fetch_recurse;
> +
> +       if (gitmodules_is_unmerged)
> +               return RECURSE_SUBMODULES_OFF;
> +
> +       return config_fetch_recurse_submodules;
> +}
> +
>  struct submodule_parallel_fetch {
>         int count;
>         struct argv_array args;
> @@ -1203,37 +1218,21 @@ static int get_next_submodule(struct child_process *cp,
>                 if (!submodule)
>                         submodule = submodule_from_name(&null_oid, ce->name);
>
> -               default_argv = "yes";
> -               if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
> -                       if (submodule &&
> -                           submodule->fetch_recurse !=
> -                                               RECURSE_SUBMODULES_NONE) {
> -                               if (submodule->fetch_recurse ==
> -                                               RECURSE_SUBMODULES_OFF)
> -                                       continue;
> -                               if (submodule->fetch_recurse ==
> -                                               RECURSE_SUBMODULES_ON_DEMAND) {
> -                                       if (!unsorted_string_list_lookup(&changed_submodule_names,
> -                                                                        submodule->name))
> -                                               continue;
> -                                       default_argv = "on-demand";
> -                               }
> -                       } else {
> -                               if ((config_fetch_recurse_submodules == RECURSE_SUBMODULES_OFF) ||
> -                                   gitmodules_is_unmerged)
> -                                       continue;
> -                               if (config_fetch_recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) {
> -                                       if (!unsorted_string_list_lookup(&changed_submodule_names,
> -                                                                        submodule->name))
> -                                               continue;
> -                                       default_argv = "on-demand";
> -                               }
> -                       }
> -               } else if (spf->command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
> -                       if (!unsorted_string_list_lookup(&changed_submodule_names,
> +               switch (get_fetch_recurse_config(submodule, spf->command_line_option))
> +               {
> +               default:
> +               case RECURSE_SUBMODULES_DEFAULT:
> +               case RECURSE_SUBMODULES_ON_DEMAND:
> +                       if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
>                                                          submodule->name))
>                                 continue;
>                         default_argv = "on-demand";
> +                       break;
> +               case RECURSE_SUBMODULES_ON:
> +                       default_argv = "yes";
> +                       break;
> +               case RECURSE_SUBMODULES_OFF:
> +                       continue;
>                 }
>
>                 strbuf_addf(&submodule_path, "%s/%s", spf->work_tree, ce->name);
> --
> 2.0.0.274.g6b2cd91
>
