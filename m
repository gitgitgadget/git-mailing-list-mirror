Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0FBC76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 18:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbjDEScq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 14:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjDESco (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 14:32:44 -0400
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527B04C17
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 11:32:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 76A843C09FA00;
        Wed,  5 Apr 2023 11:32:39 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lgOUApS0xxtS; Wed,  5 Apr 2023 11:32:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 2221F3C09FA03;
        Wed,  5 Apr 2023 11:32:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 2221F3C09FA03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1680719559;
        bh=bRYhVoaglb+oHA8EWDW1Fqok6GB2iW6NSs3OaO/A+wY=;
        h=Message-ID:Date:MIME-Version:To:From;
        b=ddPN/A9we4BUHk9jtuP3e/d7yYjuzKL+mI1OKkx4N7NuG6ksZPWNUvHGSbLckV00L
         fLV9O7BD0cvUUSIjRGHGHSSMCwYTWdutl0Ed8r9ye/L7asLcyjEcy77TrD62thRZXQ
         Op/3jqZAHJcJsSbP8ejjthm4wXf9u7OkNgr2F5yDYT0JWT7DOiW0auT6SAYXu234CV
         G/0KL1akOCluJBnF2XtLl+t6ftlrAIzfX48LqlSEI129fMNS/D/DPqJeM4nEHD595X
         2HI54efP8ArWRj//LA2JVhJaYfDJAk8qP/4ga/l0n5XJCPagkY6mjgfDMJ9Ooxj4A4
         ArTlLflXvcBtw==
X-Virus-Scanned: amavisd-new at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L7eQ5AvG5bMC; Wed,  5 Apr 2023 11:32:39 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by mail.cs.ucla.edu (Postfix) with ESMTPSA id D20763C09FA00;
        Wed,  5 Apr 2023 11:32:38 -0700 (PDT)
Message-ID: <6d86214a-1b80-eb88-1efb-36e61fd3203e@cs.ucla.edu>
Date:   Wed, 5 Apr 2023 11:32:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>, demerphq@gmail.com,
        60690@debbugs.gnu.org, mega lith01 <megalith01@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Tukusej=e2=80=99s_Sirs?= <tukusejssirs@protonmail.com>,
        pcre-dev@exim.org, Philip.Hazel@gmail.com
References: <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
 <CAPUEspj1m6F0_XgOFUVaq3Aq_Ah3PzCUs7YUyFH9_Zz-MOYTTA@mail.gmail.com>
 <96358c4e-7200-e5a5-869e-5da9d0de3503@cs.ucla.edu>
 <xmqqttxvzbo8.fsf@gitster.g>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Subject: Re: bug#60690: -P '\d' in GNU and git grep
In-Reply-To: <xmqqttxvzbo8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-04-04 12:31, Junio C Hamano wrote:

> My personal inclination is to let Perl folks decide
> and follow them (even though I am skeptical about the wisdom of
> letting '\d' match anything other than [0-9])

I looked into what pcre2grep does. It has always done only 8-bit=20
processing unless you use the -u or --utf option, so plain "pcre2grep=20
'\d'" matches only ASCII digits.

Although this causes pcre2grep to mishandle Unicode characters:

   $ echo '=C3=86var' | pcre2grep '[Ss=C3=9F]'
   =C3=86var

it mimics Perl 5.36:

   $ echo '=C3=86var' | perl -ne 'print $_ if /[Ss=C3=9F]/'
   =C3=86var

so this seems to be what Perl users expect, despite its infelicities.

For better Unicode handling one can use pcre2grep's -u or --utf option,=20
which causes pcre2grep to behave more like GNU grep -P and git grep -P:=20
"echo '=C3=86var' | pcre2grep -u '[Ss=C3=9F]'" outputs nothing, which I t=
hink is=20
what most people would expect (unless they're Perl users :-).

Neither git grep -P nor the current release of pcre2grep -u have \d=20
matching non-ASCII digits, because they do not use PCRE2_UCP. However,=20
in a February 8 commit[1], Philip Hazel changed pcre2grep to use=20
PCRE2_UCP, so this will mean 10.43 pcre2grep -u will behave like 3.9 GNU=20
grep -P did (though 3.10 has changed this).

That February commit also added a --no-ucp option, to disable PCRE2_UCP.=20
So as I understand it, if you're in a UTF-8 locale:

* 10.43 pcre2grep -u will behave like 3.9 GNU grep -P.

* 10.43 pcre2grep -u --no-ucp will behave like git grep -P.

* Current GNU grep -P is different from everybody else.

This incompatibility is not good.

Here are two ways forward to fix this incompatibility (there are other=20
possibilities of course):

(A) GNU grep adds a --no-ucp option that acts like 10.43 pcre2grep=20
--no-ucp, and git grep -P follows suit. That is, both GNU and git grep=20
act like 10.43 pcre2grep -u, in that they enable PCRE2_UTF, and also=20
enable PCRE2_UCP unless --no-ucp is given. This would cause \d to match=20
non-ASCII digits unless --no-ucp is given.

(B) GNU grep -P and git grep -P mimic pcre2grep in both -u and --no-ucp.=20
That is, they would both do 8-bit-only by default, and use PCRE2_UTF=20
only when -u or --utf is given, and use PCRE2_UCP only when --no-ucp is=20
absent. This would cause \d to match non-ASCII digits only when -u is=20
given but --no-ucp is not.

Under either (A) or (B), future pcre2grep -u, GNU grep -P, and git grep=20
-P would be consistent.

I mildly prefer (B) but (A) would also work. (One advantage of (B) is=20
that it should be faster....)

[1]:=20
https://github.com/PCRE2Project/pcre2/commit/8385df8c97b6f8069a48e600c7e4=
e94cc3e3ebd9ht
