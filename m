Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1441E95A91
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 07:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345449AbjJIH50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 03:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjJIH5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 03:57:25 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DDE94
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 00:57:23 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d865db5b4c7so4346283276.1
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 00:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696838243; x=1697443043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rkvq3l7OtGc7Y82g+8zhheACzUIjrvfwf/RHODg6uiI=;
        b=T/Wep4VW8Nn58CTZw2VdpXWJvFMdZJJfAM37mCR91iczQOLE+5aNC8npX2bmajAspX
         8Bvm/K1xYYhnLI7TFpkj7KlTz4WzsslrBr/bZ+8jXcEgOcqvGtb3Nxjuv1h2derpVFXO
         b3NV4HljfvvnUqym+BoXo/BoNwZELuNkXjyAel+QvEm0+ATBBr4ul94jz7nFvfFxtT6/
         fWWfH3BaMjjG5zpPcTJUiktZp8G68yuaFD0MZjJcNYvusdNXMb8BNl+ZFxTzSEkQshkX
         5ZHMWxOcAyu83z877dnp5WqYucBal/bPN3YWRMrRE1X9YGwLeSgfr/sLJ/AnojwIl1Nn
         PXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696838243; x=1697443043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rkvq3l7OtGc7Y82g+8zhheACzUIjrvfwf/RHODg6uiI=;
        b=I3ngrSDh2szzyL/p4cfJKLAV9qzsgbfHzak9GSJh6Bmf1KCuJZ2qvcq9Rnv0Ip2WU7
         dGPJqFG2eHl/VGewAiLA3e5gqeHtea1CbzuHKoEdUwr7h38kTFi50+baidfrQ1iW8u9e
         nQ+i1XE/ppRqGkZKBBnixg6huWxacBSTcHJCxnbbOeompnXOM9dj1LsgBCAst/xwj/va
         m2XPRC6lqGNI7oMiyDdR+9cmBlXLyADwcm8h53rnvVEkQrOqCxUz6tDzD0sJ0Ixez2qA
         IYxQtRw+i7+K0RSX+lsYzE+Vi5V2xnTvmqQMOkYo0zCrpcW3TVs6sQixXiE7709DWa1w
         JLaQ==
X-Gm-Message-State: AOJu0YzVx7dHIyhkac4t4vWBhbuUh2usPr10SEpGl/m5dcc3SCrlOpYA
        WRIElN5quaguxAfo4fgq6k3NzcfIRozJgqnQL5Wyv9MqF4nAXY3SPA==
X-Google-Smtp-Source: AGHT+IHF9EUFj4LHiqBK9oqYOSE87q41Xg7R7YAh3FWbRisiCbDViBHa9Diy29KncsClisBIXjZHyu9VQAUKcuTCL1o=
X-Received: by 2002:a25:cb8b:0:b0:d47:47c0:d7c1 with SMTP id
 b133-20020a25cb8b000000b00d4747c0d7c1mr14827882ybg.62.1696838242807; Mon, 09
 Oct 2023 00:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231009011652.1791-1-naomi.ibeh69@gmail.com> <CAP8UFD35DBBwQ1Mgc+NGVoh1ReLncAz9OJF3Yj++FFrESw8rtw@mail.gmail.com>
In-Reply-To: <CAP8UFD35DBBwQ1Mgc+NGVoh1ReLncAz9OJF3Yj++FFrESw8rtw@mail.gmail.com>
From:   Naomi Ibe <naomi.ibeh69@gmail.com>
Date:   Mon, 9 Oct 2023 08:57:11 +0100
Message-ID: <CACS=G2zcU+o6av=CQy7WAG7DZmNEERcPqB_W3Cmub4w25V3K4g@mail.gmail.com>
Subject: Re: [PATCH 1/1] [OUTREACHY] Fixed add.c file to conform to guidelines
 when using die() listed in issue #635
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you very much for the feedback Christian, I'd definitely keep
this in mind the next time I'm creating/sending a patch.
You also said asides working on my commit message, the patch looks
good, but as I'm applying to Outreachy, I need to send in my proof of
contribution as a link of a task I worked on.
Would sending a link of the mailing list , with the url of this patch
I just worked on suffice?Something like this :
https://public-inbox.org/git/20231009011652.1791-1-naomi.ibeh69@gmail.com/T=
/#u
I ask because since I used patches to send to Git , I have no pull
request link to submit.

On Mon, Oct 9, 2023 at 8:28=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Oct 9, 2023 at 3:17=E2=80=AFAM Naomi Ibe <naomi.ibeh69@gmail.com>=
 wrote:
> >
> > From: Naomi <naomi.ibeh69@gmail.com>
>
> First the subject should start, after "[PATCH 1/1][Outreachy]", with
> the area of the code you are changing followed by ":", so here "add:"
> (no need for ".c").
>
> Also even if the subject gives a lot of information already, it's
> better to use the body of the commit message to give a bit more
> context and details. For example here either the subject or the body
> of the commit message should say which specific guideline(s) the patch
> is enforcing.
>
> > Signed-off-by: Naomi Ibe <naomi.ibeh69@gmail.com>
> > ---
> >  builtin/add.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
>
> Otherwise the patch looks good to me.
>
> Thanks!
