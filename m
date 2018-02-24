Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92B5B1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 12:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbeBXMTL (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 07:19:11 -0500
Received: from mail-ua0-f174.google.com ([209.85.217.174]:35190 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeBXMTK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 07:19:10 -0500
Received: by mail-ua0-f174.google.com with SMTP id n1so7651643uaa.2
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 04:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X0iJ5sCNQAaKkhMYfw2fgFZ+uBfBir2X14368ZcoBFo=;
        b=Ui7EdRJBEhFnRIu/o9E9H/01JSZBVf4W250ILK/AfZV306smX/nyzB0lBz1EQbg/wT
         g5aZn1jq8o+GZAYoAAX+12iSr1LW4jr5ar+4hShvYqwf5MKegVuq39KdGZQ9D6c8Hw2u
         YpioEQT95hzdnD2aVDvKJ5TD6NOI8fdc9L3Ta2D1Sbz6/oiHJLOVDF/OXV8estMIrY3k
         VwOn3slbyaf0GxsXFecgum33Yq58sVpm+ZfK2XqAOF/JjcU6uvkUFng0zG2VB18EPFjO
         1eOdtBxEXOBJK9XWk2QfyZs6NTBpaJ/r4wtUPlMVOuxDjLC0NkPnWhfuJm6QH5SRrqu7
         HV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X0iJ5sCNQAaKkhMYfw2fgFZ+uBfBir2X14368ZcoBFo=;
        b=DW22OJwAx/IeRhlxMA6OTRG/FNz8xIQT3yGqIitiOcSUao/qSVd4EZhorQchjD2UST
         CgCdxCQ4MoYYnvMg2Sl/iv6iAdz9XrOzfr+orhO/ChmeSxLV9pqr0f60bDXfSvvD8mmX
         feg+bbhicaqS4JpGuTJCaAn3DMDPEGsWPl9+BmYeo7R/aC22JFpvMPY/u3WSQ/iWRm05
         eH5lFTscCFBoTLftcuTxm4WN90cSJmCq7t6cYWHQeBiWdFnE0xgH0w+3bl8feE0KOzSa
         BHH2l4f8StAWRWmB7jPV6BjvzgEINwpZ1w6UAn3u/00JXMPeuttw8CazQp+LBThK6x5y
         NNvA==
X-Gm-Message-State: APf1xPC59rkmRw7hRCda/eHDLoM5AjCLyZewh9ka+nrMRDLdqJHHs5HV
        ehOS2zX6RzmcD35epXJDI6+gWuca0QHwKJ9lEdY=
X-Google-Smtp-Source: AG47ELszNtzS6+B46mx0DYZoRcuR0TGn5wbtIgItAld/baMGaJFYltq+JYGl4etTErcE6qYH06F1NlZ1GTiqBPj1knI=
X-Received: by 10.176.16.27 with SMTP id f27mr3646786uab.196.1519474749329;
 Sat, 24 Feb 2018 04:19:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Sat, 24 Feb 2018 04:19:08 -0800 (PST)
In-Reply-To: <20180223233951.11154-2-szeder.dev@gmail.com>
References: <20180223233951.11154-1-szeder.dev@gmail.com> <20180223233951.11154-2-szeder.dev@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sat, 24 Feb 2018 13:19:08 +0100
Message-ID: <CAM0VKjkKV2NsHA-Zpv-jnXaULTGnKy=HQ+MPRebTo17wHdFENg@mail.gmail.com>
Subject: Re: [PATCH 01/11] t: prevent '-x' tracing from interfering with test
 helpers' stderr
To:     Git mailing list <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 24, 2018 at 12:39 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:

>   - Duplicate stderr of the tested command executed in the test helper
>     function from the function's fd 7 (see next point), to ensure that
>     the tested command's error messages go to a different fd than the
>     '-x' trace of the commands executed in the function.
>
>   - Duplicate the test helper function's fd 7 from the function's
>     original stderr, meaning that, after taking a detour through fd 7,
>     the error messages of the tested command do end up on the
>     function's original stderr.

> diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
> index cd220e378e..b3acb4c6f8 100644
> --- a/t/lib-terminal.sh
> +++ b/t/lib-terminal.sh
> @@ -9,8 +9,8 @@ test_terminal () {
>                 echo >&4 "test_terminal: need to declare TTY prerequisite=
"
>                 return 127
>         fi
> -       perl "$TEST_DIRECTORY"/test-terminal.perl "$@"
> -}
> +       perl "$TEST_DIRECTORY"/test-terminal.perl "$@" 2>&9
> +} 9>&2 2>&4

Oops, these should duplicate from/to fd 7, not fd 9.
