Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AFDC05027
	for <git@archiver.kernel.org>; Sun, 12 Feb 2023 09:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBLJs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Feb 2023 04:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBLJsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2023 04:48:25 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0FFEC6D
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 01:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676195293; bh=8ZW8GD7jmeK+oQ7kY2GuILsx+hTu5QLEPttuF7lGgXc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DVX4qkML7oaeKS3VlKFmkZs/tDot1lEM8XoVxvr0LU3XLDp3gmeUfkr+Ut/9vSC9j
         CukNJPuTHega3nIoLe2rXjT5O8WI4oRszOQ3awu0jdYQ4Q5g06sxZhxP5OtzaEkLmL
         N4giYIypwPsMlSfbP4r2CewUdXzv4/LCUrjPj8XZ/qKN3oMZb/KjJa6MFqQeIBjSzM
         +/bSbwpmVmNUv4NtgbYNvgMNSEB5cr63f/cXedESxgVwzZ4htkK3+CnvBhRU+W1Bcd
         RB1Ss10paZcOXrBynKL8pdr765S9Xs/bpJNGNlTbsxBWfilZaYuvRCZwpiigjnwYlj
         ZM/wpcfDu88iw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5lj7-1oUSdr3l1P-017GAc; Sun, 12
 Feb 2023 10:48:12 +0100
Message-ID: <70f4042a-df30-26e5-55bd-b349cc02c416@web.de>
Date:   Sun, 12 Feb 2023 10:48:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH 1/3] test-ctype: test isascii
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
 <21f316ab-714a-58f6-a8d2-466d738b4ed3@web.de> <xmqqr0uwdlvh.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqr0uwdlvh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XGsP7zLXfeWr1zNyBgeify8PULEPsTI1ZGbqj5L0Oz05s6kYhQW
 bJOGIyJ60FkWJL/vGIeo+uGnBhUxifpTt2N6+Ben24gtChovYw2X6EJYZyV8lW2LGsdyxhJ
 RS3zav9FCQITLw89XEzgSa17ZZv/3tDoasPJEC+s0yLu5Y2y27gk4R+waenv8Q2o39Whyu5
 Mr38RsqIDRLpTMjngpxYg==
UI-OutboundReport: notjunk:1;M01:P0:EfcKilXM8Yw=;42LUJOntH9nckIA404wxQVlsB1J
 LfcT+pD3Y1oG0Zqmfubpwb3Zp2tKShp/JNGuqHGwjDQJIBqyjUy5Wd1YBpZvNQUC1Ro8WDiwG
 c4Ou2stwULZaDfHNKeCP7MpgLhipk64I/NgqMfTlwhmwxCVKqmVF3HuqLSu+awr0tTOfozRnv
 aHuGtcET/OBQiyt2WPGUqKOeZuq/aXBjgK77mk7CXh33lCCkmRRtQJQalJxVk193UqWmaJoZ+
 AZH1ffbVZQv6IfBTgMegEoHS8977zi4AJz2FHSEE+FbywINU1c/Na8Si0LyDJXv4ROjE716Qo
 nQUdjRi9nmpfLXcyaczueRY55jmVPOPJi9AH8Gom1YbVEcJFaMLpIgsaqhkdWa4eyEQbRG8oT
 2nWCskVuHr4ZcKtpa/GZ5TCQkppQxS+YBNC3VoCVOTxLpWE0M/DTJC1mrW35HB15oU+9BA6xs
 u8AWPnEAZQq7I1TtzzjBI6v7I5Xdx4TAJZZKBV4tOgcj/dOIan2DInTV8u/mwieNqJcA2bzb6
 PdGhzhvedalywOXdfNBTpKchwsVaeYxeWIevO26EKeFyP8f2L7ijEaPANHUEjH+74qkyC4f/D
 MZD314LouzGda9YWFViagrmvZaZWQ57TaM/5n/9lT2flgL6O7i7GpOeRWTQbPPahlk1AyawPb
 kJBMBncThAcraFalZKYBgOdFL6Zdp+DeyrTFjTFc0tt8dHlKFrYeMaxNEcv/ZjnHjfudtGZmL
 M8R5CAsvXQcO/0glaA308ymS8tBLY4vVaqActPNkaHA616I/16wJnOhiTls3B7wa8PzY4CoBz
 BS+Nqkdj1xA0fDOZa0uKfFErdKYj7NnkteGBA18LdyBvtkx1mx5nZIa53qXeb48XiOTRi3UBm
 xSYbFFRoSR6neDKzeNfCXPa1C+saYmaAGw661tCvcpq427CcARfTxa4qAXTleEChMB7AsR5CX
 QlqMtK0C5qqVZUjFGotgMwWzp6U=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.02.23 um 20:48 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Test the character classifier added by c2e9364a06 (cleanup: add
>> isascii(), 2009-03-07).  It returns 1 for NUL as well, which requires
>> special treatment, as our string-based tester can't find it with
>> strcmp(3).  Allow NUL to be given as the first character in a class
>> specification string.  This has the downside of no longer supporting
>> the empty string, but that's OK since we are not interested in testing
>> character classes with no members.
>
> I wonder how effective a test we can have by checking a table we use
> in production (i.e. ctype.c::sane_ctype[]) against another table we
> use only for testing (i.e. string literals in test-ctype.c), but
> that is not something new in this series.

What aspect is left uncovered?

Or do you mean that the production table should be made trivially
readable to avoid having to test at all?

I on the other hand wonder if we really should add more and more
locale-ignoring classifiers.  Parsing object headers and such sure
require that stability, but parsing commit messages and blob
payloads should perhaps better be done with locale-aware versions
with multi-byte character support.

> I do not offhand know if the string literal prefixed with NUL is
> safe against clever compilers; my gut feeling says it should
> (i.e. allowing such an "optimization" does not seem to have much
> merit), but my gut has been wrong many times in this area, so...

Some compilers do despicable things in the name of optimization, but I
don't see the basis for truncating a string literal at the first NUL.

C99 standard section 6.4.5 (String literals) paragraph 5 has a footnote
that says: "A character string literal need not be a string (see 7.1.1),
because a null character may be embedded in it by a \0 escape sequence."
and 7.1.1 defines: "A string is a contiguous sequence of characters
terminated by and including the first null character."

Ren=C3=A9
