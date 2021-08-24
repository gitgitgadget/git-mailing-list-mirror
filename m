Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8682C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1DE561163
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbhHXVqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbhHXVqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:46:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20DEC061764
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:45:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id d6so33893849edt.7
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CXwxmLS6VvcQ7fvEhOhmmgVMrEVJoH0uqUJ4gi4Lz2A=;
        b=N7/1KrXhpHj/oICoQ+gle6RRJgG7A2KfeeABleGg3yCag4Xl/kpGZgI8qcxgHD8lG9
         PAARjb434xlbfS4+ivhzqs1UAds9iSGHbwdH5ZkJwM2suKBm7d4zxGslQaguwNFMdyqg
         JWLGGYpD260NI9kN1Esoy72E3wFKdlipzc1JrAEIIMIH+Wt6GND3d6GHpvAooee9+B2i
         JzXQgSggUXH5lBtmVsapl4vxVYVnC4Nygx0zfiuZ11C4Yvb8mn5D0TQOzG6dS5yMmarR
         6fC1p7yXXE0xh62t5oQMpxib7W9XvoQ9aLuhD6Chmbc1xauvUJyB7QaBEd/BMdkm/ubS
         kD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CXwxmLS6VvcQ7fvEhOhmmgVMrEVJoH0uqUJ4gi4Lz2A=;
        b=AVagSWwAfzp9hSuW8lMapD5IEOuzpF3/1M54n//K8wun5prNryVQ2QYE2eIQ5tk2rx
         WdyiyM62AATe8V/Elxeps1yHhZb+8/X9L8C8y2QJZ5bqDBjBt6b/Lo+kQzGd4bTTGKra
         sD4QqV610MbBOqZrasD/oQLPTN3uFGjzNC40UoEQARrA41Wx2D0o4T9exgOr9KMUjVK/
         HnqWgLtDLV+H06GmdOf8BfMYUnLxuTGLXFEtH4CQb72kkNfFUoPX/oFqCVAHA6UTMUql
         itxSfRTk79B/UhUFGqcsi37FLuwscbR45cxNisB3WMEmP/ap6t6RI4o6O0Imw1LoS250
         /RoQ==
X-Gm-Message-State: AOAM532LigIN+5XiIodQPOKrrym2Qn5/GjmJ4VcxiY8svfHlTrxBFIXq
        EyZF6Eht3K0Lue6cWsmltMY=
X-Google-Smtp-Source: ABdhPJyBR+Z6xbFZiccHqgcWyNXRIA7FTqe7jZ0cHXNTpbuG8K2PSrAPNj8d4gaseREETLYA1pAqjw==
X-Received: by 2002:a05:6402:2806:: with SMTP id h6mr4242460ede.259.1629841522500;
        Tue, 24 Aug 2021 14:45:22 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id og4sm2152019ejc.120.2021.08.24.14.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:45:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] bundle API: change "flags" to be
 "extra_index_pack_args"
Date:   Tue, 24 Aug 2021 23:41:22 +0200
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
 <patch-v2-2.4-3d7bd9c33be-20210823T110136Z-avarab@gmail.com>
 <30620e13-4509-1905-7644-9962b6adf9c5@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <30620e13-4509-1905-7644-9962b6adf9c5@gmail.com>
Message-ID: <877dgaecum.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 24 2021, Derrick Stolee wrote:

> On 8/23/2021 7:02 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> ...
>> --- a/builtin/bundle.c
>> +++ b/builtin/bundle.c
>> @@ -165,7 +165,8 @@ static int cmd_bundle_unbundle(int argc, const char =
**argv, const char *prefix)
>>  	struct option options[] =3D {
>>  		OPT_END()
>>  	};
>> -	char *bundle_file;
>> +	char* bundle_file;
>
> nit: errant movement of "*" here.

Ah, thanks.

>> +	struct strvec extra_args =3D STRVEC_INIT;
> ...
>> -	ret =3D !!unbundle(the_repository, &header, bundle_fd, 0) ||
>> +	ret =3D !!unbundle(the_repository, &header, bundle_fd, &extra_args) ||
>
> I'm assuming that you will be adding something that adds to extra_args
> in a future commit. It might be better to just convert the "0" to "NULL"
> here and add extra_args when you actually use it.

*nod*, commented on in the later commit.

>>  int unbundle(struct repository *r, struct bundle_header *header,
>> -	     int bundle_fd, int flags)
>> +	     int bundle_fd, struct strvec *extra_index_pack_args)
>>  {
>> -	const char *argv_index_pack[] =3D {"index-pack",
>> -					 "--fix-thin", "--stdin", NULL, NULL};
>>  	struct child_process ip =3D CHILD_PROCESS_INIT;
>> +	int i;
>>=20=20
>> -	if (flags & BUNDLE_VERBOSE)
>> -		argv_index_pack[3] =3D "-v";
>> +	strvec_push(&ip.args, "index-pack");
>> +	strvec_push(&ip.args, "--fix-thin");
>> +	strvec_push(&ip.args, "--stdin");
>> +	if (extra_index_pack_args) {
>> +		struct strvec *extra =3D extra_index_pack_args;
>
> Creating a shorter variable name seems unnecessary.

Will skip it.

>> +		for (i =3D 0; i < extra->nr; i++)
>> +			strvec_push(&ip.args, extra->v[i]);
>
> This seems like a good opportunity to create and use a
> strvec_concat() method.

Yeah, I guess I could start with that. Will try it.

>> +		strvec_clear(extra_index_pack_args);
>
> Why is it the responsibility of this method to clear these args?
> I suppose it is convenient. It just seems a bit wrong to me.

Because of...

>>  /**
>>   * Unbundle after reading the header with read_bundle_header().
>>   *
>>   * We'll invoke "git index-pack --stdin --fix-thin" for you on the
>>   * provided `bundle_fd` from read_bundle_header().
>> + *
>> + * Provide extra_index_pack_args to pass any extra arguments
>> + * (e.g. "-v" for verbose/progress), NULL otherwise. The provided
>> + * extra_index_pack_args (if any) will be strvec_clear()'d for you
>> + * (like the run-command.h API itself does).

... this, i.e. it's how the run-command.[ch] API already works for the
same sort of thing elsewhere, I figured making them consistent was
better than having them differ.

I think that while in general the rule of having each function allocate
& clear its own memory is a good one, that a notable good exception in
our codebase is various "one-shot" functions such as the run-command
API, i.e. APIs where the vast majority of callers just want to set
things up for a one-off run. Having those common cases not require a
that_api_release(&ctx) afterwards seems like a good idea in general.

>>   */
>>  int unbundle(struct repository *r, struct bundle_header *header,
>> -	     int bundle_fd, int flags);
>> +	     int bundle_fd, struct strvec *extra_index_pack_args);
>>  int list_bundle_refs(struct bundle_header *header,
>>  		int argc, const char **argv);
>>=20=20
>> diff --git a/transport.c b/transport.c
>> index 17e9629710a..8bc4b5fcd3c 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -162,12 +162,15 @@ static int fetch_refs_from_bundle(struct transport=
 *transport,
>>  			       int nr_heads, struct ref **to_fetch)
>>  {
>>  	struct bundle_transport_data *data =3D transport->data;
>> +	struct strvec extra_index_pack_args =3D STRVEC_INIT;
>>  	int ret;
>>=20=20
>> +	strvec_push(&extra_index_pack_args, "-v");
>> +
>>  	if (!data->get_refs_from_bundle_called)
>>  		get_refs_from_bundle(transport, 0, NULL);
>>  	ret =3D unbundle(the_repository, &data->header, data->fd,
>> -			   transport->progress ? BUNDLE_VERBOSE : 0);
>
> Previously, this was conditioned on 'transport->progress', but above
> you unconditionally add the "-v" option. Seems like a bug.

Yes! Oops. Will fix. Thanks.
