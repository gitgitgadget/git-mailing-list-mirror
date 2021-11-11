Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828CBC433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 01:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ACF46128E
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 01:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhKKBQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 20:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbhKKBP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 20:15:59 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9F6C061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 17:13:10 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z21so17635734edb.5
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 17:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=eOjhiaFPdVuCjqk/Rj8v5C7ikA/M3wkV1iPW1NMUE0I=;
        b=A9TQI6RyIzs5K20y+dN03F7JsmVJPfn0aZ7m5jEgM7dhO1IXGXsIzA/lViD119dgzK
         UsNC7DnrEAtRdh58r78gdR8R74DNSIKVtOMjMffFrFRUn7trnM8yZjulqJb4z8nRT+sj
         xDcreSdqXSMV1uDt5FlTpFl97Mb6p60HCi+jQWWQ5Hf8LwD/EtTkPk80YMJPsMxC6WI2
         9jlquG/8zd8dctcu7VGdJot/ausTV2RkF0e99JlpZKssOr00XIbpnvTTrgGGBtqeyUG7
         k1y1UINRUomYfY2+LRHKsUriRUJGWm2Lvj81x+3BoJRrhZzRg1TArrUWtBEyZEdY3+2p
         dq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=eOjhiaFPdVuCjqk/Rj8v5C7ikA/M3wkV1iPW1NMUE0I=;
        b=cWONDFX6X796i2cyYSSjxFWFrN+oC492JUpXw/lZ4t4tzCYbaWYasigUtONAxLub1+
         RrqHQJ8qQ2078dI8qZRi4Bai4yRX3BbC6yms4l4L2lv78QybTeS+bnPWPN9RWfUQyieK
         22rbLXfg0b5E4lE8r5IVGpkY2gUT4FYr8+86o3BJ1xGhg38y3zqMank43Bhi11T2Azkc
         VpuFzqHKbYOfMequl/hfGLWTK7bytoZd13hnB8wDRuAMrq8NWe3YrbETHdZX4InpffTn
         j5e0tXBqOhwwIIpv61AbiTL0rHONt0zRX68uCZ23yEAW3wHasr0TKK7RZTzFDrGLanEj
         eLmA==
X-Gm-Message-State: AOAM530jSuBatC4uiu2GqDgcngRTBXeCR/6ir9TR2JWbhMf8VJEPiaT2
        H1exeuM1zI40MPCCC6P+3SDrBSQMUPXmIHfx
X-Google-Smtp-Source: ABdhPJyiwe0K51GYx1qiOwLD7nf4CMs9jiqCp3Wt+yoBkH0WWIFV1f9VsDpDErZZQVWZGIRZcQ9LTA==
X-Received: by 2002:a50:e608:: with SMTP id y8mr4548998edm.39.1636593189347;
        Wed, 10 Nov 2021 17:13:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h20sm681315eds.88.2021.11.10.17.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 17:13:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkyeJ-00097u-Ub;
        Thu, 11 Nov 2021 02:13:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Wong <e@80x24.org>, Christoph Hellwig <hch@lst.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: RFC: A configuration design for future-proofing fsync()
 configuration
Date:   Thu, 11 Nov 2021 01:57:49 +0100
References: <211110.86r1bogg27.gmgdl@evledraar.gmail.com>
 <20211111004724.GA839@neerajsi-x1.localdomain>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211111004724.GA839@neerajsi-x1.localdomain>
Message-ID: <211111.86pmr7pk9o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 10 2021, Neeraj Singh wrote:

> On Wed, Nov 10, 2021 at 04:09:33PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> As a follow-up to various fsync topics in-flight I've been encouraging
>> those involved to come up with some way to configure fsync() in a way
>> that'll make holistic sense in the end-state.
>>=20
>> Continuing a discussion from [1] currently we have:
>>=20
>>     ; Defaults to 'false'
>>     core.fsyncObjectFiles =3D [true|false]
>>=20
>> In master..next this has been extended to this by Neeraj:
>>=20
>>    core.fsyncObjectFiles =3D [true|false|batch]
>>=20
>> Which, as an aside I hadn't considered before and I think we need to
>> change before it lands on "master", we really don't want config users
>> want to enable that makes older versions hard die. It's annoying to want
>> to configure a new thing and not being able to put it in .gitconfig
>> because older versions die on it:
>>=20
>>     $ git -c core.fsyncObjectFiles=3Dbatch status; echo $?
>>     fatal: bad boolean config value 'batch' for 'core.fsyncobjectfiles'
>>     128
>>=20
>> Then there's Eric Wong's proposed[2]:
>>=20
>>     core.fsync =3D <bool>
>>=20
>> And now Patrick Steinhardt has a proposal to extend Neeraj's with[3]:
>>=20
>>     ; Like core.fsyncObjectFiles, but apparently for .git/refs, not
>>     ; .git/objects (but see my confusion on that topic in [1])
>>     core.fsyncRefFiles =3D [<bool>|batch]
>>=20
>> I think this sort of config schema would make everyone above happy
>>=20
>> It would:
>>=20
>>  A) Be easy to extend for any future fsync behavior we'd reasonably
>>     implement
>>=20=20
>>  B) Not make older git versions die. It's fine if they warn(), but not d=
ie.
>>=20
>>  C) Has some pretty contrived key names, but I'm trying to maintain the
>>     constraint that you can set both fsck.X=3DY and
>>     e.g. fetch.fsck.X=3DY. I.e. we should be able to configure things
>>     globally *and* per-command, like color.*, fsck.* etc.
>>=20
>> Proposal:
>>=20
>>   ; Turns on/off all fsync, whatever the method is. I.e. allows you to
>>   ; never make any fsync() calls whatsoever (which we have another
>>   ; in-flight topic for).
>>=20
>>   ; The "false" was controversial, and we could just leave it
>>   ; unimplemented
>>   core.fsync =3D <bool>
>>=20
>>   ; Optional, by default we'd use the most pedantic (I'd call our
>>   ; current "loose", whether we want to forward-support it is another
>>   ; matter.
>>   ;
>>   ; Whatever names we pick an option like this should ignore (or at most
>>   ; warn about) values it doesn't know about, not hard die on it.
>>   ;
>>   ; Here "bach" is what Neeraj and Patrick are pursuing, a hypothetical
>>   ; POSIX would be a pedantic way of exhaustively fsyncing everything.
>>   ;=20
>>   ; We'd leave door open to e.g. setting it to "linux:ext4" or whatever,
>>   ; to do only the work needed on some specific popular FS
>>   core.fsyncMethod =3D loose | POSIX | batch | linux:ext4 | NTFS | ...
>>=20
>>   ; Turn on or off entire categories of files we'd like to sync. This
>>   ; way Neeraj's and Patrick's approach would be to set
>>   ; core.fsyncMethod=3Dbatch, and then core.fsyncGroup=3Dfiles &
>>   ; core.fsyncGroup=3Drefs.
>>=20
>>   ; If we learn about a new core.fsyncGroup =3D xyz in the future a <boo=
l>
>>   ; in "core.fsyncGroupDefault" will prevail. I.e. if true it's
>>   ; included, if false not.
>>   ;
>>   ; Whether "false" or "true" is the default depends on
>>   ; core.fsyncMethod. For POSIX it would be true, for "loose" it's
>>   ; false.
>>   core.fsyncGroup =3D files
>>   core.fsyncGroup =3D refs
>>   core.fsyncGroup =3D objects
>>=20
>> I'm not sure I like calling it "group". Maybe "class", "category"? Doing
>> it with this structure is extensible to the two-level keys, as noted
>> above.
>>=20
>>   ; Our existing config knob. When "false" synonymous with:
>>   ;
>>   ;     core.fsync =3D true
>>   ;     core.fsyncMethod =3D loose
>>   ;     core.fsyncGroup =3D pack
>>   ;
>>   ; When "true" synonymous with the same as the above, plus:
>>   ;     core.fsyncGroup =3D loose
>>   ;
>>   : Or something like that. I.e. we'll fsync *.pack, *.bitmap etc, and ;
>>   ; probably some other stuff, but not loose objects etc.
>>   ;
>>   ; Whatever we fsync now exactly this schema should be generic enough
>>   ; to support it.
>>   core.fsyncObjectFiles =3D <bool>
>>=20
>>   ; A namespace for core.fsyncMethod =3D <X>. Specific methods will
>>   ; own this namespace and can configure whatever they want.
>>   fsyncMethod.<x>.<a> =3D <b>
>>=20
>> E.g. we might have:
>>=20
>>   fsyncMethod.POSIX.content =3D true
>>   fsyncMethod.POSIX.metadata =3D false
>>=20
>> If we know we'd like to (depending on other config) to fsync things
>> exhaustively or not, but do different things depending on file content
>> or metadata. I.e. maybe your FS's fsync() on a file fd always implies a
>> sync of the metadata, and maybe not.
>>=20
>>   ; Change whatever fsync configuration you want per-command, similar to
>>   ; fsck.* and fetch.fsck.*
>>   transfer.fsyncGroup=3D*
>>   fetch.fsyncGroup=3D*
>>   ...
>>=20
>> 1. https://lore.kernel.org/git/211110.86v910gi9a.gmgdl@evledraar.gmail.c=
om/
>> 2. https://lore.kernel.org/git/20211028002102.19384-1-e@80x24.org/
>> 3. https://lore.kernel.org/git/cover.1636544377.git.ps@pks.im/
> Hi =C3=86var,
>
> Thanks for noticing the backwards compatibility issue with the 'batch' fl=
ag. I
> agree that we need to fix that before committing my changes to master.
>
> I'm hoping that we can agree to a version of what you're proposing, but my
> preference would be to cut out the more granular controls. I'd prefer to =
see
> just:
> 	core.fsync =3D [bool]   		- Turn fsyncing on or off.
> 	core.fsyncMethod =3D [string] 	- Controls how it's done (with a non-fata=
l warn on unrecognized values).
> 	core.fsyncObjectFiles =3D [bool]  - Sets core.fsync if that setting does=
n't already have a value. For back-compat.

I'm fine with something simpler as long as we don't think we'll
plausibly start painting ourselves into a corner.

But core.fsyncObjectFiles is *not* a setting of a "core.fsync" in the
sense that Eric suggested we have.

I.e. it's effectively a sort of early and partial Linux-only version of
what your "batch" mode is. I.e. to skip fsyncing the loose object files,
and only fsync() the eventual refs we write.

"Sort of" because we'd e.g. fsync packs unconditionally etc, but if we
make core.fsyncObjectFiles=3Dfalse be core.fsync=3Dfalse then we can't have
a "real" core.fsync=3Dfalse, i.e. one that guarantees no fsync() calls at
all.

We could also simply decide that it's a bad setting and we're going to
deprecate it, but another way is having a generic config layout that can
express what it's doing and more.

> I don't think either we or the users should have to reason about what it =
means
> for some parts of the repo to be fsynced and others not to be. If core.fs=
ync is
> 'false' and someone gets a weird state after a system crash, no one shoul=
d be
> surprised.

Yes. I'm fine with leaving this on the table. I should have be more
explicit that I'm not suggesting we implement all this exhaustive config
support, but if we imagine a sensible config schema that is extensible
(my proposal may or may not be that) then we can implement just 1-2
variables in it and know that we have room to grow in the future.

> If core.fsync is 'true', and people are running on a reasonable
> common filesystem, we should be trying to give decent performance and good
> durability.

Yeah, I just wonder if we can easily provide config to have people
decide that trade-off themselves.

E.g. from the performance numbers in [1] I might turn off fsyncing when
we write anything in the working tree.

We don't do that particular thing now, but if we're being pulled in one
direction of always being fsync-safe by default...

I can also see it being useful to e.g. do:

    gc.fsync =3D false

Or blacklist other similar batch operations, although with a global knob
that can also rather easily be:

    git -c core.fsync gc

So maybe the whole "fsck" rationale doesn't apply here.

> It would be nice to loop in some Linux fs developers to find out what can=
 be
> done on current implementations to get the durability without terrible
> performance. From reading the docs and mailing threads it looks like the
> sync_file_range + bulk fsync approach should actually work on the current=
 XFS
> implementation.

I CC'd Linus on the topic of core.fsyncObjectFiles on this thread, and
Christoph Hellwig who chimed in on the topic of the behavior of Linux
FS's on recent threads, I don't know where we'd find a focused set of
Linux devs who might be interested (I'm not going to just spam LKML). If
anyone does pointing them to this thread would be most welcome.

1. https://lore.kernel.org/git/YYwvVy6AWDjkWazn@coredump.intra.peff.net/
