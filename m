Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E06E120248
	for <e@80x24.org>; Fri, 15 Mar 2019 10:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfCOKmY (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 06:42:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35811 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfCOKmX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 06:42:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id d6so6615731eds.2
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 03:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=STxFv/sdyhq34QgISiPV/3wfDRn0VmRylkSrSawEdu0=;
        b=QwyxMx02ACQXwYHtK91Lufd/HLu0epk/WRFfK9vg696iBUc53k1M9dyigxDp8Bat++
         H1dvmsEgqm4Wuxb8cHDrtMqhNagP3al6R/Jm6C0RzjmnPu5uN4n5nV7Gun8XxUImHUI5
         3gXkGTRR9DIzF8C82GJXKp0rfXuS4LaHsl/VnBQO1AWerdsMfgSXbT4QPVNJCqQkVkH7
         /UlqB6voU8p7bvtr3YrrjpipYU9b3oy6r+SPn8QkKWky9XdygWtZSUsBLF4BrQZu+eSc
         2MjDST85B//3epXjuOQk9nrl2mLLPueVAWF/dBsNP7kN05qWDGpjFyEc0B741ICb1z5m
         nVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=STxFv/sdyhq34QgISiPV/3wfDRn0VmRylkSrSawEdu0=;
        b=EgzY1FnMaHuUAoG+aOIHScOpQxbaUX+TCGRHF+fKo0NrWZUKjry0yrw1nvCm4Z125Y
         eDozIp6jGi5CgI0rnHipipt7MCQjbpPT/o+JkL51HgoDUq8CBnTnhz/JjlcfPK/80WYG
         gwo7W5BBngXnyRY8SZT2Beg8QLhXl20ABP83hAbI1ljODcOtWYoUQphlqqCgEFS/g9dC
         APrZamOJsik57v6Qh7gB5r4Z6/0gBJoo3Ex7lcrjd/RqCWGWPJQo9B6OW4qR1EwsdfGm
         xE4dwm6pjsSBrbplz6+LP3jBRd2GRBjkg5Ngh26EvweK+fKvaqm4jQ4GWR9B8OWDWKVs
         iluA==
X-Gm-Message-State: APjAAAWU1ODKDAbR/xR/iNn7MIOEpro3QbTbnOwczJAr/BqclFIKxQlM
        cAKZ6B7QoNMXy3jk4M839TXbQdIY3zk=
X-Google-Smtp-Source: APXvYqwMJXKgU4FSoit4duye+lxdI700tAy+7zraHNlbBjZvp/5QnGiM8gNEUPLv4wGq6e34Mb6C/g==
X-Received: by 2002:a17:906:2552:: with SMTP id j18mr1804635ejb.179.1552646541560;
        Fri, 15 Mar 2019 03:42:21 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id w6sm526750eds.0.2019.03.15.03.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 03:42:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/7] gc: convert to using the_hash_algo
References: <20190313235439.30439-1-avarab@gmail.com> <20190314123439.4347-3-avarab@gmail.com> <CACsJy8CikZt_WF79V6y2JRtR0jAosTPPmDBXN8uMRTjm4FAV-A@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8CikZt_WF79V6y2JRtR0jAosTPPmDBXN8uMRTjm4FAV-A@mail.gmail.com>
Date:   Fri, 15 Mar 2019 11:42:20 +0100
Message-ID: <874l84ber7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 15 2019, Duy Nguyen wrote:

> On Thu, Mar 14, 2019 at 7:34 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> There's been a lot of changing of the hardcoded "40" values to
>> the_hash_algo->hexsz, but we've so far missed this one where we
>> hardcoded 38 for the loose object file length.
>
> Wow. Good catch.
>
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index 8c2312681c..733bd7bdf4 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -156,6 +156,7 @@ static int too_many_loose_objects(void)
>>         int auto_threshold;
>>         int num_loose =3D 0;
>>         int needed =3D 0;
>> +       const unsigned hexsz_loose =3D the_hash_algo->hexsz - 2;
>
> Since you're removing hard coded numbers. Another option is a
> combination of strlen(basename()) and
> loose_object_path(the_repository, , null_oid). They should also give
> the same 38. Then if loose object format is updated to use 3+ chars
> for the directory part, this code will not need update anymore.
>
> The downside of course is a lot more code. Or you can just introduce a
> new function to return this "hexsz - 2", keep that function close to
> fill_loose_path() with a comment there that the two functions should
> be aligned.

I think it's better to just keep hardcoding "2". We're very unlikely to
ever change objects/?? in favor of e.g. objects/???, and if we were that
would be a huge "hash function transition" of its own.

>>
>>         dir =3D opendir(git_path("objects/17"));
>>         if (!dir)
