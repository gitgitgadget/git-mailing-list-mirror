Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D28C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2BBB61178
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbhI0Xvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhI0Xvr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 19:51:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44771C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 16:50:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v10so71493601edj.10
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 16:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Vktpumcrb6Pu3FWolb6Jtig1UoYoIVnxaIhG8F8LzeA=;
        b=SVKkqvuBaOXb2RtV2ktN7OAo2AdKtn+ckPax9XzksOidMu14gEY+X63BYJ2u0UelNo
         QqM3xqepxYXIiV/TXdvFRmRluHBtBRP5md7ssIcROhhLO2qDRLMF+hamDFWavXstW/wO
         ngSROcKkMGm+bSUN73nRYKkUZ9KGuYWZoiSRpsZp0ACIvuf5MVIsWhXhsBeTbANGYOw5
         LBt4RZgVCLIGfWkbkMnQBqi2VtO7tidkEWQdNCaQdQ3HPe1+MLAzZprvFXHNSjydIeAy
         jNRFJzGyBwr9MoTjTcpojA3lYb4u5LGGMSBwBdjvvengLw1AUTzVyhruPg1sRf6nDjHQ
         +mxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Vktpumcrb6Pu3FWolb6Jtig1UoYoIVnxaIhG8F8LzeA=;
        b=aMSnJ2wlLrja86Og4mFRyWHzNginP69v2sc0iGNFbBdqc0Atbm11F2S0BWuZCB5FU/
         fN8ugULJhhYtvz3H7bJALSH7wWGLY9rY9qATy6Zgz3YZHfyII94f+nv4H0Dumas4Ud+o
         EKSoRIeidrcquI4pqEmz57X6aM1a7C9kTk8cylwEhaTD+CHXAp9w896jNk67ZZsYxeLi
         6PZRGgqOLA6GMFiSHwsnk2pK3mHgXAAomFvG5PCtiWPfuby/fCFP+W4ik3YjDM8i8b99
         eVSJ/VqyULkhCsh/aXSrgffRv2A2KF56UcOhrrF41PpzDe1DwpiwsicPtH/goa73yV9D
         j+Cg==
X-Gm-Message-State: AOAM532Yzpaif3lJhjH+5i22ArWrKYoAXUBWZ3RqgYTSHT/UAyyle9GH
        ozhbiDRIxCKNS2q3E+31ut8=
X-Google-Smtp-Source: ABdhPJxd1bGy0+reGV8LcMhiEj3mS6cTx3UMuaSFeILbC2/zg6Eflye+agYGe9vko6V8x1kaV75DqA==
X-Received: by 2002:a17:906:f245:: with SMTP id gy5mr3408626ejb.70.1632786607823;
        Mon, 27 Sep 2021 16:50:07 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x7sm11701074ede.86.2021.09.27.16.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 16:50:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 4/5] builtin/remote.c: add and use a REF_STATES_INIT
Date:   Tue, 28 Sep 2021 01:38:16 +0200
References: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
 <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com>
 <patch-v2-4.5-13ef9566903-20210927T125715Z-avarab@gmail.com>
 <xmqq4ka5oc1k.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq4ka5oc1k.fsf@gitster.g>
Message-ID: <87v92lzihd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 27 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Use a new REF_STATES_INIT designated initializer instead of assigning
>> to the "strdup_strings" member of the previously memzero()'d version
>> of this struct.
>>
>> The pattern of assigning to "strdup_strings" dates back to
>> 211c89682ee (Make git-remote a builtin, 2008-02-29) (when it was
>> "strdup_paths"), i.e. long before we used anything like our current
>> established *_INIT patterns consistently.
>>
>> Then in e61e0cc6b70 (builtin-remote: teach show to display remote
>> HEAD, 2009-02-25) and e5dcbfd9ab7 (builtin-remote: new show output
>> style for push refspecs, 2009-02-25) we added some more of these.
>>
>> As it turns out we only initialized this struct three times, all the
>> other uses were of pointers to those initialized structs. So let's
>> initialize it in those three places, skip the memset(), and pass those
>> structs down appropriately.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/remote.c | 23 +++++++++++------------
>>  1 file changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/builtin/remote.c b/builtin/remote.c
>> index 7f88e6ce9de..160dd954f74 100644
>> --- a/builtin/remote.c
>> +++ b/builtin/remote.c
>> @@ -344,6 +344,14 @@ struct ref_states {
>>  	int queried;
>>  };
>>=20=20
>> +#define REF_STATES_INIT { \
>> +	.new_refs =3D STRING_LIST_INIT_DUP, \
>> +	.stale =3D STRING_LIST_INIT_DUP, \
>> +	.tracked =3D STRING_LIST_INIT_DUP, \
>> +	.heads =3D STRING_LIST_INIT_DUP, \
>> +	.push =3D STRING_LIST_INIT_DUP, \
>> +}
>
> So, now everybody owns the string, but ...
>
>>  static int get_ref_states(const struct ref *remote_refs, struct ref_sta=
tes *states)
>>  {
>>  	struct ref *fetch_map =3D NULL, **tail =3D &fetch_map;
>> @@ -355,9 +363,6 @@ static int get_ref_states(const struct ref *remote_r=
efs, struct ref_states *stat
>>  			die(_("Could not get fetch map for refspec %s"),
>>  				states->remote->fetch.raw[i]);
>>=20=20
>> -	states->new_refs.strdup_strings =3D 1;
>> -	states->tracked.strdup_strings =3D 1;
>> -	states->stale.strdup_strings =3D 1;
>
> ... we used to set up selectively to own.
>
> How would we make sure after this change we are not adding leaks?
> Is there a way to do so mechanically?

I manual run with SANITIZE=3Dleak shows the same amount of memory leakage
before & after this change for me.

We should fix those leaks, but until my "tests: add a test mode for
SANITIZE=3Dleak, run it in CI" lands on master I'm still waiting on fixing
those, and this series will help make it easier.

The ownership of the "states" struct or its lifetime isn't different
after this change. It's only that we're doing:

    struct foo =3D FOO_INIT;
    /* use &foo */

Instead of:

    struct foo;
    memset(&foo, 0, sizeof(foo));
    foo->some_list.strdup_strings =3D 1;

What is different is that that "strdup_strings" member in the contained
"some_list" will be set to "1" earlier. E.g. in the case of this in the
pre-image:

    states->new_refs.strdup_strings =3D 1;

We'd do that in get_ref_states(), which was called by
get_remote_ref_states(), which was e.g. called by show(). So before we
wouldn't flip that particular value until we got all the way down into
get_remote_ref_states(), now we initialize the struct like that on the
stack right away.

But it doesn't result in any new allocations, string_list like strbuf
etc. won't allocate until something is pushed onto the list, using the
common "nr/alloc" & malloc on demand pattern.

>> -	struct ref_states states;
>> +	struct ref_states states =3D REF_STATES_INIT;
>>  	struct string_list refs_to_prune =3D STRING_LIST_INIT_NODUP;
>>  	struct string_list_item *item;
>>  	const char *dangling_msg =3D dry_run
>>  		? _(" %s will become dangling!")
>>  		: _(" %s has become dangling!");
>>=20=20
>> -	memset(&states, 0, sizeof(states));
>>  	get_remote_ref_states(remote, &states, GET_REF_STATES);
>
> Like this one, get_remote_ref_states() used to receive states that
> are set to borrow strings, but now we get duplicated strings, right?
> Are we leaking whatever strings we push to these string lists now?

Ah, yes it *could* happen as a side-effect of this sotr of change that
that memset() was implicitly flipping some string_list structs to the
equivalent of strdup_strings=3D0.

But that's not the case here, it was just memset() boilerplate, then in
get_remote_ref_states() we'd set all the string lists we'd use to "dup".
