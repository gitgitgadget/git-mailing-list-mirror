Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85C11F404
	for <e@80x24.org>; Thu, 29 Mar 2018 18:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754050AbeC2SPg (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 14:15:36 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:39280 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753544AbeC2SPf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 14:15:35 -0400
Received: by mail-yw0-f193.google.com with SMTP id q66so2237582ywg.6
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 11:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fk/XJvU1fN4NaF1NBhzOvb6kSAJuEsONYlBLjwyPjL4=;
        b=hr4TI9+6lYn5r6diJ2R9giHbaXypnProGWsFZCPVSCj5C5e4+Fd+cmaPGyYvaZuepR
         qIEWUYDfJuxXV1JJUYEgfY5vaGnVvdARBpI8yLnbmCuasaS1YvLKcKdKato686F00v16
         aXpwOdN9xe9pp4z0c/XmO6gYTnbmn1fdh2xeNoTLyRXoV5MV12bfWimIlTT5Q5m0HIV0
         JSxZEkzcOcUO6F3CNwuG2JEMEqr6x7i3BXmvqGPiB5XOf4b8zEbMq0xvBco6GkMa9Ug0
         yWppcy1Sb5zCrgF/NOxFTDx3Sh21F7Mdq0Y4ffvR5JdPCkj+AKT2N8+ddnFhh02moUNk
         d7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fk/XJvU1fN4NaF1NBhzOvb6kSAJuEsONYlBLjwyPjL4=;
        b=Zo1R2r/2bQg5zpzJfS9kj3Ry5iruIWzYrNVRyFkmJ0rIRItNB2pRLv6xe6KETqWMAG
         s9Pef/SHb6Rf3SrcHXt6wP6LiWnLl22kTqWOGuGg9vA4teVmBIxV7O7BeXMLAdx4on2T
         mh4ImLD6Mu7VcxfvVSGYPxHcY4y6A+txjUAO6AqJ0dLrTBdW1ftvne/6IG7ScsAquIOk
         OT8k0PlPjUjucre/FAbhjSWUCl7IWMWeAVHfyd1Hw10hxixXjD8Ih6C8LtZha/koG7PR
         NI6M4afU92l+M0vZ8AevlliEY3jApTjCZearZSA42MuVjf/PsyRz4KfgPCZpM3BfkHQY
         Dv9A==
X-Gm-Message-State: AElRT7GKFkUH8SDLz2L/JaGd3ZUcwlzfnfhFwIvasYdNDLS4Ya0wfFJm
        YmBPnlvcUDQGRbbjjlyzu6U1/Sq80TXCmss+GouZwbSV
X-Google-Smtp-Source: AIpwx48ml2mmiaVmoE06eMwN9PjPhKWJjONiBTULrkOHbPXp7OYZR6ZCe2onxTaZTANwCqVTLX4uYyeA1XIjtC1D5iw=
X-Received: by 10.129.84.66 with SMTP id i63mr5690261ywb.340.1522347333944;
 Thu, 29 Mar 2018 11:15:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Thu, 29 Mar 2018 11:15:33
 -0700 (PDT)
In-Reply-To: <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 29 Mar 2018 11:15:33 -0700
Message-ID: <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
Subject: Re: [PATCH 1/9] git_config_set: fix off-by-two
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 8:18 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Currently, we are slightly overzealous When removing an entry from a
> config file of this form:
>
>         [abc]a
>         [xyz]
>                 key = value
>
> When calling `git config --unset abc.a` on this file, it leaves this
> (invalid) config behind:
>
>         [
>         [xyz]
>                 key = value
>
> The reason is that we try to search for the beginning of the line (or
> for the end of the preceding section header on the same line) that
> defines abc.a, but as an optimization, we subtract 2 from the offset
> pointing just after the definition before we call
> find_beginning_of_line(). That function, however, *also* performs that
> optimization and promptly fails to find the section header correctly.

This commit message would be more convincing if we had it in test form.

    [abc]a

is not written by Git, but would be written from an outside tool or person
and we barely cope with it?

Thanks,
Stefan

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/config.c b/config.c
> index b0c20e6cb8a..5cc049aaef0 100644
> --- a/config.c
> +++ b/config.c
> @@ -2632,7 +2632,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
>                         } else
>                                 copy_end = find_beginning_of_line(
>                                         contents, contents_sz,
> -                                       store.offset[i]-2, &new_line);
> +                                       store.offset[i], &new_line);
>
>                         if (copy_end > 0 && contents[copy_end-1] != '\n')
>                                 new_line = 1;
> --
> 2.16.2.windows.1.26.g2cc3565eb4b
>
>
