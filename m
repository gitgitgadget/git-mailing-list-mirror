Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36601C433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 23:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD1D206C3
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 23:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQw1WSGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgFIXbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgFIXbh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 19:31:37 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29BEC05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 16:31:35 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id y45so109448ooi.8
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 16:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=qy3lDVE8kLJTmQEjFMpnlR5jcB6+NoS1/pbDX6MBPXQ=;
        b=eQw1WSGUNv1tbjnENlR4435Pbga87V7t0ZfuBhMFXoRoROJhSYKz8fJ061nD//sLXv
         3HyLykVy0U3iys5/7yA3h+zq8fT0/IDryuappxWTujKu4zBbC4Vd0VOxN6hU98xWFZE2
         j0XD6JtkKHa9w6FBN+VIF5BNXT/YgWi1n1S8tuG3NAn+S5JzT75WcnPiS7Rll2q/Q4FP
         si3crrHkuXPetLeDbfF31GrwsObLn70IGVGbwu/VXY+vvDFSrNG2nbgaVBdGbDT4lAzE
         KyEqM+R4+14c9FgFElgVDEQXzBtXW0RxvDzhOdZktDC9C509lN9+XZTtB6XImXD4MWL9
         HHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=qy3lDVE8kLJTmQEjFMpnlR5jcB6+NoS1/pbDX6MBPXQ=;
        b=fnMhmUeEsrFsGpE49gmdZn5hKleihdKBCKKGv3xNPVEAyo6WYz3QTrtEqFVdlOvKCn
         uST/acLl5Wn6FWuFr8rbSX9OHqbVhkKoELrUDS7UKkDCvpjG0iRU33+vku64ETnSUxrn
         SQOr40uLdPS2xkuMQ69/OKCRsItu6jpFA3N9rl1uRlsYjHfHDQ8C7wC3mtm9fFhbPPPy
         Gs6BD0pWsblcjbkyWQoRNjVqNDU/u9nq1dtUxLMrPWEZMHb+Dn1czzrpaHF4xjFKVzu0
         oMtVErdGq+ttPFZfNL2XotKrrdJdA/LiPzu+Otf27kErDNYxRnLciSp0/R5pbo0MQ0HD
         Pkaw==
X-Gm-Message-State: AOAM532VuUUT1zZ/RdU6hii80hETENXSyLbJ9ExXSCtOy8c4h1AUANkO
        U8dH2IA3jINwo1qNPl6+e1oYMYv5tk4Wu48Mevk=
X-Google-Smtp-Source: ABdhPJyjEGrcxLW17QnWD5ZA+woGqLABLYsgJFr9Ay300Z6d+z5Th/QIlPPx0+86bTPucmgO6T6yYusyrnA16MAP310=
X-Received: by 2002:a4a:3811:: with SMTP id c17mr187812ooa.91.1591745494336;
 Tue, 09 Jun 2020 16:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <CACPiFCJKvnDL9Xj1Xs0RCvuhymjDz4N0hT42dNtBQxp+TLiPaw@mail.gmail.com>
 <20200609231336.GQ6569@camp.crustytoothpaste.net>
In-Reply-To: <20200609231336.GQ6569@camp.crustytoothpaste.net>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Tue, 9 Jun 2020 19:31:23 -0400
Message-ID: <CACPiFCK0h0LfdyE6Q=UJkuX+Qdb=rULcgDJwgxQ0w-1O0zpMew@mail.gmail.com>
Subject: Re: osx autocrlf sanity?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

good question! There is a .gitattributes file, all the files affected
have these attributes

*.py     text diff=python

regards,


martin

On Tue, Jun 9, 2020 at 7:14 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-06-09 at 19:52:42, Martin Langhoff wrote:
> > Hi git list,
> >
> > long time no see! I am here to ask for a sanity check. I'm on OSX.
> > Checking out a repository that has an un-controlled mix of line
> > endings. Mostly linux-style, but some Windows CRLF endings.
> >
> > A few tests.
> >  - I set core.autocrlf=input globally --> a fresh clone doesn't have a
> > clean status files look modified right after a clone)
> >  - set core.autocrlf=false globally --> a fresh clone doesn't have a
> > clean status
> >  - set core.autocrlf=true globally --> a fresh clone doesn't have a clean status
> >
> > This is git v2.23.0 from Homebrew.
> >
> > Am I doing something wrong? Can git work sanely on a mixed endings
> > repo without having to fix the world first?
> >
> > ... I do strive to fix the world (and this small repository), as we
> > all do, but it should not be a preconditions before git behaves
> > sanely.
>
> Does this repository have a .gitattributes file and if so, is there any
> correlation between the patterns in that file and the modified files?
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204



-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
