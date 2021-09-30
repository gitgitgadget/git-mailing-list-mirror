Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075F7C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 05:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1FA61423
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 05:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347988AbhI3FH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 01:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347971AbhI3FH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 01:07:56 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984E3C06176A
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 22:06:14 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 188so5890242vsv.0
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 22:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kcg0FBLNTpPiDeEOscRb1RTo2jS57Uh95l8hzNIHKDI=;
        b=Zf5OAOHrFhAOlG4apRIyfu/1o04sgkWWfE8Swdqkeib1CCAc7Ckamr/rjK0ZXSDyON
         Kvnx9YQ34nJ0Tr/ylpTGdM3XSUV4T5yxweGaB5S8zonhXLLcj4vEgSZvDSm1gnGnF6VY
         T4wH4ASeTKJDfutTzxfSXi95teaJTQ3cI2vbji4MqInOhStGvd6/Y/ijEgAvpOFsiIhO
         2NujlEdXDAWLDNXSb9cgblCNyKgoAcc9ERjR232TeXF5WaigRJReiGWpYYC30jWHuF9s
         aNmLnzf3D3cJpxOVtB+c2SLtYAEml+qoFGQPSUJKaxwcVFfKGKdGABOUHdQq91Ids2kp
         g9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kcg0FBLNTpPiDeEOscRb1RTo2jS57Uh95l8hzNIHKDI=;
        b=CeZNFi+SOJKUTiS//WBK/KDxaA393C8uiBOv09ub+sJ56VhI/d2vjxmc/SiIkmA4jD
         oSQRUnl4tkjh+yqpt8Li8iYBjunz3f6cFsnbl8FnFm8CUqjIrveXqJgYurKlDJLyEd8+
         8uGIp/bs5V8LTo96BNMpH1VR8yGchOssb9mMr4x3vNNvyj4aFzwHYYZDuTfcEyrHGcA5
         oU9JATvlcs69wvAuD78MZo0nqnLO+g+hH/6mGjOvPO4sVnDb+a2CYgXYYxREsEkDocap
         icQ4+B7QtYpbC7bXMFhWHCTG98WYitPM/nExdrBs0xNO5WyQgYLh4dEeqFPf9aSkUxgK
         BsnA==
X-Gm-Message-State: AOAM532x3jBieZKJ+IDuvNmZrskZlB6RXYL/R+tzpW/qnHSkHwx06wqW
        xT4ESqIj3mnPzyshaFXNVXZbaXF4QuhrUBRlOwI=
X-Google-Smtp-Source: ABdhPJzzVjJQwUWQUWi7Or7/mBrvhVMKQITJqMEzsNqaOyh5FBk7dFER/HqA/5/coKYkYDZoZd/gvJTt23GGuuftJV0=
X-Received: by 2002:a05:6102:1d4:: with SMTP id s20mr1815161vsq.3.1632978373579;
 Wed, 29 Sep 2021 22:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8rzhmsi7.fsf@gitster.g> <871r59xfgk.fsf@evledraar.gmail.com> <CAFQ2z_NxqLVfSWNtcXdyWQsTXrTrWGq7Qof=wdx9mmeqOAJS_Q@mail.gmail.com>
In-Reply-To: <CAFQ2z_NxqLVfSWNtcXdyWQsTXrTrWGq7Qof=wdx9mmeqOAJS_Q@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 29 Sep 2021 22:06:02 -0700
Message-ID: <CAPUEspj6q_N-ZPRzUv8jx_5_eP0gDO5TyTpi5-kPkfeoVhkjvg@mail.gmail.com>
Subject: Re: hn/reftable (Re: What's cooking in git.git (Sep 2021, #08; Mon, 27))
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        ramsay@ramsayjones.plus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 5:19 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
> On Tue, Sep 28, 2021 at 10:38 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> > > * hn/reftable (2021-09-10) 20 commits
> > >  - fixup! reftable: implement stack, a mutable database of reftable f=
iles.
> > >  - Add "test-tool dump-reftable" command.
> > >  - reftable: add dump utility
> > >  - reftable: implement stack, a mutable database of reftable files.
> > >  - reftable: implement refname validation
> > >  - reftable: add merged table view
> > >  - reftable: add a heap-based priority queue for reftable records
> > >  - reftable: reftable file level tests
> > >  - reftable: read reftable files
> > >  - reftable: generic interface to tables
> > >  - reftable: write reftable files
> > >  - reftable: a generic binary tree implementation
> > >  - reftable: reading/writing blocks
> > >  - Provide zlib's uncompress2 from compat/zlib-compat.c
> > >  - reftable: (de)serialization for the polymorphic record type.
> > >  - reftable: add blocksource, an abstraction for random access reads
> > >  - reftable: utility functions
> > >  - reftable: add error related functionality
> > >  - reftable: RFC: add LICENSE
> > >  - hash.h: provide constants for the hash IDs
> > >
> > >  The "reftable" backend for the refs API, without integrating into
> > >  the refs subsystem.
> > >
> > >  Will merge to 'next'?
> >
> > I think we've reached approximately "good enough" with this for the nex=
t
> > steps, and can hopefully fix any remaining nits (such as my [1])
> > post-merge.
>
> There is still an RFC in 02/19. Maybe we can get agreement that this
> is OK and drop the RFC ?
>
> > Maybe hold off until Han-Wen gets a chance to ack it, and whether he's
> > ok with the proposed fixup(s)?
>
> regarding uncompress2: I thought it was functionality best left to
> zlib to implement, but I imagine git.git offers something similar.
> Sounds good to use that.
>
> > Wasn't there an outstanding "some of this in reftable/* should be stati=
c
> > functions" from someone, Carlo? (CC'd). In any case that sort of thing
> > could also be a post-cleanup, I couldn't find a reference to that
> > discussion in anything except my vague memory of it as I wrote this.
>
> I think I have addressed all outstanding issues in my github PR, and
> I'll send it out once I see CI pass.

It was actually raised by Ramsay[1], and might have been a red herring,
but there was for sure no follow up.

I have a few minor fixups that will post for discussion, and might be even
ok to merge to next without squashing if included on top, but I am not
sure if all those issues could be addressed post-cleanup, since IMHO
once this gets into master, then it will be considered a stable API
and it can't be changed.

For example. while looking at Ramsay message noticed the API for "reader"
in libreftable might be better with s/init_reader/reader_init/g

Carlo

[1] https://lore.kernel.org/git/bc387e32-321e-4726-2a02-2e6cf6ed5250@ramsay=
jones.plus.com/

CC +Ramsay
