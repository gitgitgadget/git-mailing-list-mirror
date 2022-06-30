Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C977C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiF3Xfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiF3Xfk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:35:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED78C59245
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:35:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o9so822035edt.12
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=mGDFRaza0q5j0pCEpR/w7n5YeKK8orYF6P0cxYaDrH4=;
        b=dkYhUsT6GSQiZSe3Eii8f3tlh6FDQkFEc9gWhiNgSEMgufmBKTgeY2GxHoWodCoV9M
         fCUjWq6C4EgTZgNKKFOVRA6K02aC22LANuWijkT7NdU1oR4VqG+jWWgTjhXNms5YbiJ/
         ZSU/kSDIouXzgUKjEIHmkcJwfEEDiXteqUfPic2Z68Vb/qrjyKSGfXzuF7e3un25FI1X
         IKri2Lo0Z3jUa1scYO740/1JDLM/vwJrlmexZfeorZbtefF8Q5gFJmKBTJnGutAMMWSa
         dkNuXX2otJOI5tD1DVtsnZTYOxOav6XTUoxV9U+nJN9oNEKvq2TgOn0NaeuyRe0DF8Gy
         DjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=mGDFRaza0q5j0pCEpR/w7n5YeKK8orYF6P0cxYaDrH4=;
        b=pmiiIgEYZrp3K7ro59IEEIsL6teLMkT6Wf+PbBRlnIG5L9LDTJYHREYkDOKXan2hN0
         Qom2821Ii5rIOBGGvibs+GvQQZipav+wv6JoZe0CadL6xSyIMPIreQgrrNmJNm4nCGUC
         Oz8QHSYMksHL29/bnklDdXQeREdBdRL/TMb65/fyTnFryvDgM3rDc2tYASkulJN1433o
         iTkb6are/SuThXpow1BCfxoMVVgWfphJGIUBt6vG5h6HOU2+KDURcszL1UVrMS+jhU6l
         xRr6Q8f2fguEpjfLqhsV0QkAMet7NQNL610e5qh9NbFivWoIBG9n/yLox4PpFFS0xN5+
         IHLQ==
X-Gm-Message-State: AJIora91QDwSwqxuXahIGIcxq+OMZyqcgkLnUAMoXVKgfL0KNfuLx6Os
        dFsp57+DOU7LgMnMtAlzme0=
X-Google-Smtp-Source: AGRyM1tYqlgIvDzijwen1x7GotvPOqFNMttukT2W1FL741XK3Dl2vD9tt7RtlUl09zUa6d2wzwMuAw==
X-Received: by 2002:aa7:d5d3:0:b0:437:d2b6:ce25 with SMTP id d19-20020aa7d5d3000000b00437d2b6ce25mr14509151eds.280.1656632138436;
        Thu, 30 Jun 2022 16:35:38 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906815500b00722e7e26d22sm9675008ejw.58.2022.06.30.16.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:35:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o73hB-002cUD-Ds;
        Fri, 01 Jul 2022 01:35:37 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 08/11] checkout: add a missing
 clear_unpack_trees_porcelain()
Date:   Fri, 01 Jul 2022 01:34:00 +0200
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
 <patch-08.11-94e28aa7ab3-20220630T175714Z-avarab@gmail.com>
 <xmqq35fldc9i.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq35fldc9i.fsf@gitster.g>
Message-ID: <220701.86wncxbu7q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 30 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> In 1c41d2805e4 (unpack_trees_options: free messages when done,
>> 2018-05-21) we started calling clear_unpack_trees_porcelain() on this
>> codepath, but missed this error path, let's also clear what we've
>> allocated in that case.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/checkout.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index 2eefda81d8c..3d6762106e8 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -750,6 +750,7 @@ static int merge_working_tree(const struct checkout_=
opts *opts,
>>  		refresh_cache(REFRESH_QUIET);
>>=20=20
>>  		if (unmerged_cache()) {
>> +			clear_unpack_trees_porcelain(&topts);
>>  			error(_("you need to resolve your current index first"));
>>  			return 1;
>>  		}
>
> Does refresh_cache(REFRESH_QUIET) depend on the porcelain error
> messages already set?  If not another way to fix it may be to delay
> the call to setup_unpack_trees_porcelain() until it becomes needed.
>
> But the patch as posted is certainly an improvement.

Yes, that would work too, I can do it that way if you'd like.

I was trying to keep these fixes as narrow as possible, and resist any
temptations to re-arrange code so as to avoid allocations, which we can
often do, but then instead of a 1-line diff it's 10, 50, 100... :)

In this case it'll be somewhere around 10, and just a code-move, so
maybe that's fine...
