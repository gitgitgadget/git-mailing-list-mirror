Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26ED20248
	for <e@80x24.org>; Thu, 28 Feb 2019 07:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbfB1H0t (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 02:26:49 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38674 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730808AbfB1H0t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 02:26:49 -0500
Received: by mail-it1-f194.google.com with SMTP id l66so14245473itg.3
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 23:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbAlb++Oh57t5esAmO1jNIY14Q27SOZ+OJDrRzyBctU=;
        b=Jx848qVA46TWswAj0TknoDrUEfn/o7ycF3zkH6D44MhaMYQmxW39UMru3KXFd+iLfK
         91PxEqaJyoFASLCEwcQzSj+NkDzf8rvUf8y72WFIk+44VbcvS59O7OJm4pYMG4SKPHau
         GWLifx0mvZLzB44TKM0Hio1FqRxFuguhPWmJVdE1tSJscBdWBJwTtHAuRje+qlC149Ug
         CLAUN2OgvNOB2hU4qr93+bGXemmvKsM7zEoljY7TRLgPcIdaWZTsdo/X5ejtk+3yQ3Ui
         wb8T7CpqQUSjJ1sx9LoICyKgW02cPRe95wuyYsSq/X6GpRJGfwJhbZBY+jrRmnUgPIc8
         5Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbAlb++Oh57t5esAmO1jNIY14Q27SOZ+OJDrRzyBctU=;
        b=E+lIVAq+T9yOkq2mHdbbqHk7rtTtX/EXaCMVigWlSA0OhwmJ/87lGpzinLwKdDBt28
         aiZf7iHPzcvv2O58DJPg3NRtfHlmj2ruYE6sZVo+LAWowlOIX6MDZCTE0s8uKhTfjOU+
         DLiyHdXZmpq68+3DSCQYS8Bk8WfC4c8+76yCbeBLXVHD18qNLulup1by19Uw5Vn+YTWR
         6pywopLGEZS5VNYzhDNWUbVXLjsvgcGaOyecdxlvGGqBZMwDG+xDp2M7/uoECfkRUD+R
         AEcEFqvfyzTbF9viAdA2lXFZg7Mxj9ZDe8RoK9etJERksvH/KI9pNBUYDjlhkst1Vwki
         yzlw==
X-Gm-Message-State: APjAAAU0abr23pOzyYsSpilOdx3p8mTuUPOT1M2/4TX2eleYhSncUUFd
        e/+t2/DyouoPmbzQrdF6zMRpqY/Q9RoATnuPSz5kyQ==
X-Google-Smtp-Source: AHgI3IaYX9b5lcWZMFjZkT5ZO9OXiTQa3KBXO3GlZDDTi8OIA/AyU/To0kZ0mT+TqVwZebeujj2BXGwTSFXaiSh+sEw=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr2045924itf.123.1551338808609;
 Wed, 27 Feb 2019 23:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20190226200952.33950-1-brandon1024.br@gmail.com>
 <CACsJy8Bgz6FiTqnq8pnebuyOr55Bqh67iRhr6J+WvzgxPSBLhw@mail.gmail.com> <CAETBDP5pfuNP4JQDaxN613sthRziJT7CZd=tjhWLpMSME9JjOQ@mail.gmail.com>
In-Reply-To: <CAETBDP5pfuNP4JQDaxN613sthRziJT7CZd=tjhWLpMSME9JjOQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 28 Feb 2019 14:26:22 +0700
Message-ID: <CACsJy8D99BYRaWR+95VzM1gyhENje4N=HBNLJ=AA-op+y4yu2A@mail.gmail.com>
Subject: Re: [PATCH] commit-tree: utilize parse-options api
To:     Brandon Richardson <brandon1024.br@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 10:24 PM Brandon Richardson
<brandon1024.br@gmail.com> wrote:
> > > +static int parse_file_arg_callback(const struct option *opt,
> > > +               const char *arg, int unset)
> >
> > I would suggest you do the same for -F, i.e. collect a string list of
> > paths then do the heavy lifting afterwards _IF_ we don't support
> > mixing -m and -F. If we do, then we have to handle both in callbacks
> > to make sure we compose the message correctly.
>
> I opted to use callbacks here to allow mixing -m and -F so that messages
> are composed correctly, as you mentioned. I did so in an attempt to match
> the existing functionality of commit-tree.

Fair enough. Probably safest to do that anyway.

If you feel like doing some improvements, maybe mention this behavior
in git-commit-tree.txt too. It does say -m can be used multiple times,
but nothing explicit about -F (and I wonder if -F also does the
"becomes its own paragraph" like -m). Also mixing -m and -F
technically could be inferred from the synopsis line, but it's just
easier to read an plain English sentence.
-- 
Duy
