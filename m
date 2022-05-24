Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBD3C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 21:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241204AbiEXVxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 17:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiEXVxR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 17:53:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199487092F
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:53:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id rq11so15899540ejc.4
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jqv1loJ+Ng4ERzor7bNeGllAGWd6+sv9YHQUDbehFtk=;
        b=KURayxD5BSeu8nXOOhgFs4S29v5nhrQg2v4GlP/Tx5mZDieKBhRk3qHIqn1eW9ABqg
         wVaGhjJ7TPKEFrIBHVabkYGlMG1rsUyH27dkXSJ4nPRdB/QjC3E2IqeSrgNXAwvPl9FE
         9eA9dLx1796JDULxxx8PwBu4iVy167N+ZUpP3rbOyc+Sc/cHMtS0JM78fbG8tbfEPvyL
         aYJ613Ne38kuexqHeOHpdokZcNSIUmef1LLFaJlwBTWnWzlBsTsw4kTvHdKNCnxNjwUV
         Ma8K35F0PMxWvjLHTlkZM1AwBtplecANG0PRBZ/BSkmseR5gMyLLSQFONo0EguZxZtB/
         oU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jqv1loJ+Ng4ERzor7bNeGllAGWd6+sv9YHQUDbehFtk=;
        b=X7On/Lyg73lpIYdv0SeAzYvR4WDa2E815uAc+sQEsVBt6l7fKDyAgVgxk3zBc2JkiN
         jH/mtUEEKDq80JkGEPqENut04wLYAy9IpsZKMLeTfSY6yP8t3BEw7jtrqqoKQPSUpIqM
         w8PWLE9KuoxkTA4q9sorej5cK47jcS1Yg1YYbcgCI6pm8F18vF5coUBSAgQlwG67+cYK
         +Dw5+kwLZDszLap+7BtMk+T99YeOLKH1YTDVnX5N9kwertb8jUW+rFHJSHLBJ9sox4NR
         6QRu7Yk/CUwOy78A57uVXymNdiHYeveBjZhlgf09DnFZ9wY8JH+Bt16Cdb5sp1W6uf23
         t4PA==
X-Gm-Message-State: AOAM530nk3o6V0uQl0ajAQ/z2yOz7Sgq11ETfOVHUte/Jj4xJZKarqKc
        U8YCMeomsqLOxtW4dzh18KY=
X-Google-Smtp-Source: ABdhPJyZHK578m+gQkfSPCrZwioGWAlsEB8+gqAj/JCO9L37SrerpJdgf5MV2UrmPqrQ3hPBkOGzNA==
X-Received: by 2002:a17:907:6d0c:b0:6fe:f835:ae54 with SMTP id sa12-20020a1709076d0c00b006fef835ae54mr8727415ejc.173.1653429194636;
        Tue, 24 May 2022 14:53:14 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id mj9-20020a170906af8900b006feb7b1379dsm4445146ejb.181.2022.05.24.14.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 14:53:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntcSn-003cDc-JF;
        Tue, 24 May 2022 23:53:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, vdye@github.com, jonathantanmy@google.com,
        gitster@pobox.com
Subject: Re: [PATCH v2 1/4] pack-bitmap.c: check preferred pack validity
 when opening MIDX bitmap
Date:   Tue, 24 May 2022 23:51:26 +0200
References: <cover.1652458395.git.me@ttaylorr.com>
 <cover.1653418457.git.me@ttaylorr.com>
 <618e8a6166473d238e62ce6243d9a0b2b72ee2f0.1653418457.git.me@ttaylorr.com>
 <220524.864k1ewwh4.gmgdl@evledraar.gmail.com>
 <Yo1QZe5CyYWGGtYR@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yo1QZe5CyYWGGtYR@nand.local>
Message-ID: <220524.86wneatx6e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Taylor Blau wrote:

> On Tue, May 24, 2022 at 09:36:45PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Tue, May 24 2022, Taylor Blau wrote:
>>
>> Just nits on the error reporting:
>>
>> > @@ -353,6 +355,20 @@ static int open_midx_bitmap_1(struct bitmap_index=
 *bitmap_git,
>> >  		warning(_("multi-pack bitmap is missing required reverse index"));
>> >  		goto cleanup;
>> >  	}
>> > +
>> > +	for (i =3D 0; i < bitmap_git->midx->num_packs; i++) {
>> > +		if (prepare_midx_pack(the_repository, bitmap_git->midx, i))
>> > +			die(_("could not open pack %s"),
>> > +			    bitmap_git->midx->pack_names[i]);
>>
>> Some existing API users of this & their error handling suggest that this
>> message is wrong. I.e. it's not that we couldn't open it, but that we
>> could open it and there's something wrong with it. Or perhaps their
>> messages are misleading?
>
> I tried to reuse some similar message based on "git grep 'if
> (.*prepare_midx_pack'", so this was inspired by:
>
>   - the caller in midx.c::write_midx_internal(), whose error is "could
>     not load pack", and
>   - the caller in midx.c::verify_midx_file(), whose error is "failed to
>     load pack"
>
> Are you suggesting we should s/open/load here and use the above error
> message? My feeling at the time was that "load" was basically synonymous
> with "open" given the context, but if you think they're different
> enough, or have a different suggestion LMK.

Perhaps "parse" or something? Anyway with "could not open" I'd assume
open() failed, but in this case it looks like we could open it, but
(mostly?) failed later.

Maybe "could not load midx"? I don't know...
