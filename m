Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620B5C433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 19:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427CB20737
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 19:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=goodman-wilson.com header.i=@goodman-wilson.com header.b="Kfc6inc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgFITBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbgFITBt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 15:01:49 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6E3C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 12:01:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id mb16so23600248ejb.4
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 12:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=goodman-wilson.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6yjqXfm1OIBmLh2R6eLL0dPI24f3aHcoh0a5Vndvcgc=;
        b=Kfc6inc0AlmRYjExjLvL1vzjwldsT4mAHIbqQUhY9QNeQlAkG7zFTro600vYp05yRt
         hRj0WPCpEMiRL9ebpJh5tdQqMWKOreXxO2yo7wQ2uPbWlgIMXjW8tlsRCBykBa6carNo
         DoiEKa3hEz3ZFEpmmDMNG+4y3f3SxKD14z6x/m2kGqR0jO3kHwBrsKAj9vRWJqHV7xCx
         7wf7+RZlkyTf5H8238ihAd5sY/cH7GAKJuMuzz7oSsZKMohHUvr2OfaOEC8b85k0Eqro
         m/yFptmrQvo70B2++WzK2WFMjS6Z6kd0be/GitP/Ojs+YHudZEjxlhodjD7+CpI+aYBv
         qCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=6yjqXfm1OIBmLh2R6eLL0dPI24f3aHcoh0a5Vndvcgc=;
        b=oQnIzowuVA4mKCKnJpQtyhmnFlZvLvq/fnSrawE4um25H+Pu9t/BL33X4rCAbNYGxH
         W2rIuIH052P5B/HhNS80MKzmPz+i+I4D8TLubVFMlSJfo8vz9nvSpdqn/oEl0wUHBj7Y
         +iBKTsCHrrKACRLfPlxsVZaqZ3NlNl5AXBPTgqUKkit9K0jEg35eoPsXcjbg01r5lUof
         XB3TX4TaXdVCbcC45k9hIFZPWh5SCKhhT+TpJsJxEhbxUopATkb6FzcIolTCDrHt/Pru
         XRyXTTBP2T+vV414oqSIkvjlQaxc6ECjB5l+2r21BXsJbNB4k+kQFpuyM7mULqegy8N+
         R7eA==
X-Gm-Message-State: AOAM530+sxts+8VHCDXIfjIeG04EXi38SUJ59DpVUo5KYOgkPsqDHwmR
        grHeWoR46Mm6lgCE1wjJBOjVpseUkj3K27c9swfxC2ThdLMAsw==
X-Google-Smtp-Source: ABdhPJxPpmjvH4pR/E0Owtt5+O70hFmiggdfeb6svDSd9wX/HJbvWDIs4rPJATo5TqIxuni/Zuvz037UOsLcr+VYmAI=
X-Received: by 2002:a17:906:fc06:: with SMTP id ov6mr28235052ejb.184.1591729307575;
 Tue, 09 Jun 2020 12:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net> <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
 <20200609160650.7e74bcjksrto3rp6@chatter.i7.local>
In-Reply-To: <20200609160650.7e74bcjksrto3rp6@chatter.i7.local>
From:   Don Goodman-Wilson <don@goodman-wilson.com>
Date:   Tue, 9 Jun 2020 21:01:36 +0200
Message-ID: <CAGA3LAcDpQQhcmaQG3+s6XNnth54KmNC+padAXXYsc5C33p7kA@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Simon Pieters <simon@bocoup.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, don@goodman-wilson.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin,

My feelings generally are: if you have to explain why it isn=E2=80=99t raci=
st,
then there=E2=80=99s probably a better alternative. But in this case it
appears the roots really are in problematic terminology.

Anyway, you=E2=80=99ll be pleased to know that as a first step, my current
work is focused on making the default branch name configurable via
`git config` or environment variables. I=E2=80=99m working on a good clean
patch for that functionality this week. I'll share more once the patch
is looking better.

Don Goodman-Wilson

On Tue, Jun 9, 2020 at 6:06 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Tue, Jun 09, 2020 at 05:16:57PM +0200, Simon Pieters wrote:
> > Thank you for your encouraging response, Brian, and the research of
> > what the change entails for git.
> >
> > I've added Don to the cc, who started to work on implementing this chan=
ge:
> >
> > https://twitter.com/DEGoodmanWilson/status/1269931743320182784
> > https://github.com/git-for-windows/git/issues/2674
> >
> > Although I think it's reasonable to move away from 'master' regardless
> > of its origin, today Tobie Langel pointed me to
> > https://mail.gnome.org/archives/desktop-devel-list/2019-May/msg00066.ht=
ml
> > where, one year ago, Bastien Nocera made the case that git's 'master'
> > is in fact a reference to master/slave.
>
> Well, he pointed out that Bitkeeper used this terminology. Git doesn't
> have any internal concept of "slave" -- the only time you see this word
> used in the codebase is in the test suite, and we should absolutely
> change that.
>
> I am torn on this issue -- I certainly want the project to be inclusive
> to all, but English has a lot of concepts that start with "master" and
> do not trace their origin to subjugation of fellow human beings:
>
> - masterpiece
> - masterful
> - master's degree
> - master copy
>
> Making this change in git seems like attacking the problem at the wrong
> end.
>
> Branch names are already fully arbitrary in Git -- you can have a repo
> without a master branch. Perhaps the best way to address it is to
> introduce a "default branch name" configuration variable, or just work
> without any default branches and let the next step after "git init" be
> "git branch".
>
> -K
