Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C844C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 20:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B83C611F2
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 20:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhKJUp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 15:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbhKJUp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 15:45:27 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC20C061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 12:42:26 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r12so15465140edt.6
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 12:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=VqEMFORkGlzzIQ4tasa9ys8MIKfLQb8GuDG5Wr5wlHg=;
        b=Bll6DAwl63XRZljs/Zin26mF0pDraXiz0Hcz6DnsPNGFB8n5QkeP0nst8fnypjRlOj
         iUjQkwmzQSVdVLsKvU8qVIPmEXZUXK8jgvzB6Bb+IOZwARbzlhlEIX3kn4r+3sat6Qol
         6YUe3iWgMIuY1ydklHk7ZA8tE1/bg03B2GzaRVvPBiKF3Wc0AUF+U9eiBc76rA/iSw0F
         9xC5HfFFJZ6aajq8Rew3mFp7yK4AnnZ4pRwDsOGLCiPJmol0w2stcAPDfIvw3vTSEF1q
         31jnakwzmKvcWfVMIT3368TVdLtbzEUbxcRS3WQuYWuIH9WzYtT4VTS/8l7uwFFq4oO8
         YfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=VqEMFORkGlzzIQ4tasa9ys8MIKfLQb8GuDG5Wr5wlHg=;
        b=hUIohH1GA9lQmXuOAIMFlO/Agl4Y0YXT5MiCJWcWOnV0GL46fyllnEPcEAV4ltwVYq
         i/FztDDTbAVvOIJB1imMkIo6JqHEQp+sKg/pn3/hl4LKSQtS6LT38JglqAivNHfDds8z
         6kw1RBXQQkaZYubLGchXCnyfXigklNd45X32xELGFO3ZPXiwUqhdjgDTeABFSsd5lu8c
         4yF7xPgdyiVxHjjdwpa7k4AFEanXaU1FlPu6etMaiNgY6P7ke4LUyvtKAsj6f/GDB3jh
         T7xDKLToSc4nw4HNk6f9rZPoc645uMlPD8lV224Vtv2Y4dRDiPpyBv9xJnkVXTEUtDlb
         CZyw==
X-Gm-Message-State: AOAM532PQP+9vbrZG2P5s7y2KAPoAeDQ9i6O+KL3lj3RtLJqs9RaD4Uo
        xZuARBeR+ZEBSXlj31bWbU4=
X-Google-Smtp-Source: ABdhPJzLxEGZIS1PMaAZ2BM+svrcs5lwny0RwAZBXRzDuJZ3cURyMi307AebF+brJzcO62fFkQo+Jg==
X-Received: by 2002:aa7:c693:: with SMTP id n19mr2358646edq.101.1636576944701;
        Wed, 10 Nov 2021 12:42:24 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gn26sm388847ejc.14.2021.11.10.12.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:42:24 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkuQJ-000525-ES;
        Wed, 10 Nov 2021 21:42:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 3/3] refs: add configuration to enable flushing of refs
Date:   Wed, 10 Nov 2021 21:23:04 +0100
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <cover.1636544377.git.ps@pks.im>
 <d9aa96913b1730f1d0c238d7d52e27c20bc55390.1636544377.git.ps@pks.im>
 <211110.86v910gi9a.gmgdl@evledraar.gmail.com>
 <20211110191533.GA484@neerajsi-x1.localdomain>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211110191533.GA484@neerajsi-x1.localdomain>
Message-ID: <211110.8635o3rbdc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 10 2021, Neeraj Singh wrote:

> On Wed, Nov 10, 2021 at 03:49:02PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Wed, Nov 10 2021, Patrick Steinhardt wrote:
>>=20
>> > +	shutdown. This setting currently only controls loose refs in the obj=
ect
>> > +	store, so updates to packed refs may not be equally durable. Takes t=
he
>> > +	same parameters as `core.fsyncObjectFiles`.
>> > +
>>=20
>> ...my understanding of it is basically a way of going back to what Linus
>> pointed out way back in aafe9fbaf4f (Add config option to enable
>> 'fsync()' of object files, 2008-06-18).
>>=20
>> I.e. we've got files x and y. POSIX sayeth we'd need to fsync them all
>> and the directory entry, but on some FS's it would be sufficient to
>> fsync() just y if they're created in that order. It'll imply an fsync of
>> both x and y, is that accurate?
>>=20
>> If not you can probably discard the rest, but forging on:
>>=20
>> Why do we then need to fsync() a "z" file in get_object_directory()
>> (i.e. .git/objects) then? That's a new "z", wasn't flushing "y" enough?
>>=20
>> Or if you've written .git/objects/x and .git/refs/y I can imagine
>> wanting to create and sync a .git/z if the FS's semantics are to then
>> flush all remaining updates from that tree up, but here it's
>> .git/objects, not .git. That also seems to contract this above:
>
> We're breaking through the abstraction provided by POSIX in 'batch' mode,
> since the POSIX abstraction does not give us any option to be both safe
> and reasonably fast on hardware that does something expensive upon fsync(=
).
>
> We need to ensure that 'x' and 'y' are handed off to the storage device v=
ia
> a non-flushing pagecache cleaning call (e.g. sync_file_ranges or macOS fs=
ync).
> Then creating and flushing 'z' ensures that 'x' and 'y' will be visible a=
fter
> successful completion. On FSes with a single journal that is flushed on f=
sync,
> this should also ensure that any other files that have been cleaned out o=
f the
> pagecache and any other metadata updates are also persisted. The fsync pr=
ovides
> a barrier in addition to the durability.

Yes. I understand that we're not doing POSIX fsyncing().

I'm asking about something else, i.e. with this not-like-POSIX-sync why
it is that when you have a directory:

    A

and files:

    A/{X,Y}

That you'd write those two, and then proceed to do the "batch flush" by
creating and fsync()-ing a:

    B/Z

As opposed to either of:

    A/Z

Or:

    Z

I.e. why update .git/refs/* and create a flush file in .git/object/* and
not .git/refs/* or .git/*?

Maybe the answer is just that this is WIP code copied from your
.git/objects/ fsync() implementation, or maybe it's more subtle and I'm
missing something.

>> >       ensure its data is persisted. After all refs have been written,
>> >       the directories which host refs are flushed.
>>=20
>> I.e. that would be .git/refs (let's ignore .git/HEAD and the like for
>> now), not .git/objects or .git?
>>=20
>> And again, forging on but more generally [continued below]...
>>=20
>> > +	if (!strcmp(var, "core.fsyncreffiles")) {
>>=20
>> UX side: now we've got a core.fsyncRefFiles and
>> core.fsyncWhateverItWasCalled in Neeraj series. Let's make sure those
>> work together like say "fsck.*" and "fetch.fsck.*" do, i.e. you'd be
>> able to configure this once for objects and refs, or in two variables,
>> one for objects, one for refs...
>>=20
>
> I agree with this feedback. We should have a core.fsync flag to control e=
verything
> that might be synced in the repo.  However, we'd have to decide what we w=
ant
> to do with packfiles and the index which are currently always fsynced.

*nod*. See this if you haven't yet:
https://lore.kernel.org/git/211110.86r1bogg27.gmgdl@evledraar.gmail.com/T/#u

>> ...[continued from above]: Again, per my potentially wrong understanding
>> of syncing a "x" and "y" via an fsync of a subsequent "z" that's
>> adjacent on the FS to those two.
>
> I suspect Patrick is concerned about the case where the worktree is on
> a separate filesystem from the main repo, so there might be a motivation
> to sync the worktree refs separately. Is that right, Patrick?

But he's syncing .git/objects, not .git/worktrees/<NAME>/refs/, no?

>>=20
>> Isn't this setting us up for a really bad interaction between this
>> series and Neeraj's work? Well "bad" as in "bad for performance".
>>=20
>> I.e. you'll turn on "use the batch thing for objects and refs" and we'll
>> do two fsyncs, one for the object update, and one for refs. The common
>> case is that we'll have both in play.
>>=20
>> So shouldn't this go to a higher level for both so we only create a "z"
>> .git/sync-it-now-please.txt or whatever once we do all pending updates
>> on the .git/ directory?
>>=20
>> I can also imagine that we'd want that at an even higher level, e.g. for
>> "git pull" surely we'd want it not for refs or objects, but in
>> builtin/pull.c somewhere because we'll be updating the .git/index after
>> we do both refs and objects, and you'd want to fsync at the very end,
>> no?
>>=20
>> None of the above should mean we can't pursue a more narrow approach for
>> now. I'm just:
>>=20
>>  1) Seeing if I understand what we're trying to do here, maybe not.
>>=20
>>  2) Encouraging you two to think about a holistic way to configure some
>>     logical conclusion to this topic at large, so we won't end up with
>>     core.fsyncConfigFiles, core.fsyncObjectFiles, core.fsyncIndexFile,
>>     core.fsyncRefFiles, core.fsyncTheCrapRebaseWritesOutFiles etc. :)
>>=20
>> I'll send another more generic follow-up E-Mail for #2.
>
> In my view there are two separable concerns:
>
>     1) What durability do we want for the user's data when an entire 'git'
>        command completes? I.e. if I run 'git add <1000 files>; git commit=
' and the
>        system loses power after both commands return, should I see all of=
 those files
>        in the committed state of the repo?
>
>     2) What internal consistency do we want in the git databases (ODB and=
 REFS) if
>        we crash midway through a 'git' command? I.e. if 'git add <1000 fi=
les>' crashes
>        before returning, can there be an invalid object or a torn ref sta=
te?
>
> If were only concerned with (1), then doing a single fsync at the end of =
the high-level
> git command would be sufficient. However, (2) requires more fsyncs to pro=
vide barriers
> between different phases internal to the git commands. For instance, we n=
eed a barrier
> between creating the ODB state for a commit (blobs, trees, commit obj) an=
d the refs
> pointing to it.
>
> I am not concerned with a few additional fsyncs for (2). On recent mainst=
ream filesystems/ssds
> each fsync may cost tens of milliseconds, so the difference between 1 to =
3 fsyncs would not
> be user perceptible. However, going from a couple fsyncs to 1000 fsyncs (=
one per blob added)
> would become apparent to the user.
>
> The more optimal way to handle consistency and durability is Write-ahead-=
logging with log
> replay on crash recovery. That approach can reduce the number of fsyncs i=
n the active workload
> to at most two (one to sync the log with a commit record and then one bef=
ore truncating the
> log after updating the main database). At that point, however, I think it=
 would be best to
> use an existing database engine with some modifications to create a good =
data layout for git.

I think that git should safely store your data by default, we clearly
don't do that well enough in some cases, and should fix it.

But there's also cases where people would much rather have performance,
and I think we should support that. E.g. running git in CI, doing a
one-off import/fetch that you'll invoke "sync(1)" yourself after
etc. This is the direction Eric Wong's patches are going into.

I understand from his patches/comments that you're not correct that just
1-3 fsyncs are OK, i.e. for some use-cases 0 is OK, and any >0 is too
many, since it'll force a flush of the whole disk or something.

Even when git is is operating in a completely safe mode I think we'd
still have license to play it fast and loose with /some/ user data,
because users don't really care about all of their data in the .git/
directory.

I.e. you do care about the *.pack file, but an associated *.bitmap is a
derived file, so we probably don't need to fsync that too. Is it worth
worrying about? Probably not, but that's what I had in mind with the
above-linked proposed config schema.

Similarly for say writing 1k loose objects I think it would be
completely fine to end up with a corrupt object during a "git fetch", as
long as we also guarantee that we can gracefully recover from that
corruption.

I.e. 1) we didn't update the ref(s) involved 2) we know the FS has the
sorts of properties you're aiming for with "batch".

Now, as some patches I've had to object*.c recently show we don't handle
those cases gracefully either. I.e. if we find a short loose object
we'll panic, even if we'd be perfectly capable of getting it from
elsewhere, and nothing otherwise references it.

But if we fixed that and gc/fsck/fetch etc. learned to deal with that
content I don't see why wouldn't e.g. default to not fsyncing loose
objects when invoked from say "fetch" by default, depending on FS/OS
detection, and if we couldn't say it was safe defaulted to some "POSIX"
mode that would be pedantic but slow and safe.
