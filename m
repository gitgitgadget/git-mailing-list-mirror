Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51521C47088
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 07:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiLCHMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Dec 2022 02:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiLCHMg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2022 02:12:36 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DCA2669
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 23:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1670051547; bh=mle1GoPtpRGxXW1v4F6NjySX+LwzfQvQZI0bKL7V/PU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ctkSFWv1PemntzXjKiezeTU20PijYbH9PAYo2wLyDWEOyzxfFFooXm82p27ZIykt2
         /NKTnOlNni1AAq0DA81qggLknhTBDTpYCczX8HQ7109i3dUAOeofg3Vnz+F455UGp6
         36NXyAoFVduxhPGu9JH7YVDs/9A+3x/yrgM+VqnZ5gp4vV078v9N8EnMoKHf/JAcU3
         M85jYo3QsE97j8yGuFYuCGidjOc5R1s11sZK3qVxytKg1bmFcrqL+r7x9EnZ6J3qhm
         dbthFTw0SyzobgGmxOOfNr3W4xELpfBnTpVdntnfdacPs+8OIF6nE15Brgk8rgy3tz
         +vxja8Q8canPg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq1CC-1oecnp0lKU-00myx0; Sat, 03
 Dec 2022 08:12:27 +0100
Message-ID: <f20815dc-7d0a-552d-4f7e-8ff21f942d31@web.de>
Date:   Sat, 3 Dec 2022 08:12:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 2/1] t3920: support CR-eating grep
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
 <cbe88abc-c1fb-cb50-6057-47ff27f7a12d@web.de>
 <CAPig+cQBsr30Sr6djCN5_982-nrrhduTcMK2PMJLTXHvsdmYAQ@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAPig+cQBsr30Sr6djCN5_982-nrrhduTcMK2PMJLTXHvsdmYAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WUPVQ+07zYFRFIQ+L6O7taH3GOwnzyseruPisXi4gbp7HgdQh6L
 x0jY8LQ568qh84UQgu5Z5srz8ik2ZoQTFug+QxKhCRrw+6B9Fjpent4REnUPEg2dvXKsx0E
 08KuXJZ4rY4sGjGJCRcm9PNLKA9xf16VERlLBxhM9IjMmodCP/p3fBiy4oQ4nxycEY6nVQZ
 cCctpb9Jv/EG4mmTsH+xQ==
UI-OutboundReport: notjunk:1;M01:P0:ixChrE434b0=;sjUWzNNBQlNF3Kay2jAmzfPSGCB
 1VNAAVRc836N2de9u4ToHFcr9sducqZEtoM+sWRyhlZ6yLRJehk7H3vocSAWBOlxUYERd9d0c
 EnfW3hzRJbJJKe/Y/0GlgMhRjtACf9EswctSQzjMsV8O0QnMiahHHEc4NVfpfD1tx1P2ybsp7
 JMQXplsg2h4Mvax1wyT0yd6C5Rx3AO9xdnIcDbZCCwLRUsEF2wh5jdbokNYiqHJRWtrU3eC/W
 VJLDJnd+FAwgH0kmBn+mqGSNskzWP0Np715ehd5MAXjgn4GS4GaYnRhYcSGezQeQ5jvL4Copu
 ps18+50O1k+VFZsUIfljLz6mEQTZTYnqU03s4IBlM1QAmTQBhp+yiyn7ohrrZBFA7Q0lX8Hfb
 mpd3NWqgtaIoq1qaMFitNp77gqXVsRza3LXH34fZRT49xroESo5R0tRdJUPklo0TbOigxIJOd
 7RvHQozuul3jZWkLvesuHTVMw+e2fGQWNLJCXrR6lZ/8BnFdfWRZNA4BP3NLGenLeOiGkZz5S
 c0nbdFWUxV5poI46/XE3ILF1oY8M6ef2XnxR79Hu8Xd1SB2OkZX/8piYp4Dk8QrTG8kHqI5ri
 AxJUNm8PRxq8VK+79BLSTKA4dHcL6AcUhSjicyPump6Mmk6TMGu+K7YkQ8RZziQGwGK/DWuF7
 wrsScN9Tq4cABE2H0KKQ8/rMf2cgZHDpu6bBheNkiWdbsd2r6kjZhnPwl6LfJ6wjLugfslx1A
 B/mIiT3GcIrfN/wYMTgXiqx0n1SLXsDY+AnS6uM4YDPiPNF3Gkacnm3o/QIO9+hQ9k7t88GDw
 cu5zVb5K6Xcul64Sl+AbbEkEwITKWN+1FcbyFb5hGdWGxJEE4djWsQn2sSjCIP4Zu0yDy4dKh
 VMjnDRzhvOQzyvYyvZFMj3JojrDTQ2G/UqOOWyfpJ0ooSyPdVNoFfl9rKgJqn9fZU8199Jwqd
 /sm48Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.12.22 um 00:32 schrieb Eric Sunshine:
> On Fri, Dec 2, 2022 at 11:51 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>> grep(1) converts CRLF line endings to CR on current MinGW:
>
> Did you mean s/to CR/to LF/ ?

Yes.

Ren=C3=A9
