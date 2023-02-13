Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D2DC636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 18:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBMShb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 13:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBMSha (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 13:37:30 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05371C7D3
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676313435; bh=JDWZExLUhid0GySKSrvtIl13aujJpAbhA1KUyf36iRs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fOldFomFU5k1pXEcd8PFhEU/8lFIqfTYSBjJ7wsIxyM1c7S6FutEQZpxY4KoCRcSH
         IbhkgFgi7XBalmDfAwWK63cqJ499kAR0RGmVmqobpnjfLzYz+TeDtdS9fLwItqastt
         HMTYFx53OXREr+T6qNbxKTKTBv/yOew+rBY3L1LhHaSRbd18j8jYgjcqv7VHAKnTNw
         tl+fWRGf5ChTje8zerlBp7C4yfFVyZL2TihfseqK2w7Mit5/S6ffe075pkl1yQVc5T
         8CHhLXofSGFLIQr3aTL4J5kUYdewRUoPemV2c4xSxm8yX4KNvphA4CtfXv+LQQRnt4
         qwDVBu3q4tTdQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pUQ-1pUPun2mYo-008Hzz; Mon, 13
 Feb 2023 19:37:15 +0100
Message-ID: <93793a00-da6a-81b4-348f-cd7b946bb9eb@web.de>
Date:   Mon, 13 Feb 2023 19:37:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH 1/3] test-ctype: test isascii
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
 <21f316ab-714a-58f6-a8d2-466d738b4ed3@web.de> <xmqqr0uwdlvh.fsf@gitster.g>
 <70f4042a-df30-26e5-55bd-b349cc02c416@web.de> <xmqqttzqcjyj.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqttzqcjyj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CR/ryAgGm5r5e4TqEzAzB/M+l3sOR5G5kn6/UuvWykEtkXKq8pq
 Z7AWQb6Q5cRdTI+JMfnMaO2NLl71y4TO7jeOwp+DLPHBaM3kbcbgBhTpDNUwbCVxOm5LPTg
 Eu0l2/0cZjIpWoEZKJ+bVc+AG8/P6UypWCQu8z+2UyNBCClYdVRQFJEExbVJrbLMD9OoOgJ
 81A95RtXf9i7Br7ZpR+SQ==
UI-OutboundReport: notjunk:1;M01:P0:O7waI0a4lPA=;GhrlUERO+T5v9TltWl2UVysT1Nv
 ZZlMonRls/weljslYzsugPvvXVwR+y930xRjl0GB3I4mT/kx4o9Dz/Gzzhumq3LU7Is7Yg9QQ
 /I83y1FMxHvA03xSKzcHg2eGucpDbWeuG5bwQ49HHqM3x0zHndVPO102SzCo9QxLcF7VmKevB
 6Q4yiV6ppMPEVMYkOvVSWFHR/bcXrf9MAtfBH0jXGspCVyEQX2n7tBckoflSWpcPlELQZANBQ
 Mdx+hKshVc5sUXHzu0z6/kg8WzuwwFsZ2J4Ngc8dIyGCs9g7EWV9txUfSmwQpX/GXn0rSMTDw
 y9pIB+lEATsv4xH2nrJOIP5ui5/86YCBgFLq4MqhL1ojxwYXawZ2aFUPfItjtNk/dH0qpgjJR
 puVb41Od+Z0DjU1N+8mIEJFbjWNq/tWO4JyIL4YjPxyu/2xjEJiOCnis38zCNkXHvJMeC/k9a
 ETp40rlBazp+ZukFnkalwiVuCSW9FiyrTi7jnxEA2FZnAG8tyXyl/9q2qwaknpq+pZc9sT8lf
 62p2LU7RDulBqz0cABLoF2IrTo7vI3PkcnHRoTbS/jcPS1ncRz2byWsUBHV45jHvdB6y7SgmN
 YY5rP12FiKXeTcyjPHS892+3lhCmx88Wy1IBkWwa4b9TNDFxY8dIx2bzGu4zTNvC1oGUf+G3h
 KqHYX0alnkc1Y3/jN5Hl8sWJoUgz1kVDSLjz+YrIW5WCZ7grpREsvwzr05ntTPC7zTYxMX9+c
 6/3W1mz5dKzFPW+iFyYYZksM7rlAuwiWBHNBqoWvoCINxMBSsyaCQvET6W0uXl/p9gYp/Tnz2
 EV2uhdnbOqYtieTffCk6pZehgfa9AN42zHNxdkD2nrniHb2OLdRLuOgMrLdnH2TgAVZ6gmYnD
 dwffudRQCrr5wMzxyxQWN10ysOPbEkrUPknJB4ngUwq1CIeYrS5JJg24qGaVZgSOE4xPk/SM3
 +tDR/llfnvJ/V3UsrtEtVTyF02w=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.02.23 um 04:39 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Am 11.02.23 um 20:48 schrieb Junio C Hamano:
>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>
>>>> Test the character classifier added by c2e9364a06 (cleanup: add
>>>> isascii(), 2009-03-07).  It returns 1 for NUL as well, which requires
>>>> special treatment, as our string-based tester can't find it with
>>>> strcmp(3).  Allow NUL to be given as the first character in a class
>>>> specification string.  This has the downside of no longer supporting
>>>> the empty string, but that's OK since we are not interested in testin=
g
>>>> character classes with no members.
>>>
>>> I wonder how effective a test we can have by checking a table we use
>>> in production (i.e. ctype.c::sane_ctype[]) against another table we
>>> use only for testing (i.e. string literals in test-ctype.c), but
>>> that is not something new in this series.
>>
>> What aspect is left uncovered?
>>
>> Or do you mean that the production table should be made trivially
>> readable to avoid having to test at all?
>
> Much closer to the latter but not quite.
>
> Both tables are not all that transparent, and it feels that the
> protection by the tests largely depends on the fact that it is less
> likely for us to make the same mistake in two "not so crystal clear"
> tables for the same byte.

The test strings for islower() and isupper() I wrote down from memory
long ago, I think.  They should be easily verifiable, like the new ones
for isxdigit().  The one for isascii() is a bit tiring, but verifying it
against the man page which says that the characters from value 0 to 0177
are included should be feasible.  The ones for iscntrl() and ispunct() I
got from their man page.

But when it came to isprint() I got lazy and just copied from ctype.c --
you got me there.  A more intuitive representation could be:

   " " LOWER UPPER DIGIT PUNCT

In my experience having two copies already helps when modifying one of
them -- but at least at some point we better check them against an
external source of truth.

The ctype.c version needs to be fast, so we probably have to make some
concessions to readability.  I'd love to be proven wrong on that,
though.

>> ... but parsing commit messages and blob
>> payloads should perhaps better be done with locale-aware versions
>> with multi-byte character support.
>
> Yes, that does make sense but it is orthogonal to what sane_ctype
> wants to address, I would think.

Currently we can only use one or the other variant because our sane
versions use the same names as the locale-aware ones.  Full overlap
instead of orthogonality.  I don't know if there is a practical impact
besides not recognizing function lines that start with umlauts etc.
for diff hunk headers, though.

Ren=C3=A9
