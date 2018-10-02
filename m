Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37C7B1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 18:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeJCBnq (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 21:43:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36092 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbeJCBnq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 21:43:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id f4-v6so3092956edq.3
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 11:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bO7EIMw5W9sfALx+Xf0tz/xUSUU1N0JyWFXJndhf3c=;
        b=Hyb5jdJu3gZykn030Dk41V5kr9D4KvZg/tEkpoTsZdHeZfJtAm4lJzetVLFOZoV2ZO
         0ADXXTAKlVdRuDv4KacCkgkZIRoSV++TNnvYW52ywq7JriwH9zK5YBx9LVzWXtV1wWv+
         xMdIPgZ5q96GdLA41p7jo0N6Xwj3nbaYEnfd8cBDc1XO3QmnSVPsBSHlsN8ylu+Ays43
         nfaitHeErP5W7BLu4EzYvb5rqKvPVQDUj93Akz/DRb3nXFJO3iR3nNK9Su6tcrVw5xFN
         bNol/Lj8ns9L95kXCoFbr2cZmkmIEMa7KU8gbZOadOnjGGUQiG34c9LduIfl+gY353u9
         zucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bO7EIMw5W9sfALx+Xf0tz/xUSUU1N0JyWFXJndhf3c=;
        b=fBiUxp84mjMd4wvrtdIrMdYGfKmjYmnuJoHXqqlYh/SDMD0Wq6kI94C3I2f+oH3L8R
         6/sr0vYDkD0THjMaqtt3pXTuj8cG2PJSxaXVAT67a6tXeRavO/6sKmfnA2X7Z03RyQ/C
         yihM7QP6x9tZfpk728896CDrFfgD5DrhBKm8cFPZbsf0rQrRm/lxZDavgEhDqcjUmghl
         rw7V+TEDuiOSAe6Fsv3GSz9vSzq5Un3HwixinJGFRcA+GNx8hdylWJ6bWjW+23LkcmGq
         Cf/2EUh/P7wIxyMOoeIfFHAVC0ESPFg0tgNqbM9UFaALNBMIORg3ld3u0qvZgKa/4nPk
         86dA==
X-Gm-Message-State: ABuFfoiHWo49xU7NA7qhHF/IRefGuTpghhm6wctdShAqI1dU5DjtHhFK
        nFSrqqX6CeccrLU54ZzCgFp9B5rv4NPpo8Kn4kvu8Q==
X-Google-Smtp-Source: ACcGV63LtpmSz7AU3gSuZWrPZtG/opWAR3Ibn+H5P/tHAkKm41QgMmby9ugV2l0/Y1RVTzW+MARNIv5AVOEvQuofd2Y=
X-Received: by 2002:aa7:c746:: with SMTP id c6-v6mr8339684eds.231.1538506736881;
 Tue, 02 Oct 2018 11:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181002175514.31495-1-phillip.wood@talktalk.net> <20181002175514.31495-2-phillip.wood@talktalk.net>
In-Reply-To: <20181002175514.31495-2-phillip.wood@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 2 Oct 2018 11:58:45 -0700
Message-ID: <CAGZ79kYu9enUT=yL8wfM9quYYz1fs5OU4Wcvci9ZVPPdXkY6gA@mail.gmail.com>
Subject: Re: [PATCH 2/5] diff --color-moved-ws: fix out of bounds string access
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 2, 2018 at 10:55 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When adjusting the start of the string to take account of the change
> in indentation the code was not checking that the string being
> adjusted was in fact longer than the indentation change. This was
> detected by asan.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index 5a08d64497..0096bdc339 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -841,7 +841,7 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
>                 al -= wslen;
>         }
>
> -       if (strcmp(a, c))
> +       if (al < 0 || al != cl || memcmp(a, c, al))

If (al < 0) then al != cl, so I would think we could drop the first
part, and only check with al != cl || memcmp

In theory we should use xdiff_compare_lines here
as the rest of the lines could have more white space issues,
but we catch that earlier via a die("color-moved-ws:
allow-indentation-change cannot be combined with other
white space modes"), so memcmp is fine.

Side note: There are comments above this code that seem
to be also obsolete after patch 1 ("...carried forward in
pmb->wsd; ...)
