Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD18EC433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 09:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F81C20716
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 09:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lufia-org.20150623.gappssmtp.com header.i=@lufia-org.20150623.gappssmtp.com header.b="uClDL4WU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgHJJEn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgHJJEn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 05:04:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBEEC061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 02:04:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id d4so4622584pjx.5
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 02:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lufia-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fZtV0o3Fr286Jw5ezLGXQzcUiZwk87pfHiRS1MqGfp4=;
        b=uClDL4WUZzIMulowdmat81UwER4L1hkWvQqmW9aJHDppgGACB0bJlF4zLiDY/EUHU8
         OvuRdmFVnRthnFcAr1YeTK4+lkSPesdfFFNGJ+yqFZb79Z80DrE8ML2Frk2BYpEgapza
         y2WPbEuyG6P0Mie3k7dGWcBBpQUMm63GkVsH8TYjjjSHYeqjx53dQoN+bcpKsimeB2OZ
         gJAwnYXol/6n4Ceip4VjO+2N3LVvrHVL7e/jzZKedTwM25Eoqu98SGa0mjRIuG9auDdN
         AjVHLdlQjAkOHtBrFeUYqn6pmw7+C/YfeQWAnb0YlNmZvA20n84mnAqRcWMVdJVygEzH
         FXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fZtV0o3Fr286Jw5ezLGXQzcUiZwk87pfHiRS1MqGfp4=;
        b=mbt2uTLNeAkGLbo51lW8oBVV1KEqLKhi35UtzHK5VCMSoyGlz2T/HEb2RrcWwMdFfc
         vlyd5XePyfOADaRoIPflcglWrv773Hg5m2+bFfQbnH/9RlqIGRiZD9jMpzj9xWXANRzC
         GDMoUMrbkyfupy8XURsn7hSYIotKZ3QrihSUR6GY23j5K7sPmuK9knukLc3Vt+jjAKc1
         yaFT1YsKRGBZZ2nZPoOcF6r9CEjEyAgO4YFdYwhugLfwXQCcGrq1ataWvqpviBfP96hK
         okPTQhIGJc3AB6JlQxDvOhQUPOaJ7UeqvnnZBy4q18PNmNL0/RNdRBDMxiPw0Jg0Gl0+
         3ncQ==
X-Gm-Message-State: AOAM531YsCiEFmhXYrhYjb7R5Reim49rUxUhUfuXkjm+CdjHKZ0hSopg
        VbFS27KhuIaGWUsZjl4pUX8PmGNNrVdEUuiItco/4niHvitFoomD
X-Google-Smtp-Source: ABdhPJxzDfGNTvGfUzD9eOOq+DxwHdKCXmUaspDLe0KSPjlZ7E0Kc40ImQZZ9BknIfns1ubLPOuv2I+MvGM2wc3C6Q4=
X-Received: by 2002:a17:902:7b85:: with SMTP id w5mr22624065pll.22.1597050282292;
 Mon, 10 Aug 2020 02:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
 <1f63b4fc7c2ae1970d7226bbf0b66901528fb9d8.1596675905.git.gitgitgadget@gmail.com>
 <20200806021354.GS6540@camp.crustytoothpaste.net> <CAPig+cRe2OUeHXE3XELtkS7b2GrZVxLm0pzduojDB97uLnBZKQ@mail.gmail.com>
 <xmqqeeojlm1s.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeeojlm1s.fsf@gitster.c.googlers.com>
From:   Kyohei Kadota <lufia@lufia.org>
Date:   Mon, 10 Aug 2020 18:04:31 +0900
Message-ID: <CAFMepc=ZGyp=bZRdSkEsrtPCq70+U1amv3OoBk0QMbiwb4W8dA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Use $(SHELL_PATH) instead of sh in Makefile.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        lufia via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After a moment's thought I decided to run ape/psh before building git.
If so then, sh will be found from the directories named in PATH
because it is mounted onto /bin.

2020=E5=B9=B48=E6=9C=887=E6=97=A5(=E9=87=91) 2:30 Junio C Hamano <gitster@p=
obox.com>:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > On Wed, Aug 5, 2020 at 10:14 PM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> >> On 2020-08-06 at 01:05:01, lufia via GitGitGadget wrote:
> >> > In the not POSIX environment, like Plan 9, sh might not be looked up
> >> > in the directories named by the $PATH.
> >>
> >> I think Git's editor handling assumes that sh is somewhere in the PATH=
,
> >> so it might be fine for us to just ask the user to adjust PATH
> >> appropriately before running make.  I don't have a strong preference; =
if
> >> this works on a standard Unix machine, which it looks like it should
> >> (although I haven't tested), I'm fine with it.
> >
> > This does, however, have a bit of a chicken-and-egg feel to it. The
> > results of the "uname_FOO" assignments in config.mak.uname are
> > consulted later in the file to _assign_ a value to SHELL_PATH on a
> > number of platforms. So, making the "uname_FOO" assignments themselves
> > depend upon SHELL_PATH is rather circular and confusing.
>
> Is that just being circular and confusing, or does it produce an
> incorrect result depending on the circumstances?  We would end up
> special casing SHELL_PATH (e.g. exclude it from the variables that
> are set based on uname), which I would want to avoid, as I would
> suspect that there will be even more variables that need similar
> treatment.
>
> This does have a bad smell.  Even on a not-so-posix Windows, we do
> not use such a hack.
>
