Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0788F1F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 04:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbdBCEQA (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 23:16:00 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33550 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbdBCEP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 23:15:59 -0500
Received: by mail-lf0-f67.google.com with SMTP id x1so543295lff.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 20:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nrOb3buFonpLlPshUWobFRDqHRIOLzVWld2aDDtOsb4=;
        b=P+ZUi2QSYpcwsNjYF4XlBnV5rMjqJpJz/eNmPdvzqIlqGOCyHnIUeUf2GklyIo/jSl
         XhRDQdOTMj8slb/xrQ7OiMYOc+Iy4iy3GtTM4YgT4oF8j+sVe10bulh0nmgZs7Z6evaz
         hO4hJ2S0IgFE1iGEwcsQI0amtKV9MQ2N2101XTp5LohXhSci4YWCsjjDTOLVipinWL6N
         j/ZKFI6j5qh1QKKfhwlj8a6ZVrocRDiZWnSYfNkOmG4ccFkc8dyZSADjVfsc3EZZ1FHy
         vN4kE1bro3Jlr34Hhw3wZEiRHhBlOECkz3Gpj9iVxkyNNTfbpxdN9AeOjCl+TcceixRY
         W0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nrOb3buFonpLlPshUWobFRDqHRIOLzVWld2aDDtOsb4=;
        b=gqYhPwPdTnreZERxR1mS0UPFisIH3WuQEv5227oTGdk+rPtQ7o30WxxP9fCAH0NgXl
         rL0vx8G+fkwSflV/dWwtwUmb40U5ntzkjNGa5YXrhihtomdFGpamavild32pBmtpCELy
         iv6v4d8Q5e4Nq+HgmmqckGXVZFrLuhZkM4HvOyh3XDDCLRxSisAtCkOniOm6/8giBo2m
         +w4VXKDRwbmvHAlfO0O1ZqGqPYX/suDHv/WxuO65XBh2WKYG4PoPhJn6UnEGiJM+ImnZ
         oeXA0E+ajqvuzuSjJ/cj3OTtJHLbn6+YYDtGRM3vpdb8BmLAco6l+T1BUATkkINuVW+z
         FvBA==
X-Gm-Message-State: AIkVDXKnXO+LsFgJ11NAtnTUBcznuu1MuYX3cr+O3mdM3LdjzvePGRx+sm8tZqyg3/Ors6v4bPLZ0vPYt5gfAw==
X-Received: by 10.46.21.66 with SMTP id 2mr4537141ljv.19.1486095357509; Thu,
 02 Feb 2017 20:15:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Thu, 2 Feb 2017 20:15:36 -0800 (PST)
In-Reply-To: <20170203025405.8242-1-szeder.dev@gmail.com>
References: <20170203025405.8242-1-szeder.dev@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 2 Feb 2017 20:15:36 -0800
Message-ID: <CA+P7+xqhjVQMXtO4gtQ_2VAVd3qrpVLncH6YpFHreVV2mHORxg@mail.gmail.com>
Subject: Re: [PATCH 00/12] completion: speed up refs completion
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2017 at 6:53 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> This series speeds up refs completion for large number of refs, partly
> by giving up disambiguating ambiguous refs (patch 6) and partly by
> eliminating most of the shell processing between 'git for-each-ref'
> and 'ls-remote' and Bash's completion facility.  The rest is a bit of
> preparatory reorganization, cleanup and bugfixes.
>
> The last patch touches the ZSH wrapper, too.  By a lucky educated
> guess I managed to get it work on the first try, but I don't really
> know what I've actually done, so...  ZSH users, please have a closer
> look.
>
> At the end of this series refs completion from a local repository is
> as fast as it can possibly get, at least as far as the completion
> script is concerned, because it basically does nothing anymore :)  All
> it does is run 'git for-each-ref' with assorted options to do all the
> work, and feed its output directly, without any processing into Bash's
> COMPREPLY array.  There is still room for improvements in the code
> paths using 'git ls-remote', but for that we would need enhancements
> to 'ls-remote'.
>
> It goes on top of the __gitdir() improvements series I just posted at:
>
>   http://public-inbox.org/git/20170203024829.8071-1-szeder.dev@gmail.com/=
T/
>
> This series is also available at:
>
>   https://github.com/szeder/git completion-refs-speedup
>

Nice! This is something i've been bothered by in the past since
completion would take a rather long time!

Regards,
Jake
