Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7334C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE10206D8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ne9lICoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfLTSzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:55:52 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38144 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfLTSzw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:55:52 -0500
Received: by mail-ot1-f67.google.com with SMTP id d7so8591650otf.5
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kzw7Yi4xYRcmn2yaywpBm2mvXF/gw6Sa5dQoSvLlxWI=;
        b=Ne9lICoT8P322slPWTOgqRTeIQQahHIXb8cqQ0DN6lOfmfcsY5giGh91TDLIWuxz0K
         6Rsi40O/NfZ+gvdnEwvBKbmP4hPxOsI/vH6jfAO2vRMDnMJAIPy5rAacouneLb1IfK7C
         cPyr834Pd5bPzsMJOuHClqtDcTvw/ffAbAPjPwgDZ8BlaEYoZ2R1d+S05N+xYAVsIGjg
         Hcv0lMlATu8IKD+EOAzJOBTJ3CxXnUcgwU0xidiS9ihyhe0KdVypf00e+Zg4o+5hQr4u
         jIrP4njV9A2XcDyk186s5PG8eF7ooP/oaEQNJ0GE7/uztHXamYYahNbN23ChrI0jFIyE
         /lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kzw7Yi4xYRcmn2yaywpBm2mvXF/gw6Sa5dQoSvLlxWI=;
        b=LQGcwBI2P7wb+5zylCZx4W6usLKGbZt+0Kct34Kb5mO+83rhtkfGsdmH8WOI9bIX3l
         eBCj2l58eHBt0wBc89A8h1XrCfytPBp5ZqlLYCF/kkF+D1BqMn4rc20rWVhcmaX+wyJR
         AcFH78R0K0FOnjM63hw47BbLeBf0HvjNlhQwFhabN0VVE3BwlL+fpwbevEz0Nk0UxqpD
         5wlO1vWSb4fGIuZJQ5nVT2RGd2nTk9aYoxJOlCUgqaBt7rg9mDz0zzLZaAylPYp8r175
         mT100X48TLWYGw8Usrz1B8kKXJI/m5XJwzXXjIxTjdDhPqsr14rHdyo29ByitzdRlXRv
         rSqQ==
X-Gm-Message-State: APjAAAV+lqLvmFvL0hPpyeSt4JaqSxoh3eFYs0SQjailkKJfySH9eQkZ
        lW8lf6ut40k3N1w5JH73/ZH36gdr3Tlci0C7GpQ=
X-Google-Smtp-Source: APXvYqwMQWLx4ZlgcPgJpv9JQ2RwLqCobz5FMXsL9lSNKTCVf6zComj68oS5suVCm0e5Vs9vAULbKdTvtcczVHJeWWU=
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr16133380otq.112.1576868151018;
 Fri, 20 Dec 2019 10:55:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com> <0387d5b2-6b53-a428-291b-2489a9447bf3@gmail.com>
In-Reply-To: <0387d5b2-6b53-a428-291b-2489a9447bf3@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Dec 2019 10:55:39 -0800
Message-ID: <CABPp-BFWf204jnBf=pgO+USULVmJXw5riwj4sOWNxK8gciD9mg@mail.gmail.com>
Subject: Re: [PATCH 00/15] rebase: make the default backend configurable
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Fri, Dec 20, 2019 at 10:53 AM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> Hi Elijah,
>
> Le 20/12/2019 =C3=A0 18:09, Elijah Newren via GitGitGadget a =C3=A9crit :
> > This series does a lot of work around making the default rebase backend
> > configurable:
> >
>
> BTW, I have investigated on the performance regression when split-index
> is enabled, I=E2=80=99ll give my conclusions next week.
>
> Cheers,
> Alban

Nice!
