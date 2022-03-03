Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9199C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 10:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiCCKIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 05:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiCCKIP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 05:08:15 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C35FBC9B
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 02:07:29 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o1so4861523edc.3
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 02:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=XnesJLMnzRxY4vpeTXgp9CjTihhQ1LU8GWK5rsO0Vng=;
        b=ZZ2XglR0PJYkB8m5/ljrQ8Y70UAYNup6kgdDuFqB504nrt1GD3iZGRmDOvaCwvKoFI
         2A5VILTsQA30NoDHz3SXLPMiSPEVB5UNzejZ4VxI/V/w+8mjqT8PICB7NBrLNEVKhmfB
         qlNc8MLZpU9rFmJnQARQMHJMsxhdA0Hnavi3I8V6rL6+TxIoGn1OJ9yB6dp5pN3YiMyF
         NBcbpq6oe8rnLrNIzm9EQtPYHPhQoaN8iMoaxTLtR2VcvxHX61lQUAx9Q6ui68OwnC/u
         18oiwTDy8v4p78QnuLcWSzjUN91eMjiD33TFuYmK5Rg1DvnLaPHUjXUyZve+WFuEN87E
         riDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=XnesJLMnzRxY4vpeTXgp9CjTihhQ1LU8GWK5rsO0Vng=;
        b=ziq5wPpfLyYqyA+B411eMKaUkUh3wYNCUfc1JrNP8ZJDe957FETxQVu9FhiviTYtvY
         PQJl00Z5SF0grTiA2O2cNKgTQrmEY2VLOCQ4T7cWQYznwGjKFZWNLKIVe1qXwSbS5Nt/
         yYHbx2uUJVzLCKZ7J7hnrXjrkA9t1kNSbmTwB+nKqET0Jcp7L5Hil07UOrMAo31m8yWH
         R4YoG99sR6mpQj7fYuqLUfiV0nbRAXXKJPN8Ojnu8pa44RsTLIV/p/sFIC5SVZPIUncV
         fnZ9kRIhTK/n0TnCZs5nn0RCh8tcnxWRlqQ3p4HmqPnKo4CZLlfe50iW7L6iiEwktLQu
         zdMA==
X-Gm-Message-State: AOAM533biLd0yJjsDece+sxs0jkNV1TFmV83tyOXsMW/P/TLl82BbqkU
        NXRdBC0cxToxgBvo6+EOL4vpfMPFpZT2oQ==
X-Google-Smtp-Source: ABdhPJx702xJInYTgn/8uTtg/lKwSbTfeQq+J32NwSBRehN/F8sUbLWOCLVhZAXn/gHPT8rSVODepw==
X-Received: by 2002:a05:6402:2806:b0:412:9e3c:9820 with SMTP id h6-20020a056402280600b004129e3c9820mr33454448ede.320.1646302047985;
        Thu, 03 Mar 2022 02:07:27 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u9-20020a170906124900b006ce88a505a1sm544738eja.179.2022.03.03.02.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 02:07:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPiMo-000PD7-Lr;
        Thu, 03 Mar 2022 11:07:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 13/13] submodule--helper update-clone: check for
 --filter and --init
Date:   Thu, 03 Mar 2022 11:06:58 +0100
References: <20220301000816.56177-1-chooglen@google.com>
 <20220301044132.39474-1-chooglen@google.com>
 <20220301044132.39474-14-chooglen@google.com>
 <220301.86o82q16ib.gmgdl@evledraar.gmail.com> <xmqqbkyqt9b2.fsf@gitster.g>
 <kl6llexted2t.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <kl6llexted2t.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220303.86o82n5oyp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 01 2022, Glen Choo wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>>>> index 2ffc070319..3e8a05a052 100644
>>>> --- a/builtin/submodule--helper.c
>>>> +++ b/builtin/submodule--helper.c
>>>> @@ -2543,7 +2543,12 @@ static int update_clone(int argc, const char **=
argv, const char *prefix)
>>>>  	};
>>>>=20=20
>>>>  	const char *const git_submodule_helper_usage[] =3D {
>>>> -		N_("git submodule--helper update-clone [--prefix=3D<path>] [<path>.=
..]"),
>>>> +		N_("git submodule [--quiet] update"
>>>> +		"[--init [--filter=3D<filter-spec>]] [--remote]"
>>>> +		"[-N|--no-fetch] [-f|--force]"
>>>> +		"[--checkout|--merge|--rebase]"
>>>> +		"[--[no-]recommend-shallow] [--reference <repository>]"
>>>> +		"[--recursive] [--[no-]single-branch] [--] [<path>...]"),
>>>
>>> Since this has <repository>, <path> etc. it should still be marked for
>>> translation with N_().
>>
>> Yeah, that sounds like a good idea.  Isn't it already inside N_()?
>
> Did I do this correctly? e.g. an alternative interpretation is that =C3=
=86var
> misread this as:
>
>   	const char *const git_submodule_helper_usage[] =3D {
>       N_("git submodule [--quiet] update"),
>       "[--init [--filter=3D<filter-spec>]] [--remote]",
>       "[-N|--no-fetch] [-f|--force]",
>       "[--checkout|--merge|--rebase]",
>       "[--[no-]recommend-shallow] [--reference <repository>]",
>       "[--recursive] [--[no-]single-branch] [--] [<path>...]",

(Even if a v3 has already been sent out). Yes, sorry. I just misread
this. The pre-image is correct.
