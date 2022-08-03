Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B636FC19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 13:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbiHCNCy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 09:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbiHCNCx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 09:02:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2617113E3D
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 06:02:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dc19so8625308ejb.12
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=9uwKOPM4+qI+948Pluf8S9Xq6iSbs1bXgghKJZkrQDI=;
        b=L1VVNCqwDXAAWI0gdik7jhSGiZIZhTCT+5SzxjLAGlV6eBfJGA4xCu19M8VhK2uaxk
         vzNnCmU+64gwm+3z9PB+OwEzT7WMzC8Ws9K5i2LrDZOF07A8JlAMuGeia10Zsuq7uokK
         Bhh7tG5cNpcTCkM3QAzK4HxShDqalJX+JzhypQEE4/xB+iHnOwc3+UrihvAR/yhQK1GX
         qTK8WexTxKcQZUrphwLMiUBJn18w9i2btJ2dMIABgXpZj3Mkk1QtxBTgaARpkQpjQ1NW
         qNZ6VodI4M9a1RJ9Vd4prVNROFa1QVeTcv3QNL1drHupIJouLkDeo2TpNS91+NGl4okK
         Frew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=9uwKOPM4+qI+948Pluf8S9Xq6iSbs1bXgghKJZkrQDI=;
        b=Vx8A+Jk28NWEfKkyXuR1eVM38fzSYyBiwuA3Yl/Ft1u5G3+M5I0oukLRNqLx5I2+xg
         L57q/KsopJz8SksoSJF49VQdfsd7eH3hA04i2xP9pg7pFCI1REO6AyFzT/ue+mv7qR8j
         lMH+MrqmxGL8yOR8Qsaj6BQlbTmV9grNAiEor1a98sSCbTSQCWBY47JavAgA0FK2/GXP
         UpcTYfZWW0jfRhK7mWcBVY7GT2MR6LBY5Ydh1NxUH62fJdV7hJ27eMglwOktun7SPZxr
         GmdQAn5CRuSojYFLUKeGEGw2RIIRz+aoFE1Qp3gL5Kf439o08EuIkztmJlscJeKkq74H
         U1ag==
X-Gm-Message-State: AJIora9W4OO0UBrv86XXXz5hBe50AHFdRQK9N91/64wmTYNz/Gcz1Zs+
        iRM7ig0hR/gsD+QM5CJGiqrjGm/Fob+MTg==
X-Google-Smtp-Source: AGRyM1uQ7tQM0f7ElKs/vHdxLuFD40mhxIgpWimGLMoUUHj0wiTUnI8J49aGXmmjlyZW8Poz3JM89Q==
X-Received: by 2002:a17:907:6e0e:b0:72b:9ec4:2ba2 with SMTP id sd14-20020a1709076e0e00b0072b9ec42ba2mr20358981ejc.300.1659531770393;
        Wed, 03 Aug 2022 06:02:50 -0700 (PDT)
Received: from gmgdl ([2a02:a213:23c2:bf80:c530:8f19:38e6:f393])
        by smtp.gmail.com with ESMTPSA id kv11-20020a17090778cb00b00730bfe6adc4sm49781ejc.37.2022.08.03.06.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 06:02:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJE1Q-009Szr-1q;
        Wed, 03 Aug 2022 15:02:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH 0/7] Generalize 'scalar diagnose' into 'git bugreport
        --diagnose'
Date:   Wed, 03 Aug 2022 14:34:04 +0200
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <220802.867d3rgx8n.gmgdl@evledraar.gmail.com>
 <392ae6f1-c2f1-ab0f-c832-f8e53800506a@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <392ae6f1-c2f1-ab0f-c832-f8e53800506a@github.com>
Message-ID: <220803.86pmhhfpjb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 02 2022, Victoria Dye wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Aug 01 2022, Victoria Dye via GitGitGadget wrote:
>>=20
>>> [...] I didn't see a major UX benefit of 'git diagnose' vs 'git
>>> bugreport --diagnose', so I went with the latter, simpler approach.
>>=20
>> I really wanted to like this, but I find the end result here really
>> confusing from a UX perspective.
>>=20
>> You can now run "git bugreport --diagnose", which creates a giant *.zip
>> file to go along with your *.txt, but your *.txt makes no reference to
>> it.
>>=20
>> Should you ... attach it to your bug report to this mailing list, do
>> something else?
>>=20
>> The documentation doesn't offer much in the way of hints, other than
>> suggesting (with --no-report) that this --diagnose is for something
>> entirely different (and that's how "scalar" uses it).
>>=20
>> I know what it's really for after reading this series, but for "git
>> bugreport" in particular we should be really careful about not making
>> the UX confusing.
>>=20
>> The generated *.zip contains some really deep info about your repo (and
>> not just metadata, e.g. copies of the index, various logs etc.), someone
>> e.g. in a proprietary setting really doesn't want to be sharing that
>> info.
>>=20
>> So I would like to see real integration into "git bugreport", i.e. for
>> us to smartly report more repository metrics, e.g. approx number of
>> loose objects, the sort of state "__git_ps1" might report, etc.
>>=20
>> But I think the end-state here makes things much more confusing for
>> users.
>>=20
>
> The "confusing UX" you describe here doesn't seem to be an inherent issue
> with the implementation (nor is it as insurmountable as you're implying),

I'm not implying or saying that it's insurmountable.

I think in principle having such a mode in "git bugreport" would make
sense.

But the UX here seems to be an afterthought. So I wonder if we shouldn't
hold off on it and just have a new *--helper or something instead.

> it
> largely appears to be an issue of under-documentation. I'll improve that =
in
> V2 [1], but I want clarify what I was/am going for here as well.
>
> In the context of a bug report, the diagnostics are intended to be used as
> supplemental information to aid in debugging (i.e., attached with the rep=
ort
> in the email to the list).

Per https://lore.kernel.org/git/?q=3Dn%3Azip we don't block *.zip
attachments, but we have fairly low size limits (to the point of
blocking some large patches).

E.g. e448263716f (po/git.pot: this is now a generated file, 2022-05-26)
(https://lore.kernel.org/git/20220526145035.18958-7-worldhello.net@gmail.co=
m/)
was blocked, and it's just over 500k.

Aside from the data-sharing issues that seems like a good addition to
git-bugreport, i.e. tell the user if the attachment would be blocked due
to its size...

> They're especially valuable when a bug reporter
> isn't very familiar with Git internals and they can't reproduce the issue=
. A
> lot of bugs can be investigated without those diagnostics, though, which =
is
> why '--diagnose' isn't "on" by default.
>
> There are also valid use-cases (beyond 'scalar diagnose') for '--no-repor=
t':
> someone requests more information after looking into an already-generated
> report, or a developer wants to investigate a bug on their own and use the
> diagnostics as a "starting point" to guide more in-depth debugging.=20

Yes, it's useful in a lot of cases. I'm just saying that we really need
to bridge the gap of telling the user what they should be doing with
this new file....

> As for the proprietary data issue, I'd be open to having an option to
> configure which diagnostics a user wants (either something like '--diagno=
se
> <level>' or a separate option entirely). I'm pretty indifferent on the UI,
> though, so I'll defer to other contributors on 1) if they want that featu=
re,
> and 2) what they think that should look like.

I think it's really important that a bug report feature doesn't submit
private data by default. The name of a "--diagnose" option heavily
implies some aggregate metrics etc.

We then attach what to the user are opaque binary files, but which
contain even the file contants of the repository (index files).

I think scalar was developer for "internal" use-cases where such sharing
wasn't an issue for anyone, but I don't want anyone to get in trouble
because they shared their proprietary source code on the ML while trying
to file a bug report, so defaults really matter.

Especially because if there's one thing we've learned from bug reports &
questions to this & git-users is that the one thing you can rely on is
that users routinely don't carefully scrutinize documentation before
trying out various features...

> [1] https://lore.kernel.org/git/f3235afe-25cc-21a4-fc35-56e35d6be0ce@gith=
ub.com/
>
>>> An alternative implementation considered was creating a new 'git diagno=
se'
>>> builtin, but the new command would end up duplicating much of
>>> 'builtin/bugreport.c'.
>>=20
>> It seems we always "return" from cmd_bugreport() quite quickly, and we
>> basically only share the code to create the output directory. Just
>> duplicating or sharing that seems like a much better approach for now
>> than creating the above UX confusion.
>>=20
>> Note that you can also share code between multiple built-ins, even in
>> the same file (see e.g. builtin/{checkout,log}.c). So we could even
>> share something like the safe_create_leading_directories() calling code
>> in bugreport.c without libifying it.
>>=20
>
> You deleted the part where I addressed this suggestion directly:

Yes, the "Although that..." sentence, but I commented on the UX
trade-off elsewhere.

>> Although that issue could be overcome with refactoring, I didn't see a
>> major UX benefit of 'git diagnose' vs 'git bugreport --diagnose', so I
>> went with the latter, simpler approach.
>
> And, in the process of writing down my thoughts on the UX above, I've bec=
ome
> more convinced that including '--diagnose' in 'git bugreport' is the bett=
er
> way to present this functionality to users.

We're on the same page there, we're just discussing if/how to make the
end-to-end process clearer to users.

I don't think it's clear in v1, and is sorely missing something like the
discussion we have around "ANONYMIZING" in git-fast-export(1), and we
really should have a "safe by default". Everything I'm noting here would
be addressed by e.g.:

 * The *.txt output would say "you can additionally attach a diagnostic
   *.zip" file etc. etc., noting if/when the user would do that.

 * We'd have that --diagnostics be safe by default in the way
   --anonymize is, e.g. including stats about number of refs & the like,
   not their contents.

 * We could also have e.g. "--diagnostics --no-anonymize", or
   "--diagnostics=3Dfull" or whatever, which would be some approximation
   of the current output.

>>> Finally, despite 'scalar diagnose' now being nothing more than a wrappe=
r for
>>> 'git bugreport --diagnose', it is not being deprecated in this series.
>>> Although deprecation -> removal could be a future cleanup effort, 'scal=
ar
>>> diagnose' is kept around for now as an alias for users already accustom=
ed to
>>> using it in 'scalar'.
>>=20
>> We don't have a "make install" to get a "scalar" onto user's systems
>> yet, do we really need to worry about those users?
>>=20
>> Or is this a reference to the out-of-tree version of "scalar", not
>> git.git's?
>>=20
>
> In practice, it's the "out-of-tree Scalar" users that would care the most.
> That said, with Scalar in the Git tree (albeit 'contrib/' and not built by
> default), I think it's reasonable to want to avoid breaking changes if
> possible. The continued existence of 'scalar diagnose' wouldn't really be
> hurting anyone anyway, so there's no pressing need to deprecate it now.

I'm fine with keeping it, but just found the juxtaposition of doing that
& previous discussions about scalar to be surprising.

When it was submitted (from my recollection, I see
Documentation/technical/scalar.txt is rather light on the topic) the
idea was (and this is from my own recollection, I haven't dug up ML
references) that scalar would be "going away", and that the reason to
have it in-tree was to inform the design of the main "git" tooling for
the use-cases scalar is addressing.

So, a bit similar to Cogito (although that was never in-tree).

I'm fine with just keeping it as an alias for "git bugreport
--whatever", but think it would make even more sense to change the
interface a bit as we integrate it to the rest of git, and then "die()"
saying "'scalar xyz' is now 'git abc', mostly....".

Existing scalar users used to 'scalar xyz' would then try the new 'git
abc', and report if/how that fits their use-case.

Then at some point if we do that with all of scalar's features we'd be
at the point of 'git rm'-ing it, as it would have served its stated
purpose.

Just my 0.02, I think in any case having the scalar.txt doc's "Roadmap"
updated to address this would be very useful.
