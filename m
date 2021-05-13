Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3A9C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 13:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0364161205
	for <git@archiver.kernel.org>; Thu, 13 May 2021 13:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbhEMNmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 09:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbhEMNmh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 09:42:37 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D09C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 06:41:24 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t30so60868pgl.8
        for <git@vger.kernel.org>; Thu, 13 May 2021 06:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cgIC7tu5ulUyICufpY8zoa/zMVp9nSjekeFwNCODrQ=;
        b=kQ06YP71TjX9A7FJSkhxir3DR20e8dFOY5+vJeRSkwCwtlCc2c0ryZHdRAYzs/F91P
         gZP1bdsv+q+YlSgIPsP3NJpEfuwMuwiHn+DCXalA7FQQj5O0DWDtc4Ze+CuLc63Wf+ku
         vMCpPKb7J7c/LRkzQoc5iG4BtL+Nh7D4u6Qs8dtjqrUH8zmbSrxE/2syNcjqR84EhGni
         w0dU8VoIAvqldLgSyNsWxg5QewvHcjQhMv4+eanqme6xsqUnfzQ3adI7o7VGUVCEQV/e
         hY4Tg15Xhke3gKWoY2IuQQsimQjyE34q3bQgTcQ26IiPZH/GoS0vwi0Vs2yBISTVpVPO
         CS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cgIC7tu5ulUyICufpY8zoa/zMVp9nSjekeFwNCODrQ=;
        b=TxD15a/Y+p6C9Y+wuxLLjGqEK50chkOafhzMOjLOSPCmyoixPzVUbA9Pe8HXZG6QBj
         p5BIQJvD8JvN5bexYwWWvNJkJN7FkEwo+0P5I4XAvjI7Csev5f8tGgdaNRA6kXWEJm72
         P3EOWI0+2d5h8kkh8gL6p2xRYzDko7C7QWBmwd3buxmwcKsPNCFdS4cfS4StbaVtvDKR
         oX+sTgD9iFK7hK5FKxBnvLaCJWW3dTsaObnHBc47PNTmGVIHgdSZZX4NN82LUfCGqtgs
         IouH02D2+lg1cZRBYePQ1WA5LDPUefUrqXMuQB86pvvf4WeEjN1Hvy91S+EESkorQZVd
         57lQ==
X-Gm-Message-State: AOAM530fGDqd6GyhiHp81L13is6v0papg8kQ8crSyCvjCAgzAXSLVo5L
        d6EgUqqJir/sAtEdrC/nVkjG6NKkAZqhBDlDhIM=
X-Google-Smtp-Source: ABdhPJyJuxd7k3krJ3NT0j0qFYe3fhYXfIGNxeFfBstSr4QA281gjQyn3CGll1FOJw+nYbs2wqLuz9bDJpsgzr1YzA4=
X-Received: by 2002:a17:90a:5207:: with SMTP id v7mr5226019pjh.87.1620913284538;
 Thu, 13 May 2021 06:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210512064128.15411-1-bagasdotme@gmail.com> <xmqqtun8fncl.fsf@gitster.g>
 <609b8e214e1b6_6e4e92087e@natae.notmuch>
In-Reply-To: <609b8e214e1b6_6e4e92087e@natae.notmuch>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 13 May 2021 15:41:11 +0200
Message-ID: <CAN0heSrNzxSpq=trPvOHAYx_yT1W=WuN1XstzTRjHdZko-i+DA@mail.gmail.com>
Subject: Re: [PATCH] INSTALL: note about make man with Asciidoctor backend
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 12 May 2021 at 10:13, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Junio C Hamano wrote:
> > Bagas Sanjaya <bagasdotme@gmail.com> writes:
> >
> > > +   You can also do "make man" using Asciidoctor's manpage backend in
> > > +   place of xmlto by passing USE_ASCIIDOCTOR_MANPAGE=YesPlease. Version
> > > +   2.0 or later is highly recommended, as these version properly handle
> > > +   apostrophes.
> > > +
> >
> > Hmph, I wasn't closely following the previous discussion, but is the
> > apostrophes the primary reason why anything below 2.0 is not usable?
>
> "Not usable"?
>
> I haven't been able to reproduce the original supposed problem, but even
> if true, the man pages would be quite usable.

Even early 2.0.x had some issues [1]. It's always debatable whether they're
significant or not, i.e., is a significant speed-up worth it if the
result is just-as-informative-but-a-bit-ugly-here-and-there? We should
provide some rough background here to help people and distros decide.
Maybe something like

  "This can be quite a bit faster and requires fewer dependencies, but
   please note that this is early work: there are some typographical
   issues we know of, and there might be others."

but hopefully phrased better than that. I would suggest the commit
message saying something like "I skimmed through the doc-diff between
the asciidoctor-with-xmlto and asciidoctor-without-xmlto (using
asciidoctor v2.x.y) -- there are quite many minor differences, but
nothing particularly jarring stands out".

[1] https://lore.kernel.org/git/20190325190041.GM4047@pobox.com/

Martin
