Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5D1C433EF
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 00:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiCZAtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 20:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiCZAtE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 20:49:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D204425F664
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 17:47:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r13so18362197ejd.5
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 17:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=66WkhOtKhRQnokakzAg0lTfDpwDWniNKwmd26USJJn8=;
        b=V3u5TvLK/0BVbEdLGmWmeZjSn3RpQOYfaiZLnSCdbUbBOgFU75tWCRpVzqXpGa0FKu
         H9avW283JbaISuQ7DBe8hOE5tiX83kVpIf+dXnqCUUWg+2H/Z99/cbPtfJqo9WYnHet5
         etBEH5Fqn9ero3/7xtNIOC58VwGLRvvpjFeqtB+y4f1QRDJjqAm3EIqt9A7EExp4fPq5
         pSaFDSLG7heu6P0zE0e4olO9LzHcmmTsusFKeQ8oBYKZJEqXIUmpv+crjRhRD5dKVoap
         RnBx5py+OnDsZUuWo1vnLUzWNN/dsafGMNB83wP0h50Hhs7ZacApVectb/ZypHNHtT/r
         CkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=66WkhOtKhRQnokakzAg0lTfDpwDWniNKwmd26USJJn8=;
        b=CFHturgjekcoGxY8WyIWP31I5IRorxfb3HMyrTYhYWYiPKreAIXKwjcZlJtYvgAQdz
         z+mBwVGS0tNCashvErlJ4FLJh9rb9Snd0HmQ68avjZXr8SQEYNNkDMQ6dY/ILTxrmLYJ
         0IaCP9R32a2wUukZcN2AvMVl0d3aMmdDtiyEc6ohahaTEx948rgbZwdIe7tduqAvLUK9
         qPfMo/fYXJPp5nkxHqEmG7bw0+ioAoGBcQTrtJjfAokJBKxv+wk1RlHPu8FbQYUHUY9J
         yG8Ms53SGkSvrBzTp39teHVrqNal613e+No0m4AUNBnJBEYtjJMIm1M2pMFzrwFzWG9y
         YDCA==
X-Gm-Message-State: AOAM532yDzPiPejakwEO1AEejFbqUew8jdp+A1IIfidt+LOdrU03E58W
        tz1KkIOn9sabYs8N/0SoJ64caz3JOlu5PQ==
X-Google-Smtp-Source: ABdhPJy18VC/iwcHqzzRVFjCZWqs+cWEuDD414p2VLNrJifnhQUdRfEG7eodsR+NZaXeEQnZ1rs7PQ==
X-Received: by 2002:a17:906:5ad6:b0:6e0:1799:4a15 with SMTP id x22-20020a1709065ad600b006e017994a15mr15191746ejs.594.1648255647104;
        Fri, 25 Mar 2022 17:47:27 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c11-20020a056402120b00b004196059efd1sm3417401edw.75.2022.03.25.17.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 17:47:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXuaT-002K4K-Qz;
        Sat, 26 Mar 2022 01:47:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 08/27] revisions API users: add "goto cleanup" for
 "rev_info" early exit
Date:   Sat, 26 Mar 2022 01:37:50 +0100
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
 <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
 <patch-v3-08.27-f8a9443fe6f-20220325T171340Z-avarab@gmail.com>
 <xmqqtubl93n3.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <xmqqtubl93n3.fsf@gitster.g>
Message-ID: <220326.86ee2pleua.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 25 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> It would be a lot cleaner to be able to initialize "struct rev_info"
>> with "{ 0 }" here, or if a "REV_INFO_INIT" existed, we'll hopefully
>> get around to making the initialization easier in the future (now it
>> can't be done via a macro).
>
> If "struct rev_info" can be initialized with "{ 0 }" here, i.e.
>
> -	struct rev_info rev;
> +	struct rev_info rev =3D { 0 };
>
> to give us a valid solution, why wouldn't you be able to do
>
> +#define REV_INFO_INIT { 0 }
>
> elsewhere in a common *.h file, and then
>
> -	struct rev_info rev;
> +	struct rev_info rev =3D REV_INFO_INIT;
>
> to make the fact that "rev" is initialized (and ready to be handed
> to the releaser) even more explicit?  It's like arguing against
> fixing a code like this:
>
> 	struct char *pointer;
> 	...
> 	if (condition)
> 		pointer =3D malloc(...);
> 	...
>         /* pointer leaks */
>=20=20
> by initializing
>
> 	struct char *pointer =3D NULL;
> 	...
> 	if (condition)
> 		pointer =3D malloc(...);
> 	...
>         free(pointer);
>
> because for some reason you are against the macro NULL but you are
> willing to spell it out as "0" (without double-quotes)?

I was fine with having it be { 0 } and have "release" functions
everywhere assume that memset-ing structures to zero makes them safe to
pass to release(), but my reading of your v2 feedback was that you
didn't like making that assumption, so I changed it in the v3 so we
wouldn't assume that.

I then took that REV_INFO_INIT suggestion to mean that this series
could/should be predicated on some cross-codebase refactoring to change
all of the "struct rev_info" initialization, which would be a rather
large digression.

Because I don't see how it makes any sense to have a REV_INFO_INIT if it
doesn't actually give you an init'd "struct rev_info" that's ready for
use. I.e. if you still need to call repo_init_revisions() it's just a
misleading interface.

I also think the cosmetic issues of initialization here really aren't
important at all, fixing these leaks is. So whatever idioms you're OK
with us using here are fine by me, as long as I can be made to clearly
understand what you want for a re-roll :)

Very preferably something that doesn't require refactoring the entirety
of "struct rev_info" init across the codebase...
