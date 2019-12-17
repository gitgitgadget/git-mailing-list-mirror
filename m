Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEA3C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 16:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0227C2467E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 16:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvNN+Ygx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfLQQL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:11:26 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:37599 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbfLQQL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 11:11:26 -0500
Received: by mail-io1-f43.google.com with SMTP id k24so9946148ioc.4
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 08:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rYAA3F7KAgPy6gY9hTW542OSjYfL0TjLyG2MKZ3rAvU=;
        b=RvNN+YgxpjCezvtEOzwDD7EWytYV0JRnQj4lJuX+wamN55OGYENzWcVcRXinJMoM4y
         vfjac+SNEBnWAciM5i3cP2r5F2yMG2K00o0Aq2llzK3kEvKpiQEXB6DYAu5AHe1ScNAa
         uu8/30C/g5100JD9qMIiObOptMvPSpelATtXdcGVzBF3ePsiyY9CEU0M3cTgwUaa7iMt
         mSAyQLETDHbQcNqnDFMHlcneUqgiLTRENtaRKLat1qTvL1NC31STqe7Kh7F9WY1PK2r1
         MO0gOG+CmKru/7tCd6rRu+aXvIx18+48xvGECn1+fousxG44fKiRPEQlqguJvmMd12EA
         oPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rYAA3F7KAgPy6gY9hTW542OSjYfL0TjLyG2MKZ3rAvU=;
        b=De8wwKhSu4UwrxEliD+OtDP57UKfSwX7pPh//lgvm5+EOZcpQzGUZ5KW2dqDqHCAHC
         6saRK9nPSH6EqXzjMnlrlemKDkrWr7Jun4Nq5VT23YGhkz21bvuxWop4MR1Tb8CZ98d9
         phJG8xqpT6xkBChs1vX2ek7R7I3yeQLifdUzJX4wYbBUFXcieEsoZkPYQI7XkxXumLOU
         KKHWDUhAM0uoYpOT18J270Pdoo6b96tsgNfzc/o4PZzswxf6n+8J/V7NGHtXZH0zaK+k
         bjD7Hp681BQTHe6p5veWrFfBO3WxPezDRPRnyx5MYhcvOZ3RBeq0rbFzTP85KrUzrG6T
         BBow==
X-Gm-Message-State: APjAAAUxf0x7UpiYoBySf+uqVnjIZdYidPWo+4WOgusUaJA3HKG40PsT
        1lerJcsrxeDeN1s4OaA0X/CZ/cKq1OkcfqwDtziafh4B
X-Google-Smtp-Source: APXvYqw6zmb9lfsty7a2dd8eVLkTJmuYDkzq9z/Abc75zmvG360eXKHlJvq+MwDkop4SI0ph2io/pFgd0v4yzvV81js=
X-Received: by 2002:a6b:ed15:: with SMTP id n21mr1891562iog.128.1576599085663;
 Tue, 17 Dec 2019 08:11:25 -0800 (PST)
MIME-Version: 1.0
References: <CA+0NiBEFssPJsQ8UV6vRNBxzUEsJddF4Q-=-xVq-xgNUtFbHUA@mail.gmail.com>
 <CA+0NiBGcYwu1Gyyv3AQEbfQCMiE0rrurzgkQzwsjHgi9cEj4wQ@mail.gmail.com>
 <CA+0NiBFU46YRBFEbngK+Rc0e4uE_nSqQkYak9a-_UoTaCCb1Jg@mail.gmail.com>
 <CA+0NiBEifgam1xVJw7F=mO_DtLgfqK9g7eHJMK5dt3yc1JpaAQ@mail.gmail.com>
 <xmqqd0cojd7r.fsf@gitster-ct.c.googlers.com> <CA+0NiBGQHK_bVdH11zRErxNTjvyU-SqJYj=CHZy3afm47+reYA@mail.gmail.com>
 <20191217135945.GA5103@cat>
In-Reply-To: <20191217135945.GA5103@cat>
From:   Marce Romagnoli <marce.romagnoli@gmail.com>
Date:   Tue, 17 Dec 2019 17:10:49 +0100
Message-ID: <CA+0NiBHFcVZ0RpDB6kffCA5fzdfhcGwH7k=4q15kbXeF5J7UPQ@mail.gmail.com>
Subject: Re: Fwd: `git stash pop -q` is deleting files.
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh ok, thanks to everybody for your time!

Marcelo Romagnoli

El mar., 17 dic. 2019 a las 14:59, Thomas Gummerer
(<t.gummerer@gmail.com>) escribi=C3=B3:
>
> [please don't top-post on this list]
>
> On 12/17, Marce Romagnoli wrote:
> > But it seems is still happening to me in 2.24.1 -latest-
>
> It being in master doesn't mean it has made it into a release yet,
> though it means it will in the future.  So you have a couple of
> options in the meantime:
>
>   - Compile Git yourself from the 'master' branch
>   - Go back to an older version of git.  v2.23 didn't have this
>     problem, but it had a different issue that I was trying to fix in
>     34933d0eff ("stash: make sure to write refreshed cache",
>     2019-09-11), but where this bug was introduced.
>   - set the stash.useBuiltin configuration option to false, which will
>     make you use the legacy stash written as a shell script.  This
>     also shouldn't have this bug.
>
> > El lun., 16 dic. 2019 a las 20:13, Junio C Hamano
> > (<gitster@pobox.com>) escribi=C3=B3:
> > >
> > > I think this has already been fixed with
> > >
> > > http://lore.kernel.org/git/20191113150136.GB3047@cat
> > >
> > > at the tip of 'master' a few weeks ago.
> > >
