Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64D7E1F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 09:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbeGGJ6F (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 05:58:05 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46598 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbeGGJ6E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 05:58:04 -0400
Received: by mail-lf0-f65.google.com with SMTP id l16-v6so11678107lfc.13
        for <git@vger.kernel.org>; Sat, 07 Jul 2018 02:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snCs5F62tcvnQYCERPGPOf972SLMH55iZfOgx6QsMYE=;
        b=dCQFR1LjOwcLHRpYZswdZF/SOXWeHz0OAS2PmzFJgXw8q1AtFAZLUn+99eTxR96cBb
         AmBSk6UCmGhUNMhxYBmqKOT61WzRlQpE1eolFhY/81MpaQ77y4XCA1mgcxKgMra3uhUW
         V+/KCtpomqasVaucKqEi3PVYHxOZTMmKz8KCbJJhjNYmgUhwikPY462DkESPGKj0ysN6
         nJ7dnCmLzAdJpuUMY6qssfsriOD5Mxf7Ia4e+yZCfnyoAiWvq003buPuQQG8e8p+ZBel
         y64/wntsoNvgUBggxzRcPV/tCqRFRtyoEUUX1bH1Fj3jBBrgvymH5W6THdHM/lAxOwI0
         Mb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snCs5F62tcvnQYCERPGPOf972SLMH55iZfOgx6QsMYE=;
        b=HLtocpSj8o7+yBcK7aqBzy5ZhEUW5KTMRkOXmObpMRMGAfzJBXjsX1E4ZX37xXeubB
         jCefJi4Kbj5SVCTanygTGpTV65ue1DqaWEJPH88yo8DRMhHhLHEoQGfPMARE0dt+X5zl
         qC7f4aFhV//rU8nxhbwBB1OeveNnrj0IDQyVRlClorxNhzQmfPPc+Ftk2c3Fziiuem1T
         xxt2tyVqn8qBfizpeil8VDSMtpukjZMrl/SxaNecBGPcS9K6RSR3Xz/6MS5lsjjh8O2+
         5LN1+lkmgJZVLKuzozNm/LK0h8goB7aE7UNqN0DC5LEZdBR/5jIV6G333i7/Drp4wvQu
         ZoeA==
X-Gm-Message-State: APt69E3STlw+Y94nCX038UqUUTBuAcrrfmRsXn0YNyIGQSUcVmXuwJ5B
        BY2A5gZhL9DeS8sRTmQmOUQGgkmyK2KTYTCp9d0=
X-Google-Smtp-Source: AAOMgpdyIlOaEgnfg2uLEVX1PLnDFFmckDLTOuCHgsoRIGIJjZ9VPzg0R8FOWcuBocWDSKh3LhsO3axXymEhdYHtQms=
X-Received: by 2002:a19:1366:: with SMTP id j99-v6mr9672879lfi.21.1530957482837;
 Sat, 07 Jul 2018 02:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180630133822.4580-1-kgybels@infogroep.be> <20180704201600.9908-1-kgybels@infogroep.be>
In-Reply-To: <20180704201600.9908-1-kgybels@infogroep.be>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sat, 7 Jul 2018 11:57:51 +0200
Message-ID: <CAM0VKjkCf+V1ZPGfghOcE73TAshd58V1QJz4af57jAjtktTu-A@mail.gmail.com>
Subject: Re: [PATCH v2] gc --auto: clear repository before auto packing
To:     kgybels@infogroep.be
Cc:     Git mailing list <git@vger.kernel.org>, kilobyte@angband.pl,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, tboegi@web.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 4, 2018 at 10:16 PM Kim Gybels <kgybels@infogroep.be> wrote:

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index e402aee6a2..ef599c11cd 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -828,10 +828,12 @@ test_expect_success 'fetching with auto-gc does not lock up' '
>         test_commit test2 &&
>         (
>                 cd auto-gc &&
> +               git config fetch.unpackLimit 1 &&
>                 git config gc.autoPackLimit 1 &&
>                 git config gc.autoDetach false &&
>                 GIT_ASK_YESNO="$D/askyesno" git fetch >fetch.out 2>&1 &&
> -               ! grep "Should I try again" fetch.out
> +               test_i18ngrep "Auto packing the repository" fetch.out &&
> +               test_i18ngrep ! "Should I try again" fetch.out

The messages containing "Auto packing the repository" are indeed
translated, thus they have to be checked with 'test_i18ngrep', good.

However, none of the "Should I try again" messages are translated, so
checking them with bare 'grep' is fine and it shouldn't be changed.


>         )
>  '
>
> --
> 2.18.0.windows.1
>
