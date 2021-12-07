Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01729C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 17:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbhLGR6D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbhLGR6D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 12:58:03 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C04C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 09:54:32 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x15so60392252edv.1
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 09:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=aUv1UUvlMn7Euc0loRAtk7KNh0BfZwgxAW5zds/INrY=;
        b=nxPWtCByFxK9hyOmX913psP5H5kySIze9M95/EeVipJk3RYw6qZbsnJKVdiStchW4J
         67FO6OWArXbeHc+KwAzm61+yRZowMD+qpfxIdoOFLaaSycQxAxLY3+a2sQr6V4/5NLrS
         M6iGkGshHLGQYQqCdzGenEIyiSKW+Tu4Hndku3wPP2oewelExpAK6jcXEf0QXfgHPOzY
         VKVN5L59KJEchC7CcnKYq8khXV2jl/IjrVrPkC9ZBQQhEFa5FHP0NaJh5/oAAhi7maLS
         SiauXLRPZPg3tL85d8y2kYQjjFshuVDw/J4VkAE4H6iWWByRhUHi02n3eCxI7j5Tvkhy
         Xb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=aUv1UUvlMn7Euc0loRAtk7KNh0BfZwgxAW5zds/INrY=;
        b=yCd/gNTMNiZTytwudEoHC2d+QoFHIva/Xu95LVSmwHIFMk8id3ujL0Z4K7t+i9Jqy7
         +q9aEPK6OSaXDQRGPfIgpAMlsCDQxXD4C5xMD4J/h51FIfB4derLq8TryeDHfi6SfkXP
         UnV9dAJi/sCeAqDV71q+u4km1g2GJ47EUWNHbncw04T6AVfEM330OAgHFSvaFUbwhzFg
         l6/c5Q8xRVS6RzsGQfQN6qHXrIWOVKRa0Hqyg0LL8ubZP9D6xoLLnGspsz+99hZSlZW5
         8E+C8wxI/M7K6d1TWC2HTQVlhGEwuAE9G8TjbGTh2qFDjOYBCmImyWr8I6kvN8jfXtiv
         8ZXQ==
X-Gm-Message-State: AOAM533OmxnhrWw3cjS12YORsykHBJugntvOs5pg2dIJGL4aXQQXrcuf
        yI2UxopFLWMDSySCvJZ1XzhAGYIbz4z2Xg==
X-Google-Smtp-Source: ABdhPJzpz7rWd4lKBGlrxG3M/KZZCZqPcjBYJY+hSaEmwDF2Zrx/T0lNx95+TM5+YouM3U8+gQLvag==
X-Received: by 2002:a05:6402:1292:: with SMTP id w18mr11339493edv.46.1638899670737;
        Tue, 07 Dec 2021 09:54:30 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sg39sm138898ejc.66.2021.12.07.09.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:54:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muefc-001Ehs-8Q;
        Tue, 07 Dec 2021 18:54:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Fwd: coverity problems in reftable code
Date:   Tue, 07 Dec 2021 18:46:02 +0100
References: <YarO3nkrutmWF7nb@coredump.intra.peff.net>
 <CAFQ2z_OK5949p1WfovJ00Katk5hTv_oeLo-ZRCi1XqrtzQqL2g@mail.gmail.com>
 <CAFQ2z_OrN+RkwnMyrJHdh5xN6ueOP8KKBVQ7-U4kEkA3ApcuNg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CAFQ2z_OrN+RkwnMyrJHdh5xN6ueOP8KKBVQ7-U4kEkA3ApcuNg@mail.gmail.com>
Message-ID: <211207.86o85snvvv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 07 2021, Han-Wen Nienhuys wrote:

> On Sat, Dec 4, 2021 at 3:13 AM Jeff King <peff@peff.net> wrote:
>> We're not doing project-wide analysis with Coverity right now, but I've
>> been doing builds of my personal repo, which I usually build off of
>> next. And since hn/reftable just hit next, it got included in my latest
>> build.
>>
>> It came up with several complaints. Some of them are dumb and can be
>> ignored (e.g., using rand() in a test harness, oh no!) but I poked at a
>> few and they look like real issues:
>
> I fixed most of the obvious ones.
>
>>   - A lot of your structs have vtables. Initializing them to NULL, as in
>>     reftable_reader_refs_for_indexed(), leaves the risk that we'll try
>>     to call a NULL function pointer, even if it's for something simple
>
> I have the impression that coverity doesn't understand enough of the
> control flow.  Some of the things it complains of are code paths that
> only get executed if err==0, in which case, the struct members at hand
> should not be null.

I think coverity is right and the code has a logic error as it
suggests.

In the reftable_reader_refs_for_indexed() example Jeff cites we'll "goto
done" on error, and the reftable_record_release(&got_rec) will proceed
to segfault since the next thing we do is to try to dereference a NULL
pointer in reftable_record_release().

You can reproduce that as a segfault in your tests with e.g. this patch
below, which just emulates what would happen if "err != 0":

diff --git a/reftable/reader.c b/reftable/reader.c
index 006709a645a..4c87b75a982 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -663,6 +663,7 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
        /* Look through the reverse index. */
        reftable_record_from_obj(&want_rec, &want);
        err = reader_seek(r, &oit, &want_rec);
+       goto done;
        if (err != 0)
                goto done;

In that particular case this appears to be the quick fix that's needed:

diff --git a/reftable/record.c b/reftable/record.c
index 6a5dac32dc6..e6594d555e5 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1090,6 +1090,8 @@ int reftable_record_decode(struct reftable_record *rec, struct strbuf key,
 
 void reftable_record_release(struct reftable_record *rec)
 {
+       if (!rec || !rec->ops)
+               return;
        rec->ops->release(rec->data);
 }

But in general this looks like an excellent candidate for some test
fuzzing, i.e. to intrstrument the various "err" returning functions to
chaos-monkey return non-zero some of the time and check for segfaults.
