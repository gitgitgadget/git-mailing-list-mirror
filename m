Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19F3C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 08:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbiCNI1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 04:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiCNI1H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 04:27:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950C811A06
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 01:25:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kt27so32190791ejb.0
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 01:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TZH1lGF2NR0bo8Lgu7ebxMixFoG0fpL+Jkk4BOi+a3Q=;
        b=vBeUv3prONXkY1e7cdtvSEPZaUrO90BEumDrfNHu7ReHn9wnwiPLQ4+21+fkyd/i3p
         OkyVtCgV8TZBALoKJXuIDYDnZ6JRqtAifpXrUTUiEnj7vMBawZGnZHB2c3aJzZk9K03u
         oJBX4wtUw8ulSzaGR2bGk5vykDPVXB5ys7fDulTV/wRiChWH6Dxfk+f+Gc71idbDz3TE
         NiZqzFXI1AJKu4UvFR/52jBsvdI5OqbeJ9HPfT+b9zAgSx/Ywg04lRiAR4w5jhTlL1fw
         ILTutRPzQBVKrE0e6Kkmiie5armZpLLBKuMS1ud4TuzGSaF4wMvMZFMOl4K7TRHgSDts
         ZHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TZH1lGF2NR0bo8Lgu7ebxMixFoG0fpL+Jkk4BOi+a3Q=;
        b=PJqDunANWIw5G1EpMHU3KmbrGTIWSS7iCDTt8EBJrICR6Lzf889Zp3DFpN4+ku1NHE
         P8BwzF9xTAesU2gD8QOUHUzGlfl++FOC+DFe2gAaLnBn27TlP4WlcIshP/F7e33J/U9G
         tOUEXPaPkD5W2qvBKA4EIb1CBX56dHI4TVjSsfDBEp21Q0tDE2LUruzTFgVVcVoYcDMp
         VuuiQJHVRx+3w/YUIpC5Vw1swdeM8W78f1/bWcNU6QUqPcZ/xcx/wvBwh6C7NPs2RNGA
         HRlwEl5muaR0hy5dCFdVNDtfo/DaXo4UyU0pRb8lUksPjrZQFvbq0WCI7OmiezeJi/hp
         Y8Jg==
X-Gm-Message-State: AOAM533N2LTeWQKtimBAOWAPoATZpZ81VlWnfLoA3qwOl9ZVU+FI1iKG
        AFEGpKofiBuzu6WdFY47buPKIDzGjvuoFjeDsbGHXg==
X-Google-Smtp-Source: ABdhPJy2oiZPI0uPXN6rq5uvyqmc3iaZbHO8J7BXkTRNbKTpPUGikH6lEokDwf2BMtlhyL3+bisK/Q1d0Zz3ZXPNhP8=
X-Received: by 2002:a17:906:d54f:b0:6db:af13:dd8c with SMTP id
 cr15-20020a170906d54f00b006dbaf13dd8cmr11125390ejc.540.1647246357084; Mon, 14
 Mar 2022 01:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpog=qBwLrxss_ci6ZMM+AjbdrF8tszXLW7YH1Zqr+m7mPQ@mail.gmail.com>
 <CAFQ2z_Oht=-QrzoH8FW_Jm-B7u9O0wXUaY-ifwZah6gkcgVVSA@mail.gmail.com> <220308.868rtky4q8.gmgdl@evledraar.gmail.com>
In-Reply-To: <220308.868rtky4q8.gmgdl@evledraar.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 14 Mar 2022 09:25:40 +0100
Message-ID: <CAPMMpoiDTprbf_9J3gY6WQwUVWfOTms6LVyJDYQUOcUp-42doA@mail.gmail.com>
Subject: Re: Keep reflogs for deleted (remote tracking) branches?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 8, 2022 at 2:05 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Tue, Mar 08 2022, Han-Wen Nienhuys wrote:
>
> > On Tue, Mar 8, 2022 at 12:28 PM Tao Klerks <tao@klerks.biz> wrote:
> >> As far as I can tell, even "core.logAllRefUpdates=3Dalways" does *not*
> >> keep any reflog entries around, even temporarily (until reflog
> >> expiry), once a ref  is deleted - do I understand that correctly? Is
> >> this behavior intentional / reasoned, or just a consequence of the
> >> fact that it's *hard* to keep "managing" per-branch reflogs for
> >> branches that don't exist?
> >>
> >> I am planning a workaround using server hooks to "back up" refs that
> >> are being deleted from specific namespaces, in my specific case, and I
> >> imagine that a system like github keeps track of deleted stuff itself
> >> for a while, but I find this "per-ref reflog disappearance" behavior
> >> puzzling / out-of-character, so wanted to make sure I'm not missing
> >> something.
> >
> > I think this behavior is motivated by directory/file conflicts. If you
> > have a reflog file in refs/logs/foo, you can't create a reflog for
> > refs/foo/bar, because that would live in refs/logs/foo/bar
> >
> > At Google, we keep reflogs in a completely different storage system
> > altogether, which avoids this problem, and I wouldn't be surprised if
> > other large hosting providers do something similar.

This is interesting - so at google is the assumption that the storage
system, whatever it looks like, *does* keep reflogs for deleted
branches? Or at least backs up states that get force-pushed out of
existence?

>
> I once worked on a system where:
>
>  * References would be "archived", i.e. just a backup system that would
>    run "git fetch" without pruning.
>
>  * You were only allowed to push to either existing branches like
>    "master", or names with exactly one slash in them, e.g. "avar/topic",
>    not "avar/topic/nested", for that you'd need "avar/topic-nested" or
>    whatever.
>
> The second item neatly avoids D/F conflicts, at the cost of some
> grumbling from people who can't use their preferred branch name.
>
> And you can easily implement backups without that constraint by fetching
> refs/* to refs/YYYYMMDD-HHMMSS/* or whatever, and have some manual
> pruning process in place for those "secondly refs".

Ah right, backing up into another system - I guess we could...

>
> More generally I have not really run into this as a practical
> problem.

That's fair, nor have I - but I *have* come reasonably close: one
person accidentally deletes a branch that someone else had prepared
*without even realizing*, and the initial author is not available, and
I only find out about it a few hours later. Dangling commit hunt, here
we come. (the original author became available and re-pushed before it
came to that)

>
> Another way to solve a similar problem is to have
> pre-receive/post-receive hooks log attempted/successful pushes, which
> along with an appropriate "gc" policy will allow you to manually look up
> these older branches (or even to fetch them, if you publish the log and
> set uploadpack.allowAnySHA1InWant=3Dtrue).

Yep, that's closer to my expected plan, thanks - my intent is to back
up, on force-push and/or deletion, into a specific refspace with a
cleanup policy, using a server hook. So after something is "deleted"
(or force-pushed away), it can be easily recovered for a period of eg
3 months in that refspace, eg
"refs/force-push-backups/YYYY-MM-DD-<BRANCHNAME>-<HASHPREFIX>".

My question is specifically about the, in my opinion, very surprising
behavior of deleting reflogs along with deleted branches - I mainly
provided the example use-case for context.
