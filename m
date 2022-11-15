Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547B5C4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 16:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiKOQGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 11:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiKOQGq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 11:06:46 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FA52609
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 08:06:45 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id m22so37138555eji.10
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 08:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rq76/tBaQZs9oNWOHcy/AIHBHedgneYuMOQ4QbpXP98=;
        b=mhl/qbleE7XdbO8qEVdckzaBqBbvonKhPiJpTssXAa+geZqybF/vSTrgS2xhyJEaxc
         BKiNNtxvY9pA3szjPY5Y4X69/NIpSzPsCRoQxd/s8WA97iuqb9k9PlFzNCWZXISrYeU9
         SF9jEhCDXHoRA3NUwFNcgf1q73S8dL8GhwtsShaz4kR97QKLLWVuczMYzc3qBFVfCvln
         r7fbnIkiO45JY2vFN+YE0NYd0qwqpw8M0Rzi8RYxdnNVn8q+eo3PEOv5dJLX3vfhRXjb
         jadU3zm2kC/LRooqIc+ukCsZuWzDIY8LFimo1I5uYGUHnwOFEKfO+RATTQHfpO8S6BLR
         N8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rq76/tBaQZs9oNWOHcy/AIHBHedgneYuMOQ4QbpXP98=;
        b=obXEFACoN1HqkG6O37kZxNDtNRZbOOVXlmWITqvc7K5nDSmt1DfD/kCHh5j+bgzbws
         ZAp9tevzlb2s38uKP4Ml4OVwEfmoeEzaD65f+txpm3sHz+0E8Kb3PDT77b7hBjWkwUVN
         bzdHr9wpHT1U+ahNt2xdkx+Cjdk0ZQfsbbfJNupOPsp8N27pZTdmH1T5hGWIdv+6dtmU
         5q3gAUCE0D8sHuui23UEUWYjY+nyk+LdFDMCBuImMh/IYJ6BqTAGkcbxNVSIftd9xGac
         zvuBtJp41WzwFSm0kdJO0OHl4E3DEstZQNYlfzw6u0QLf5ZJdzXJRU76I+lNHbvcm8kj
         d9og==
X-Gm-Message-State: ANoB5pn+WFC8v7EotejrT9VK826CuhZVMZMLfc7u96u90W7olsD73s0d
        D4oB4Bv9PAGJUnkh8CLaN4lz08jOa4tmuA==
X-Google-Smtp-Source: AA0mqf5Gy0WlMfc/hVHUGZ59J4dRzLVOEzeAjNpcQlNzZ4t48pznlmYJO5pwKQ2Sj5otVklpRNLc4w==
X-Received: by 2002:a17:907:990f:b0:7ad:79c0:5479 with SMTP id ka15-20020a170907990f00b007ad79c05479mr14352924ejc.392.1668528404193;
        Tue, 15 Nov 2022 08:06:44 -0800 (PST)
Received: from gmgdl ([109.38.136.37])
        by smtp.gmail.com with ESMTPSA id lb4-20020a170907784400b007ae243c3f05sm5650773ejc.189.2022.11.15.08.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:06:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ouySP-003eJ3-2r;
        Tue, 15 Nov 2022 17:06:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Ronan Pigott <ronan@rjp.ie>
Subject: Re: [PATCH] builtin/gc.c: fix -Wdeclaration-after-statement
Date:   Tue, 15 Nov 2022 17:05:32 +0100
References: <patch-1.1-54d405f15f1-20221115T080212Z-avarab@gmail.com>
 <3p6n2r7s-q136-n7q9-8o27-740q4qr5os84@tzk.qr>
 <r31o6p7q-po67-osr1-3qq8-93s4p3o23nq2@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <r31o6p7q-po67-osr1-3qq8-93s4p3o23nq2@tzk.qr>
Message-ID: <221115.86v8ngjj72.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 15 2022, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Tue, 15 Nov 2022, Johannes Schindelin wrote:
>
>> On Tue, 15 Nov 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> > In 1f80129d61b (maintenance: add option to register in a specific
>> > config, 2022-11-09) code was added which triggers a
>> > "-Wdeclaration-after-statement" warning, which is on by default with
>> > DEVELOPER=3D1.
>> >
>> > Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>> > ---
>> >
>> > This landed in the latest "next" push-out, causing e.g this CI
>> > failure:
>> > https://github.com/git/git/actions/runs/3467538041/jobs/5792504315
>>
>> I looked at the same thing all morning, and found that
>> https://lore.kernel.org/git/20221111231910.26769-1-ronan@rjp.ie/
>> _probably_ was designed to fix the same issue (and I think you agree that
>> that patch should be used instead of yours because it is more complete in
>> fixing left-over issues).
>>
>> However, try as I might, I did not find out yet why it does not apply
>> cleanly over here (I got side-tracked into range-diff'ing patches
>> downloaded from the archive, which is quite the challenge and not even f=
un
>> because `range-diff` requires commits, not emails, so I side-tracked
>> myself into teaching `range-diff` to accept mbox arguments).
>>
>> Maybe you can adjust that patch so it applies cleanly?
>
> Seems that the v2 of "maintenance: improve error reporting for
> unregister" [*1*] was _partially_ folded into v3 of "maintenance: add
> option to register in a specific config": At least the config change that
> talks about `--config-file` inste of `--config` _is_ part of v3, and one
> reason that the former patch does not apply cleanly on top of the latter
> patch. Which is a bit funny because the former patch was sent out two days
> _after_ the latter patch.
>
> And it looks as if there is one more thing that needs to be forward-ported
> from that no-longer-applying patch: the initialization of the configset,
> otherwise we're potentially trying to clear an uninitialized data
> structure.
>
> This is the patch I am currently testing (on top of Git for Windows'
> `shears/seen` branch:
> https://github.com/git-for-windows/git/commit/cd7b86d19f):
>
> -- snip --
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 635f12499d68..a3f63880dfba 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1569,6 +1569,7 @@ static int maintenance_unregister(int argc, const c=
har **argv, const char *prefi
>  	int found =3D 0;
>  	struct string_list_item *item;
>  	const struct string_list *list;
> +	struct config_set cs;
>
>  	argc =3D parse_options(argc, argv, prefix, options,
>  			     builtin_maintenance_unregister_usage, 0);
> @@ -1576,9 +1577,8 @@ static int maintenance_unregister(int argc, const c=
har **argv, const char *prefi
>  		usage_with_options(builtin_maintenance_unregister_usage,
>  				   options);
>
> -	struct config_set cs;
> +	git_configset_init(&cs);
>  	if (config_file) {
> -		git_configset_init(&cs);
>  		git_configset_add_file(&cs, config_file);
>  		list =3D git_configset_get_value_multi(&cs, key);
>  	} else {
> -- snap --
>
> =C3=86var, can you please have a thorough look and see whether there is
> anything else we were missing before advancing this to `next`?

Thanks, I submitted a v2 just now that addresses the unit'd issue as
well, and as we're fixing that we can just reduce the scope of the
variable, which makes it lifetime more obvious:

https://lore.kernel.org/git/patch-v2-1.1-f37e99c9d59-20221115T160240Z-avara=
b@gmail.com/
