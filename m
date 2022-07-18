Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A008EC43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 16:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbiGRQL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiGRQL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 12:11:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F152A710
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:11:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id va17so22234033ejb.0
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=He34IZQPwLqddnkB1ExMQLzj4PM0ep6QbWogykDpDxk=;
        b=ay8Zeu/7wSLXVuZoa4XJPsrVgEZfLnYMseJVmTBPm3gPEvMZ5tKrlol14O6hK+8eqN
         LKdNG9/g1ixh4g0Qj3l8DS1RtEHmWOCSOh64Oy4a+DX55BauFWMBWJg7N87iRPs5WMeZ
         aIvEXaXjrbv3GEysNfmi7wcCRz2m+eJimzdQsyjRQcaHb0hs5fw11N0EOHrhMPi2ujex
         o/RgMQgFXhsM8v3oG339K0KMR/cIKUCfODLxBPcllxgMgh6T3aPhHxvIEXWvLO7N2dJR
         l4h4lFS2p6f9wCWWPc9XpgGHWNN7UruVqw/QEO//veYhIP/YO+8V0DlrFIAMOWPUMirR
         4M8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=He34IZQPwLqddnkB1ExMQLzj4PM0ep6QbWogykDpDxk=;
        b=iqLLP4J2QRRF5hrhhLh8dKL0iRT+4R8MFxmYk73opkTkx44As8zFFjco0WCdyPUVLi
         17XJ0uSCb+4aHzhu807f0Um/ZUQlTWXdEFglTM+VhrSL/nRA83WsCEUT8QCDKWy/9MZj
         h4pjPvzgl97+tiltKKFQxnx0hoJMfyXFvtGVaB8v180v1SkJhsnJgIPxyVmCK6d3bzo2
         0kELFrE1/n2HcjW4XOBP5k+NeQcILvqqoMr8WYkWEpKlrldA1fwpoV0F/aPvtkJoU9Wx
         fFxTjxNrSJpLgMG3FG7dLHx/VFbyQmVW7z7HNB7qbvPWoaKIUd26BvB7mHM1cvslAEB8
         LduA==
X-Gm-Message-State: AJIora9u3Va9bRanevAQrqhdPNkoWf2Bsas9st5rxFmWqnnEYqASgqxC
        jC/09HXdQu1W9xjBTE9f7zs=
X-Google-Smtp-Source: AGRyM1ugpWJ6xhCiW5eBVkOuDpduyOzetoKMCkd0XfZa3LfRxM5yZGClJ8A60qMknkxya4GMziwMxw==
X-Received: by 2002:a17:906:2086:b0:715:7983:a277 with SMTP id 6-20020a170906208600b007157983a277mr26191512ejq.386.1658160715052;
        Mon, 18 Jul 2022 09:11:55 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906560d00b006fee98045cdsm5712525ejq.10.2022.07.18.09.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 09:11:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDTLd-003EYq-L0;
        Mon, 18 Jul 2022 18:11:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH 09/11] submodule--helper: free "char *" in "struct
 update_data"
Date:   Mon, 18 Jul 2022 18:10:16 +0200
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
 <patch-09.11-7b36f71879e-20220713T131601Z-avarab@gmail.com>
 <kl6ltu7j4k98.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <kl6ltu7j4k98.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220718.86v8ruwgc6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 14 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Make the update_data_release() function free the "recursive_prefix"
>> and "displaypath" members when appropriate. For the former it could
>> come from either "argv" or from our own allocation, so we need to keep
>> track of a "to_free" sibling seperately.
>
> Obsolete message probably? "recursive_prefix" no longer exists as of
> gc/submodule-use-super-prefix ;)

Thanks, will fix!

>> For "displaypath" it's always ours, so the "const char *" type was
>> wrong to begin with, it should be a "char *" instead.
>
> Ok.
>
>> For update_submodule() we'll free() these as we go along, it's called
>> in a loop by update_submodules(), and we'll need to free the "last"
>> one.
>
> Hm, I don't follow this part. Does "as we go along" mean "as we go along
> freeing things in update_submodules()", or "we'll do this later on"?

You know what? After looking at this again I have no idea what I was
talking about here, and I think this makes no sense... :)

> I'm assuming it's the latter since this patch only frees the "last" one
> and doesn't free inside of update_submodule(), but maybe it's not so
> hard to do? I think it's just:
>
>   diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>   index 0bac39880d..34b54e97d1 100644
>   --- a/builtin/submodule--helper.c
>   +++ b/builtin/submodule--helper.c
>   @@ -2560,6 +2560,7 @@ static int update_submodule(struct update_data *u=
pdate_data)
>   {
>     ensure_core_worktree(update_data->sm_path);
>
>   +	free(update_data->displaypath);
>     update_data->displaypath =3D get_submodule_displaypath(
>       update_data->sm_path, update_data->prefix);

Thanks, I'll fix this case in a re-roll, fixing it generally turned out
to be a lot trickier though, but in the process I fixed a lot of the
control flow issues. Am currently running extensive tests on it.

Thanks a lot for this & other reviews, it's been really useful, as
always.
