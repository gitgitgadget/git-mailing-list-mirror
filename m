Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC67C4320A
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 15:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D326102A
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 15:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242886AbhHZPYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 11:24:22 -0400
Received: from mout.web.de ([212.227.15.3]:46327 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231732AbhHZPYV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 11:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1629991408;
        bh=6SHEsOb1MMSuxXwXcoWEc56DQcbyWsEhxJ7vTABMB04=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ftwlynCiSBpvlUQzHjL30q0zey2vtuQtmbHEvUlULaoYCtmUtSJmX2SRRpZsb7whx
         w5Za+BwqGN3yAFNWUNpsO0T5LYE826Us/kkz8DmGzXBrHhidKMxFpXs7Wf/lJPPyKQ
         fQEsi7F2GTFqQ3LuiL/Z4phK/ga2PejqdwPipUtU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LcPm2-1mhrKY1Uwg-00jqgP; Thu, 26 Aug 2021 17:23:28 +0200
Subject: Re: [PATCH 1/2] xopen: explicitly report creation failures
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <6a5c3e8e-0216-8b63-38fa-b7b19331d752@web.de>
 <CAPUEspjkcV1_R5DNXCkL5wQpZCW+K4As2nGuEGu6fyeFrr15KQ@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f44bf316-efae-34ce-33e0-0161c3bb78a0@web.de>
Date:   Thu, 26 Aug 2021 17:23:27 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspjkcV1_R5DNXCkL5wQpZCW+K4As2nGuEGu6fyeFrr15KQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CZU/A2djsZ+aA5BB0Kjco816TCH3yOLqw3NU332oejfXvBwuGt9
 qdIcI3+C//mjqYjs1N189AP5vklJQE3zTIdRy0UDghP/DCz4Z6gZou02zMFw3bfSe00teDw
 umZROxqHbK0gCeddgHUU9bUcFGVKfzJmANSoelNYx3kOCKyV7IQ+df+CnfW/ehbREBF7CcI
 rdGs8XBNdv8GVUeWY5ANw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j1SQuf6YMKI=:16pr4YAcmpOOh7M+rplZck
 UoEfr9dnZp8oFaDG0QI2aEfVQE4EEZKROyNZreC5+tgh4Bv5uhkWdb2+g5AUcWKI0uT8ltaKT
 Y8VmJOO/vJZVpu6DdWwJUiuWK+rcdR45cqdwFePRImtCdkljxErEfDO+kYtLXqsIFo/RhrUrm
 YaiE8itu+lEXojVkYRDZ9SyYAy3cNVD/8ho0bZhbbtbSumMczsKyhkxavM/mFGDEzUlsObcEC
 dxdT0StjSTneltE7VWGLVryy6E5L4GIrASbE7W8ssRAo7dWrEsg20MoUhebmTlPPVYaeYweRP
 gNTOemm2jcxrHtG0P5yO4zUEIFBZOnzT/69+tzF1Y6YrVgQ0CbE/f0w0yK8ojTEb0UmhbSl3G
 WYS1t9ndnohH35w7UQ3c9IYleXQZvXJZgV3Rgg5b3gSJYL0dG3KC+f08AM4iTkbDjlm/n9ci3
 yC9OO+AN1lv+6FXUx8n4UZ6aeYJ/dLsRQxGI3+WU8qmLeG0PwR4qPffP/W2zfsVjLV8Y1+IL1
 iD0mCp9V9iUZ8O3vEGgDFlAp5nEBbIrzOl7E4PGvP02uLdxcl8DQxiBpDRjTj7cEJwfq1kvH+
 7xEFVPhGphO6tcEhdOYN5elFd/NtjU3RV4rb4/7Cfzofwa/itYIxnWJLwt+rYUUSi+7J0cGA0
 +1Eowbl998kPCwKWk9WTxeOAR9ZHCDk2epQScH0pY5n7ppVFoB+yyDwyCP8h98LeG3rQVRzXX
 Jq3LNL4ec7Qk9Ma87myUcqmvN7go+VeDdCJUaAxilOsCQTviYjwOKmnarzovIGqMJb+to8z0p
 oJxcIEhG/2uN8lCDhFrFSlHkIq55wvXr9WDXvlgskG4a+qcJp68GPx22zqFMC9+DnAvPbQPLE
 pmRapBScOIOjtYe3qQyg7vbWxHAdjnuejSi9hZIT9bp2NyT1EtHr1w3eCkNtpokTqFX/8YtYh
 ztweqwZP3VCa9thi+u35lgFHPlBc8nJ3Ft/olDNS/3G6QffdkiKC0rnfDPd1WsN4AhhwEE+7h
 qEaY+RYBGxaJioQ3q7aqMquSDxCS9GCd0/NjiAOveT7Wnf3tSWiEZxJA5b2OLP1/NRKT8E7MI
 47uRnpL2lR5yEGhmNp8E5xolFsXjokcv1Rs
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.08.21 um 01:46 schrieb Carlo Arenas:
> On Wed, Aug 25, 2021 at 2:11 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>
>> diff --git a/wrapper.c b/wrapper.c
>> index 563ad590df..7c6586af32 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -193,7 +193,9 @@ int xopen(const char *path, int oflag, ...)
>>                 if (errno =3D=3D EINTR)
>>                         continue;
>>
>> -               if ((oflag & O_RDWR) =3D=3D O_RDWR)
>> +               if ((oflag & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EX=
CL))
>> +                       die_errno(_("unable to create '%s'"), path);
>
> probably over conservative, but && errno =3D=3D EEXIST?

No matter what error we got, if O_CREAT and O_EXCL were both given then
we tried to create a file, so this message applies.

>
>> +               else if ((oflag & O_RDWR) =3D=3D O_RDWR)
>>                         die_errno(_("could not open '%s' for reading an=
d writing"), path);
>>                 else if ((oflag & O_WRONLY) =3D=3D O_WRONLY)
>>                         die_errno(_("could not open '%s' for writing"),=
 path);
>
> Since you are already changing this code, why not take the opportunity
> to refactor it
> and remove the " =3D=3D FLAG" part of these conditionals which is
> otherwise redundant?

The repetition is unsightly, but it's a different issue that should be
addressed separately.  Simply removing the comparison feels iffy,
though.  POSIX doesn't seem to forbid e.g. O_RDONLY to be 1, O_WRONLY
to be 2 and O_RDWR to be 3, and then you need to check all masked bits.
I can't think of simpler alternative to the comparison.

> Either way "Reviewed-by", and indeed a nice cleanup.

Thank you!

Ren=C3=A9
