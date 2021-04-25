Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A5CC433ED
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 02:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C807561284
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 02:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhDYC4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 22:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhDYC4K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Apr 2021 22:56:10 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1DEC061574
        for <git@vger.kernel.org>; Sat, 24 Apr 2021 19:55:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id v123so1552308ioe.10
        for <git@vger.kernel.org>; Sat, 24 Apr 2021 19:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KzEixbaMonrQCLO7d3A4QzF8Ty5loeKS6spu8Am/hw8=;
        b=cd+zT8Lsusjl6BzKXW+m4gOcBECUYDkebsLJ+Mxts2Ci87ApgUcKz0Rx4MDh+Nru3w
         DOzR1BQ77J8wKkCGvVrlNBiXyrc/+9HBG0qCugD344vwzwNpncl4b/uTenAnpjT7IhsD
         XwN8ypucrq4A+VyIzDQJQ39gjpzf1oGYIM+zfxsmCgq8lHFq/zOUBxn/xLxS4HUnARIS
         LH0zQT3myQzYgGjGx6JMDTs5AkwPeBXnmeWnRrdJbQYdbSBvUd2K+kelqqDrNVDh9HKb
         QvBIoM8u0FXRL9NoITBf2W750rdjgrz0tI6waRRzMLfZu/kMo1e002wh6svq5qwLIUla
         RvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzEixbaMonrQCLO7d3A4QzF8Ty5loeKS6spu8Am/hw8=;
        b=Ek7FqFg381HcOha0jmliWIGewZIaXddf0sOVdMAUUS5iFlMuIW4fQ/D2oXWMhK+p/f
         2CRs3w7CAHcN/2DawKwTjaCdMWo6epLI/ajZZy/00Y1Cpebbk6CXWF54DbHNpTWlF3uo
         Vvlmj5OXK43pSt5XixKgeBPVHFx3dmqz/YNvEtZgNLJvoKR625TaDhiShTlefn/SDDFC
         /6jDqLqQWk+IfkyZLzAbHgtPJYHiRWTCwX99qpst/1mnVKw86jLGB7UHz+l7Z7a5/ryX
         DU3vEtu/ie49vOVDeoRObJ4vWzt5GKHYPiGyh9Mrn9l1nMJffc6SqAuViI3Iwb36gdQr
         Mdcg==
X-Gm-Message-State: AOAM5324qycuHfQvGS2IMuOS0rQxvSZbviMQR88nrnJTwWe9MkEwqmNS
        j+kZgTA2HM3K3QrDSqgA0P/q3pwxb01/sPZTI54=
X-Google-Smtp-Source: ABdhPJwf23IysDurnVutVc6eZDQxGruHTckKunA5CfXroiL5z90t71kbj+0L9clKA8C6HpXj5Pfcr2ghYRufLEog12w=
X-Received: by 2002:a05:6638:144e:: with SMTP id l14mr9927242jad.76.1619319329656;
 Sat, 24 Apr 2021 19:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210423194230.1388945-1-lukeshu@lukeshu.com> <20210423194230.1388945-31-lukeshu@lukeshu.com>
In-Reply-To: <20210423194230.1388945-31-lukeshu@lukeshu.com>
From:   Danny Lin <danny0838@gmail.com>
Date:   Sun, 25 Apr 2021 10:55:17 +0800
Message-ID: <CAMbsUu7PQ+Ni-fhGa3Fbc3YTODETYaPYGLPW9jqGgo=TcdPaAA@mail.gmail.com>
Subject: Re: [PATCH 30/30] subtree: be stricter about validating flags
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git develop <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> From: Luke Shumaker <lukeshu@datawire.io>
>
> Don't silently ignore a flag that's invalid for a given subcommand.  The
> user expected it to do something; we should tell the user that they are
> mistaken, instead of surprising the user.
>
> It could be argued that this change might break existing users.  I'd
> argue that those existing users are already broken, and they just don't
> know it.  Let them know that they're broken.
>
> Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
> ......

Thank you for the recent works, Luke.

I'd like to know if you are aware or working on the issue that branches
before "git subtree add --squash" are pushed via "git subtree push",
which has been reported by me at Tue, 16 Jul 2019 02:30:44 +0800, as I
haven't seen an obvious fix about it in the recent patches in a quick
glance.

Below is the original report (with a slight modification):

-----------------------------------------------------------------------

Say we have a repository with "master" and "sub" branches like below:

    A---B---C---D---E---F  master
               /
          X---Y

    X---Y  sub

where commits A and B include changes in subdirectory "sub", commit C
removes subdirectory "sub", commit D is generated by "git subtree add
-P sub Y", and commits E and F also include changes in subdirectory
"sub".

We'd get this if we run "git subtree push -P sub . sub" on master at F:

    X---Y---E'--F'  sub (after push)

On the other hand, if we have simliar trees except that commit D is
generated by "git subtree add --squash -P sub Y":

    A---B---C---D---E---F  master
               /
              Y'

    X---Y  sub

We'd expect to get this after we run "git subtree push -P sub . sub" on
master at F:

    X---Y---E'--F'  sub (after push, expected)

But actually we get this (in Git 2.22.0):

    A---B---C---D'--E'--F'  sub (after push, actual)
               /
          X---Y

This seems to be a side effect of 2.7.0 -> 2.7.1 in which a change is
made to include merged branches in "git subtree push", but mistakenly
causes branches before "git subtree add --squash" be included.



This bug is especially obvious if we simply run `git subtree push`
after a `git subtree add --squash`:

If master is at commit D, which is generated by
`git subtree add --squash -P sub Y`:

    A---B---C---D  master
               /
              Y'

    X---Y  sub

After running `git subtree push -P sub . sub`, we get:

    A---B---C---D'  sub (after push, actual)
               /
          X---Y

While the sub branch should not change at all!

This bug, seemingly introduced by 933cfeb90b5d03b4096db6d60494a6eedea25d03
critically makes --squash approach for `git subtree` almost unusable.
