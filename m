Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCC6C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 14:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241867AbhK3OF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbhK3OF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 09:05:27 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F81C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 06:02:08 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v1so87082809edx.2
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 06:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=36sKn9H6CgjF+7dkYY+DBdQ3nqm4mCTyqVvijIFEH/w=;
        b=aFZjgtGgnOTa96R+zDqeqX38t2/ZdJD0Zwy23jxqWn4HfD/Zehw/2T3QcgSKwoN+fS
         vLEESXmzY10/MGx0wUlY1YnXkN8r6PsrVGog6IXnuwACdeTBz+mG1giXmFd5AS145nwI
         GMyLtlQv21HvD+s2MKnDXpE0GGWe0R3ug/9SbbWOx/2xxnCYPL64Xvyo0m6c1cRkxmc9
         6oYiyr3mss3fWH27Kg+nUArz7uUYDAahm0R0zesZH0zn24H8otyXOTrY7YWchO15DxmT
         swFJb8ohI7JNQ1s237RGfgIL3rmJHQeNLbuErLxDnhBxUMkBGv0sdTkA6GEZ7TYXfK/y
         WQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=36sKn9H6CgjF+7dkYY+DBdQ3nqm4mCTyqVvijIFEH/w=;
        b=zaY8lqqRTKBWi4WbGVqCzuqDCpgsrmxfKFbqSsaxigKDJuesvm7zWoEKrpqudbGFz+
         lszCH62wZNpsJPycn2oMX0ifIE0CkQoZ9+wauiCq1Ns078xZUMcIqZX/HQDkZ1CGlvZv
         saSnhCgnFTGu5Rqt6aaJRWoPVtBe7EMYLN+mTySvZL7tH5+KeWLBsGfxPr/S+zyKoaXC
         bCAqxSwrsXIDynxItpY3X3CPbOgWCO+jhGqO3bGn9jvlGTZV7amHCKsNfunGBWtxAEmD
         b7R1Kozv+E/2gF6BOnOblNRoTvNV9/jdwj4Gyr9QCLU1eh8G/E0Jyky3dfqahwahMs8x
         CkyQ==
X-Gm-Message-State: AOAM532jcXuX4x8z3kACCZxQJTkm2AvspbFsN7Wjq6kqvqbMSGWlF6ux
        Z3yVGTuFBaa/HdN3RtDBODg=
X-Google-Smtp-Source: ABdhPJxzzdGUySdB3gBpbGL5PKYJGliLlNVR04VtYcl1WMBBtAxgC888P8izUw4aI+6Gnj7UUPQPTw==
X-Received: by 2002:a17:907:94ce:: with SMTP id dn14mr69087204ejc.85.1638280924520;
        Tue, 30 Nov 2021 06:02:04 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a17sm11219470edx.14.2021.11.30.06.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:02:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ms3hr-0010t9-KH;
        Tue, 30 Nov 2021 15:02:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Anselm =?utf-8?Q?Sch=C3=BCler?= <mail@anselmschueler.com>,
        git <git@vger.kernel.org>
Subject: Re: patch: change =?utf-8?Q?=E2=80=9CEverything_up-to-date?=
 =?utf-8?Q?=E2=80=9D?= to =?utf-8?Q?=E2=80=9CAlready?= up to =?utf-8?Q?dat?=
 =?utf-8?Q?e=2E=E2=80=9D?=
 (No-op messages for git-push and git-pull)
Date:   Tue, 30 Nov 2021 14:55:47 +0100
References: <VUYC3R.9YCVE0AMVVIF@anselmschueler.com>
 <CAPig+cRRxYmFqYimTHSi9uzmWU0FRXQ2hGXJK6jYLJcsFce_Rw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CAPig+cRRxYmFqYimTHSi9uzmWU0FRXQ2hGXJK6jYLJcsFce_Rw@mail.gmail.com>
Message-ID: <211130.86a6hleo84.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 29 2021, Eric Sunshine wrote:

> On Mon, Nov 29, 2021 at 7:04 PM Anselm Sch=C3=BCler <mail@anselmschueler.=
com> wrote:
>> Why are the no-op messages for git-push and git-pull (i.e. when remote
>> and local are identical) so different, while describing something very
>> similar? IMO the messages should be either identical or very similar.
>> git-pull results in =E2=80=9CAlready up to date.=E2=80=9D, while git-pus=
h results
>> in =E2=80=9CEverything up-to-date=E2=80=9D.
>>
>> It should be considered that other messages reading =E2=80=9CAlready up =
to
>> date.=E2=80=9D seem to use a translation system, it might be better to u=
se
>> that system here, too. Unfortunately, I don=E2=80=99t know how to do that
>> (currently). At any rate, this patch could serve as a temporary
>> =E2=80=9Cfix=E2=80=9D.
>
> This question/issue is raised from time to time, and the short answer
> is that send-pack is plumbing, thus there likely will be resistance to
> an arbitrary change of text. Denton goes into a bit more detail in his
> reply[1].
>
> [1]: https://lore.kernel.org/git/20191122180433.GA57478@generichostname/

Yes, but this isn't really applicable to what Anselm really wants to
change.

Here, i.e. yes the builtin/send-pack.c part of his patch mayb e suspect,
but we can simply skiip that and change the transport.c part, it's API
that only builtin/push.c uses.

Currently transport_push() returns -1 or 0. I think the best change
there would be to chang it and its callers to return an enum, so we
could have it indicate whether it pushed anything or not.

Probably even better would be to make it stop printing output entirely,
and to merely have the "struct ref *" of remote refs returned to the
caller. Then the caller could do the equivalent of
transport_refs_pushed() itself.

I.e. we might want to print these in various mixtures of these
scenarios:

    Already up-to-date
    Pushed all requested refs
    Pushed X/Y refs, Y-X were already up-to-date

Anselm: If you're interested in following-up please read
Documentation/SubmittingPatches, i.e. send your patch with
git-send-email or another method that doesn't send the patch as an
attachment.
