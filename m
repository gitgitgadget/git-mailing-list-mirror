Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC04C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 03:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiHVDf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 23:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiHVDfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 23:35:25 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95644201AD
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 20:35:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gb36so18677257ejc.10
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 20:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=o3RjsFpXpTCtmczFTkJ+5MYa+084j7EUyjPo4d0YDrs=;
        b=OG/UUUnA5Ona+8Kmi2faq+z8tH7DI/F4/hi8D2DcCoKCtEhXj/1gjuZFJtFcATRemq
         N79d1vAWHxX7Phmd1EWUijiZEoTVeicSU59JKgwmajSQ8Q5QSPkMLQdpJMLBYXqdpA5C
         QwDYsvd0cozP6XwC7ZmqZkQuTVigkeYBUzcqG32fGKeTibQXongDwruj/TaiAdNvUb+J
         v/anDcKqK9DP51XeWHdEqRIUFJ1yCswfDOENHgzMFMAnQOhay8Ka7wsrhW06YsHISWPX
         ytwWzjyTO60+G49Ce12vrvvjPmIpDlN/BJsxR1+4bT0lD4qCjqCByYbCEQ/a7bxlKjBo
         +/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=o3RjsFpXpTCtmczFTkJ+5MYa+084j7EUyjPo4d0YDrs=;
        b=GYcYRqOy7LJhRBbAMArCVeh6WgphQ+GcxaxqTejG/VUuZosyOKwzwD0mzQmUWKQw4Y
         lCu2NN1bOkDSVDFsQo+mDCQUFPoEMW5Kk4DtEL7XTvYwPHNbo39D2rCGXrIqjpfNuPB+
         SpzjGaVhrTUxaC1OweOweMS2e4HO1hE6TBNusuR1VcfmKCmQWiQ5OxjO7oc3Z0eMpRmz
         Vatbtg9K1UN4Lw6ArjE9SsCA7qG3+noT3oVWLpRWPBydvIxhXYrs6y2bghS74vPLDOz9
         TKHirAYM0BP6qyPWKWukGfgaVtkHx9OiDhCZ8uBdVAMc1lKrbwJehNtMSj/JxeQqnkPt
         06zQ==
X-Gm-Message-State: ACgBeo38XgQ4gJqOlUdOlkACzRK804D4qguA8rUfQp2irDrCXE6/6W/h
        CwOCKmTQmKvzTu1CwhiTS/+Nb3ecDVkcp6aMb/cyJFFM6to=
X-Google-Smtp-Source: AA6agR7b4v5JVOAlnwiqHgBToCLB3q6qE1X6+fFgSdwNNByV7BuFQ63y0R6+T8wx3qSfKm9LVA0b77j0HhU8EaFzF5s=
X-Received: by 2002:a17:907:2896:b0:730:983c:4621 with SMTP id
 em22-20020a170907289600b00730983c4621mr11737757ejc.502.1661139322061; Sun, 21
 Aug 2022 20:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <CADmGLV32OAg6HU+n1UsP2Fq-MjcyUsFFF=q0_jZCB0JEop5VUg@mail.gmail.com>
 <YwCe6ONEaeIj4SO/@coredump.intra.peff.net> <o4sp3o6-75sp-o12o-2p29-r94s2s769r47@unkk.fr>
In-Reply-To: <o4sp3o6-75sp-o12o-2p29-r94s2s769r47@unkk.fr>
From:   =?UTF-8?B?546L5bCP5bu6?= <littlejian8@gmail.com>
Date:   Mon, 22 Aug 2022 11:35:10 +0800
Message-ID: <CADmGLV0F==7ep-xZKd2crZLi8JnFBFVkdX9Bi2T63NECcSAbVw@mail.gmail.com>
Subject: Re: git clone with basic auth in url directly returns authentication
 failure after 401 received under some git versions
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        lj167647@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you very much for your answer=EF=BC=81
And now I tried to add CURLOPT_UNRESTRICTED_AUTH  but it failed.
Here are a few examples of what I've tried.
1. docker run -it -e CURLOPT_UNRESTRICTED_AUTH=3D1  5de1a96efc49  clone
http://xxx:xxx@xxx/xxx/xxx
2. echo CURLOPT_UNRESTRICTED_AUTH=3D1 > $HOME/.curlrc
I wonder if it's the way I'm trying to do it wrong

Daniel Stenberg <daniel@haxx.se> =E4=BA=8E2022=E5=B9=B48=E6=9C=8821=E6=97=
=A5=E5=91=A8=E6=97=A5 06:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, 20 Aug 2022, Jeff King wrote:
>
> > The curl change seems to be from 620ea2141 (transfer: redirects to othe=
r
> > protocols or ports clear auth, 2022-04-25). The goal is to avoid leakin=
g
> > credentials between ports: https://curl.se/docs/CVE-2022-27774.html
> >
> > So that makes sense, though I wonder if curl ought to make an exception
> > for moving from 80 to 443 and http to https?
>
> Nice research there Jeff, and yes this seems entirely correct.
>
> We stopped curl from following such redirects because of the reasons stat=
ed in
> the security advisory for that CVE. We quite simply realized that when cu=
rl
> previously did that, it was actually doing more than what was documented =
and
> what can be considered reasonably safe.
>
> Following a redirect to another protocol and another port, even if it is =
still
> on the same host name, might very well connect and use another server run=
 by
> someone else than the one reached first. We therefore now consider that s=
econd
> host+port+protocol combo a different host.
>
> Setting CURLOPT_UNRESTRICTED_AUTH is then the only way to make libcurl se=
nd
> the credentials again after such a redirect.
>
> I would not mind having a discussion in the curl project to see if we sho=
uld
> possibly consider adding a middle-ground where we allow sending credentia=
ls to
> another port for the same host name, but I am personally NOT sold on the =
idea.
> I think such redirects should rather be fixed and avoided - since I belie=
ve
> users will not understand the security implications of doing them.
>
> --
>
>   / daniel.haxx.se
