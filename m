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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E871C64E90
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58BC2224B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgLAXdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 18:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgLAXdi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 18:33:38 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63706C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 15:32:58 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c198so316172wmd.0
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 15:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BFKgyUbWCL3ZYFWP7belZ5BA6/trDQWDQ1YUKocj0ig=;
        b=M0W+s2W6lH70vAL37hsqs+iFWmFZRnz68w2Pw21m8PDjya6+YzvTQbz+NGyocOPXh9
         HiGKtErPyltRPRP86UWwJJntN7baFnfkSYeZKW47BqJI7/ukeVI9Aa/vWvHg5cUfAuLa
         GjFyxkPyhEgNgDKP5qEfkgFvt3RHg3n9yElBijeuknaF9NIOBmOQoBLGq77AUXD/PRQq
         z05hQg8G24barwEBaBCIh1HYwXJiyL2OsVW8u1V9DQlYagVXBS/1ICU7E3MZcn5haOZF
         sz39ZnDGqJxTaN2ywB7I9cQoMbCamUWwQpcI8nUTiS2318gaJzLanIKjiavAUNSnDms1
         KA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BFKgyUbWCL3ZYFWP7belZ5BA6/trDQWDQ1YUKocj0ig=;
        b=aPMrWpWfY+aXFMjcU9rRMgsrVsK2W842N5+olbYWJP6HOVgSXSEnBzPGtSBRkMIwkU
         twuCySyE9aXIeMoY4PwF9AXsiJ/LNakBbHm54lleJDR2BfZ1d/ccYNlHsNm2rzTMtPnJ
         Tm3pS+X7RALg0hd4qE4YRWGRIGbKq2DQghTsedcBrU4TB1yBCoqdvNotVDf2VpSGAuKa
         qvTpuk501uyToDuPcSNEFffFmco2kTmYz13/zrDU5Jvfvl9KyqObd1nnBc/6+hTmsFCQ
         ea41A0AWTsSbzRVnfiz/GzHKZgJNpX3+LDjD0UwanChxHlP7viDOarI32G1vxVfIOVLb
         693A==
X-Gm-Message-State: AOAM532dejluGXcbfPW2PoMPlnR75PTMgKR/jtEwZNNwxe+PzLnsWkIT
        6zEcLh8PymiHiFH6Vt5moqL9ysGR7q4a86wJmgcvTCxZzE8=
X-Google-Smtp-Source: ABdhPJxiDv5xTcGqJU6UjE0xc1CqB+d+TmYyDioBpDh7SlLk751fGvuqFlsuK3pKSDn5Atd+dB6coi/vdKfqu7ONblQ=
X-Received: by 2002:a7b:c7c7:: with SMTP id z7mr12692wmk.48.1606865577213;
 Tue, 01 Dec 2020 15:32:57 -0800 (PST)
MIME-Version: 1.0
References: <20201201004649.57548-1-felipe.contreras@gmail.com>
 <20201201004649.57548-3-felipe.contreras@gmail.com> <xmqqczztqszv.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqczztqszv.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 1 Dec 2020 17:32:46 -0600
Message-ID: <CAMP44s1sdTYxWthfHCxPdoDdmapE05gG5Rr1W3BjTfWv2pCTvg@mail.gmail.com>
Subject: Re: [PATCH 2/4] .gitignore: remove dangling file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 1, 2020 at 12:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > The library was removed 7 years ago on commit ae34ac126f. But not from
> > the .gitignore file.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
>
> Good eyes.  Any automation used here, or just mark I eyeballs?

Nope. Just switching to a very old branch prompted me to look at the
.gitignore file and I stumbled upon it.

-- 
Felipe Contreras
