Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831BDC33CAA
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 22:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3343621D7D
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 22:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWmYjKVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgAWWi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:38:26 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:33362 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgAWWiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 17:38:25 -0500
Received: by mail-ed1-f43.google.com with SMTP id r21so211074edq.0
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 14:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I28dyjZzR48R9fe8rv+H4n42AQf+BHoADWNUU4q3cPw=;
        b=DWmYjKVoCDPC0bAvZfZg9Knt3CtQHUjz/JXlblwPf1yGp4gjH14pEkzUDC/LEmqqXK
         OQ8sTMKUVziWBK2D6JonBXgT/rB3Z9VgPjlZde6i2WwJ0pzaVDo4TG6k+xaImxG/BMXl
         4/+cKv4PyRJpK7/l3mKBoWOYZmI+wSu2nvyQqqSj9riSl4aMszdzNUMKWzZepLvmr8Zg
         K8XC8ibVSFRqIOP/TsACa6EB8BWDGUmuKIgYEjjgLXAlI12r5AmJT+XYfrkstZ3rGcba
         VapHBKX/xpfE6FdOywGOye4oeWLXgjgIe1XpsnQElbWb2zRC17OXY+BB5HpTT6gAAPuk
         5akQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I28dyjZzR48R9fe8rv+H4n42AQf+BHoADWNUU4q3cPw=;
        b=jTMApPaTI+cxzXZaM9nYnkGw/wzQlMWIeK/iDZEPPmZHch8wT7M5NJr7YF3arjglcH
         oT/PmMcynrLhH7zQ/1QfqIygQ553OEGvoar9sfc7VwbQi8isRzNdbmMjNPzTrxlVEwZA
         NynOI6QDMWXkirhOCqu00ES+6PEGUAS+iEfFgh6yBHViiIbthw9qNiOGKjb+7SwYSzf0
         I0agcesmBx60T0kIsRXo89ftOri9/Ddavx8oQVm4rn1e6v2WKUj5p+JPHshKE87P14be
         vyTRoyrTMdOiY5VxDkRIxTeKoUWMLq7Pqarne0xM5B51rBHUfGAjHZq2Lozk1ItHD+k/
         EGSg==
X-Gm-Message-State: APjAAAVXK2kl7gRfHlF4t56IH3gg2+H9S+nITO1rt9cHupvoEssCzQOU
        iBF3NpPihadqjpssyAi3Wwt6guXvnjuxZP5zUbA=
X-Google-Smtp-Source: APXvYqzwCe0TTzH1Ub4My7E90oaX3Udca+SgK6wMHyR8amIysMqVE3B9ALahP5X4V/yf0oW2B3FNm7E9P5XhP3hikhc=
X-Received: by 2002:a17:906:29cb:: with SMTP id y11mr262549eje.67.1579819104149;
 Thu, 23 Jan 2020 14:38:24 -0800 (PST)
MIME-Version: 1.0
References: <CA+CkUQ-72jKTMUQuGvYg+o5bp3DoKxX5bFCUrWyGLf_tzVydsw@mail.gmail.com>
 <CAP8UFD20Jh4HRBUTUfy6t72r_wyX3F2RWoyRVwBx4dY2VfhrbA@mail.gmail.com> <CA+CkUQ8vDG6HHyzX=bEEmzsZX0uCm4cpRD5zev5tY18ZFueuPw@mail.gmail.com>
In-Reply-To: <CA+CkUQ8vDG6HHyzX=bEEmzsZX0uCm4cpRD5zev5tY18ZFueuPw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 23 Jan 2020 23:38:11 +0100
Message-ID: <CAP8UFD3ywtc0Xo8nu22-Uyu78-ehXQxBnHD3eXhc1yvfkqbNdg@mail.gmail.com>
Subject: Re: [GSOC] Introduction
To:     Hariom verma <hariom18599@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hariom,

On Thu, Jan 23, 2020 at 9:18 PM Hariom verma <hariom18599@gmail.com> wrote:
>
> On Thu, Jan 23, 2020 at 4:46 PM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > It is not clear looking only at the links if the issues you solved
> > have resulted in some patches posted to the Git mailing list or just
> > fixes in Git for Windows. Could you give us more details about that?
> > For example if you sent emails to the mailing list could you send
> > links to those emails?
>
> My apologies, here are the links to the patches[1][2].

Great, thanks!

> > If you have already sent patches to the mailing list and they have
> > been accepted, you don't need to work on a microproject.
>
> Both have been accepted and merged successfully. Those are just minor
> issues, so I don't they can be qualify as microproject. Although I
> forgot to tag [GSoC] with the patches.

I think it is enough for a microproject.

> Few Doubts:
> 1. Do I need to tag [GSoC] with every patch I will send before GSoC or
> just only with a microproject?

I think it's better, except when replying, if you tag every email you
send before the end of the GSoC with [GSoC].

> 2. Can I use GitGitGadget throughout the GSoC period and for my
> microproject? (I'm quite liking this tool)

I think so. I think other GSoC students and Outreachy interns have done.

Best,
Christian.
