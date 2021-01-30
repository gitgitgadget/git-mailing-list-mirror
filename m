Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2DBC433E6
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6CB64E12
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhA3JuQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhA3JuH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 04:50:07 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E63C061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 01:49:27 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hs11so16607291ejc.1
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 01:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nZObf6XPDbsxFUYFsr2ooasEANC2DphMcIDbhGyGwaE=;
        b=rC8zRQlSHFx7/lQWhXMoPMBDzG6LSXvrsiYYPOrBxVRV7Brq4EpreiXRxUFHJ7etE1
         8z5BFn0ff1FxvvHiEpaxYbOHHxpC5cgVvytmbEfvyk+dJZHdUxm8Xfp7TEoj/60tGjC4
         /b0TXUvCUWFkMyWRDTRCrx7e7xzZVQ17k+yNyQ+jbc1xPbgmMorBfW935a77cZ+QHR4N
         fQPuRhdqTc/amGBooDTtCCYC851Zzx7qNQXh5feT6rYudDGrTbh2INfILJ3tuOm08w+C
         VtbX4DHWn5zFk5dv8xnb7tZIyKxZyojqZxQym8VdJdXjb7emCx6in+vEq+ghA4GYxp5G
         etBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nZObf6XPDbsxFUYFsr2ooasEANC2DphMcIDbhGyGwaE=;
        b=WB4E5noYCU3LFYQoniFgTlryDBFEM4QLOz8KfIZmUN06tCmBtFxwdoZfcDIKrRm24+
         MOZ5yXiRUAss7Mb0aDO0RFHNjLyO4vqrAFoRVCJoBBUEupqfJHoIqdeXYF/nP8QfG9c6
         YTkdL4dBH8wTJUtNcaDp/DJczPRG+Gwbs/9ZTjWxR2JQnZYzi5HG4/tN0b7Y+unAGres
         bSn8GOgPgCUV37e1C2AHVyb7vG2b1fTnRFOqk3u2Qz32M75d/jGSYI/C/s1Cdc2yiOmW
         4I/S2VxzheVLEBedGH+LRHcMyHzwjmVFvKgFKiPSh0VPW3G377FbLDexmmLPctHUowQ1
         VMMQ==
X-Gm-Message-State: AOAM5305ELMPSaqfleS2U/w3m6jg/B846bw3PJnE2ZmWIvQ2dPZRsxu2
        K8kSJuvlQKdLk1B7ejWrBrqQQPBLhwej7evuEzM=
X-Google-Smtp-Source: ABdhPJyc9Ety1LEXM2jWEyRrbRJFrdpaqyLC1EJN7KXy8aG2KCDzpD4IwchxQtPpllfIU3BS7FBb8xVyMlwWlBcxOI4=
X-Received: by 2002:a17:906:ce49:: with SMTP id se9mr8463125ejb.341.1612000166087;
 Sat, 30 Jan 2021 01:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20210125191710.45161-1-mirucam@gmail.com> <20210125191710.45161-2-mirucam@gmail.com>
 <YBS6YJq0W3VsGf6P@danh.dev>
In-Reply-To: <YBS6YJq0W3VsGf6P@danh.dev>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 30 Jan 2021 10:49:14 +0100
Message-ID: <CAP8UFD0iZ5WMMV8FZgNx9jFV9W4qMMPXMEN-ExG8jOkw9LLH6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] bisect--helper: reimplement `bisect_log` shell
 function in C
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Miriam Rubio <mirucam@gmail.com>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 30, 2021 at 2:46 AM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
<congdanhqx@gmail.com> wrote:

> > @@ -210,7 +205,7 @@ case "$#" in
> >       replay)
> >               bisect_replay "$@" ;;
> >       log)
> > -             bisect_log ;;
> > +             git bisect--helper --bisect-log || exit ;;
>
> The original code was "die" when no bisect_log available.
>
> I think we need to "exit 1" here to indicate a failure, i.e.
>
>         git bisect--helper --bisect-log || exit 1 ;;

Actually:

             git bisect--helper --bisect-log || exit ;;

will indicate failure. See:

$ ( false || exit )
$ echo $?
1

The difference with what you suggest is that the exit code will be the
same instead of always 1:

$ ( ( exit 4 ) || exit )
echo $?
4

which is a good thing, as die() exits with code 128, so if `git
bisect--helper --bisect-log` die()s then we will get a 128 exit code
with `|| exit` instead of 1 with `|| exit 1`.

Thanks for your review,
Christian.
