Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325B5C49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC5F6120D
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhFXTc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhFXTc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:32:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF780C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:30:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r7so10095098edv.12
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=pl+E+fCm5W2VkuWgQ7oapo1U4RN0IQiH0mBNlw0qkA4=;
        b=IpXxsIuLKeJNcCOBeamE18Aa1q1Vmb22MXUeCeLxcKKef0hU1ibZhVfmVa3vm6/a3i
         ky8dn6gZddjss1lKyXiekpL2WbRWTiEE0qHx2PSET63L9686/5jBcjK+42ELq7xuOGZG
         hR5uGKPxdBsEtOUtK8MDvY9l1/O14JzwpwW/GKtv8UlpN/DTYlUUZuJj2y5Fa0FCV2HZ
         qt3njOMxdaeGfATR7ch95X1jLFvUrrxXfyOfzl2Z/ckGynuoGyMOjns2HfykXYsi/SDF
         1YFXzbhoG+Y96LaZczIA50QaQSF2I84Ax4QpARChO1/DGTw4Eb5HjtgtcNVZOfEFYPk1
         PrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=pl+E+fCm5W2VkuWgQ7oapo1U4RN0IQiH0mBNlw0qkA4=;
        b=rWCp5voIpgSSz3PHtjYLBHfdsws6I1pITi97dxueBqNj9zv8F/IOC8s0AQpfRL57F9
         71eh+P/rTEMNvMIcVH3kaSkUbUFUR5AMm6ZyQJqz8frA7T4bs2odjvpw45DgoxJrMMzq
         BRB/zaOouFG6ODArFxjxdrP5OPUTbxtHT0e0hDRjix7FTqpVR6cRS630gmlLcwxdYZr7
         WYHNOyYZFC4vM4qwhArtR/DIeZq6uWomIALFtUWI40wMnU6JEToWJizxdCBdApCGQfbQ
         bLs4QpbpWt8kpPLom0UVdA0LgHAm/o0g3pKsVpIMQbda2s/qFLoyyz+iziUItxmKu0ot
         vxFQ==
X-Gm-Message-State: AOAM531sMIDNIP9loaxoNxzKvbr50Bn6UfzEtmv7FmcW61tR8vNscaZx
        2b4fhZyLB8dy3EqHamrrNxE=
X-Google-Smtp-Source: ABdhPJxf28bcmtC27KhztMKvH5lrvkCkNO7BlKnksVJ1Iacw8YkDP78l38WNvcEIGJyhp75JCE7jOQ==
X-Received: by 2002:a05:6402:31a9:: with SMTP id dj9mr9464997edb.164.1624563036201;
        Thu, 24 Jun 2021 12:30:36 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p13sm2481287edh.79.2021.06.24.12.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:30:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v2 1/3] bundle cmd: stop leaking memory from
 parse_options_cmd_bundle()
Date:   Thu, 24 Jun 2021 21:28:24 +0200
References: <cover-0.3-0000000000-20210617T111934Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
 <patch-1.3-932c0883ce0-20210621T151357Z-avarab@gmail.com>
 <YNS4wCjkp4yiLLBQ@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <YNS4wCjkp4yiLLBQ@coredump.intra.peff.net>
Message-ID: <87v963ys9x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 24 2021, Jeff King wrote:

> On Mon, Jun 21, 2021 at 05:16:12PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Fix a memory leak from the prefix_filename() function introduced with
>> its use in 3b754eedd5 (bundle: use prefix_filename with bundle path,
>> 2017-03-20).
>>=20
>> As noted in that commit the leak was intentional as a part of being
>> sloppy about freeing resources just before we exit, I'm changing this
>> because I'll be fixing other memory leaks in the bundle API (including
>> the library version) in subsequent commits. It's easier to reason
>> about those fixes if valgrind runs cleanly at the end without any
>> leaks whatsoever.
>
> Looking at that old commit, it seems like this is a good candidate for
> just inserting a single UNLEAK(bundle_file) into cmd_bundle(). But it
> looks like the allocation has now migrated into all of the individual
> sub-command functions, so we have to deal with it multiple times. They
> could still use UNLEAK() if you want to avoid the "ret =3D foo(); free();
> return ret" dance in each one, though.
>
> We should avoid UNLEAK() in library-ish functions, but sub-commands that
> are just one step away from cmd_bundle() returning are OK uses, IMHO.

I'll change it if you feel strongly about it, but I always read UNLEAK()
as "ok, this is too hard, we won't bother, it's just a one-off
built-in", and not necessarily a recommendation for a desired pattern.

I think it's nice to have e.g. valgrind be able to report no leaks in
the binaries we build by default, not just if you compile with
-DSUPPRESS_ANNOTATED_LEAKS.

>> @@ -92,77 +93,107 @@ static int cmd_bundle_create(int argc, const char *=
*argv, const char *prefix) {
>>  	if (progress && all_progress_implied)
>>  		strvec_push(&pack_opts, "--all-progress-implied");
>>=20=20
>> -	if (!startup_info->have_repository)
>> +	if (!startup_info->have_repository) {
>> +		die_no_repo =3D 1;
>> +		goto cleanup;
>> +	}
>> +	ret =3D !!create_bundle(the_repository, bundle_file, argc, argv, &pack=
_opts, version);
>> +cleanup:
>> +	free(bundle_file);
>> +	if (die_no_repo)
>>  		die(_("Need a repository to create a bundle."));
>> -	return !!create_bundle(the_repository, bundle_file, argc, argv, &pack_=
opts, version);
>> +	return ret;
>>  }
>
> This die_no_repo stuff confused me at first. But I think you are trying
> to make sure we call free(bundle_file) before die? There is no point in
> spending any effort on that, I think. When we exit() via die(), the
> variable is still on the stack, and hence not leaked. And there are
> probably a zillion other places we can hit a die() inside
> create_bundle() anyway, which would produce the same effect. There's not
> much point treating this one specially.

Right, it's there just for the free(), and yeah, there's a bunch of
places we'll leak anyway.

I do think per the above with valgrind that there's value in making the
common non-dying codepaths not leak though.
