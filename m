Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26731F597
	for <e@80x24.org>; Thu,  2 Aug 2018 20:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbeHBWn4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 18:43:56 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:39333 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbeHBWn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 18:43:56 -0400
Received: by mail-yb0-f195.google.com with SMTP id c4-v6so1845095ybl.6
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEy7pOyUTZz9Bg4/1tpjv8z5fMKurZxzD0y8X3uEUZ8=;
        b=PWGK1l4hjg+OjbuMESrVNEL/a77UO6/JoLGisug5ImTfb6LpLb28JA6D/mg/CgA8Ic
         1vcnD4mpv1mTirR3BZXxoDg5MFdk3oTQAuqF9+B+pHjHpnJEqL0zxGs2e07JBhK6GaUk
         zaR3UBJ/TlWzpvYAD1EcORwcL4gZ03rT0xuJy84vSvDLLrMq29wFdccfjjzU1a1G/7Kg
         whZNMcnPbBanK51hCWVwQQVOeOQcVLfokXnHPF6GSEm2UQ/+7dVpuT5zvLaxj+YuCH66
         tI4Q6WByjiBRXja0ISw5F56+njH3XiDWzyrhKVVURxyif7FGGtS288HEMBB9pCeXr6Wi
         tzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEy7pOyUTZz9Bg4/1tpjv8z5fMKurZxzD0y8X3uEUZ8=;
        b=Mcj4JLRkqfg3EaGpzQKNYoNaBA7wW6yRnWfOWJr4V5j0IQ55L8uRH9NPc6Stx1rjyu
         C/NGgxVq1tnLp3bCOT0OPwQtH/zUW97m6CSC8NnnE+IQTPLcyzJxE4SYSc3mqHBZFy8u
         cdMkgyvV5JLvXgfal7gw9xBcT4d4vhQcg6V+p5izLT3h4hHJGcHX3s7Ahj46YtTvT6Pf
         MFTXTId4FYjTO14B6ctgUswGJddVNWJvYjT0bdO4nva1EWBOlifeEutwZlqCZbzOmkok
         U/7+rqZgEdkav3rSYW1Xol80QgdOpBfWfVEOdcOkbHJmleYpSv7tG97iBImN5uK3SAC0
         i6sA==
X-Gm-Message-State: AOUpUlEo/2CiseYA+shgTdZrzSHcdJgFZHBTj1baoKdEl14gexGyk08A
        QRgDn9RPBLQDC3oHMKygeeOi4cxbBgqlNdRwB08nYQ==
X-Google-Smtp-Source: AAOMgpd7DvklULLm5l8c6Sw0F8im3NNQGqL05+bdCAPZxM429K4kJAEuPzfN8SbU6KekdVS2h/hT9fPpxGatD/uy7Cw=
X-Received: by 2002:a25:a263:: with SMTP id b90-v6mr646605ybi.247.1533243066356;
 Thu, 02 Aug 2018 13:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180802134634.10300-1-ao2@ao2.it> <20180802134634.10300-12-ao2@ao2.it>
In-Reply-To: <20180802134634.10300-12-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Aug 2018 13:50:55 -0700
Message-ID: <CAGZ79kYpsYbg8nkE+8hTPM=Bg_3-p3EzoRfJ1y7f+Dz-3hT-HA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/12] dir: move is_empty_file() from builtin/am.c
 to dir.c and make it public
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 6:47 AM Antonio Ospite <ao2@ao2.it> wrote:
>
> The is_empty_file() function can be generally useful, move it to dir.c
> and make it public.
>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>

Makes sense,

Thanks,
Stefan

> +++ b/dir.c
> @@ -2412,6 +2412,22 @@ int is_empty_dir(const char *path)
>         return ret;
>  }
>
> +/**
> + * Returns 1 if the file is empty or does not exist, 0 otherwise.
> + */

Please move the comment to the header instead.
/* possibly as a oneliner ? */
