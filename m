Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE50C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 22:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C95921739
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 22:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PabxQo5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfLPWjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:39:47 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45814 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfLPWjr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 17:39:47 -0500
Received: by mail-oi1-f193.google.com with SMTP id v10so4605221oiv.12
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 14:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=86UakFp1MM5C0JeK7sWZzNowF5bDwotIxTmpv4c3t2Q=;
        b=PabxQo5ovZNuW1MswOYaDAoQYjzdlwtGSlHFbh98oa/U8MFlvjn/0Vv0uds9SHYdal
         6pY9P7ff9dGQFdgNl9s28147Hvy7fA1O6C1+oY7j6xh1Js1ipDhNssBFADPJjv80Z8A3
         UJzLlI077T+G8XnNNOPxzWQEiXWd+REk2BZ8BGMCNHNG4YU/oRLnlXRvVvtEPePcSQY/
         +RIAN/49I/oVOAI4sYoi7+rsAgjU5tXNaBGioRcQ8hWD/nUMhR630s/fKuZzHcL2gmqo
         JdblBVaRYH5iMTJQiV6+KaU3uh7lbz7IJkqNylnF5gdILmtnmLJy3e6LLBrSUCurr1bK
         +jQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=86UakFp1MM5C0JeK7sWZzNowF5bDwotIxTmpv4c3t2Q=;
        b=bScug6Z7CmxbgMOA+asttDW85lAgA6bd8oAjEZAmLHIPjTjwUUTKnFbOtSGbvxD5xy
         9gn/6xBUOQRcBjDYjnJqpoA4W6BA1ChMxwUI/zJ/XTuVmK5/tqiLh8Qsqh/iTbi+o2jd
         y9BGGR4aiwRLbg2VYY+uszewy0JcnpLJ1TT24JpyoydCf0LUbRpq0SzytI9wuxTe7hs7
         wzthqF6Cr1zLGS2wf4flPH1W2h/AwyHSB7u4Cmf3GZUQ2bueQq4RBmdeIkRdEUH992JJ
         Vm3e8/kCJu2vI5xW5XjaFGMb7ffAa97/pblrihWkh/F5EFbKcmr6giPls4ggOFmit8Zy
         e0cQ==
X-Gm-Message-State: APjAAAX+PmQfAKbxU1diTmxHU8Is2mXIrDanWEjTgSrE0Sa6bqHfdPgi
        J2DkbJR+5TBPC3lUeHDj9ieMMwuVPkB+TPe6Ebs=
X-Google-Smtp-Source: APXvYqy+7OPjgKfpUx/Hn63Yhq+1Z7wakQT1abLXT19teUnUputiGdDtozcf1DElJYeN5YQKuqbKq2b5DRKGIPoUOIk=
X-Received: by 2002:aca:230b:: with SMTP id e11mr433860oie.167.1576535985791;
 Mon, 16 Dec 2019 14:39:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
 <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com> <9839aca00a10b16d96c47db631ac025281ffc864.1576008027.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1912151126030.46@tvgsbejvaqbjf.bet> <CABPp-BE04=A9wx1VfWsghn6scy8aaVFoENxV6YiW2AxgM2jhjQ@mail.gmail.com>
 <CABPp-BGoC_D6LzzMNyf30wFssTU2WA1kTLmFvJ2Do+Tfg4+YQA@mail.gmail.com>
 <xmqqwoawjg09.fsf@gitster-ct.c.googlers.com> <CABPp-BF2UL5m4_f2tETfZvq=011KsKheGA=axFwYhC+kJXi0JQ@mail.gmail.com>
 <xmqqzhfshsk2.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhfshsk2.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Dec 2019 14:39:34 -0800
Message-ID: <CABPp-BHETKt1rTT76u9phGqjN+RU6B-ydzM=S0tzE6To_N4PQw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] dir: fix checks on common prefix directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, blees@dcon.de,
        Kyle Meyer <kyle@kyleam.com>, Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 16, 2019 at 1:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Any bright ideas about what to do here?
>
> Restructuring the code so that we do not use "struct dirent" in the
> first place, even in the original code that used only those obtained
> from readdir(), perhaps?  Then the codepath that would take the _thing_
> that describes the diretory entry would expect to see the data in
> the struct you define (not "struct dirent" from the system), and you
> can safely manufacture ones out of thin air.

Okay, I'll submit a new series dropping most the patches, but note
this thread in the commit message of the new testcases in case someone
(maybe my future self?) wants to dig further.
