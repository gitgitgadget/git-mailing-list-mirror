Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AE0C636D3
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 02:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjBICax (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 21:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjBICaT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 21:30:19 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130792942E
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 18:30:18 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a10so856291edu.9
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 18:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P9AfsO3qIlzg1SAYQbMj5xqZgnLWkTP5npb5f7wC1zg=;
        b=p7kZN4xm9Ga4lgTnanGHtXeyHndkRq2jZSTm0QAzwmOhgbabEYBhw08mI/od0DaoFl
         OYRBPMfDKUcf5dmLeAIimmHHXOt5FFdipBANC5lb80lVLCkPzsKHIeLsH4A2/fpbZLDb
         9naDU0NAnSHPhxdS2Lmz1g1VtpK6r7ipBxYBFplR/rXrkaR0DScAJ6I54VSnuqo1pbyU
         tQPRViaFCzPFeCFvwlwaRkTwzS4Xtph/WayRub8D2/gbmcy8woOAyCNNxFQo3LvOegxx
         dxXYUwPvleOKFNO5TvbLi1S3OdWcUiuIU6DmgrEGBjvvbi287wxyqJVN34CggdZIBb7T
         ILYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9AfsO3qIlzg1SAYQbMj5xqZgnLWkTP5npb5f7wC1zg=;
        b=7KsINWvbox8paTF7UB7wRiKLfxiLrQlYGgUD7Qmp/zPBI9arafJDxCSVHtwr0BEPBZ
         T89IkSPYpJ/gEfnqjl3UFwQGr9r8TbCEHd6Tp7R/n/z+8Y6QKnLLX/kUAWXl6SS4zaPg
         yMY2xPOs75dS+jh3t0VucwoLq6xwl5wXM8E8G6sn96KqMLV2qIiB0TkrckweX2erHxeZ
         e03tsSwiQWxgj6C3VDxA9cTqjDzHKpjkhu4yY5wZ8U1hjVFhUUSrW39r4AuGwjME5+HC
         8WPOVBVJeVPU5de2h77mzbS3IBrYiUEH6N9mPfCFJzHeTaNCtAObIuvK010qQJl9u83g
         ca1A==
X-Gm-Message-State: AO0yUKU7LmHvI/GHITLQiYIIIv4o5Z/plcJSgRAMGGXq3z5Fq/Q6vuWf
        b7M6B/ELo1G8HiGR/4Dh5w7bZw9zUZs9m8D5
X-Google-Smtp-Source: AK7set+C8UccXcEt4wC6iPocztWX2igP9Vp3ozRIlB097Avsh1rXfepmc7aP4tfSh0VuwmI/yHnYmw==
X-Received: by 2002:a50:d692:0:b0:4a2:51db:c7c6 with SMTP id r18-20020a50d692000000b004a251dbc7c6mr10407676edi.8.1675909816610;
        Wed, 08 Feb 2023 18:30:16 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id j26-20020a508a9a000000b004aac83d6554sm128647edj.47.2023.02.08.18.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 18:30:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPwhT-001c8N-1S;
        Thu, 09 Feb 2023 03:30:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Max Gautier <max.gautier@redhat.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] gpg-interface: lazily initialize and read the
 configuration
Date:   Thu, 09 Feb 2023 03:24:31 +0100
References: <Y+PGRaiTTaZ/DtlJ@work-laptop-max>
 <Y+PRTYtFDoE73XEM@coredump.intra.peff.net> <xmqqmt5orqgv.fsf@gitster.g>
 <xmqqh6vwrpce.fsf@gitster.g> <xmqqlel7rj9z.fsf_-_@gitster.g>
 <230209.86fsbfznot.gmgdl@evledraar.gmail.com> <xmqq5ycbpp8a.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqq5ycbpp8a.fsf@gitster.g>
Message-ID: <230209.86pmajy3ig.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 08 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> One thing left un-noted here is that this will defer any errors in the
>> config now until use (or lazy init), so e.g.:
>>
>> 	git -c gpg.mintrustlevel=3Dbad show --show-signature
>>
>> Used to exit with code 128 and an error, but will now (at least for me)
>> proceed to run show successfully.
>
> That one is probably a good thing.  We shouldn't interrupt users for
> a misspelt configuration value that the user is not using.

*nod*, just noting it.

>>> @@ -632,6 +644,8 @@ int check_signature(struct signature_check *sigc,
>>>  	struct gpg_format *fmt;
>>>  	int status;
>>>=20=20
>>> +	gpg_interface_lazy_init();
>>> +
>>>  	sigc->result =3D 'N';
>>>  	sigc->trust_level =3D -1;
>>
>> This is needed, because we need "configured_min_trust_level" populated.
>
> I specifically did not want anybody to start doing this line of
> analysis, because it will add unnecessary bugs, and also introduce
> maintenance problems.  You may be able to grab the current state of
> the code, but that will get stale and won't be a good guide to keep
> our code robust.
>
>>> @@ -695,11 +709,13 @@ int parse_signature(const char *buf, size_t size,=
 struct strbuf *payload, struct
>>>=20=20
>>>  void set_signing_key(const char *key)
>>>  {
>>> +	gpg_interface_lazy_init();
>>> +
>>>  	free(configured_signing_key);
>>>  	configured_signing_key =3D xstrdup(key);
>>>  }
>>
>> But this is not, we could say that we're doing it for good measure, but
>> it's hard to imagine a scenario where we would end up actually needing
>> lazy init here. we'll just set a variable here, which...
>
> And especially this one, we must have init or we'll be incorrect, I
> think.  There is a direct set_signing_key() caller (I think in "git
> tag") that does not come from the git_config() callback route.
> Without the lazy initialization, we'd get configured_signing_key
> from the config because early in the start-up sequence of the
> command we would do git_gpg_config() via git_config(), and then try
> to process "-u keyid" by calling this one again.
>
> If you forget to lazily initialize here, configured_signing_key gets
> the keyid obtained via "-u keyid", and then when control reaches the
> real signing function, we'd realize that we still haven't
> initialized ourselves.  And we call lazy init, which finds
> configured keyID, which is very likely different from "-u keyid"
> (the user would not be passing "-u keyid" from the command line to
> override, if that is the same as the configured one), and clobber
> it.

Yeah, I take your general point that it's good to sprinkle the
gpg_interface_lazy_init().

In this case I think we'll just barely do the right thing, the only
external caller is tag.c, which first does:

	set_signing_key(keyid);

And then:

	sign_buffer(buffer, buffer, get_signing_key());

So we'll (I think):

	1. Get the non-config'd key from before
	2. Call sign_buffer()
	3. Promptly clobber that key
	4. It won't matter because at that point we'll be passing a key
	   as a parma, which overrides the "config"

But yeah, dropping it would mean we end up with the wrong key in the
variable afterwards, which even if it's not used is nasty.
