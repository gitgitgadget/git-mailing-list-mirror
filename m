Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0D4C433E2
	for <git@archiver.kernel.org>; Tue, 26 May 2020 19:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0AB20776
	for <git@archiver.kernel.org>; Tue, 26 May 2020 19:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1Ay0+ka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392044AbgEZTUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 15:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391720AbgEZTUb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 15:20:31 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41883C03E96D
        for <git@vger.kernel.org>; Tue, 26 May 2020 12:20:31 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id b13so7614786uav.3
        for <git@vger.kernel.org>; Tue, 26 May 2020 12:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+svjRmYsPVUDNo4M6i2RaP0GNxaW1pqXhWeTLbQmeJg=;
        b=K1Ay0+kaeNe/8QEm3t9si2j5nTL113E9QOJxli2MIo5ap9vAf3D+hsivkXa7UciTVL
         CBvzy3OhGrejwHUSB3wUHE9MSx+lK4TVtNIyjPgtXenQjnns/VWyNW1i7EwcRJdcnGW/
         ixYXeGUtJjofAteaIhc3wg6vexkKf/VKJimKj/IT+tOoQksg2voVeuusVb2oyck5V/8h
         jgz6PwNkAw7PZB1MWYqrBuVmMI2ltwdkje6LDI2CrADrBJ1MPxeF4pHqiXfAbZHLO3n2
         51TxjEBClaaleny9sG9oMhr40UcV7an/IfXfhGNOyOt2w5+jplIGqDBe/RdPts+saQuY
         UZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+svjRmYsPVUDNo4M6i2RaP0GNxaW1pqXhWeTLbQmeJg=;
        b=SaEehTnJ5O8rtTByO0aLgC9t79tJi3KdTmGtdyC24MrTGsBdmslsejUiwD5h6yfZlG
         C/SjiHbuTDmFdBP0Ps6sN7npyIupfJa2mTbbE551XzzylOSFfTv61fMK1Af1XqZwcEBj
         fvEoXRC6CG+Po5YHoXld1zbw4AZ5brJjM5CYCHRjbbV8jHRL1Bi0ym+ud+qYAI3J86jS
         03f3YAt8id3RRAA9auKMpRjURYJie1pZq47FnRDm3z39uvtqNqSbDJTB7CTesg5w5VJW
         Q0xDm61X8rOeJL/4IfDmJqz2p24AY02kxrTaj1xs4loFc8xwRFxIpzkeTTQ9S0mqfd8B
         saaQ==
X-Gm-Message-State: AOAM532fkxU9SlsfWnDs6aaV3j0MYT/Xgnh2OtPFVh4yV3cCD5e495iO
        rhSo9Tf03eEnsIfRuLbr5RUXH/f2EDppBlKOuUlA4911
X-Google-Smtp-Source: ABdhPJx+KXXbFZJk5W3Mcr6dSjEaCb+Pm9bJryHU2+/mzx2BE5+RqhAY6gjXSX+w9dq/7b+GYZvLHfx4X/z2RM7AU28=
X-Received: by 2002:ab0:1e4:: with SMTP id 91mr2121952ual.112.1590520830439;
 Tue, 26 May 2020 12:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqsgfx0z9k.fsf@gitster.c.googlers.com> <20200525170607.8000-1-martin.agren@gmail.com>
 <xmqqv9kiohfv.fsf@gitster.c.googlers.com> <474bbf51-bd40-837a-77de-1688f6488ae3@gmail.com>
In-Reply-To: <474bbf51-bd40-837a-77de-1688f6488ae3@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 26 May 2020 21:20:19 +0200
Message-ID: <CAN0heSp-D8qfKzDfBYxLA-76v=E_VgKWtfitCFb8DdWiHqMDmw@mail.gmail.com>
Subject: Re: [PATCH v2] rev-list-options.txt: start a list for `show-pulls`
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 26 May 2020 at 19:01, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/26/2020 11:16 AM, Junio C Hamano wrote:
> > Martin =C3=85gren <martin.agren@gmail.com> writes:
> >
> > This is not a new issue introduced by this patch, but ...
> >
> >> +--show-pulls::
> >> +    In addition to the commits shown in the default history, show
> >> +    each merge commit that is not TREESAME to its first parent but
> >> +    is TREESAME to a later parent.
> >>  +
> >> +When a merge commit is included by `--show-pulls`, the merge is
> >>  treated as if it "pulled" the change from another branch. When using
> >>  `--show-pulls` on this example (and no other options) the resulting
> >>  graph is:
> >
> > ... "is treated AS IF" somewhat made me go "huh?"; with or without
> > the option, the merge did pull the change from another branch,
> > didn't it?  The only effect the option has is to make that fact
> > stand out in the output.
>
> I guess the 'as if it "pulled" the change from another branch' sentence
> is literally talking about the "git pull" command, as opposed to the
> "git merge" command, or creating the merge upon completion of a pull requ=
est
> on a Git service (which is almost always using libgit2 to generate a merg=
e
> commit).
>
> Perhaps there is no semantic difference between "pulling" and "merging"
> and then this could be reworded to be less awkward.

Agreed on the awkwardness as it stands (before or after this proposed
patch). I don't have any concrete thoughts to offer though.

Martin
