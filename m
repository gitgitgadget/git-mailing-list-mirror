Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BA3220954
	for <e@80x24.org>; Thu,  7 Dec 2017 19:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbdLGTDt (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 14:03:49 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34208 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751904AbdLGTDs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 14:03:48 -0500
Received: by mail-wm0-f65.google.com with SMTP id y82so1819681wmg.1
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 11:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M63wAOtsM6NGWeRSoIWBrOW0ulhLfv872rF+Ft5XSj0=;
        b=Ja//36t+g6wFP4elZ+gZaEdPiOv9L211vDh18lcoRrBO6HZ8Q2Gbw7NJGZNXUifjKy
         Kr79Ni775TbmAEdga54F6DF0IqzICb1IE4zBrGO823F/ylU5tsa8Y5ub3SdeUZkpzr0V
         Ux1tp1RPMLhW2ZIqgUY9serS6JRdgBTb1ucUBGZhXF2R1n9Ne13CdsbCJZVgOKSiTuPh
         Rma2YjkKqeQywovzdkqL8FINx+YbmT7Ipkxws8tLgogSZI4BVFm5T6rbpmw7imRQqVsE
         ua5fNZ6I20XhgWEsVxR2Xv3aUTtImo8McJlSW9GxgIhH6BT2deiQN8xu4IaTf8V2zlvK
         EyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M63wAOtsM6NGWeRSoIWBrOW0ulhLfv872rF+Ft5XSj0=;
        b=W46OEr6j3iBkCJlYneubkCYEhaxj8kOK5YMjc5j+5RvTVu5vkyGs6IN0xXVK0IW4BM
         N+kxxnW3e13iU1lJi7E2Y/+p7fBPPI3D7wnC5SURVRprhNeZq/xBcpWrbkmrwLt9dSKP
         Qsx9vU/84AvdJd5cAY7SGwab6ZsWUEmcxgwDSV5Bw99mD8UJG6+R9fxSzfINMkoMGtV1
         ShlaqhA2VNUHa3kyMPRUxnRgreoPuX8/Z41imKMPVCR8VGxezBFKEM6xtoCWacplaHDi
         0EFaNMACYHqvYeaWRkHJRhUsQelv6DA2+Yf7lkDmQlUrTIq5nyLePN6L5fO5Oh7oNQ5Q
         vWlg==
X-Gm-Message-State: AJaThX4YRLByW1Fb2YT27nViTmyU2Dep7aDDEYUjFOmafDdS8Z+2DKpY
        S1xnIbSDUgWKkTcjlvkuQ4GpydruILtiOAhq27s=
X-Google-Smtp-Source: AGs4zMaB6QYd9molwRADOiCiJ9cE/aDxAVBd/3OG1My/GHl4coKQ7oC3U4of4RZXOao4ooF8PB6FpcI1Bt3TimrPLTw=
X-Received: by 10.80.182.217 with SMTP id f25mr48080549ede.104.1512673427292;
 Thu, 07 Dec 2017 11:03:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Thu, 7 Dec 2017 11:03:26 -0800 (PST)
In-Reply-To: <20171207173034.12865-2-gitster@pobox.com>
References: <20171207003517.11729-1-jacob.e.keller@intel.com>
 <20171207173034.12865-1-gitster@pobox.com> <20171207173034.12865-2-gitster@pobox.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 7 Dec 2017 11:03:26 -0800
Message-ID: <CA+P7+xp0b-6936K3_2hN3LH4wh8k+Hkgukh6aC2CRF1QdQ_FUQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] diff: use skip-to-optional-val in parsing --relative
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 7, 2017 at 9:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  diff.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index cd032c6367..e99ac6ec8a 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4563,11 +4563,10 @@ int diff_opt_parse(struct diff_options *options,
>                 options->flags.rename_empty = 1;
>         else if (!strcmp(arg, "--no-rename-empty"))
>                 options->flags.rename_empty = 0;
> -       else if (!strcmp(arg, "--relative"))
> +       else if (skip_to_optional_val_default(arg, "--relative", &arg, NULL)) {
>                 options->flags.relative_name = 1;
> -       else if (skip_prefix(arg, "--relative=", &arg)) {
> -               options->flags.relative_name = 1;
> -               options->prefix = arg;
> +               if (arg)
> +                       options->prefix = arg;
>         }
>
>         /* xdiff options */
> --
> 2.15.1-480-gbc5668f98a
>

Yea, this is exactly what I had imagined as the fix.

Thanks,
Jake
