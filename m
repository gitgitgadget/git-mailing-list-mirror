Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19F9C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 05:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJEFA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 01:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJEFAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 01:00:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE47A1C12B
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 22:00:23 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b2so13049389lfp.6
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 22:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=eLf1TMYXDrQOWYgPFbVV+2B11765ebqXlBrH5CWrFpI=;
        b=UMnCtEwWg+yt/W3YdEOpkCizPsfEAh1uAEVtgODYjz16aXRhUlDnE7T2/WKya/KPJJ
         p83r+njMCIsxyGFB7FoNvH+cpxT79ChEKd4cjUeLlueFXGBWc+Y3+kxEM+uSaTxrw4mz
         tD/bnCIRvlH7L5rRDAIUoKRKxt/rglrJb/ISZj33r6DkBG4d/lXM2Yz0lcqezWzBTR1e
         e1NHxrJN6E+d7JisDQfFb1jzRPZJL78TQIAH65iffeaRymv0MD4xRmvovJ2AbvgvD8ei
         p2ROIAX8mU4DSLcmz9Xcl5dZkBdMR6rfUTIt2z+PrO/MaDki9/uCLaIPhwpFCXonfMUb
         TB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eLf1TMYXDrQOWYgPFbVV+2B11765ebqXlBrH5CWrFpI=;
        b=yjJyPR8K0ATggSehOFusEWl10W/IB2BzvFlUehWIhVOIc9PiSmcn8waHuJGNd1I6X8
         JaVBQXkG9fJQRgcE+buUxU26EfgIypVZF6YWgZtEV6Z4riO2pznwe0+02/AxTon8UkBm
         fbhPhPtNpyNoY3SxhPGfsB/WjLssb/RnInDC1RHveh4rRcRgmM1beO8CVVZx3x2dzr5S
         YgdiqYu4AIKRl2yQwYQjrtS9FS/8qdZgbH2IZlh57Bp5jUv+X0kIYTP/bVoi0z8jQN8Z
         u3nvi0xyClw9Phbi+lLf0epYFeJL0VFtz3C+gKEIz05un4Klack0JuaZebz9giUBqDJc
         GE0g==
X-Gm-Message-State: ACrzQf2M8FpSJXEBZfD1zQf2odYZsfEaAayZCc+l9lR2OqwqAmmbQU/E
        5auB3VJ5rBhJq4eOZWrkoY4Ul9f+S2JaHeAi/GM=
X-Google-Smtp-Source: AMsMyM4NE3dswdBk8OxDvjEsx2LL9KQPMq3u3sXr7FY8EjjWwGv61K+Z1n9j59lOGZRBrBi5R1XLHxdkvMrFxSlKJgk=
X-Received: by 2002:a05:6512:b82:b0:4a0:5970:115c with SMTP id
 b2-20020a0565120b8200b004a05970115cmr11344180lfv.531.1664946021782; Tue, 04
 Oct 2022 22:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <kl6l35c4mukf.fsf@chooglen-macbookpro.roam.corp.google.com>
 <54ee4a2a-1937-8640-9297-8ad1516596cc@github.com> <CAESOdVAh68HoQoyicfZn4XbjGfiRFCu1zFQmUjMcSAg3tUzr4Q@mail.gmail.com>
In-Reply-To: <CAESOdVAh68HoQoyicfZn4XbjGfiRFCu1zFQmUjMcSAg3tUzr4Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 4 Oct 2022 22:00:10 -0700
Message-ID: <CABPp-BEZeKdO_UzgO=7EX0EszVsNSiiySuGT_tuhtghLBtLWOQ@mail.gmail.com>
Subject: Re: Bug report: `git restore --source --staged` deals poorly with sparse-checkout
To:     Martin von Zweigbergk <martinvonz@google.com>
Cc:     Victoria Dye <vdye@github.com>, Glen Choo <chooglen@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marin!

On Tue, Oct 4, 2022 at 10:52 AM Martin von Zweigbergk
<martinvonz@google.com> wrote:
>
> On Tue, Oct 4, 2022 at 9:34 AM Victoria Dye <vdye@github.com> wrote:
>>
>> Glen Choo wrote:
>> > Filing a `git bugreport` on behalf of a user at $DAYJOB. I'm also pret=
ty
>> > surprised by this behavior, perhaps someone who knows more could shed
>> > some light?
>> >
>> > What did you do before the bug happened? (Steps to reproduce your issu=
e)
>> >
>> >   git clone git@github.com:git/git.git . &&
>> >   git sparse-checkout set t &&
>> >   git restore --source v2.38.0-rc1 --staged Documentation &&
>> >   git status
>> > ...>
>> > What happened instead? (Actual behavior)
>> >
>> > I saw a staged modification (Documentation/cmd-list.perl) and the same
>> > file reported as deleted in the working copy. Specifically,
>> >
>> >   $ git status
>> >
>> >   On branch master
>> >   Your branch is up to date with 'origin/master'.
>> >
>> >   You are in a sparse checkout with 64% of tracked files present.
>> >
>> >   Changes to be committed:
>> >     (use "git restore --staged <file>..." to unstage)
>> >           modified:   Documentation/cmd-list.perl
>> >
>> >   Changes not staged for commit:
>> >     (use "git add/rm <file>..." to update what will be committed)
>> >     (use "git restore <file>..." to discard changes in working directo=
ry)
>> >           deleted:    Documentation/cmd-list.perl
>> >
>>
>> Thanks for reporting this! There are a few confusing things going on wit=
h
>> 'restore' here.
>>
>> First is that the out-of-cone was even restored in the first place.
>
>
> I was actually happy that the out-of-cone paths were restored. I ran that=
 command as an experiment while reading Elijah's doc because I was curious =
what would happen. The reason I think it should restore out-of-cone paths i=
s so you can do `git restore --staged --source <some commit> && git commit =
-m "restore to old commit"` without caring about the sparse spec.

I think that could lead to something that would be very dangerous or
highly confusing to other users.  In particular, if they run

  `git restore --staged --source <some commit> -- '*.rs'`

and git changes not only all the Rust files inside the sparsity
specification (i.e. the files they are interested in), but all the
ones outside too, then they'll be rather unhappy.  So, I think if the
paths you specify aren't within the sparse specification, we should
throw an error, much like we already do with `git add` and `git rm`
when in a sparse checkout.  And if you don't care about the sparse
spec despite having set up a sparse checkout, you can always specify
that (with --no-restrict or --scope=3Dall or whatever).

>> Theoretically, 'restore' (like 'checkout') should be limited to pathspec=
s
>> inside the sparse-checkout patterns (per the documentation of
>> '--ignore-skip-worktree-bits'), but 'Documentation' does not match them.
>> Then, there's a difference between 'restore' and 'checkout' that doesn't
>> seem intentional; both remove the 'SKIP_WORKTREE' flag from the file, bu=
t
>> only 'checkout' creates the file on-disk (therefore avoiding the "delete=
d"
>> status).
>
>
> Restoring only into the index (as I think `git restore --staged` is suppo=
sed to do) is weird. Let's say we do a clean checkout of a commit with tree=
 A (i.e. the root tree's hash is A). If we do `git sparse-checkout set non-=
existent`, the index and the working copy still logically contain state A, =
right? If we now do `git restore --staged --source HEAD^` and that command =
doesn't remove the `SKIP_WORKTREE` flag on any paths, that logically means =
that we have modified the working copy, and I think `git sparse-checkout di=
sable` would agree with me. That's different from how `git restore --staged=
` without sparse-checkout would have worked (it would not have updated the =
working copy). So from that perspective, it might make sense to remove the =
`SKIP_WORKTREE` and add the old file contents back in the working (i.e. fro=
m state A in this example), and maybe that's why the commands do that? Actu=
ally, `git checkout HEAD^ .` would update both the index and the working co=
py to match HEAD^, so that shouldn't have to remove the `SKIP_WORKTREE`, ma=
ybe?

Yes, you've flagged this correctly as an issue, but I think only
touching files within the sparse specification is much safer and
throwing an error telling the user what flag to add if they specified
a path outside the sparse specification would be better.

Now, if they do provide the override...then your question becomes
valid.  My inclination there is that they provided --staged without
--worktree and provided an override so although they'll get weird
results (much as they also would with git-add or git-rm when they
override) we just follow what they said and only update the index and
leave the file as SKIP_WORKTREE.

> I barely ever use Git, so take all that with a grain of salt.
>
>>
>> Elijah's WIP design doc [1] describes 'restore' as one of:
>>
>> > commands that restore files to the working tree that match sparsity
>> > patterns, and remove unmodified files that don't match those patterns
>
>
> I *think* that only applies to `git restore` without `--staged`.

Yeah, you brought up a really good example here.  I think `restore`
and `checkout -- <paths>`  should probably be better grouped with
add/rm/mv
