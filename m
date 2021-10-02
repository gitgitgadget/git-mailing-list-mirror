Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D978BC433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 16:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D7961A54
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 16:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhJBQ6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 12:58:50 -0400
Received: from mout.web.de ([212.227.15.4]:44525 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233659AbhJBQ6t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 12:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633193819;
        bh=M8RhcGJxzbKeJ/RnX80OpLzbJsm4NEGBf1cEkUh3ogw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=prhlkYEhH5iwOXB/fKxNiMKSpTLaX1eBc5Hbjqi9bNM6ZpovrmWJ4LEyhWaJar+iT
         NoRWIbJ4SCm1vbGqHWDCrasunPrE4YRF9voFTFrgPYLr1t6ZjsYVwsRHaelODuFUDt
         sDf4G/jtrEO3DJ0FDk3NX1V72t0KFYm9OgotA12Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MW6Ib-1mHhTO2ZnV-00XNmN; Sat, 02 Oct 2021 18:56:59 +0200
Subject: Re: [PATCH 1/9] test-mergesort: use strbuf_getline()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
 <928cb42c-c45b-c90a-c71b-2f6669e03251@web.de>
 <87fstjpzdu.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0bff46b8-fd45-c4e5-e8b3-60e68ba7c2b9@web.de>
Date:   Sat, 2 Oct 2021 18:56:58 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87fstjpzdu.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5t8OZ7DJ9epvvvlAgVTiP0QLyFabC2di+hgnw4tB3VvHXRqARXx
 PJ4fIKRClrgTeJrnJHF2Le5urDnHHOoVbjqB3W56BNi01p1E560dsI7eWhR6NFEfFRM8hHf
 3xVrpBcs8RKqWBORRKS5ha7pPtNQeRfUZRZ3AJXCCt3Vfym5FlgyAvkRrVYByTUUEFjgxkv
 rnrlFE0Y1rv+ql2iAGHQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IUhYB7j0PFI=:mmYhPZ5MhugbaSKzoyPkC4
 U9vk/KodpSgcRIi4L0JxlYuYNgGOaEop0cWzME9/LQO/BkAP9LGDE15t9bOBPr0bEyWS5kTWg
 /2272tWyu/1ethFkhflQsY1HCkZZKAvwsN9Dst/m+wm/4x5Y5fIUECFlMtRjf+qnCrPkFi/wa
 q/YRKizmyIppjonmplqiyAv8vj66F2r6ktjYSj4Gp+wUDzCM3lRYclSLmOnOVvsYME/TcGfCj
 HsaNdRP1c58zDiTi/p34MOS/Qra68pr0qYMca54Xv7vkcWsdWsFpv8a5Yt+9yi+yber22vS9p
 jIgse39ywyuchfSjAg1mt7ryfRxvONL0pWKzyDInYj9QiXUGyn3e0krY44aC4MHKT1ykX6RQc
 eYiLVYbOFH6NNcUzkFQgiVAwEHvwXS2PigFZYRZTKtNvksbhxgck8f48pNnpVYjD+nHocnrHd
 5dM1+maRhphNgkhhREme8clrThukQnGwkDFImRIdKVgpjaSSP5wBrcEVhNDqnZNNpiqd7kfqF
 MIivWNgUU82T0l2eeznMhmzzGSnX0KiybaKgxI9BgL9dXVTwFQLmDj5RTpD8sNdPhgKJFZwS6
 Epmw8NQjYMdovG9+9S4/Eug/ayuvLyxGOyOah26gxE+uCP82vG7eTBxUfYcC8rwGHDJVwxYax
 7EpNK/K+bGaSow4vQADK5Jz5bNBBgSV7OjJqNqbOCqcjChaCU3uV4EliHwVXCRIXH0VZZWVHi
 7CEwN7i8rCt369X2lledbItILoT/tdDZmlELD2Fzmnq/bztA13fn2uQ6ZhbG+evFS6uI61IPk
 d56avBq5NDldxgZS4AXCMKX75iyD3j7AbmATeV7FiiteKBjb4EZqrR1Aun8dIGkPoTq+ldIkZ
 lAPkPmHqkXy+eJjfDEdm33u2TesKpS+7v70DOJKTe2JhRpFQ2KC051U84RuiKVnKy8siLRBAN
 OgAvD5PUzaRD7CfpKQdFU8QbYDq+LgidQC9ahPVJaSKvZ/vzkQF364giOb5paUITQb8E3wTKu
 OHbUuXYlVFuPp19xGhchGhU4YL5+q+RuYsWn+XrKypZs+J5OkJtWRKUdMkNt8XR3vTkD40eQI
 Q7oMh5cVQcP87U=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.10.21 um 11:08 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Fri, Oct 01 2021, Ren=C3=A9 Scharfe wrote:
>
>>  	while (lines) {
>> -		printf("%s", lines->text);
>> +		puts(lines->text);
>>  		lines =3D lines->next;
>
> Aside: I wonder if we should have a coccicheck for that (not as part of
> this series), but maybe it would generate too much noise.

To replace printf("%s\n", s) with puts(s)?  I considered such a semantic
patch before as well.  It would effectively forbid that specific printf
usage.  And why shouldn't it?  puts(3) is easier to use and its call is
shorter.

But puts(3) is also confusing: It adds a trailing newline, but its
sibling fputs(3) doesn't.  And it would look weird in the middle of a
run of printf calls.

Clang already does the replacement with -O1 and GCC even with -O0, so
there is no further performance improvement or object text size
reduction to be gained.

And so I dropped the idea.

Ren=C3=A9
