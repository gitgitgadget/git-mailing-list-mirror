Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80355C48BC2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A81160200
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFUSn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 14:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhFUSny (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 14:43:54 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F50C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 11:41:39 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id q10so20924822oij.5
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=4Wc9rou2SMquKoiiEAgT4+BuWYyTsm42m1mMGXn5o6w=;
        b=Woql4nZP26nqI+t1AN6t7Bd2VTKVio/k9gF44AcOTM8xLF5+w13jC4kyCOLtrju5EL
         Yr8qXTBKutWF56N5AZIhgw+3rwBB5Gw2vPhgK4X5ZoUw+KgoZdKzW9NdSQYqKyAPl4Bp
         xEs4qUtW9BwVZ/+ti028QP4a7Krg7gixdBoJEQRtSoHps3BTR3V3aqPAXvx/6mCw+pUG
         9qqs5ZGtLrbi6o2gZbukiN+JHDglWvzwkUMAf97j+3JJX9Jc+Wak04AYqUNLPdfvMxM0
         39TvX8CXbxZ7bHwstpXoSZhUmvoMUJKktSS5E0kznh2IGeaw44rH6aoQ3G0+0Xwui6wA
         pV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=4Wc9rou2SMquKoiiEAgT4+BuWYyTsm42m1mMGXn5o6w=;
        b=umnPhkoB55KrmvuCOwgIEABCoA99endIhH/d583ifLNSeU863p2XLwKSEGR9l/LmU6
         9ZGuSHCeJg4T8Eh+vu3SHDwKSAJri3+Xb+PA7xToP6rpKpXuC/NOyC3pUoIYfey/FDFw
         ryfGa7WeNh8t58OmhSt7PC3LeOCvL//rbPGc4/g4lr83FeqeEFdJWzq5S7JOFw2/tOfa
         dt6vLgLDiZkYMCbIW3/KqJVo/+fxL/6YVaUM+4T7CFIGg9aNwMvuYPOZrzJjuiMPOqEL
         e2jS/ns6JyG1G6oOYVgrjhjtm50acTV9Q00C52P/ZJikoaKSOrhlg22RFrDSHJBqQ9QX
         XZ1A==
X-Gm-Message-State: AOAM5326aEvy9vgYg5oa088NB3VbJRaE/na5fbkhyEtUEGh+APs3n5OO
        V4W5BlGKmFFiaYtsrC0A7NI=
X-Google-Smtp-Source: ABdhPJwNlXIBsrx0Vw82sjueht3VvtXvLJbMFXEEsBHR9C5W3OdcOHPxlFALqelVSQHgzrUSAsyDaA==
X-Received: by 2002:aca:53ca:: with SMTP id h193mr24679990oib.69.1624300899092;
        Mon, 21 Jun 2021 11:41:39 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id g1sm1319382ooi.34.2021.06.21.11.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 11:41:38 -0700 (PDT)
Date:   Mon, 21 Jun 2021 13:41:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <60d0dd619a2c6_10782120814@natae.notmuch>
In-Reply-To: <xmqqfsxbika3.fsf@gitster.g>
References: <xmqq4ke8pig9.fsf@gitster.g>
 <patch-1.1-a950ef49e28-20210621T083254Z-avarab@gmail.com>
 <xmqqfsxbika3.fsf@gitster.g>
Subject: Re: [PATCH v7] help: colorize man pages if man.color=true under
 less(1)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> > Fair enough, here's a version I think you and others will find
> > acceptable then. It allows users like me who like this to explicitly
> > opt-in via color.man=3Dtrue.
> =

> Not really.
> =

> Since the implementation of the posted patch, as I understand it,
> does not aim to affect both "git help -m foo" and "man git-foo"
> identically,

It cannot aim to do what is not possible.

> I think it would be easier to understand to end-users
> if this were exposed as a new "mode", like "git help --web" and "git
> help --info" are different modes from the "git help --man",
> something like "git help --fancy-man" (or whatever is easy to type
> and explain, and also add it to the variants help.format knows about
> to make it easy to set the default).

But it is not a new mode.

I presume you mean format, since man, info, and web are formats,
controlled by help.format.

But no, it's not a format either, because we still want to see the same
format (man).

Perhaps you meant a man viewer (controlled with man.viewer), but there's
no command line option to launch help with for example emacs woman.

But still, it's not a new viewer; it's an improvement of an already
existing viewer.

> One advantage of doing so is that we do not have to worry about "ah,
> user has LESS_BLAH environment variable so we should disable this
> new mode here" etc.

We don't have to worry about that with the current patch.

> As long as the new mode is requested either via
> the command line option or help.format configuration, it can
> completely take it over.

That is already the case.

> That simplifies the necessary explanation given to the users quite a
> lot, no?

No, it would still be:

 1. man.viewer=3Dfancyman must be set in the config
 2. The user must use less
 3. Not have the same LESS_TERMCAP variables set (we call setenv(3) with =
overwrite=3D0)
 4. Have color.ui enabled
 5. Not have color.pager disabled
 6. Not have git with stdout directed to a file

Moreover, this explanation is for developers.

Realistically all the user needs to know is that color.man=3Dtrue turns
this on (man.viewer=3Dfancyman is not better in any way).

-- =

Felipe Contreras=
