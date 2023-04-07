Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F5DC6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 19:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjDGTCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 15:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjDGTBu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 15:01:50 -0400
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1DFEF82
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 12:00:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 64E6E3C09FA01;
        Fri,  7 Apr 2023 12:00:17 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zp66LFy4pHE7; Fri,  7 Apr 2023 12:00:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 0E32C3C097AFC;
        Fri,  7 Apr 2023 12:00:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 0E32C3C097AFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1680894017;
        bh=RLGYiM+qbMJT97xdVCzt/fP+O1nLWgInQnT7uysumQU=;
        h=Message-ID:Date:MIME-Version:To:From;
        b=ihF/bUcmkB0vPm8EweR+bhESphyJsVE2A7pZD1bxge1K/Cra6+NeQzVjYAe5GeL/j
         vaDyolqDxZnVUVXzM2Hd1PtptcnFudh/Qh35TBFhU6mxh2ydjnJn6Ld36fuKNdswI/
         ni/1Q4NScfFlhwCsJ21c/CAIySv8QO0sz6my2gtds3PT88nO3+egndruMz8p8ihg7m
         EOKYEeW5pMXGxkO7EvhyGnTSQg1Yg5sx/0iruvSSIMTUyvWe40UweTpMAIe4NX2GQz
         M+Ph7M68u3adlMdxx6c4iHzdSaNW22mP8owoQSVfgfA4CCiR4QTAoMwOo44EKwSvHW
         nRXRIjBoM3wxg==
X-Virus-Scanned: amavisd-new at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hpZkBCsrcJpZ; Fri,  7 Apr 2023 12:00:16 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by mail.cs.ucla.edu (Postfix) with ESMTPSA id C1CF63C09FA02;
        Fri,  7 Apr 2023 12:00:16 -0700 (PDT)
Message-ID: <065bcdcb-5770-5384-5afe-4a4d29272274@cs.ucla.edu>
Date:   Fri, 7 Apr 2023 12:00:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     demerphq <demerphq@gmail.com>
Cc:     60690@debbugs.gnu.org, mega lith01 <megalith01@gmail.com>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>,
        =?UTF-8?Q?Tukusej=e2=80=99s_Sirs?= <tukusejssirs@protonmail.com>,
        git@vger.kernel.org, pcre2-dev@googlegroups.com,
        Junio C Hamano <gitster@pobox.com>
References: <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
 <CAPUEspj1m6F0_XgOFUVaq3Aq_Ah3PzCUs7YUyFH9_Zz-MOYTTA@mail.gmail.com>
 <96358c4e-7200-e5a5-869e-5da9d0de3503@cs.ucla.edu>
 <xmqqttxvzbo8.fsf@gitster.g>
 <CANgJU+U+xXsh9psd0z5Xjr+Se5QgdKkjQ7LUQ-PdUULSN3n4+g@mail.gmail.com>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Subject: Re: bug#60690: -P '\d' in GNU and git grep
In-Reply-To: <CANgJU+U+xXsh9psd0z5Xjr+Se5QgdKkjQ7LUQ-PdUULSN3n4+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-04-06 06:39, demerphq wrote:

> Unicode specifies that \d match any digit
> in any script that it supports.

"Specifies" is too strong. The Unicode Regular Expressions technical 
standard (UTS#18) mentions \d only in Annex C[1], next to the word 
"digit" in a column labeled "Property" (even though \d is really syntax 
not a property). This is at best an informal recommendation, not a 
requirement, as UTS#18 0.2[2] says that UTS#18's syntax is only for 
illustration and that although it's similar to Perl's, the two syntax 
forms may not be exactly the same. So we can't look to UTS#18 for a 
definitive way out of the \d mess, as the Unicode folks specifically 
delegated matters to us.

Even ignoring the \d issue the digit situation is messy. UTS#18 Annex C 
says "\p{gc=Decimal_Number}" is the standard recommended syntax 
assignment for digits. However, PCRE2 does not support this syntax; it 
supports another variant \p{Nd} that UTS#18 also recommends. So it 
appears that PCRE2 already does not implement every recommended aspect 
of UTS#18 syntax. PCRE2 also doesn't match Perl, which does support 
"\p{gc=Decimal_Number}".

Anyway, since grep -P '\p{Nd}' implements Unicode's decimal digit class, 
that's clearly enough for grep -P to conform to UTS#18 with respect to 
digits.


> A) how do you tell the regular expression
> engine what semantics you want and B) how does the regular expression
> library identify the encoding in the file, and how does it handle
> malformed content in that file.

Here's how GNU grep does it:

* RE semantics are specified via command-line options like -P.

* Text encoding is specified by locale, e.g., LC_ALL='en_US.utf8'.

* REs do not match encoding errors.


> on *nix there is no tradition of using BOM's to
> distinguish the 6 different possible encodings of Unicode (UTF-8,
> UTF-EBCDIC, UTF-16LE, UTF-16BE, UTF-32LE, UTF-32BE)

Yes, GNU/Linux never really experienced the joys of UTF-EBCDIC, Oracle 
UTFE, UTF-16LE vs UTF-16BE etc. If you're running legacy IBM mainframe 
or MS-Windows code these legacy encodings are obviously a big deal. 
However, there seems little reason to force their nontrivial hassles 
onto every GNU/Linux program that processes text. A few specialized apps 
like 'iconv' deal with offbeat encodings, and that is probably a better 
approach all around.


> there seems
> to be some level of desire of matching with unicode semantics against
> files that are not uniformly encoded in one of these formats.

That is a use case, yes. It's what 'strings' and 'grep' do.


[1]: https://unicode.org/reports/tr18/#Compatibility_Properties
[2]: https://unicode.org/reports/tr18/#Conformance

