Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084DE1F461
	for <e@80x24.org>; Tue, 23 Jul 2019 19:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388808AbfGWTjL (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 15:39:11 -0400
Received: from mout.web.de ([217.72.192.78]:45083 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730048AbfGWTjK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 15:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563910737;
        bh=ajZNW8HMgdVXlhVxcNQKlCDHKPRIqGPj2XcCUEB5Gm4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=o+mgPVxrqMwQTvBn6PlArCveA5UTBJYP4AE5epvkOTq+SedD3JLDOyj5OcGVcU5N6
         W/bsqEZJ+tTKoTuTfF6AJFaq0B/9gWM260IlbABdJuiXp0TsIeKiiNfs5SHKrzUfzQ
         hu1SLVh/XQSwI/TOVUVvygaJjQdW+w4MvGk8ZnI0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXYS2-1hsfuJ0nyg-00WVaP; Tue, 23
 Jul 2019 21:38:57 +0200
Subject: Re: [PATCH] archive: Store checksum correctly
To:     Junio C Hamano <gitster@pobox.com>,
        Matt Turner <mattst88@gmail.com>
Cc:     git@vger.kernel.org,
        David Oberhollenzer <david.oberhollenzer@sigma-star.at>
References: <20190723025736.23036-1-mattst88@gmail.com>
 <xmqqd0i0u253.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <14410e00-4701-40d0-6960-e481fea50ed0@web.de>
Date:   Tue, 23 Jul 2019 21:38:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0i0u253.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jx+jisrT5MQQT27yNkoWSe/EIt7Q/yewhr5MGqwsz/438yPojh8
 jEbEkHKLCDlopO9HdQhgvkrcO3XyYyZhYxRi9LYQ0ejqzgweBNk11W7JK+dNAVCkhYPXjsZ
 yEdrln2CmrTRoYWNbsaoCbR3GrEper5BmUCxPSWAfiV7qPEV12a+OZ2fvVPJ7i/BFzGB/3r
 Kh4JFDf23nvTDNNSBNQtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yFmznm8xWvI=:2dMh6F8uhyjRvzEjFBOERH
 aIlTdaV63InqRMWUty8g0K/NLonZ79Vk+rLcqvJa7SH0SHU8Tg20n9BvtgKZ1/a31lBBb9V0y
 1Q4/Mhodhe32wZfE251uPKT35Kpt7dFw3nmaNzwvXsrvFEmQDRD9ANjrxZaTOke5wi4EEEFbk
 i4G3/8FikY3dDqDGbuRlIA1Sz7Mp47jqhUV0q0q+1Dn6zwoUbWJ8ho3+fbqc3mQN3fqZGjgaP
 dPUbXueEeemQ48GxPffib46V3mvX+yxf+m/TUc/i1Z3naDa7liIXJWQE52VB/2ZiLpp3xnHNH
 pu5dRkT6yGEhSvHQpRuzrHS/V8a2LNiGzGlw1jHrDr5UTVX2MLrRvex791aiPeZwvG95jmKH0
 eT35wxv3iePHjS/VSdYwJgPXY/aENEDDjWOLbrI+jH5eKDeq2yP7ZTChRYPNMaEyfkUc8CqJ+
 Cf5M0GcyNKiJKA2aV5UYgFKWhyJRw/GHyKxGzKLqSf7KQUV5XenHNR0CJ0JytszRom5XnuZOJ
 kfo0wn3gkvOYWG+vFuXiJ+tIX+jl8AhXqA2N/VH/0pr1feAGw5nxpzvBBye3/oxI/UNdqLu5x
 Dlm1gV8NIBoK3KYSsTgvAzN0ywnlr0TUhG1Gt+WSwEosda+zrdk41UQyUGa2osmPscwNjOS2L
 TGBjDIqoyIqKYz34j8hHCV0kNTYT9CR8dWMMV21Vg5wp/GrdFCTPeH4f1q767r+95oSjTaSjU
 eu//qTflQiLRGhzk2nocHGFk7IB/6Gkq27KBc1zhBiKownFheWOYxbXtyApHRYkUt0JTgBqX8
 ZCMjho93Fh0Fb7oGFjGOPpDXPHhImhssvtArllfVNZoODkcB9JS6VuSGq2+YZzTviMtqW9nM5
 q7NXU8CZnAg2txWBpapq0lGRk/wvFhH3cFmOcKPH7gkyGfqM/0zbhm9kusf0fHVPsJ63byRxM
 hXI5yI4rgqoNvPMYty2uhIpa0clNtN4FBLGqJa4vO02ahV8iswKdlkPwjaxkmiTfC2kjWLNGT
 3DRbNQIrA1dbSwFCJdafT4Kn0zj6GfEAYcDgh1sNX1rByyKJAhSTEVZoAcnLoRxBEHQYglrDa
 dM6AQI+Fd+jt2M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.07.19 um 18:49 schrieb Junio C Hamano:
> Matt Turner <mattst88@gmail.com> writes:
>
>> tar2sqfs (part of https://github.com/topics/tar2sqfs) rejects tarballs
>> made with git archive with the message
>>
>>     invalid tar header checksum!
>>
>> tar2sqfs recomputes the tarball's checksum to verify it. Its checksum
>> implementation agrees with GNU tar, which contains a comment that state=
s
>>
>>     Fill in the checksum field.  It's formatted differently from the
>>     other fields: it has [6] digits, a null, then a space ...
>>
>> Correcting this allows tar2sqfs to correctly process the tarballs made
>> by git archive.
>>
>> Signed-off-by: Matt Turner <mattst88@gmail.com>
>> ---
>>  archive-tar.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/archive-tar.c b/archive-tar.c
>> index 3e53aac1e6..f9a157bfd1 100644
>> --- a/archive-tar.c
>> +++ b/archive-tar.c
>> @@ -215,7 +215,9 @@ static void prepare_header(struct archiver_args *ar=
gs,
>>  	memcpy(header->magic, "ustar", 6);
>>  	memcpy(header->version, "00", 2);
>>
>> -	xsnprintf(header->chksum, sizeof(header->chksum), "%07o", ustar_heade=
r_chksum(header));
>> +	xsnprintf(header->chksum, sizeof(header->chksum), "%06o", ustar_heade=
r_chksum(header));
>> +	header->chksum[6] =3D '\0';
>> +	header->chksum[7] =3D ' ';
>
> Wow.  The choice of %07o is as old as the very original of tar-tree
> implementation in our codebase, starting at ae64bbc1 ("tar-tree:
> Introduce write_entry()", 2006-03-25).

Actually it's already in 731ab9ccf2 ("[PATCH] create tar archives of
tree on the fly", 2005-04-28).

> I think the updated behaviour matches Wikipedia [*1*] where it
> spells out that 6 octal is followed by a NUL and a SP; it also says
> various implementations do not adhere to this format---perhaps they
> meant us ;-)

OpenBSD's pax(1) does the same if I read
https://github.com/openbsd/src/blob/master/bin/pax/tar.c correctly.

> Frustratingly, I couldn't find this spelled out in POSIX [*2*] X-<.
> The closest I found there was
>
>     All other fields are leading zero-filled octal numbers using
>     digits from the ISO/IEC 646:1991 standard IRV. Each numeric
>     field is terminated by one or more <space> or NUL characters.
>
> which sounds as if the standard wanted to be deliberately more
> inclusive than what tar2sqfs is insisting on.

Yes, I remember following that specific paragraph when writing the
code.  The wording probably tries to account for the different
variants invented by vendors over the decades.

is_checksum_valid() in
https://github.com/AgentD/squashfs-tools-ng/blob/master/lib/tar/checksum.c
compares the formatted checksum byte-by-byte.  That seems
unnecessarily strict.  Parsing and comparing the numerical value
of the checksum would be more forgiving, better adhere to POSIX and
might be a tiny bit quicker.

Ren=C3=A9
