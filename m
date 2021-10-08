Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16969C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 08:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E93FB610CE
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 08:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhJHILD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 04:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhJHILD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 04:11:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005E8C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 01:09:07 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a25so17372077edx.8
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 01:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=vtVhgHa32y7s+UgR/Rd4WMUPUKV4iXcmP8/kt+gsHic=;
        b=p/OzaBRqAXCmlQkKI5D8NVltR/3t+Gn90JvirB5vA9wwpWRiIQHVtaOMQfEJy2E3D2
         37WNUTAjdwRsYRcLGp6B+L4lJ5MSOylHm9kQUnmijk7jfC+7uKYUU5WX9nNN/rjrML+K
         OgdbOFah9uQMqLdQRDWa/MMscSH1INh0ojfubtqpePachDxnqGJ+52KWaoIxCg1kceIW
         Op/jnEoG6viN887rH7gKUX8Vb7gALbcmgoU+0JWYv2lGjFm/HF5GAsfiRAfjjIJsLlsj
         7kTEUZmFyALYbppdPdhBWsuOh7DzOzSutC05SqqDhin5U12kuzNqp/dbQ5dQhAa3fErz
         71iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=vtVhgHa32y7s+UgR/Rd4WMUPUKV4iXcmP8/kt+gsHic=;
        b=a+sBC0YvsuzBYHaHEY6/kQllvK/MLKYfxm4ML1J+Xtje1qK4jPKAVn0J/c0YpiT8BZ
         jBQy5jTdsL/ddx++nnZdeZWsyBPCO6lvc57Sx0qbK4TOowLsvj8MEUewA24qMbbU4IXB
         oqTlDDmyY5w/Myesl02NadidmQheBycY42bSDjm+PRMALKamIWBa9eLpMFd/IAEKYlbW
         6x9gE6UPqsomoT/5Dq2owC09tLEAZXGzsTerfaSNINyiEeSB/LaYG7nKkBeoBLdu7lMi
         2DmDNsFHwjSCecHCN0kZvrHeRraNVdP0Qru7w+MW1NxY0bJi4vufpcUBHNumwT8I++NT
         E7sw==
X-Gm-Message-State: AOAM532aiUEib0uHmlstGro8QJX/xSjQDs5LtL0XHBmjsI4geozBi2q8
        blb3DAbqfzOnoQvIc/CAMRfmlxSef6/ECw==
X-Google-Smtp-Source: ABdhPJwQP3dfQTAABEVPxz7LSp8Ty7GPv2YAX8PfxRnKDv+XApSPZxtKKkJOmPzErMRbZqdkOyrZ7Q==
X-Received: by 2002:a17:906:16d0:: with SMTP id t16mr2379802ejd.199.1633680546351;
        Fri, 08 Oct 2021 01:09:06 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s24sm705787edy.38.2021.10.08.01.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 01:09:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] cat-file: mention --unordered along with
 --batch-all-objects
Date:   Fri, 08 Oct 2021 09:54:45 +0200
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
 <YVy2DNd+XemykKE0@coredump.intra.peff.net>
 <877derjia9.fsf@evledraar.gmail.com>
 <YVzGeE1T/Kp8DDZD@coredump.intra.peff.net>
 <87tuhuikhf.fsf@evledraar.gmail.com>
 <YV3LonbeIS8DrMsN@coredump.intra.peff.net>
 <87k0ipgmbb.fsf@evledraar.gmail.com>
 <YV+tXVWVuy/rZn/l@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YV+tXVWVuy/rZn/l@coredump.intra.peff.net>
Message-ID: <87lf34ey5a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 07 2021, Jeff King wrote:

> On Thu, Oct 07, 2021 at 12:18:45PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> >> The usage of OPT_CMDMODE() in "cat-file"[1] was added in parallel with
>> >> the development of[3] the --batch-all-objects option[4], so we've
>> >> since grown[5] checks that it can't be combined with other command
>> >> modes, when it should just be made a top-level command-mode
>> >> instead. It doesn't combine with --filters, --textconv etc.
>> >
>> > This is not right. --batch-all-objects does not provide a mode exclusi=
ve
>> > with "-t", etc, by itself.
>>=20
>> Yes it does. See the "if (opt) {" branch on master. We just don't
>> implement it via a cmdmode, but --batch-all-objects can definitely be a
>> CMDMODE (I see you found that out below...)
>
> I agree that if you make it a CMDMODE it does not introduce any bugs.
> But it is semantically confusing. You would not make, say, --buffer a
> CMDMODE option. It is a flag which only takes effect under certain
> modes. And the same is true of --batch-all-objects, which modifies the
> batch cmd modes.
>
> In fact, it _would_ be a bug to make it a CMDMODE if --batch were
> correctly marked as one (but it is not sufficient to reason the other
> way; --batch without --batch-all-objects is still mutually exclusive
> with -t, etc).
>
 > What really makes things confusing, IMHO, is the --textconv and --filter
> options. They are marked as CMDMODEs, and they are indeed mutually
> exclusive with -t, etc. But they also work with --batch, which is itself
> a different mode.
>
> So I don't think OPT_CMDMODE could ever present this complete set of
> rules, because they are not all mutually exclusive with each other. But
> I think calling "--batch-all-objects" a mode is just muddying the waters
> even further.

I think we've got some different understanding of what a CMDMODE
means. --batch-all-objects should be a cmdmode, but --batch, --buffer
etc. can't be. Similarly it's not a bug that --filters and --textconv
are cmdmodes, but you think that's bad.

I think it's fair to say that you think this because "the batch mode" is
a ... mode, that cat-file operates in, therefore it's weird that we
don't call it a "command", but that when you're doing "cat-file --batch
--textconv[...]" you're in "textconv mode" or whatever.

I agree that it's a bit weird. But OPT_CMDMODE() under the hood is just
a way to label N options as being mutually exclusive with each other,
and not needing to follow-up parse_options() with a bunch of "die() if x
&& y" etc.

So both in terms of code clarity and to enable later clever use of
parse_options() I think just squinting a bit and reading it as
s/OPT_CMDMODE/OPT_MUTUALLY_EXCLUSIVE_WITH_OTHER_SUCH/ makes the most
sense.

E.g. for any command-mode we should be able to teach the completion that:

    git cat-file --batch-all-objects --<tab>

Should only complete those options that go with it. We don't have that
full picture yet (since we just have cmdmode, but no way to say A goes
with B and C, but not D), but a rough working start at that is to
exclude all the other cmdmode options.

