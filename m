Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6E5C4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 08:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiLEI25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 03:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiLEI2z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 03:28:55 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1503E0DB
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 00:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1670228926; bh=yEissstxxLzr1THC1VHrThrp/tdlW4GkJPbDEu5EInw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=HfG5XFOskZoMTr7C59R/ZOjolR17br9vye8klLfFtaHLEcEMvLmcrKXRt9hNgJ2mc
         5rdfCtS41CfyyBgc5NL/RJobJhxkMejq8DVbBDxHE5ry9JZU9XOqj2bMaTua+YmQxx
         NKJVoWSQWT3EPmFpR01eDvP2zheRSFsW+E50J/d5L8xVRbXlA+hQfloSwnJKjmfdvR
         OcdJwbfKkQGv8PegSbaCK+yJ5WGpYWjhmkWDglxHTena9DgbINaOhQHp1PXjrXNnc0
         HiNAkfs8dYfXxVL5mP99eSTKhyKJG/liMAf+xTMSwXkwSHpbHBGjrPFMwSdafoY69K
         vHS8RJItlBmhQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mfc8o-1oUywQ1Hku-00fo49; Mon, 05
 Dec 2022 09:28:46 +0100
Message-ID: <569714f6-a913-5f7f-855a-b303adbde3ee@web.de>
Date:   Mon, 5 Dec 2022 09:28:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 2/1] t3920: support CR-eating grep
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
 <cbe88abc-c1fb-cb50-6057-47ff27f7a12d@web.de> <xmqqo7sisllv.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo7sisllv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WwXvsPN94dj2P6ETJBNdkRAHL7Z+CF3NdbB2wowYxIApCR1ji76
 xtIkSTSxP8nPcwNkDIdp6ZY/UMwCVgFZj0LJCKt3aRNNXAfOEXRbiwOYGomFHJrtTd3Zj/s
 Il6a7Esc70ttBRw+s0nHekfeuPY/ZbimqGInzXW1jz90e7CeBw808xkfzeCxUZZ07ZCSr0a
 bF0mAhxzWygwmsSoz+jnA==
UI-OutboundReport: notjunk:1;M01:P0:iHqn1HsL1PA=;zSQa0NJF9ekN+9EhAud2i+pu7JH
 BNVtI1F6mC7TKHcPz2u30tc/5uEIqf4+Hlf9VyhbD44127A/8pnxfFP9rGIb9AgOemDIt0E7b
 F9lpaSeqkv92zRG9Bjwluww/jLyCMgmQeRrm0ZKnex7oPjODt2LD8pdXoEZ9OPkIVUemYrE+t
 m9Xi8/e92RJlUFv4t13Fla1b4poEBln2ISomJS9Ln0vIZCZQNgIW7Dvkv6AEdXsI+Ud61j9TP
 NPg++C+imWc4cnKUgoX6Ms+kKfISDvNW7goxHwaz/soy/lmw40/ztn0Q2HunTU+n5Sc6St/kx
 9LPOKBUe+BVltzZ50VAIiaU+I4FfZ08RPcrMWfLG0Zuj/h8z8bgHBp5dUVSPtZsqVtNGvN6tl
 k9U8D+z4k5nh5q33GrAvEShCs6Xh9k+cSJiWFZ0FgIZfrDbFhE+IVh3D23etpBnC9MUrtNpzt
 BDYQaYADqIr7Svt0/0CwqQCbVHIFlyhDD82416BqpRd4wz/kFsu760Bz6yrMhIWI2QXtAP1Ai
 5ftODOIP7FGkNerZfVe3wUBWgG6ikANE1ZwWeCISuJia33LDgDACq15ztJlnuqLH6jOuCiAEE
 VYCmmM9jWyN0tkDCUrjX6E9pB53rzUJj6N97biVdT6tyPspW7hkOvCsSGth9hL+wItEnezL4l
 S7kdS4889DmEtV+yzH+xBKkTGcwM/bomdgTeSyeym4JG2no3NqsZC7VU4YWpyogiosRgV3kne
 kcUQhfJM0AFi8Xppo/K5/xa+09IQg3Y+8qntGtMKt6tFLlHKQQerldothTcQBytkT8sjiJ9AR
 Q4AZah7c/GlyabIAD7+RY38CWn+jktqZ5s4In74sjvVdnfYcx3UHInTbdVWZJIfKVD0pwPtUG
 u8ADkF62cTOgRZvsqEmMZ95iZvSlwziboWWolkkZWGD4LjHAyfo+69XQhw4geSpIuDlAYa7h3
 7i5uc1N+gyaMYrCglT5SVRGv8gk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.12.22 um 02:08 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>  	grep 'Subject' .crlf-orig-$branch.txt | tr '\n' ' ' | sed 's/[ ]*$//'=
 | tr -d '\n' >.crlf-subject-$branch.txt &&
>> -	{ grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || tr=
ue; } &&
>> +	grep 'Body' .crlf-orig-$branch.txt | append_cr >.crlf-body-$branch.tx=
t &&
>
> Doesn't append_cr unconditionally adds CR at the end?

It does.

> Do we need to
> touch this test again when "grep" gets fixed on the platform?

Depends on the meaning of "fixed".  If it stops removing CRs then this
line is unaffected -- .crlf-orig-$branch.txt contains no CRs.  If it
starts adding CRs then we'd have a problem with all grep invocations,
which was addressed by 4d715ac05c (Windows: a test_cmp that is agnostic
to random LF <> CRLF conversions, 2013-10-26).

Ren=C3=A9
