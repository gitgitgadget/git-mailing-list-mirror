Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C0DC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 06:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC6E610A0
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 06:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhHBGxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 02:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhHBGxE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 02:53:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BEEC06175F
        for <git@vger.kernel.org>; Sun,  1 Aug 2021 23:52:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id hw6so15308452ejc.10
        for <git@vger.kernel.org>; Sun, 01 Aug 2021 23:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GXTS9HACDqEQOG70pBDmZA4i2I3HujN3SCMxe8q/vw4=;
        b=KtFRHOtuFFNBbRPESO2DlpFhXe1oh8slOkWDsQEL4sesSSWHq16eUPfWC5quwXpy3e
         wbzcg4w0MODE0diOGArqJJKcsVMl3ysM5qtgqeyIUinjWuqjlC97By/8HD6Yq3YnZHLc
         avcEc5V58rTjRfmJmAGjwfNtXOXfvUQE5xKZECQBh7VSTauRQ0J/TZZr3vuNPQCvxEof
         0CMIwypVbDERWzUq+u7NICfk1d42GU570Pqql0P+ekgRPAyP8uY1Yev9ZRyhxLvzQT+L
         XA7RO7t69ajCAod9tiEU7atmIEZqpRvrXW4bwyLdDUMEcTlr4rxtSi3B/V05DR5ttJ4X
         raRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GXTS9HACDqEQOG70pBDmZA4i2I3HujN3SCMxe8q/vw4=;
        b=ds92CFAWiTG71Z/5o8lRvUsDgAvL8qb4vp4gUOobMkW6GJ8Q+W/KrPvUz3ad1OsMv8
         8mn17Z7zNN/+GD7JhgyZHSTDhZdLTs1t2p3QXZsZMDiiISBl/p4C54Lr2NRX+NVQ+f7c
         tGH/b9iju+zrwDofC3Y7TmzCLBRy++yMGr8vJEalC1ctJ6pJbjBfxbySFdybpkC/5nof
         Mc7PFAdYlOPeknj/TdoPuCtgh9lwSfGJSbo9BA+SoEWzXIQj7ilmZL2G2dFg48pDfa3c
         iGsbWt9Z0bPgK9/q7wmChcHAM3vgfhGCrzI11EsOpEODj1iCYIOZ0GK9OEvxfX+v5k9h
         95kA==
X-Gm-Message-State: AOAM533rKzLcOnOClYo7nroMMZBXo37T1/xuyk/VWKnnfs4lHLR5kzHp
        s1Rw8GUfH/mMW1ALmucj2Ph8DWYGi0d93grWTCM=
X-Google-Smtp-Source: ABdhPJzUNMNDIiVZiVF6ar3u3I2fJsSwboqyeIOhTdb10hfoX9d3GE//6v2QC+uobWYrAn53LC/ABu8E5IATQSJ2ypc=
X-Received: by 2002:a17:906:58c7:: with SMTP id e7mr13752734ejs.197.1627887174132;
 Sun, 01 Aug 2021 23:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <m2lf5lxog6.fsf@gmail.com> <m2k0l5xo1q.fsf@gmail.com>
In-Reply-To: <m2k0l5xo1q.fsf@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 2 Aug 2021 08:52:43 +0200
Message-ID: <CAP8UFD0V3hoDUkeMyAaeo_=cZ46P-Yka1v67FFNbQ5Me5Hh_+g@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSoC=5D_My_Git_Dev_Blog_=E2=80=93_Week_11?=
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>, Shourya Shukla <periperidip@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 1, 2021 at 4:00 PM Atharva Raykar <raykar.ath@gmail.com> wrote:

> Here it is:
> https://atharvaraykar.me/gitnotes/week11

Great, thanks!

> > Preview:
> >
> > - Project progress: where I discuss a rough plan for making =E2=80=99gi=
t
> > submodule=E2=80=99 a
> >   true builtin.

So your plan is the following:

  - Rename git-submodule.sh to git-submodule-legacy.sh.
  - Create builtin/submodule.c, that will read from a config switch
called =E2=80=98submodule.useBuiltin=E2=80=99. If this is set to false, jus=
t call the
legacy shell script, else use the builtin versions.
  - Copy the functions from builtin/submodule--helper.c to
builtin/submodule.c one by one. Make necessary changes in the flag
parsing.
  - Once all the functions have been successfully copied, make the
default value of submodule.useBuiltin to true.
  - =E2=80=A6eventually remove submodule--helper.c and the shell script
entirely, and deprecate the =E2=80=98submodule.useBuiltin=E2=80=99 option.

I wonder though how in the tests you are going to check both the new
builtin submodule and the old git-submodule.sh? Do you plan to run the
tests twice (once with submodule.useBuiltin set to true, and once with
it set to false)?
