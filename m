Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB25CC433E2
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 14:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706FD20855
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 14:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEIymF36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgILOCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 10:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgILOC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Sep 2020 10:02:28 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EA5C061573
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 07:02:27 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id y194so7002195vsc.4
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uj+XxiZR9t/aHpzvNExpHuDpnTRmUHptKNF8dM2/sSo=;
        b=QEIymF36zxleuCDclXU7Z+1VOYMT/5m5LF2BmvLTcRRGYvl5mQpSC/QnSPQDQC/BwE
         HSQSlEsWSGhrx+zdD2Z7y9aFVTxm2Mzsv0z2Sck8uLo2aTrYmKqXLeWwGJrGvjUmrKfk
         paQdh1ZUgFwHMf+WKsApp5Xn13D1wx3bofVlrVZ3j3PBewD6pqdEjQqP7IlJCHtjhKKT
         o6ZljZu6RGrQ1nTS9CCOeTYyYawELkg/WPx6h2hmYMjGG8FXP9hCUJoXOP4ItcjuZGsI
         lVJU1j1R4+rgyS+CDRBf/4hq5m8N3+DngIlJtDlgqorO+m8bcw0coiDH50goM44NHNCX
         pFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uj+XxiZR9t/aHpzvNExpHuDpnTRmUHptKNF8dM2/sSo=;
        b=ic8IfcuIeeRN5cMSC2wuMs3J4wwmrPWPM/NHprzH85nNSual3bbtPsIf6wQs5Q7Ybh
         mNICDmfhPgOWS2vliKXp+emGddWVdUFCXgoyI4c53Lt8uMfMFKEpHhN3TeEs1VgPBW2y
         2bUAoA3UKh0FLvtwwZWdfOmq6UHPOA8Q0EfFWiS3yxPEVOQHq+MEEcf2oDAQeh+qSwEs
         IaKU0mXCu7JDK5TK80OmtIgIoHfwLZ90DGgWudO2cd+BBdw921Xb0Ino0dbgsc5Q5jWD
         GDYf/eRFEmgT+7SQma7WQoBL1yL17M2u32yVenjs12iiu3rr5AmjvBKpnQkgXWKINKMo
         5tQQ==
X-Gm-Message-State: AOAM530FJzckFZAXz05tBkjHfo9/tc6Lz/pH47EDtImpu7hqdprfoe+1
        dNCoLrmgS65PWOf8iYlgVmHXG4gq+SRBCuHnqtI=
X-Google-Smtp-Source: ABdhPJycZxOqL2Oq12+CkFMYvUTE7YXC93qNIslF9nRK2rYLsCcB26v5nCF7tmTweNl+MqUuE0ovBDBaynTvSnHv0+I=
X-Received: by 2002:a67:2245:: with SMTP id i66mr3732528vsi.1.1599919346088;
 Sat, 12 Sep 2020 07:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599762679.git.martin.agren@gmail.com> <58a2469cc18839e57b45f687b6e484d69161a34c.1599762679.git.martin.agren@gmail.com>
 <CAPig+cTZLqFayp0wZEFYkaXtoOx8HedUK1oQoOa+zq=Yrgvjbg@mail.gmail.com>
 <CAN0heSrQT9N3=e70qkgS_rOQ0oy0rrHqud=rRtr-r5JaL=ofNQ@mail.gmail.com> <CAPig+cSEOUebNV90Gec2KqskZgAmX=jd++s4tfAyYN6Up4_O3A@mail.gmail.com>
In-Reply-To: <CAPig+cSEOUebNV90Gec2KqskZgAmX=jd++s4tfAyYN6Up4_O3A@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 12 Sep 2020 16:02:13 +0200
Message-ID: <CAN0heSo92MWy=o8aQ22i0dHa1bgTuWo9Sc=X3bqvLxquiJsREA@mail.gmail.com>
Subject: Re: [PATCH 4/8] worktree: drop useless call to strbuf_reset
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 10 Sep 2020 at 21:49, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
>
> On Thu, Sep 10, 2020 at 3:40 PM Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> > That's not to say this optimization won't ever be useful, of course. I
> > also begin to hope that no caller keeps their returned pointer around
> > for long. It only seems to be used from `other_ref_heads()` and that
> > looks ok. If we do want this strbuf reuse, maybe that function could
> > just keep its own strbuf and reuse it (not necessarily having it be
> > static) and learn not to call `worktree_ref(wt, "HEAD")` twice.
>
> Yep, I wouldn't be unhappy to see worktree_ref() disappear altogether.
> There are no external callers and it would be easy enough to retrofit
> the lone internal caller to use the safer strbuf_worktree_ref()
> anyhow. Plus, both calls to worktree_ref() in other_head_refs() invoke
> it with the exact same arguments, `worktree_ref(wt, "HEAD")`, which
> makes one wonder if it need be called twice at all in that particular
> scenario.

I'll look at this hopefully tomorrow. Thanks for all your comments.


Martin
