Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B60C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 22:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjCXW0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 18:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjCXW0n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 18:26:43 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA2F15148
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 15:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1679696793; i=l.s.r@web.de;
        bh=wxO5gr69MgKa+hR/j3AFlMvIb1aJjZP/muBs+vFyQyk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XGOM3+rnf/neChL5x6TlCtFMSUP7Xsb2aQiqsplDIUrlAHYNuolXh2EgkBYFavGyb
         nb64cqyqJz6xaTyNMJsx8JPtnKZwTqLK3fkE+4G5Lq0ZC5Z8zRaYjTWJAk7vZJqqEs
         fsqjP36DB8Wct9UWeyQPPO8Du/EmMb6TA35DtR0pb7jZ8jOGJwXwQdEHMGS5CrEDlF
         U8TdXbTzcHO1OfpM2fHbyW9OkSRF5HXCUs61iV+AEHUBefFAuF50k9TN/sdmQPLQmz
         jvK5WV40AhkA1DJ2dmIewxFaFIeYW15LzdVJoiyFOKgZQiHjxqBdtT7Kl79oS0Wjsu
         c3qDxrHOS4f9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.31.43]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MidHZ-1q9Pig2ijH-00fjH7; Fri, 24
 Mar 2023 23:26:33 +0100
Message-ID: <2be99e1f-bff6-cd24-dbe8-8948e2d630c7@web.de>
Date:   Fri, 24 Mar 2023 23:26:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] archive: improve support for running in a subdirectory
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Cristian Le <cristian.le@mpsd.mpg.de>,
        =?UTF-8?Q?Matthias_G=c3=b6rgens?= <matthias.goergens@gmail.com>
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
 <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
 <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
 <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de> <xmqqcz5lbxiq.fsf@gitster.g>
 <d16c6a22-05d8-182c-97b4-53263d22eaa6@web.de> <xmqqo7p59049.fsf@gitster.g>
 <3da35216-ca42-9759-d4f9-20451a44c231@web.de> <xmqq4jqx8q6q.fsf@gitster.g>
 <f7949f1b-4bad-e1bf-4754-f8b79e3ce279@web.de> <xmqqjzzly84q.fsf@gitster.g>
 <9e215e5c-0b67-0362-fd53-8c22b8d348ff@web.de>
 <e923e844-6891-76dc-e7db-4771b2d91792@web.de> <xmqqlejpg17g.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqlejpg17g.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:igUAgrUZSrJCGIYnbYrKpCX4aAbUsgNm+D4XS/9QRmi2Qgbwzil
 6SNMzmOMQvPLlzt9VkteZh3C03myYjf4D6fyRw5YtdxxJHrBPpAgGx+Wv91EC+cpt8yJRcl
 POW6BNqYfeqkY/JKEMVBEW4/GJYPuFNSchOVJeZJM/ZzkKHgcvHzPJE3iROQ+klYAnVXpmP
 RSBJKl3OTSQGVLYKlJagQ==
UI-OutboundReport: notjunk:1;M01:P0:jGTExquKdkE=;5gW7bGtHL77eq/tuq7sjz4Dg6vI
 6+gIVfJMRamLtm8t28vb3siMBeF9zJs9L7vOOg6mPYR+29l9i3B3TgCi3cuUKAvs+d3k8m1r5
 2BA7j2SRuq8rBGyj7SixQT2PBEABJumPRN3z2C22PkXFPeaaTlXMWndG4Q0zqYJH2pvoB6ny/
 Z8PCc6GAAA8qET8lLI/wWW7PitbFr82vG6idW9uqz1bxJKW4I80SHILRf0d5OO0ttfKU3+XVQ
 mU0Y1HgIHX33taxWvUTke76oyWUse7TcfympviJmd3VYHhQoAZwFVqkfP8sLCvkg1+BdrVua3
 ExABXs7fDBdtvvJE8BVgN4LpKrC0stMei/RVOk0WldBH7xUI4nsG7JIodnzAzZ3cUO1hn8fWq
 MjltljFDVN8UUO//OxbvxRrko9Jl1eZSoctfPRT4o6goSjaeO8lvWnI4+JG7YI8VU9j6uJfAK
 WhRnv+KgZ2Hr41aEVwrke0rJ9WcmXP4mUOq6Zac34fgfTYuBWrtWF5UjHfvxEN/+/CyDEBi/D
 UEUHDasS/NGarbXaqnAwrnTyPt09yyGsajpCIf/UHwpQu7spiVidILdwYBuR3ES/jEAnkhULn
 TS9CQ5+3rQOXTYT3o0VjEtahydK9Qzdvn/JaemkImyATSHxupr31uM49R+R6T0BVF1D7SWnwJ
 efg1/+GyLajcOHPGqj01EUQTPr6jEj1VH1j/9yHbxwz/esbLndHyZ3VKyRUNLf6Ds3HlOUYbb
 N8aJoSLXcdt09PbvpY84U1OWFuRD/aDmFv6/tF7bfUl52GTyXoAL3KG71Rf4fZX8ziA+dRJag
 Tvwatar433Ps2yBYANT4/brVIiprm/zS1Q1UtWGcgXwNcNQsMgSI4YhITeeUrF1zup/ElRXcl
 6ZhFhZvkAGMsseUyHYmXzkyLq+erm7mZof8FDN+lvCV4Oml1c3cCmmvRpUzQsYOHulHCeh6mw
 /wN46WK/vjQHKw38KuY53Yg3UNo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.03.23 um 23:59 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>  archive.c               | 71 +++++++++++++++++++++++++++++------------
>>  t/t5000-tar-tree.sh     | 13 ++++++++
>>  t/t5001-archive-attr.sh | 16 ++++++++++
>>  3 files changed, 79 insertions(+), 21 deletions(-)
>
> There are a handful of CI failures that can be seen at
>
>   https://github.com/git/git/actions/runs/4482588035/jobs/7880821225#ste=
p:6:1803
>   https://github.com/git/git/actions/runs/4482588035/jobs/7880821849#ste=
p:4:1811
>
> which is with this topic in 'seen'.  Exactly the same 'seen' without
> this topic seems to pass
>
>   https://github.com/git/git/actions/runs/4484290871

Uh, nasty.  The linux-asan run reveals a use of the return value of
relative_path() after manipulating the underlying buffer.  I hope
fixing that helps linux-musl as well.

Ren=C3=A9


