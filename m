Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CCDC433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F7A61935
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhC2XGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 19:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhC2XG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 19:06:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A121FC061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 16:06:25 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kt15so21886793ejb.12
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 16:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=BlepVrFPXrLpOoQwngd/KBcVERp+EBENabf0cv59b0c=;
        b=un+frbqbXRfu+R9Ftbe5dgj9h+k7i3S0WFC6cNaw1YPktbQm9NnpYlvhtI4Pe8ACEL
         0Rn1BsKSUnO0uY0yJZGrcXNHhdSUa8xxkUsJmqfSBn87he1F4lAkMNW2haz6b/viFFvZ
         bmOOIL+qUC6wA8k6wqQKc48d8C6Y6pvO67BnZRJlICF7vwVsAhsChS3YHiggtw8HhK7l
         ypqFTgiYhvupAB1n5H7oBk9FHE1Z/ujSnh5/8kDvBVGQcTBCkzbcC/+aaZYKOU6qEwMW
         7TQ4CLBgoePq+gMDdRJ4lX7/9QF0uZXt/aKoWQ3T1i7PN/HQOYmqJi7Mbg/heqG1/MFC
         VZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=BlepVrFPXrLpOoQwngd/KBcVERp+EBENabf0cv59b0c=;
        b=PiXuV2dlg7fh9+aYiHgvRWYlGafl175RqURIr3851ECNFomm5sXk+/iPwE32cNmCP6
         xFO700G3dWj4Vm+T5SxEogtAkL3ECeYfKYR6jrpL97N8BUecJ+ielJXi9JbasjDdaTp+
         bIpPT3/fu4vGaL5OhyaZt15Dv71LEKRlNTHYLEJZepH8qBGqFpqcf4bvU+I/3loDjjrU
         RP15nBmAtCfGpuDE+3yUUJzbrowjI8UTcs3pgsKVLGblgo2GKF+b8Wi9BZ6g+5JN0eBT
         FreEGrY3GvLFNjgadjcDD1U4hC80ku3VpQpotkfShIC6W7rgzXYZfrVgxp2mmwiKCQEM
         Ltxw==
X-Gm-Message-State: AOAM5339jD9p7pGCaEPE1uejTnA71cQ8F7PvA3uqxQEAQ5ZwGbO9Wh8I
        GMuSVVNcHhGKYLF6gisrQWEAgPXbljVd9g==
X-Google-Smtp-Source: ABdhPJxi+ZWU074cLLvOKbrq+AXxn0azJMiXg37FuUNH2hCO/FPpDD788qrechJtkjzP2BhN2xY9uQ==
X-Received: by 2002:a17:906:ada:: with SMTP id z26mr30587872ejf.438.1617059184053;
        Mon, 29 Mar 2021 16:06:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id sb4sm9052774ejb.71.2021.03.29.16.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 16:06:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 07/20] test-read-cache: print cache entries with --table
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <7ebd9570b1ad81720569a770526651c62c152b9f.1616507069.git.gitgitgadget@gmail.com>
        <87r1k5pcmx.fsf@evledraar.gmail.com>
        <ca8a96a4-5897-2484-b195-57e5b3820576@gmail.com>
        <874kgzq4qi.fsf@evledraar.gmail.com>
        <CABPp-BGRwxn73sntpX8Q5aD-O192RZmOOy_jiU3SQp4-erivtg@mail.gmail.com>
        <87eeg0ng78.fsf@evledraar.gmail.com>
        <b1eee802-f20c-5381-366c-729755bfac8a@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <b1eee802-f20c-5381-366c-729755bfac8a@gmail.com>
Date:   Tue, 30 Mar 2021 01:06:23 +0200
Message-ID: <87im59mufk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 29 2021, Derrick Stolee wrote:

> On 3/28/2021 11:31 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:> It =
seems to me that the reason for that state is based on a
>> misunderstanding about what we would and wouldn't add to builtin/*.c,
>> i.e. that we wouldn't have something like a --debug option, but as
>> ls-files shows that's not a problem.

At the risk of going in circles here...

> I feel _strongly_ that a change to the user-facing CLI should come
> with a good reason and care about how it locks-in behavior for the
> future.

And I agree with you. Where we disagree is whether lives in builtin/*.c
=3D=3D user-facing. I think --debug options are !=3D that. It seems Junio
downthread agrees with that.

> Any adjustment to 'git ls-files' deserves its own series and
> attention[...]

A user-facing change to it yes, but I don't see how use of an (existing
even) --debug option would warrant any more attention than a new test
helper, less actually, it's less new code.

> [...] not in an already-too-large series like this one.

The alternative way of doing it at the end of
https://lore.kernel.org/git/874kgzq4qi.fsf@evledraar.gmail.com would
make this series smaller.

Anyway. As I noted in the E-Mail you're replying to
(https://lore.kernel.org/git/87eeg0ng78.fsf@evledraar.gmail.com/) I
really don't care that much.

I'm just still perplexed at how you keep bringing up use of an
internal-only --debug option as "user-facing", and here "already too
large" when we're talking about a proposed alternate direction that
would reduce the size.

> I'm not happy that this series and the next are so long, but that's
> the best I can do to make them reviewable and still capture a
> complete scenario. Hopefully the remaining series after these first
> two are smaller. Things like "what should 'git ls-files' do with a
> sparse index?" can fit cleanly on top once the core functionality
> of the internals are stable.

Sure. I'm fully on board with just moving forward with this in some
manner.

I'm not on board with the part of this that seems like it could just be
rephrased/understood as "...and we're not touching ls-files even with a
--debug option now because that would be user-facing[...]".

> I have an _opinion_ that the ls-files output is not well-suited to
> testing because the --debug output splits details across multiple
> lines. This is a minor point that could probably be corrected by
> a complicated script method, but that's why I list this as an
> opinion.

If the --debug it's spewing now isn't handy we can just change the
output format. The docs say:

    This is intended to show as much information as possible for manual
    inspection; the exact format may change at any time.

And we don't have existing in-tree users, something like this would make
it rather trivial:
=20=20=20=20
    diff --git a/builtin/ls-files.c b/builtin/ls-files.c
    index f6f9e483b27..7596edc9f9d 100644
    --- a/builtin/ls-files.c
    +++ b/builtin/ls-files.c
    @@ -113,11 +113,11 @@ static void print_debug(const struct cache_entry =
*ce)
     	if (debug_mode) {
     		const struct stat_data *sd =3D &ce->ce_stat_data;
=20=20=20=20=20
    -		printf("  ctime: %u:%u\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
    -		printf("  mtime: %u:%u\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
    -		printf("  dev: %u\tino: %u\n", sd->sd_dev, sd->sd_ino);
    -		printf("  uid: %u\tgid: %u\n", sd->sd_uid, sd->sd_gid);
    -		printf("  size: %u\tflags: %x\n", sd->sd_size, ce->ce_flags);
    +		printf("  ctime: %u:%u%c", sd->sd_ctime.sec, sd->sd_ctime.nsec, line=
_terminator);
    +		printf("  mtime: %u:%u%c", sd->sd_mtime.sec, sd->sd_mtime.nsec, line=
_terminator);
    +		printf("  dev: %u\tino: %u%c", sd->sd_dev, sd->sd_ino, line_terminat=
or);
    +		printf("  uid: %u\tgid: %u%c", sd->sd_uid, sd->sd_gid, line_terminat=
or);
    +		printf("  size: %u\tflags: %x%c", sd->sd_size, ce->ce_flags, line_te=
rminator);
     	}
     }

But even without that it wouldn't be some complicated post-processing,
just a pipe to a small perl or awk process.
=20=20=20=20=20
>> I mean it's fine if it's just a "I don't think this is important and
>> don't want to spend time on it, but it seems like a good idea", in which
>> case others have the option of re-rolling some of these patches if they
>> care (at this point I wouldn't).
>>=20
>> Or "this is just a bad idea for XYZ reason", which is also fine, and
>> even more valuable to document for future work in the area.
>>=20
>> But to have another series built on this with refactorings back and
>> forth before code's landed on master just seems like needless churn.
>
> I think changing 'ls-files' before the sparse index has stabilized is
> premature. I said that a series like the RFC you sent would be
> appropriate after this concept is more stable. I do _not_ recommend
> trying to juggle it on top of the work while the patches are in flight.

Just to clarify, upthread in [1] you said:

    And I recommend that you continue to pursue [these RFC patches] as
    an independent series, but I'm not going to incorporate them into
    this one[...]

So do I understand it right that you're referring to phase IV in your
opinion being the first point where we'd consider piggy-backing on
anything in builtin (that "user-facing" dilemma again...).

But at that point wouldn't you have your own ideas about some
user-facing ls-files or other porcelain for this, so I'm not sure where
to place the encouragement that I continue to pursue that RFC series,
other than setting a reminder in my calendar for 6-12 months in the
future :)

1. https://lore.kernel.org/git/ca8a96a4-5897-2484-b195-57e5b3820576@gmail.c=
om/
