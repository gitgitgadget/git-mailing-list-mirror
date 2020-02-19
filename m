Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9B7C34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18E224670
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDdF5TBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBSTOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:14:47 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39799 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSTOr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 14:14:47 -0500
Received: by mail-io1-f67.google.com with SMTP id c16so1807783ioh.6
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 11:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ULs2SqWQx3ml1RMMg8uehMCtjASZ744+BcehaxAA7/I=;
        b=GDdF5TBIScPtAqRXmAMMIjtMSwyrlUy1qG1CAabm159ab1ZXv45Xh37wXR5gEq1aE5
         bDc/WB/RUfsp09SQCITDmjKPJLKOUsre2k1T1d3tDyRc+45z+ip6veGah75mxIDMW3WY
         LdYTqPGsinD3ilEf9ZZ37/cBpynoe/FOdU92phnUcVwh1LaOzly/o0g6+x67BkDpC1Be
         ewaaFc0c6TuGQfZfVwpfbndaJBhjp5OknnhNlV5xqLYerjPnwginmT06wwY63Od0wYQP
         UAPDujSKhBilZVs9lQLLrrGYfE5PnTnDd99jV0BbGFNPXzkpvBv9y5ca/9lIkIEZPrbb
         8TcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ULs2SqWQx3ml1RMMg8uehMCtjASZ744+BcehaxAA7/I=;
        b=CHaiNJGZ5IaVNCTwqT8XPY9vYPkd4uxQO3U/TM1g9p8NF3OWMW0+08cnvF8IvCeftp
         3mM36zPGGrdLQ7dRwfpm6dIXdV/lAObW0IsRrsNuha4yf631JqXy15jl74iR4fPJjJzX
         yGIYomlBUWqGVbN2qUXX4qzvHu61S5MJNA6zOacfNSyZc0S4BBq/TLKsOUmObTbbIQ1K
         WsArmg/r/VSckPZsNMjEMtE4XlrGB+o9+nqX14HfTcfUI+/w33GwqrF6hJoo15Bvrn75
         EBDWJ1kTKxwYQIYRNcN4fbK+52gd+COQL1bresvtIY3kuRlo2ZEWA5B6RCw1VeWtaRyG
         45ww==
X-Gm-Message-State: APjAAAW5R7Lsgks5WSPKtvkriIi+7hk+wRPOUMxU7X0ZISzRGWxOBGFL
        Xu0v8hO28ZHu0sDazTXZllWYShcnPk3weCOim18=
X-Google-Smtp-Source: APXvYqz24qxYRHDxRM3waFxl+6Bow1gOZX5Wu0ti1Ix/ME+gZfS2rrjqUOAA+SVBjMkAasl001D8XOQxs6jK+oY5Mn4=
X-Received: by 2002:a02:a00d:: with SMTP id a13mr22626957jah.8.1582139686210;
 Wed, 19 Feb 2020 11:14:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
 <pull.539.v6.git.1582015420.gitgitgadget@gmail.com> <xmqqy2szip35.fsf@gitster-ct.c.googlers.com>
 <CAOw_e7abpAwTkb6qKZjbxxw7XrAWdhcANbjAWvRxi1_fT5vSDA@mail.gmail.com>
 <xmqq36b6h5o2.fsf@gitster-ct.c.googlers.com> <CAOw_e7ZztSCzpmaCYg2c1iaZLWSsYz4dYegT0V0dHVaDy8A_uQ@mail.gmail.com>
 <xmqq8skyfnxm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8skyfnxm.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwenn@gmail.com>
Date:   Wed, 19 Feb 2020 20:14:35 +0100
Message-ID: <CAOw_e7YPzLb-zR+NVCR=-cNJg_43Q0E758RBJubqDdgYR=tNww@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Reftable support git-core
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 7:10 PM Junio C Hamano <gitster@pobox.com> wrote:
> It is OK (and indeed you're right that you cannot avoid it) to ship
> a reasonably new snapshot as a fallback in such a case, but it still
> is far more preferrable to avoid linking with the fallback snapshot
> copy when a working one is available on the system, especially for a
> widely used and established library like zlib, because we have one
> less thing to keep up-to-date with the security patches made to the
> upstream.

what is the procedure for doing this? Do I need to write autoconf
macros (oh no!) ?

I've added a comment for now in system.h

>  reftable/.gitattributes | 1 +
>  1 file changed, 1 insertion(+)

thanks, I've put this in.
-- 
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
