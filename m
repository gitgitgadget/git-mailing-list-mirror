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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3139020305
	for <e@80x24.org>; Mon,  8 Apr 2019 15:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfDHP5Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 11:57:25 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41817 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfDHP5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 11:57:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id u2so7757459eds.8
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 08:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ItECY+qHjw+J+wY5Y1+AorjAi9kncagdzkNH7sa0VAY=;
        b=dx4BcE0ZLBMKTYZLN5vos/xd/aXx2vuCTp+dSoNeeGvD3gT2qwjVBsGLUHRFBLLsss
         1YrdS+wtk/fTEiFvphOdh/rrbaWxRE/TXlJFfc6H+QJwPugFImIF5tU3qfEuT9q1Z8Iw
         yJZWOcR6YaeByGcCqMxJsTyXoMb+HulgzPhecdrYPZtG1FRCgs0G+mOfAb7EHqFbu0rt
         cz+JPTC0IW+YAgxsZ+sWRvlaf2YH9imeAlGmwfURw9Fbpg8Y1XSxpAlc66T292aL1FRa
         xiJ9Jwi1UG8R8GrHyPnoFQdzDARfPIAJDMXedxj6XB6PB5NeESr9p9LtYrvfyBaULJPg
         +Obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ItECY+qHjw+J+wY5Y1+AorjAi9kncagdzkNH7sa0VAY=;
        b=HukU5mddQ8ucu6vXdjQYqhG+L78kUDz55ydoZGwns6rgeBS4oNMAW+ExVBCJTXfPRq
         eVczMCwsLKeeU3hDVXKpqG3z3VLTdil03pZPBMzHWkCsqBQAx/C2JefxsFIxIl4D141y
         DTNbrBK1qzdhdpoTOj4BMQU6wSibW+4KU/cJrOmINcuvRJa4pW0H7E8F+OLeCMJsRSvX
         rJclsLua2Xlty7mz4vzcdWMSJBR+hsIApwQp0cRE9dNoOp0VccJulxRfXK8NfN7SsHJo
         NoOQdufHCp3PJkUHalhPIwIbu8a7kuVMeJdlUzHaHAn732OO5JIZ9kT1BTysQfT7295k
         Q9Ww==
X-Gm-Message-State: APjAAAU6+9bHLC19E1l51Vs/b/2jcJNmK/SvTcggMLSeUyZ0LiIcF95E
        6pmK2Cpi7ps9/yVHt0eq90jy5bh5NIc=
X-Google-Smtp-Source: APXvYqwV8dO1siupqI8tF8pEWkfoKEhQkwnmAe6EnUKL0sW5fWafPfwz8D+eHD3XE2zTcB9NceVkeA==
X-Received: by 2002:a17:906:d20e:: with SMTP id w14mr17251573ejz.160.1554739042991;
        Mon, 08 Apr 2019 08:57:22 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id 25sm5458695ejv.27.2019.04.08.08.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 08:57:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2] sha1-file: test the error behavior of alt_odb_usable()
References: <20181204132716.19208-2-avarab@gmail.com> <20190328200456.29240-1-avarab@gmail.com> <20190329134603.GB21802@sigill.intra.peff.net> <87pnq9aipl.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <87pnq9aipl.fsf@evledraar.gmail.com>
Date:   Mon, 08 Apr 2019 17:57:20 +0200
Message-ID: <874l78a3rz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 29 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Mar 29 2019, Jeff King wrote:
>
>> On Thu, Mar 28, 2019 at 09:04:56PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>
>>> Add a test for the error() case in alt_odb_usable() where an alternate
>>> directory doesn't exist. This behavior has been the same since
>>> 26125f6b9b ("detect broken alternates.", 2006-02-22), but if that
>>> error() was turned into die() the entire test suite would still pass.
>>>
>>> Perhaps we should die() in that case, but let's start by adding a test
>>> here to assert the long-standing existing behavior.
>>
>> I think if anything we might go the other direction, and downgrade the
>> error() to a warning() or even omit it entirely. It's not an error to
>> have a missing or transient alternate. Unless of course it has objects
>> you need, but then those generate their own errors.
>
> Yeah that sounds fine. FWIW it's just an "error" in the sense of being
> printed out by error(), but we proceed, so it's really a warning,
> sort-of.
>
>> I actually think in an ideal world we wouldn't say anything at all about
>> alternates which aren't present, don't appear to contain objects, etc,
>> on their own. And then when we hit an error because an object is
>> missing, only _then_ diagnose and say "hey, you have this alternate but
>> it doesn't have anything in it. Maybe that's an error?". Doing that
>> diagnosis in the error path helps in two ways:
>>
>>   - we don't have to worry about it being slow
>>
>>   - we can be a bit more loose about things that _might_ be an issue.
>>     E.g., it's not an error to point to an alternate directory that has
>>     no files in it. It might be a misconfiguration, or it might just not
>>     have any objects right now. It's hard to justify complaining about
>>     it in _every_ git command that loads alternates. But after hitting a
>>     fatal error due to a missing object, it seems like a convenient
>>     thing to mention to the user.
>>
>> I suspect that implementing it that way might be a pain, though. Even if
>> we had a convenient diagnose_missing_object() one-liner, there are
>> probably dozens of separate places it would need to be called from.
>>
>>> diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
>>> index 895f46bb91..d2964c57b7 100755
>>> --- a/t/t5613-info-alternate.sh
>>> +++ b/t/t5613-info-alternate.sh
>>> @@ -136,4 +136,11 @@ test_expect_success CASE_INSENSITIVE_FS 'dup findi=
ng can be case-insensitive' '
>>>  	test_cmp expect actual.alternates
>>>  '
>>>
>>> +test_expect_success 'print "error" on non-existing alternate' '
>>> +	git init --bare I &&
>>> +	echo DOES_NOT_EXIST >I/objects/info/alternates &&
>>> +	git -C I fsck 2>stderr &&
>>> +	test_i18ngrep "does not exist; check" stderr
>>> +'
>>
>> All that said, I don't really have an objection against this patch,
>> since it's just testing the current behavior. Anybody who wants to
>> change it would find it pretty easy to tweak this test, too.
>
> Yup. Just wanted to get the patch to test what we do *currently* out,
> might loop back to finishing up the rest of this.

Junio: *ping* about picking up this trivial test coverage improvement
(missed in the latest What's Cooking).
