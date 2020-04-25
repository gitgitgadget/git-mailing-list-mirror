Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C96AC54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 14:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BAB520704
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 14:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CawV48sG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgDYO5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726062AbgDYO5u (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 10:57:50 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660DFC09B04B
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 07:57:49 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q7so1257949qkf.3
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 07:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eRdY54kYlJAfAMZqmNIal6jlmFmiXRt4dgQvc7m7jtA=;
        b=CawV48sGPn8934sGbMvRbUKFaQj556k6oV6qvUDAHYPvRRTu1TJSJiVC4la10Vm4iy
         3/zz3Ob3X1ieuy/ymeUWcDghFkmFvLyhHRdumaoyelGInnTWptKhacHyvdFuiMGxuLdL
         6AUIm3XX3EM7qLGKI8rVty7CINzJkObwMnRcprBDCGoqEhUsOFmXM7iBvqEPUkXB5HGo
         q969VFJgeDC02D+pNFqEQJDBPvotGS7gP0XRXkqKcWtyWyd+vcdcaOkc4Kn/YcLFpy2C
         y52pK81CzxqKIAMmu5BR1M8iq62XiaIVcxeEbWZg0fU6wnStIFqZ2vQ8hksFhP1ZcA0q
         x9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRdY54kYlJAfAMZqmNIal6jlmFmiXRt4dgQvc7m7jtA=;
        b=Nxr4fJxIs4qglj/B7CkN121oXLwZEZCCTugaj3+3JF5TV3bIqQN55bi4YeexYJQ6ke
         JCFQs7KPnKjuV5pO5rL2u/ZEx+z/qSkUkdqT8HSdZ2zbpZBC6s/5m2vU8B3gaMobtNYt
         YA3Eb/Zyy0XKSY8FN9EF00T0a98ri+F3zcIUH7BUkAMHTYEM5By+uekt2zycTB6fwzRP
         mWnavUMm/XRrVd51+lDlBQIr77jrCNeJVHw5sFS/PTexEp+F9EfTcpSMCJRIU9f0uanJ
         nwUpncYB/zwcIdT407GHpT3CY/AUug83Jnwy9NDpy205lpGPpa03F/W2lz6NT5o+lkfo
         dZIA==
X-Gm-Message-State: AGi0PuY5ScDgeFe3L3QTIHUxw7NeajA++5CIoMyCEnhJ8womuZXQcvI1
        kIu+Bqn0KdkxlrSm1zzT1r00IpyyGZEjYCyw1ds=
X-Google-Smtp-Source: APiQypIm2xyA9+hZ00bISlLcA/kRedzMLD/InEjxPDYyIpxJ0FJqCxUNFpp5g3nUzXyl+BCJFqvz+AqtZgPbuwvk+HU=
X-Received: by 2002:a37:6c07:: with SMTP id h7mr14258454qkc.328.1587826668509;
 Sat, 25 Apr 2020 07:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com> <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com> <CAKiG+9Xtof8Hj3npsS-M0SnT_dcjtHjP_+avWB4oOHkaMdnSbw@mail.gmail.com>
 <40da111a-77e0-55b1-a6c2-9edc77cf1f3c@iee.email> <nycvar.QRO.7.76.6.2004251523560.18039@tvgsbejvaqbjf.bet>
 <CAKiG+9VMjft14ttqQuZMwewOGFbnbfJ3uXn0vPiJb05A8wdSwg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2004251624100.18039@tvgsbejvaqbjf.bet> <CAKiG+9XpZjesKs4p_yRvtgEhqwSHDqnjJcNkzqg_AEWr5BeuQg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2004251647520.18039@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2004251647520.18039@tvgsbejvaqbjf.bet>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 25 Apr 2020 20:27:37 +0530
Message-ID: <CAKiG+9XwoD+UzHovS_mW76CPX_Vtt1eTaSM-xaszKWwt6R3ewA@mail.gmail.com>
Subject: Re: [PATCH 0/8] CMake build system for git
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

I guess this is a pain point having to manage two separate build systems.
I will modify CMake script to get its sources from the Makefile.

Thank You,
Sibi Siddharthan

On Sat, Apr 25, 2020 at 8:19 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Sibi,
>
> On Sat, 25 Apr 2020, Sibi Siddharthan wrote:
>
> > On Sat, Apr 25, 2020 at 7:58 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Sat, 25 Apr 2020, Sibi Siddharthan wrote:
> > >
> > > > On Sat, Apr 25, 2020 at 6:59 PM Johannes Schindelin
> > > > <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > >
> > > > > We already use `GIT-VERSION-GEN` as the authoritative source for the Git
> > > > > version, by parsing the line that contains.
> > > > >
> > > > > It would look very similar, at least in my mind, to generate the list of
> > > > > source/script files by parsing the `Makefile`.
> > > > >
> > > > > Sibi, what do you think?
> > > >
> > > > One way of doing it is to track if the Makefile is changed in a commit,
> > > > run a hook to see if it contains any new OBJs and match it with the
> > > > CMake script. But this is too much work, in my opinion.
> > >
> > > Oh, sorry, I should have clarified: We already parse the
> > > `DEF_VER=v2.26.GIT` line in `GIT-VERSION-GEN` to determine the Git
> > > version.
> > >
> > > We should be able to do the very exact same thing to parse the `SCRIPT_SH`
> > > lines like
> > >
> > >         SCRIPT_SH += git-bisect.sh
> > >
> > > in the `Makefile` to accumulate the list of shell scripts, and likewise
> > > the list of object files could be accumulated by parsing the `LIB_OBJS`
> > > lines like
> > >
> > >         LIB_OBJS += abspath.o
> > >
> > > (We would of course need to substitute the `.o` with `.c`, but that should
> > > be easy.)
> > >
> > > That way, nobody will ever need to touch the CMakeLists.txt file when they
> > > add a new source file to libgit.a.
> > >
> >
> > I understand what you are trying to say, this is not impossible to do but doing
> > so will make the CMake script dependent on the Makefile for the sources.
> > I am not fan of this approach.
> >
> > We should write a separate script (say python) to match each of the sources in
> > the Makefile and the CMake file automatically whenever the changes detected.
> > This excludes the platform specific/compatibility stuff in config.mak.uname.
>
> Hmm. That is an approach that _I_ don't like. Why duplicate the
> information when you don't have to?
>
> I don't see any issue with keeping CMakeLists.txt dependent on Makefile.
> We could of course extract the lists into a separate file that is sourced
> both from the Makefile and from CMakeLists.txt, but that would actually
> not reflect that the Makefile _is_ authoritative. CMakeLists.txt will
> never be the authoritative source.
>
> Ciao,
> Dscho
>
> >
> > > I was not trying to auto-detect what `sed` invocation changed. Those
> > > changes _will_ need manual forward-porting to CMakeLists.txt. Thankfully,
> > > those events are really rare.
> > >
> > > Makes sense?
> > >
> > > Ciao,
> > > Dscho
> >
> > Thank You,
> > Sibi Siddharthan
> >
> >
