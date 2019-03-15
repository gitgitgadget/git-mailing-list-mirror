Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6EB20248
	for <e@80x24.org>; Fri, 15 Mar 2019 10:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfCOKCH (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 06:02:07 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39021 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbfCOKCG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 06:02:06 -0400
Received: by mail-it1-f196.google.com with SMTP id l15so9891017iti.4
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 03:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nqSZckrGggq4nfsWFW5BFIVGxvepz+OMmx4Fx5P5YG4=;
        b=bad+0m2T4+lP4GwSavqNehwsRxSJk7W8lTi8QlUxLlGV6O+pzbRQmg/X2UBAKA9+TE
         JgjNDmJHs57D23rwHw9/VHxqhUl5Wi9KMd25YAMWslKktn006nRkgoxYJO2UKoTp+QjX
         /s2we3yyeeS4NmE27l+yrBNVhNcRCJMTHpBw1PRtKXdB9ad0t/4iKkgoQt1w04dFcqC9
         k6kUgiFETibGf1IhCZjyWYf7skMAJg75ODlOzClq+/rYV2uZ80xBfPBFGmyVXqhd/ZX0
         +Y/D164mSsAbPuG4olDV6hfP0cX5AMiOzHReXo/Il2YhFmabuiGR+00mqpJ7GFMPjxca
         2+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nqSZckrGggq4nfsWFW5BFIVGxvepz+OMmx4Fx5P5YG4=;
        b=VkHs4HeYPxavRHkCB89USFWIJMG3flRUR3NRlkvOulJbHEcPdoUmkkfqScv3o35Fjm
         /uw7YG9V3CCHvrbUW3GJQKk8nbZNq+YaPPh+g4eEyF4bVzT3KstfJZOMrtleBKQqh/tB
         kI47X+UkLYkmGAOiui7TfkYl1GvkaoWxR5gEaBpClWaq/ef0qoUH/iV9SwYAI7t5itov
         nbvEQ4QVZ6JrLJlS5E9D+YZIag+hSjJFmfHP/Z9dAVPWVcochomPXWx/HRz2Aivj7Kz+
         1sfevMWpFW5DWUATg3e/lY+P2T0N8G415z/sw2XJuuCiiAK1Y1zx8YqlXCDl19S/zt6A
         V08w==
X-Gm-Message-State: APjAAAWZcfAqMODxy/3oDz/k5QH7NiExnkXPTWJgnrg1RkkJkLgYnIsc
        6Ag56jUvSvOHT+EiawFZe6ORNm/EH1niWxbcjl8=
X-Google-Smtp-Source: APXvYqzljEDzsWSZLEpAMpC+W+6Oibn2oPvmBuou9C5zPSEyRQZfN9lqO1CMhzjtmsFoVXcaoji4vCwzwJW5edRA+e8=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr1256047ita.10.1552644125642;
 Fri, 15 Mar 2019 03:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190313235439.30439-1-avarab@gmail.com> <20190314123439.4347-6-avarab@gmail.com>
In-Reply-To: <20190314123439.4347-6-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 15 Mar 2019 17:01:39 +0700
Message-ID: <CACsJy8C-zyh6Vea1hqciDHhKk+UvS5qFb1F2SfU15yWniy53Hw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] reflog: exit early if there's no work to do
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 7:35 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> When gc.reflogExpire and gc.reflogExpireUnreachable are set to "never"
> and --stale-fix isn't in effect (covered by the first part of the "if"
> statement being modified here) we can exit early without pointlessly
> looping over all the reflogs.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/reflog.c  | 7 +++++++
>  t/t1410-reflog.sh | 4 +++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 4d3430900d..d95c77ca0e 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -606,6 +606,13 @@ static int cmd_reflog_expire(int argc, const char **=
argv, const char *prefix)
>                 mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL);
>                 if (flags & EXPIRE_REFLOGS_VERBOSE)
>                         putchar('\n');
> +       } else if (!cb.cmd.expire_total && !cb.cmd.expire_unreachable) {
> +               /*
> +                * If we're not expiring anything and not dropping
> +                * stale entries, there's no point in even opening the
> +                * reflogs, since we're guaranteed to do nothing.
> +                */

I'm checking should_expire_reflog_ent(). With both of these being
zero, we skip most of the "return 1;" except the last one
cb->cmd.recno, added in 552cecc214 (Teach "git reflog" a subcommand to
delete single entries, 2007-10-17). Will this shortcut affect that use
case (I haven't spent time understanding that commit yet, gotta run
soon)?


> +               return 0;
>         }
--=20
Duy
