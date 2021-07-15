Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2235C12002
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 00:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B117261377
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 00:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbhGOAMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 20:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbhGOAMO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 20:12:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BD5C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 17:09:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v1so5562410edt.6
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 17:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RqBaFQz77vFFv71ZPuVChpPW0E/t6VuQiA7+kjlFhEs=;
        b=qGjRa+tVpctePgUm2r+z+XpOfOQfzsrkXkn86PPi0xQaXULId1pvfBiMkdW91XMzhX
         KRUShYcMHOKXAKpC0hxqVFwOLBo5gzaoOH1PiPIGQeZgQARzZft39eOX5N5FROzXQAWb
         6Qb/f9tfeLAZug8KVvyKao7qK7In2c0i57VKQPVfGcQEUxjQQOC5Y83aCPOJL0oMR1YH
         Bi1d8hDfwVNvOvc4UEAvxqBGxt2HAairggy+ta1e+xP1wjdfM+Csu1TBKP27bl24/ZQd
         SWAUo6Gf6nodSzhvMSEaTDeThOhpMQmVVycLJIB0SGAOdb0O5Qt7yQf6lCELP6VaktX0
         JX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RqBaFQz77vFFv71ZPuVChpPW0E/t6VuQiA7+kjlFhEs=;
        b=lq9SVMNOMUR53Vjd12BFhjf0e5mhTmHuGBjhDfxWKUxgf4J1WWo4a/vQ0goKizu9Y4
         kOUKnpCUGc5r/prCnvDzomNxPVk2aTPHD2HdX/uUskn1MNqsi1Ts/iud344SNjY57qo6
         rZVueFzWvzvnfusFvRxzc6cJl0TfSH4VPBZiU9qpQCJRettkzTsZqxuNtaeBKwcAYJQE
         oYaCJFaElJXVremLqsZBHDNh677Ok1LxUwT0ydjuzs/sLyy9X2p8/9vdWUMhyJVWUJkV
         ML5/ofnz3AyWFH9avAifjWHfmpELfv2364m8oTCcnGx7TlwOlN/okYkGqjQolS3cBzIV
         a2OA==
X-Gm-Message-State: AOAM531v1inc0YTFaJc4gBXYfjDmA2VTqGFQf8dzv+/z9kiQPeX8GnT/
        vsyPRORc1KFMe2+a4LqBLEE=
X-Google-Smtp-Source: ABdhPJzjdWeivlm2KvkwTtalIgM/AjwjGiRITHXSgSkxEoGjPSvl9nKzptYfxVvpizwIUymbFa1PBQ==
X-Received: by 2002:a05:6402:5cd:: with SMTP id n13mr1308768edx.345.1626307760152;
        Wed, 14 Jul 2021 17:09:20 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m15sm1633074edp.73.2021.07.14.17.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 17:09:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] refs file backend: remove dead "errno == EISDIR" code
Date:   Thu, 15 Jul 2021 02:02:40 +0200
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <YO8PBBJZ2Q+5ZqFs@coredump.intra.peff.net>
 <871r801yp6.fsf@evledraar.gmail.com>
 <YO9wCqetxHii+TvK@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YO9wCqetxHii+TvK@coredump.intra.peff.net>
Message-ID: <875yxczbd6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Jeff King wrote:

> On Wed, Jul 14, 2021 at 09:07:41PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > Isn't that pseudo-code missing a conditional that's there in the real
>> > code? In refs_resolve_ref_unsafe(), I see:
>> >
>> >        if (refs_read_raw_ref(refs, refname,
>> >                              oid, &sb_refname, &read_flags)) {
>> >                *flags |=3D read_flags;
>> >
>> >                /* In reading mode, refs must eventually resolve */
>> >                if (resolve_flags & RESOLVE_REF_READING)
>> >                        return NULL;
>> >
>> >                /*
>> >                 * Otherwise a missing ref is OK. But the files backend
>> >                 * may show errors besides ENOENT if there are
>> >                 * similarly-named refs.
>> >                 */
>> >                if (errno !=3D ENOENT &&
>> >                    errno !=3D EISDIR &&
>> >                    errno !=3D ENOTDIR)
>> >                        return NULL;
>> >
>> > So if RESOLVE_REF_READING is set, we can return NULL immediately, with
>> > errno set to EISDIR. Which contradicts this:
>>=20
>> I opted (perhaps unwisely) to elide that since as you note above we
>> don't take that path in relation to the removed code. I.e. I'm
>> describing the relevant codepath we take nowadays given the code & its
>> callers.
>
> It's not clear to me that we don't take that path, though. The call in
> files_reflog_expire() looks like it violates the assertion in your
> commit message (that we would never return NULL with errno as EISDIR).
>
> So I'm not entirely sure that the code is in fact dead (though I
> couldn't find an easy way to trigger it from the command line). I do
> think it probably can't do anything useful, and it is probably still OK
> to delete. But in my mind that is quite a different argument.
>
> Maybe that is splitting hairs, but I definitely try to err on the side
> of caution and over-analysis when touching tricky code (and the
> ref-backend code is in my experience one of the trickiest spots for
> corner cases, races, etc).

I'd entirely forgotten about this, but I had a patch to remove that
"oid" call entirely, as it's really an unrelated bug/undesired behavior

You also looked at it at the time & Michael Haggerty reviewed it:
https://lore.kernel.org/git/20190315155959.12390-9-avarab@gmail.com/

The state of that patch was that I needed to get to some minor issues
with it (commit message rewording, cleaning up some related callers),
but the fundamental approach seemed good.

I then split it off from the v4 of that series to get the non-tricky
changes in:
https://lore.kernel.org/git/20190328161434.19200-1-avarab@gmail.com/

I then just never got to picking it up again, I'll probably re-roll it &
make it a part of this series, then we can remove this whole OID !=3D NULL
case and will be sure nothing fishy's going on.
