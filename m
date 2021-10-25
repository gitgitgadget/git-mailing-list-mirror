Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCD3C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 12:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B21FE603E9
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 12:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhJYMy2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 08:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbhJYMy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 08:54:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9445C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 05:52:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k7so8017023wrd.13
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 05:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=rTbJZN5Spc5+5ePcY/c5ikBzlMHdIt07PiM0BycAYk8=;
        b=BIl+BBT0Rf4EPMzmdfaR4hMPRX5qWV8MACy3SVsExPk+c5BRCnWQuqFIWQGrG1Ezvs
         SqYpQTWQFYrVhjbkMQIOyKxYwWnyug/Q3fEv8MTCKBpZ3vEsQRI4UDttVf3E5S03tH1i
         s0/iotwuE7qdmC2Tg3CdDXPEyqHTU2PNeIZ7F/fFpZ2+L0crmriKS1IJ6zEGJHDhOxdp
         MMIYZgB3M0d6nDN//99/XTqWnTMLLNXPoKpnMGGrTtihs/Ih3b3+aOrW0KIsPRBWql2y
         pnIkizr7r8vj0vC3XLUf9QzRwMXTjNYJMIiRZroWUYKLvPOvPEQmrtLSAHEc5SWpxjb9
         Uvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=rTbJZN5Spc5+5ePcY/c5ikBzlMHdIt07PiM0BycAYk8=;
        b=7QjZA5B3R3ZsnI424e4j7PG+m19cDfXZOUhQs/75ngFnMB+mCK1o5NFSHXae0Gobkt
         08Z9RI0gC1nT8EeylPnMJSjlXf87xHu5pcdnXR2UmLS58AFHzPaGO2pFSMXiSgHetNK9
         iriXk7MPRkobQDLW/f1VlbhspTS2oAlkBBuk9Jq8nsQOYHt76M86O+j+tHp69D3y7lLk
         5nR3TtbV6yEALfJq7i/8pWWF163dIK2DJE1Fri55UT2dzgPax1x2atmb2Zl/ycmoJcnO
         4VV0z3mbD2I7L+aCXfQeIvNYTS/g19Inbmcuah6rgtVamBH8X/W9H3a4B/bTmaaJ3sak
         M59g==
X-Gm-Message-State: AOAM530fRcV4LDNv3bXV3IhweBIfcQpWNFXpNUzl9PJcoV4X5v7gr0LT
        H54kZbBGmHswe6M71Ku4UFA=
X-Google-Smtp-Source: ABdhPJzY9m08VFPe1wGxXFP6B4yBFNklfPSaDWLYja+5+btYesTrl6ziFqvC4F7ZsXb04RWyJE16mw==
X-Received: by 2002:a05:6000:1841:: with SMTP id c1mr23584848wri.204.1635166324355;
        Mon, 25 Oct 2021 05:52:04 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o20sm191499wmq.47.2021.10.25.05.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 05:52:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mezSN-001X3l-CL;
        Mon, 25 Oct 2021 14:52:03 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin <git@mfriebe.de>, git@vger.kernel.org
Subject: Re: changing the experimental 'git switch'
Date:   Mon, 25 Oct 2021 14:48:47 +0200
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211150290.56@tvgsbejvaqbjf.bet>
 <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com>
 <9c6b3041-a5c0-6fe1-860e-7bfcb292ae81@mfriebe.de>
 <da952e81-70f9-886b-42ff-2ec850f55fa0@mfriebe.de>
 <xmqqwnm2418p.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqwnm2418p.fsf@gitster.g>
Message-ID: <211025.86tuh5gtcc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Oct 24 2021, Junio C Hamano wrote:

> Martin <git@mfriebe.de> writes:
>
>> So one could do
>> git switch=C2=A0 --settings-from <branch-with-reflog-and-conf> --create
>> <new-branch>=C2=A0=C2=A0 <commit>
>> git switch=C2=A0 -s <branch-with-reflog-and-conf>=C2=A0=C2=A0 -c <new-br=
anch>=C2=A0=C2=A0 <commit>
>>
>> "settings-from" is just an example, there may be better names for
>> it. Ideally not starting with a "c".
>>
>> And using a name different from "copy" may be more accurate, because
>> unless it is created on the same one <commit> to which the=20
>> <branch-with-reflog-and-conf> points, then its at best partially copied.
>
> I like the "copy the settings from this other branch when creating
> this new branch" as a concept.
>
> One thing that I find iffy is the reflog.  Even with the current
> "create a new branch NEW, pointing at the same commit, tracking the
> same remote-tracking branch, having the same branch description, and
> pretending to have come along the same trajectory, out of this
> original branch OLD", I actually find that the copyng of reflog is
> utterly questionable.  Before that operation, the new branch did not
> exist, hence NEW@{4.days.ago} shouldn't say the same thing as
> OLD@{4.days.ago} for the branch NEW that was created like so just a
> minute ago.
>
> If you generalize the operation to allow starting the new branch at
> a different commit, it becomes even more strange to copy the reflog
> of the "original" branch, which is not even the original for this
> new branch.
>
> Another thing nobody seems to have brought up is the branch
> description.  We copy everything under branch.OLD.* to branch.NEW.*
> and end up copying it from OLD to NEW, but I think that is also a
> nonsense operation.
>
> So, it probably makes sense to be more selective that what are
> sensibly copied and what are not.  Reflog most likely does not
> belong to the "sensibly copyable" set.  Tracking info most likely
> does.  Among various configuration in branch.OLD.*, there may be
> things like description that are not sensibly copyable.

It is a bit weird, but the main problem is that we'll use it for UI such
as @{-1} or whatever in addition to things like "x days ago". So if you
copy a branch for some ad-hoc testing, and were just running such a
command you might expend it to work.

For a user it also maps nicely to the mental model you'd have if you
copied two directories with the "-p" option to "cp", i.e. you'll be able
to run a "find" command on that checking mtime of N days ago and the
like.

Maybe it still doesn't make sense for those cases just some thoughts on
UX edge cases.
