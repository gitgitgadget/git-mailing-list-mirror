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
	by dcvr.yhbt.net (Postfix) with ESMTP id 27EAE20248
	for <e@80x24.org>; Fri, 29 Mar 2019 13:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfC2NzX (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 09:55:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42560 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbfC2NzW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 09:55:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id x61so2075652edc.9
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Cb6qWVPpD3pVYY9I7AtbPKM0PvvOI0HD8C1Sard8Kf8=;
        b=JNrg4Ge3Pp+oRkZomZZVR5Jbn117DnksmYfVJAEtFYg635ZxqQKIgkD0FC1R+G11ib
         39AZTxbqiIq7eh3d1y8nGMExxBsKN1qOzgGSdhIm+csyoZSr7099YfofHnB6VtDlo6xw
         nLq/amXvvItLEnWNoRXR8CSMDY7jyM4UzbKlO3PERQpx00q8Pqnw/7bWuLWvOkWwvBO8
         0sljNFgOixcbY1HuCJLQxTE81DHd0dt9gj4syneroj2lID/3CyaWLrVFY6jIHO/uRsH0
         ASAzhAIqF2S16a7lVCQkMmaciD5iFUHxKypkzsg/DNWmJrwYSV/8S0GLm6Ft/euV/oCO
         o68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Cb6qWVPpD3pVYY9I7AtbPKM0PvvOI0HD8C1Sard8Kf8=;
        b=laVsBcxTZh46uAnvJOyoLcWaKS3Hu4HjumlqCxZ8DyBRmDykD/SATLtFNzNi3uGXOr
         mM6/MlhDUOE4NeT1qw7shTqJWfxf6T2N2QXdq3da3/uyUt16CirBscCKUVVRMnqn2rQx
         oBEOydRxgWPp4ijkOUjePBtJ+Jv8c2zTis9u9LO5U5JMKazlGGDtWYgS7UHBlvZyuG1d
         5XNi63nB0B+F4ue8+jG/JeJFiJASXjj/+0t6VuX7ZBorn7MpFv0LmJHBhhgTSohvKwY7
         0zHMKYq/3ZpjEJ6dahX7HrlcFpyvphS8y0CefuWVgKvzAkeZBK9bBaDEP2TdEqBFv+J0
         ueVQ==
X-Gm-Message-State: APjAAAVwQCV/D8YRN20ePA65LWQoXxvbX7vYPe4oP7nL4ZRkUppLFeFU
        nyjB1hHXiF5itR2Sqe+VXkk=
X-Google-Smtp-Source: APXvYqyeD/0J+McJWwYdAjx2VngAaLqC2X/pf1D18zaDRKy13OaYlhljfJSCkSEgcfNix85YuD5xRw==
X-Received: by 2002:a50:8561:: with SMTP id 88mr17191303edr.101.1553867720575;
        Fri, 29 Mar 2019 06:55:20 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id r14sm674190edd.87.2019.03.29.06.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 06:55:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2] sha1-file: test the error behavior of alt_odb_usable()
References: <20181204132716.19208-2-avarab@gmail.com> <20190328200456.29240-1-avarab@gmail.com> <20190329134603.GB21802@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190329134603.GB21802@sigill.intra.peff.net>
Date:   Fri, 29 Mar 2019 14:55:18 +0100
Message-ID: <87pnq9aipl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 29 2019, Jeff King wrote:

> On Thu, Mar 28, 2019 at 09:04:56PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Add a test for the error() case in alt_odb_usable() where an alternate
>> directory doesn't exist. This behavior has been the same since
>> 26125f6b9b ("detect broken alternates.", 2006-02-22), but if that
>> error() was turned into die() the entire test suite would still pass.
>>
>> Perhaps we should die() in that case, but let's start by adding a test
>> here to assert the long-standing existing behavior.
>
> I think if anything we might go the other direction, and downgrade the
> error() to a warning() or even omit it entirely. It's not an error to
> have a missing or transient alternate. Unless of course it has objects
> you need, but then those generate their own errors.

Yeah that sounds fine. FWIW it's just an "error" in the sense of being
printed out by error(), but we proceed, so it's really a warning,
sort-of.

> I actually think in an ideal world we wouldn't say anything at all about
> alternates which aren't present, don't appear to contain objects, etc,
> on their own. And then when we hit an error because an object is
> missing, only _then_ diagnose and say "hey, you have this alternate but
> it doesn't have anything in it. Maybe that's an error?". Doing that
> diagnosis in the error path helps in two ways:
>
>   - we don't have to worry about it being slow
>
>   - we can be a bit more loose about things that _might_ be an issue.
>     E.g., it's not an error to point to an alternate directory that has
>     no files in it. It might be a misconfiguration, or it might just not
>     have any objects right now. It's hard to justify complaining about
>     it in _every_ git command that loads alternates. But after hitting a
>     fatal error due to a missing object, it seems like a convenient
>     thing to mention to the user.
>
> I suspect that implementing it that way might be a pain, though. Even if
> we had a convenient diagnose_missing_object() one-liner, there are
> probably dozens of separate places it would need to be called from.
>
>> diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
>> index 895f46bb91..d2964c57b7 100755
>> --- a/t/t5613-info-alternate.sh
>> +++ b/t/t5613-info-alternate.sh
>> @@ -136,4 +136,11 @@ test_expect_success CASE_INSENSITIVE_FS 'dup findin=
g can be case-insensitive' '
>>  	test_cmp expect actual.alternates
>>  '
>>
>> +test_expect_success 'print "error" on non-existing alternate' '
>> +	git init --bare I &&
>> +	echo DOES_NOT_EXIST >I/objects/info/alternates &&
>> +	git -C I fsck 2>stderr &&
>> +	test_i18ngrep "does not exist; check" stderr
>> +'
>
> All that said, I don't really have an objection against this patch,
> since it's just testing the current behavior. Anybody who wants to
> change it would find it pretty easy to tweak this test, too.

Yup. Just wanted to get the patch to test what we do *currently* out,
might loop back to finishing up the rest of this.
