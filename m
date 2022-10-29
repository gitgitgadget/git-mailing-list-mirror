Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A855FC433FE
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 07:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiJ2HYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 03:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ2HYP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 03:24:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A5818D830
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 00:24:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l14so9228530wrw.2
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 00:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=statystyka-net.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPltRGg1fIWk/+ahUpEX3xjKxHi5Qo0vuG+2rqwsV3o=;
        b=h5JpPZ4qCZOtTra++NLteeE7pnbkrjsYjFCPKSqXB2m3Hwes6mEDEQHX5kI/uHgeDn
         mLZz4l06Rh37XVsstHr92r/ZqSK1MZbaTEJmL2wcuRfKFmeFr2/uSFuX1CtybwpDupRv
         DjOT3HIBzy6V+VgjG2EhHKhAl2P0tFVdCJ7STYSMXRpCiSeplOs1LoCBCfBLQBHheE2A
         FigVzjlFmkN1Qy+4BbQNTmb8+H4tb4C4UZ4h04OTBIM03qVjLFcpJVSQHhEePEsV1h6t
         9xoNiIOAlA6pMMiuo+hVoeTklY/Xl0gBE7HOEpgPthWUVp/2NXBO6BPtnaaFr3+VuAcS
         inlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPltRGg1fIWk/+ahUpEX3xjKxHi5Qo0vuG+2rqwsV3o=;
        b=BWl7PRkMssxWjiX7qyO/LdWu3SqFm67uffamPEOW5Tr04LH0Ql6DVrFdJZf0pQTTMN
         y7R+X/1O1l+yPxEMaqIOw0t8I6oUtmeIhogn0E9KyN2LdfjvZJWaOl9FCBACyA3LI2Gq
         jOuDxRCIQCro9RwC57ReA85jgG2JKQ0H2KbMNwzzS5CfOB2Q5/4HWsqc/INyjHI1HWh9
         aHTh6BNtTJzXdNSfYhtcSrsA9wt0uRnPgGXLLsS7WxKBmCbCOrorPGgU2J/p6XaqjDo9
         BGlzhC6ltV/TF9i82eCzay3gprW07A/UOuvEg1fQmDDVdkt/LdwRx3AMrtBzq+VTt4Cd
         9MqA==
X-Gm-Message-State: ACrzQf32aryu8MAC/PlqSuVytma3/JxrSUF2hGAQUoxCub7oyhw2Qtbt
        +OWIY2tDtWfw8qKjmuBwMPEU7g6WCqId5nb1JpmAcBB9MUYqlGpn
X-Google-Smtp-Source: AMsMyM5gjk0OotpfG7AYRLoLy9NonEelKEVtKBjqBl6PE4cB0z5L3vB71jwf6eQ5mNFgPO7KypNA4DUISM6pcn7KvoU=
X-Received: by 2002:adf:db4d:0:b0:236:699b:be5e with SMTP id
 f13-20020adfdb4d000000b00236699bbe5emr1569637wrj.147.1667028252450; Sat, 29
 Oct 2022 00:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjZQXRsMaRYrskmpn5zBCrOt3xNOZ5shoVG82kjS7A3MZQtUQ@mail.gmail.com>
In-Reply-To: <CAEjZQXRsMaRYrskmpn5zBCrOt3xNOZ5shoVG82kjS7A3MZQtUQ@mail.gmail.com>
From:   Adam Ryczkowski <adam.ryczkowski@statystyka.net>
Date:   Sat, 29 Oct 2022 09:24:01 +0200
Message-ID: <CAEjZQXRB47GirGP53njjGMS1gm6ydUUuxOEaj_XQGkkE8wfo5g@mail.gmail.com>
Subject: Fwd: Soft bug: No chance to sign synthetic commits when using git
 subtree External
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A week passed and my last message did not get any follow ups
(https://lore.kernel.org/git/CAEjZQXRsMaRYrskmpn5zBCrOt3xNOZ5shoVG82kjS7A3MZQtUQ@mail.gmail.com/T/#u).
Since it is my first post to the vger.kernel.org and I am using gmail
(which feels awkward in the context of this list), it lets me to
believe that the message was filtered out from human eyes somehow.

I would appreciate it if someone responds to this email, just to let
me know that the initial message was delivered successfully. Thank
you.

Adam
