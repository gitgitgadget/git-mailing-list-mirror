Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC444C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 21:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbiGNVPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240574AbiGNVPP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 17:15:15 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7530721E39
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:15:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t3so4054287edd.0
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=FIb+O40aDiA+yoUFnVn+j+HbGZzuo8AYxOOSzdbBCas=;
        b=SPs8oxGRiVjkaU19XOjUUZu7frfa2r1bRA3TMajF4tHtL7BYruhocERV48hgvrIvi2
         xsrzrFP5CSYGpMFHo32jmOu+Nc81Y4afOJwqSYE6+Eoe79Tmn1uZxQqofIo0W3g8VgjG
         ewcF8Zg+6NaLIPLiDebbI8E38U0DLucBFJE7BeEtPhml39KFcBSK30xfFQgwJmU7USG3
         DQTHimnQPRITqGXng+qXuykVqEaVgSIitYbVMVje+hFOLRKU88HqMbO1sBLVE2mQZ1Hk
         arTasYhKEgmsuKm9Hf1JeB1mW44vYJhvL1QrjCigmwNCtMXfts3xEwiekiqFB0zsmGa4
         fk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=FIb+O40aDiA+yoUFnVn+j+HbGZzuo8AYxOOSzdbBCas=;
        b=a4WlmZGPLShVCDm0Ui7dAJrn19vu0RRyZ6Ke6WL+F4Kxawz/ka4uwrLEdxVd03IiDP
         tJN2KkFRe9vlorb+kzHs2hZ5FzPhTeTZq9c1vgyszMUIBGUI9aLSG7qVP3aUd60hDfjm
         Bj0zo79DpxJ+t6BB4HD5WEX3WXufCRdMmJiDbm8Wmre+92DgCDsZP0OA1XOw990Wm7+6
         8KkoxdN8xVLELmcSVkXPchzOh/J6AfooysjMtGqMZTIlmdly9ldLjYQHMyz69XNtYK+p
         loGCD2F2Pl6krT3mm8CzwWOVvWHBIVuDiE4FsNh0IgSthdqBx1+96lG/PmzVhUV0VTjt
         /p4Q==
X-Gm-Message-State: AJIora+kSzP65kxv1Emc3IPG00m44PTECBy1U2SCNFFvmhRPvr7Y26PD
        zhgxN/YTs/gjcAkBY8NDRnk=
X-Google-Smtp-Source: AGRyM1stI+vdYwZxDaEoB7TBLkmf+DfRDEEsQwd0dzZ/rItMq4SXAmMwhRWhea1aPWtvPKPHdaWdzA==
X-Received: by 2002:aa7:d759:0:b0:43a:6fe3:acb4 with SMTP id a25-20020aa7d759000000b0043a6fe3acb4mr15006507eds.27.1657833312943;
        Thu, 14 Jul 2022 14:15:12 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o18-20020a170906769200b00726abf9a32bsm1144173ejm.138.2022.07.14.14.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 14:15:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oC6Ax-002UzI-0o;
        Thu, 14 Jul 2022 23:15:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: js/bisect-in-c, was Re: What's cooking in git.git (Jul 2022,
 #03; Mon, 11)
Date:   Thu, 14 Jul 2022 23:09:53 +0200
References: <xmqqo7xufee7.fsf@gitster.g>
 <s3726r9p-r96o-7793-0qrq-o54rs4npr972@tzk.qr>
 <220713.865yk1456z.gmgdl@evledraar.gmail.com> <xmqqtu7ldmrz.fsf@gitster.g>
 <p8srrprq-s23s-711n-n452-34qr856qso29@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <p8srrprq-s23s-711n-n452-34qr856qso29@tzk.qr>
Message-ID: <220714.86mtdb1jmp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 14 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> On Wed, 13 Jul 2022, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>> > I'm not claiming that we always use 129 when we're fed bad options etc=
.,
>> > but rather that that's what parse_options() does, so at this point most
>> > commands do that consistently.
>> >
>> > 	./git --blah >/dev/null 2>&1; echo $?
>> > 	129
>> > 	./git status --blah >/dev/null 2>&1; echo $?
>> > 	129
>> >
>> > But yes, you can find exceptions still, e.g. try that with "git log" a=
nd
>> > it'll return 128.
>>
>> Yup, that was my understanding as well.  We may have existing
>> breakage that we shouldn't be actively imitating when we do not have
>> to.
>
> This patch series already implements `git bisect` in the desired way:
>
> 	$ ./git bisect --invalid; echo $?
> 	usage: git bisect [help|start|bad|good|new|old|terms|skip|next|reset|vis=
ualize|view|replay|log|run]
> 	129

It doesn't, the claim isn't that there's no way to have it return exit
code 129 on *some* invalid usage. In this case we do the "right" thing.

Rather that as noted in [1] there's other cases where we call die() and
should call usage_msg_opt().

Of course both of those would be more useful if the new built-in still
had the parse_options() usage info we could display. I.e. in this case
the conversion to a built-in leaves on the table nice benefits we'd get
for free.

Compare that with e.g. how "git bundle" handles it, note how we get not
only "don't do that", but also how valid usage would look like:
=09
	$ git bundle -h
	usage: git bundle create [-q | --quiet | --progress | --all-progress] [--a=
ll-progress-implied]
	                         [--version=3D<version>] <file> <git-rev-list-args>
	   or: git bundle verify [-q | --quiet] <file>
	   or: git bundle fetch [--filter=3D<spec>] <uri>
	   or: git bundle list-heads <file> [<refname>...]
	   or: git bundle unbundle [--progress] <file> [<refname>...]
	$ git bundle create -h
	usage: git bundle create [-q | --quiet | --progress | --all-progress] [--a=
ll-progress-implied]
	                         [--version=3D<version>] <file> <git-rev-list-args>
=09
	    -q, --quiet           do not show progress meter
	    --progress            show progress meter
	    --all-progress        show progress meter during object writing phase
	    --all-progress-implied
	                          similar to --all-progress when progress meter is=
 shown
	    --version <n>         specify bundle format version

1. https://lore.kernel.org/git/220627.86ilolhnnn.gmgdl@evledraar.gmail.com/
