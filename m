Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8B1C54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 14:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E62320714
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 14:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAP3QW/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgDYOiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgDYOiY (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 10:38:24 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13350C09B04B
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 07:38:24 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s63so13349429qke.4
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xxp7zOvTd5SAXWj+uwTbA4jo4ccFBBR88664KNOXhZw=;
        b=oAP3QW/K51emZ6inIERopCFzP3FBLdFtw2dyDH42KhB234XQybqiA7JXg2njv5IHsB
         FtYY9aW+TtJ3TuONYJn9zdWNNCYOURz3D20AXtGpyzXJcXWaJdnGLlNqXLEYdB7dPozE
         VTMaO8rGluJjG7yvY8Rt0OX3++11a7RwUahPi2NLEiaRIcBQ2uCNqIz9u2Dg/eTAMEn9
         No6Q2gYr32QW77ep7XOhXC6O40QKg96Njt4zF5n8zQljtm9wz33rVhZmUiWhbQYLA7Tg
         djQTtrNFtCpppV2qxO/ELcq8Yk4V7eqWFSJqwnBw75fNB9R00/OqZGcFbJNk8Gwgy8vP
         981w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxp7zOvTd5SAXWj+uwTbA4jo4ccFBBR88664KNOXhZw=;
        b=IOTSszVOpYo4Qxs/IMSQvpV6KZsYgGJVSG6FK8gOTCvQlLvzl3XeIsl+mRSNm3BQOL
         edZH2NOGfaORZITSc+4xPESqdv14po/4d+Z+VF6ONUt0NbA3pcyaKj/ioL92TpDiPBdm
         KTUj/7FxJzeG5OEWOgE4O6MZIXzZuD5Ow5YaQEdAWT+HKYvsRuMhLKGMGs8R3Qfeiswa
         2rDsef55aRIZn5A3Q+haa9iCFeQseZJKykYZwUVlpp+2YiU+jq776AQ19R3dt1jkZzTN
         4FhmpTqEyG/5ow1Z52khjLO4jKqEzn4vWt9kctFl30xYh7zX65WxwyOSWSJhl1jmh36E
         LOKQ==
X-Gm-Message-State: AGi0PuYWXtCRCIxOpHTIbO13NvKZ0ED7PdyZ2r6DUg/+6g47JO6XW0uR
        RMSm6sscXsY65hd3bOv6a2uwMkYok157WpZ7Ahw=
X-Google-Smtp-Source: APiQypJYNU0zsgLhxKT8MwkDZdZ50lpHqSFp8Jws4XErMxYSV/gbXhvItk5x+MrexUHTtmi78wXjeIUTZrzvfCTHvfo=
X-Received: by 2002:a37:787:: with SMTP id 129mr14013445qkh.92.1587825502366;
 Sat, 25 Apr 2020 07:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com> <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com> <CAKiG+9Xtof8Hj3npsS-M0SnT_dcjtHjP_+avWB4oOHkaMdnSbw@mail.gmail.com>
 <40da111a-77e0-55b1-a6c2-9edc77cf1f3c@iee.email> <nycvar.QRO.7.76.6.2004251523560.18039@tvgsbejvaqbjf.bet>
 <CAKiG+9VMjft14ttqQuZMwewOGFbnbfJ3uXn0vPiJb05A8wdSwg@mail.gmail.com> <nycvar.QRO.7.76.6.2004251624100.18039@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2004251624100.18039@tvgsbejvaqbjf.bet>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 25 Apr 2020 20:08:11 +0530
Message-ID: <CAKiG+9XpZjesKs4p_yRvtgEhqwSHDqnjJcNkzqg_AEWr5BeuQg@mail.gmail.com>
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

Hi Dscho

On Sat, Apr 25, 2020 at 7:58 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Sibi,
>
> On Sat, 25 Apr 2020, Sibi Siddharthan wrote:
>
> > On Sat, Apr 25, 2020 at 6:59 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >
> > >
> > > We already use `GIT-VERSION-GEN` as the authoritative source for the Git
> > > version, by parsing the line that contains.
> > >
> > > It would look very similar, at least in my mind, to generate the list of
> > > source/script files by parsing the `Makefile`.
> > >
> > > Sibi, what do you think?
> >
> > One way of doing it is to track if the Makefile is changed in a commit,
> > run a hook to see if it contains any new OBJs and match it with the
> > CMake script. But this is too much work, in my opinion.
>
> Oh, sorry, I should have clarified: We already parse the
> `DEF_VER=v2.26.GIT` line in `GIT-VERSION-GEN` to determine the Git
> version.
>
> We should be able to do the very exact same thing to parse the `SCRIPT_SH`
> lines like
>
>         SCRIPT_SH += git-bisect.sh
>
> in the `Makefile` to accumulate the list of shell scripts, and likewise
> the list of object files could be accumulated by parsing the `LIB_OBJS`
> lines like
>
>         LIB_OBJS += abspath.o
>
> (We would of course need to substitute the `.o` with `.c`, but that should
> be easy.)
>
> That way, nobody will ever need to touch the CMakeLists.txt file when they
> add a new source file to libgit.a.
>

I understand what you are trying to say, this is not impossible to do but doing
so will make the CMake script dependent on the Makefile for the sources.
I am not fan of this approach.

We should write a separate script (say python) to match each of the sources in
the Makefile and the CMake file automatically whenever the changes detected.
This excludes the platform specific/compatibility stuff in config.mak.uname.

> I was not trying to auto-detect what `sed` invocation changed. Those
> changes _will_ need manual forward-porting to CMakeLists.txt. Thankfully,
> those events are really rare.
>
> Makes sense?
>
> Ciao,
> Dscho

Thank You,
Sibi Siddharthan
