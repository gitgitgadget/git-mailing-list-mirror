Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1993BC5479A
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 20:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354499AbjHQUEI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 16:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354190AbjHQUDf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 16:03:35 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DD130DF
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 13:03:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9fa64db41so3026461fa.1
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692302612; x=1692907412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnNSUwcpum0WmBqaflOpWOhsUwPOVFwW4xMu3rAnQsI=;
        b=W3AGywj9vrIz+WJLetuh462spJB+1jFVH6Xgph+GtwjQ6bMLfqc8Wg22pAFK2vhBlF
         GIZJh8PzhDTh8EnlcAbh/3nVwQkcDlNpNTW8v9WJcr9cPRYRNpl2D3BkoaAP4FheR/us
         OCbLT2duWs1GgR+qTd0qj6cTGwwzV2IvITWcVqVEx2XgOGBkp/mPiGV3vb+MHqygAX34
         ZxqIMr/Cy+4yFTJIhqcbvIxyjJ2wu0HWtdcjhsN2TSeM08v9l8AyuTgCjTNEOIi6zvWX
         QmCMh/UEYx/4dI+xkHHfsl0+R7oiEaHUCPDc9ZgQWTygFxi52QunBfp57kdJ4hbkscdD
         82tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692302612; x=1692907412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnNSUwcpum0WmBqaflOpWOhsUwPOVFwW4xMu3rAnQsI=;
        b=F0CaBNoQwcAIXylGirln96WO33BNS8TmqeviZJ7Itm+9psXZ6VGmFUrIEgJH3gnQI+
         SSkVzRUHvrVrrQVV81GnqARF6sPzdoS44ksJql/QObq8UrIs46X4POeybikm5xgsftud
         Tk3zsHsBGlekdQmJbw7obwOeEfTNK/pMthyfCz6Z6Ogeh7YdkMt2ukFNBfBDyiGGAj7h
         jYm0Q8do3/Q3S5PatYBkh5RVL97ESGJ5h8SCrN7IFNmkqdSUy1SUsLBe0ypbnKz3VTEg
         2wnuII6D2EP9a+R9NnJyMBPXCodiDoxvVK+ueqDGBjNWfwro1vGDf8LEpmnC+iel8dly
         WLNQ==
X-Gm-Message-State: AOJu0YxE9qlbbD1n/G9jJM5cnPeDorEacY6cGKziTeAU/rgQv2n3wjE7
        V/D5kMus8Iage2miRkTukpoRVnxrq1LKFO0rANYXJgvrWV0=
X-Google-Smtp-Source: AGHT+IEploaiXWZJX9I2OL4YbAt0EBhTga9OOAJVw2plgCeHAnpEmFOo95ewrMnEdcD2kny8ki6f7gebqphXBdgxP70=
X-Received: by 2002:a2e:3a09:0:b0:2b4:6eb0:2a27 with SMTP id
 h9-20020a2e3a09000000b002b46eb02a27mr267523lja.17.1692302612065; Thu, 17 Aug
 2023 13:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAMRL+qYYGJ-LYG8qZpJOq+_=YO_C7JSTH4TPDpbEA4fRdANP7w@mail.gmail.com>
 <20230816025715.GB2248431@coredump.intra.peff.net> <CAMRL+qbGBOiR49A0FDYgZJmMbsfyeTZkzVmEdrCRYEanjv195A@mail.gmail.com>
 <20230817054405.GD3006160@coredump.intra.peff.net> <CAMRL+qbSn058AsMW7+d1nRbt4Ao6R+BZ6HYHxDrVQhURgWoy7Q@mail.gmail.com>
 <20230817194735.GA3032779@coredump.intra.peff.net>
In-Reply-To: <20230817194735.GA3032779@coredump.intra.peff.net>
From:   Patrick <patrickf3139@gmail.com>
Date:   Thu, 17 Aug 2023 13:03:05 -0700
Message-ID: <CAMRL+qbyLvdfKnv47BRSrRoBKZW5pU_uy1w7GO3Hyo3+X224PQ@mail.gmail.com>
Subject: Re: Force usage of pager for diff, show, etc when piping to non-TTY
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for clarifying, Jeff. And thank you to all the git
contributors who not only maintain git for all the developers
everywhere, but also provide first class support :)

On Thu, Aug 17, 2023 at 12:47=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Thu, Aug 17, 2023 at 10:06:58AM -0700, Patrick wrote:
>
> > Just to be really clear, the filter in `interactive.diffFilter` is
> > meant as a filter for transforming (think a photo filter), as opposed
> > to a filter that removes elements, correct? I think that's what I got
> > tripped up on when you explained the first two times.
>
> Yes, exactly. In retrospect, the name is a little ambiguous. :)
> Glad you've figured it out.
>
> -Peff
