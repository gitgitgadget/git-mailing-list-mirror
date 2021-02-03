Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F674C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 01:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0BCA64E4F
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 01:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhBCBAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 20:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhBCBAp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 20:00:45 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E170C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 17:00:04 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id e15so10734914lft.13
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 17:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpbtKot0HlYbGSGCnGSr+Oau0IGNp1A2XeRVJcXFNbU=;
        b=B/0Tc+EtVoPDD751SFGchV/jbaqQk4zKLhv+UiAIT/Wfy2JmjkWaHtoxNHA2Jlu5Oz
         HulXV2U7qxtjtzh21jveV0x2JKIa0sBRe0SCmvz+UtzI7rKdOAeSo8wbyXIYbrp3fGwt
         3j1I4S42BFDt9QrDqQq9MA90Ku5uO+WxEuZmXsdi2DZwoPXSI+NJl8GXniT653M23p4R
         84vwtEPhZWrR6eBNGy4HReFnkSgTRYJrindGTEy2VR13LTdCq3IUKGXQ3Xn7BMQ1V5El
         7Sfpm1xw207e5GHGz9sEuziQIfz5RqIsWjhgvM113xyvYAyiXwk927jX6lDkxAj7zADz
         CZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpbtKot0HlYbGSGCnGSr+Oau0IGNp1A2XeRVJcXFNbU=;
        b=noaLltUPgelbMpHiwqWtwRqE5iWiOBvJOeiOPwXfoiNkmYYjSY6lKN72/AzBFVA7EL
         d7TDVhxhNaN07WTUE/3DOajVlW3U6ZuOLuKqAGGTMfHQc42nFjYK3yC1Ev5Wrcup+XUJ
         JunTvhj2TxpCcbtP9a1WSCjLCJ0X8krJnnFmrx5mwCiqH86aKncTQBZyFxCO1Fqe2LpV
         dRvgRzX0mkGB8U2WMeKCGn+kqX1uJHSxwVbS/cVF/WK5yid3ureISGXztQ9iqEdniXoP
         9lUIHznes/xN5byon6LYfcqoeCKRAR8ahP7zLATi3zE24nqN4e9NbM5GN8nX1lKwiv6W
         bsfA==
X-Gm-Message-State: AOAM532UD7+BCQ/OwUWxyAb+Ds2r9mmteV455kRvCIHC4cuzDHJub5c+
        n5gi4UBVgs/07f3qonKZ/DhT9zK+FG09DcyUbMZemCGa1+PCzl/s
X-Google-Smtp-Source: ABdhPJxZiYpojv04x+wfdGSb5Es1tPaTB1xHttwpdZz69Me58GnsTqKs2KrBMHO3lWiDIDvsk4VSwgi6uE2RreUygF4=
X-Received: by 2002:ac2:4ade:: with SMTP id m30mr372278lfp.231.1612314002912;
 Tue, 02 Feb 2021 17:00:02 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
 <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com>
 <CAGP6POJeg4EB1Lx8NN0+PP-nxystKtLT_FH2UdQhoF13TjWvXg@mail.gmail.com>
 <xmqqv9bagzwb.fsf@gitster.c.googlers.com> <CAGP6POJ4GPDL3uTzzBDSZ1ykypA4SyVEC5sc0W=FCLOsHmOntA@mail.gmail.com>
In-Reply-To: <CAGP6POJ4GPDL3uTzzBDSZ1ykypA4SyVEC5sc0W=FCLOsHmOntA@mail.gmail.com>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Wed, 3 Feb 2021 08:59:51 +0800
Message-ID: <CAGP6POKj+f3J76h7qDYRJ7CowUE9WM2L_QTamHYQ3_YvSM13MA@mail.gmail.com>
Subject: Re: Only receive the topics I participated in or initiated on this
 mailing list.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 3, 2021 at 8:55 AM Hongyi Zhao <hongyi.zhao@gmail.com> wrote:
>
> On Wed, Feb 3, 2021 at 1:09 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Hongyi Zhao <hongyi.zhao@gmail.com> writes:
> >
> > > On Tue, Feb 2, 2021 at 1:41 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >>
> > >> You can,  on _your_ end, filter incoming messages that are sent via
> > >> vger.kernel.org and do not have your address on To or Cc.
> > >
> > > Thank you very much for your comment. It seems that the following
> > > Gmail filter will do the trick:
> > >
> > > From: *@vger.kernel.org
> > > To or Cc: -hongyi.zhao@gmail.com
> > >
> > > But I can't find the Cc field on the filter panel.
> >
> > Here is what I use to process messages that are sent to me without
> > being sent to the mailing list:
> >
> >     (to:gitster@pobox.com -(to:git@vger.kernel.org))
> >
> > The rule is set to skip the inbox and throw it in dustbin ;-).
> >
> > I'd imagine something like
> >
> >     (-(to:hongyi.zhao@gmail.com) (to:git@vger.kernel.org))
> >
> > would hit what you want to filter out.  Let me swap To/Cc of this
> > message so that you would appear on Cc so that you can experiment; I
> > think to: would work for such a message just fine as well.
>
> Thanks a lot for your wonderful notes. Based on my trial and error
> with Gmail's filter/search toolbar, It seems that the correct filter
> should be written as follows to meet my requirements:
>
> to:(git@vger.kernel.org) -{hongyi.zhao@gmail.com}
> to:(git@vger.kernel.org) -hongyi.zhao@gmail.com

NB, you can also change the "@" to ".", they are equivalent in the
filtering result, as shown below:

 to:(git.vger.kernel.org) -{hongyi.zhao.gmail.com}
 to:(git.vger.kernel.org) -hongyi.zhao.gmail.com

Best
-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
