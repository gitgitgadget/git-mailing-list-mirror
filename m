Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31031C4BA24
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F2724653
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxNyACa8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgBZUj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:39:57 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:54484 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgBZUj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 15:39:56 -0500
Received: by mail-pj1-f45.google.com with SMTP id dw13so139187pjb.4
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 12:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=By7iLYQCLbg+rDJgzQzoMtdvyjjD64CyU1bySXU9cfg=;
        b=gxNyACa8MgbpycTRNAj3hOe8kyeszaX8YMs+a18xk+29SxOD36kz4TvOIrrjbqe5gn
         kSOOnIr9WvV+l+VxnW7r506eTecnEvKp0CGL2r9UjpJCIybNCiZMGcRj8miCvtoKIaNM
         a61VUJ03gQqENbASdobS2YJjWHBOoNKtdLG+awA0zpRRYR+rjlgEXawvqp8OlRQbiFUD
         WLiT9/7dIJsNp4VW9tXvWkLVDVe05vrfEFzuNCIpOX0bXE0P3d3qQ0t2Wa+l1MSoFLuk
         9KbC9hLqoiuZqBxnNEiwhqAagw2j1q8x58aqdntgJ5mvoGmPOf2X7d633n/VvSO1Z6uL
         O3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=By7iLYQCLbg+rDJgzQzoMtdvyjjD64CyU1bySXU9cfg=;
        b=pnb47zKgksRVVwayaXguFWOzAFKGrOdWthcW2fNAh2wxqvscP0iHzlgthGnBcHSxWG
         ihSblLA2M4ROXU6MCoolyalj9st5X7c4DM4njMVL0CMbwHF1APn3npe0FYsAvPEPHv8+
         TcP/EJEMNKRoCGI9Wz1Dd0fpA9M5IG6XR8rlJyKzSuqaCJt7QvfwwK5KwgnYeUuHBjS5
         2uVoYezPG/PGOlQo+Vw6jTLgPfkS6qCilMJyzi/y+DAZuWcAGDIaOA/nGj4D3jxtBt/i
         bywREj2AZvm4JBxDuGoaHz9RRzyMqLkVt7/lJG1oQV/IBwDyun4FYhCdTX0afUZtYWQY
         azyw==
X-Gm-Message-State: APjAAAXR9QtRV0tnfmR4Te1sXWGCM3YT6gyt7wkf8qUhJdrFnXYyrz++
        VY8zSoArwsxX+lCiWBePpDQd5EXfqwzorHZlU/4P3Rpt
X-Google-Smtp-Source: APXvYqwkjj1HNHGMk4Egd8GgIijIsm5e1FJYnnKiQLXEnNsxNUZDHy/M4biQqRALpPcbJccKgF8GSMtMIVZlZDgLnAg=
X-Received: by 2002:a17:902:ba93:: with SMTP id k19mr1081594pls.197.1582749595935;
 Wed, 26 Feb 2020 12:39:55 -0800 (PST)
MIME-Version: 1.0
References: <xmqqo8tml1lv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo8tml1lv.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 26 Feb 2020 21:39:44 +0100
Message-ID: <CAN0heSr1dEAXuU4pb=-kxSupbTT3-pKntUcgHxGGzAjRTxd8fw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2020, #05; Tue, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 25 Feb 2020 at 23:58, Junio C Hamano <gitster@pobox.com> wrote:
> [New Topics]

> * ma/test-cleanup (2020-02-24) 3 commits
>   (merged to 'next' on 2020-02-25 at ce00c705a9)
>  + t: drop debug `cat` calls
>  + t9810: drop debug `cat` call
>  + t4117: check for files using `test_path_is_file`
>
>  Code cleanup.
>
>  Will merge to 'master'.

I had intended to reroll this topic (squashing the last two patches as
we discussed), but it looks like you beat me to it and merged this down
to next. From your review, I'm not sure that was really intended, or if
you experienced some trigger-happiness.

If you holler, I'll be happy to provide a v2, but otherwise I'll go
ahead and assume that the usual "it's in next so let's not reroll"
applies.

Martin
