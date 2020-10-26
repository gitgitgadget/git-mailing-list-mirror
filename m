Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0490C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B3620795
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EfuUXFi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgJZTzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:55:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46202 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbgJZTzu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 15:55:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id v6so13695156lfa.13
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sPMoZVQA2VdfjSg+tt1BPi0YzyrU4tunAKuEqDuogcs=;
        b=EfuUXFi5ULAVRYtxWWPaXqT9V/5ddyruHW9ZBfTtz0uqQ+dUSkC9+KW32kar5VN+ha
         9P0wvPD9jMAPJVuYn86NET8dU3UnFScD4kooyffdQkAvBGfvZVWSAAGt5Cq91hBOFbgR
         j67etfSHJtYL+shRXca58qA4S6QBNSaERZfYeTnjok43FNVzbKlIvh8gZk3fGATRgped
         wRZ/7YNLYLAfqvSwYN7vH5w56jbOHMFmNPhv0oZZvmWoLZIf5L4xwcRX5TuAPeWVXFCR
         yMfS5qKq0e/GHqQZfCYQqY29ScbhAfZGlwPAVJ39uu4OnB6GtPKdOV04gzt+wCpTgI9V
         /V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sPMoZVQA2VdfjSg+tt1BPi0YzyrU4tunAKuEqDuogcs=;
        b=VdZK3WN+PZW1COrCE5kHdroubxetmwTO+caZf7832pCczjK72SagFErGYmHUaKSzGM
         iUc0Ucic3GlJ+jI9gHPveT5akJgDSik8WfUxkzesLqNU2NZS+Cx3LMdn0ky/NnAUb6X2
         YeOJCEZHPjxODLlk31eO2FsmI/xWje7oKeRBae+sOsVMp33VzocJNS7gdH8SrGK99sAL
         pl3SwYaA9RoiioXpnHWSTR/RDgbF1Lp1OL27/gfnnpE7+xcJ0IByLrVw8V3bAKJPqeca
         vaDsp/ho6Ux687YTDKTadn8FiTDDYKs5Xq0MzcT9LqhcZYBbSI9fYGbepwtVVfHeM5yJ
         gcWQ==
X-Gm-Message-State: AOAM5329hN4b8rPgwqnsvENHgt3sFTVs1lQReBsti3/A9EuW1MjopIP4
        hUMq60ed7+rD3xW3kbXjxCgSoelO0qtHDPbSiFM=
X-Google-Smtp-Source: ABdhPJxqKPkLfwXryDqbW1LOBvK01OdWAwsx8Zd27ZLp+kh6TIdP2QuqCylhChKWsbcuoxWsPGyYg93f/kYMPP9XEwQ=
X-Received: by 2002:a19:6514:: with SMTP id z20mr5548526lfb.456.1603742148002;
 Mon, 26 Oct 2020 12:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201026144825.26537-1-avarab@gmail.com>
In-Reply-To: <20201026144825.26537-1-avarab@gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Mon, 26 Oct 2020 20:55:36 +0100
Message-ID: <CAKPyHN0Dbk+fqYR-5-RMUanJXFqjzh_w6zd0QXnM1fMpSUDJ3Q@mail.gmail.com>
Subject: Re: [PATCH] remote: add meaningful exit code on missing/existing
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 3:48 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index 9659abbf8e..c1f1355f52 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -203,6 +203,17 @@ The remote configuration is achieved using the `remo=
te.origin.url` and
>  `remote.origin.fetch` configuration variables.  (See
>  linkgit:git-config[1]).
>
> +EXIT STATUS
> +-----------
> +
> +On success, the exit status is `0`.
> +
> +When subcommands such as 'add', 'rename' and 'remove' can't find the

at least a comma before 'and', but I consider 'or' better here anyway:

When subcommands such as 'add', 'rename', or 'remove' can't find the

Bert

> +remote in question the exit status is `2`, when the remote already
> +exists the exit status is `3`.
> +
> +On any other error, the exit status may be any other non-zero value.
> +
>  EXAMPLES
>  --------
>
