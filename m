Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BEBC63777
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 20:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF5C20DD4
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 20:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ivjBAv6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391465AbgKZUFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 15:05:16 -0500
Received: from mout.web.de ([212.227.15.3]:36537 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgKZUFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 15:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1606421103;
        bh=lCOi5DPbvbeZJE/HON5RJzKIHvqDV4qXdLg6dhu01/c=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ivjBAv6c7Dl2bidTp8tS9N7VayopIz77tQGQGd2Ca3IHVuCMx1ivm3SUW8VJX5MkA
         kW3K9aNjHvbP5zIXjorNUpXvmWtZ88wv6XFstz6QkaclzqmLv6kD1rwdp+wQ7llE8I
         Bjr6I6ES0ZFQc49UqXg/k8wj1XRq7DyTX6aviGqQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MmQcf-1kIQc22NUH-00iRVf; Thu, 26
 Nov 2020 21:05:03 +0100
Subject: Re: Bug report: orphaned pack-objects after killing upload-pack on [
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>, git@vger.kernel.org
References: <CAFWsj_UwkQX9y0xPQJE3xguo0z3TMkvKAwei5iryCWXvVP8CjA@mail.gmail.com>
 <badf3777-3970-b714-3ad9-67d2f77f94a5@web.de>
 <20201121002921.GC353076@coredump.intra.peff.net>
 <xmqqd006s7ee.fsf@gitster.c.googlers.com>
 <X7zOKbzR9gwJHMbJ@coredump.intra.peff.net>
 <xmqqy2ipcdvj.fsf@gitster.c.googlers.com>
 <X778eIAr3uzdh0H0@coredump.intra.peff.net>
 <xmqqo8jllyhc.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bd2c4577-4c8c-851c-6045-ba4b306ca612@web.de>
Date:   Thu, 26 Nov 2020 21:04:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqo8jllyhc.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dzIhv1h+5J1tfDcg2w/WgkuUe23x9CZFlcZnUVj9oUGjDW4tOBN
 XGI5NMkr7o29Oa6lcceOKWM9CBkF0tiUd7qMRqZPhcgvIVNuxmSzPOHGyCegqzgA/kzzYVq
 k4t7rbkrvHMJp6ZiEOgkhLdnYHfQbe23YYvfIGOOy29b9Hp95SgETjkrq3O5mzRXeADij53
 9bI8GysUuPOx60O/bHLqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DhHm7cM198w=:b+XXt5Qv0t5BHdHGSak28u
 /off3pE2acCgDOwjjc2oabLbrL7VUWPJw6xS+N83ithb0ZMMfGsV713MChaUOF2nvPSqHfMlz
 UWZAMAPMXsQWb/6EUmLiKxBMBjX4rVOiNOJDD1NjuyitLfLRZoUQR50ILtZVgT7cmlaKDbldr
 sMIDjFrDkndXP5OrIrEcNLHmM52CuTRopNLwdCiKW1KbqPQReVj7fjynmW5SIWhn9ITbpfUPD
 4LcdEE9+n4qoTlERawOTIdnAd5vZSfXWOMw6bDdDwpGM8x3WLb2UT4H9XiZ4gNi/1QwqWxpeY
 xU6m0Pim3liwVQhQ042DtHp2qosS8B3W5c4fqeyq/ABluln7NQ2gqRAR6ygXIubooBN4RkoCm
 YoDV5VF5eWkpwzavKlJInmarrJIIF2/wn17Djs3c3Y+MMjWF72NWUIvfVRkriFQGany/vj67/
 Wm+qirIWW0FCBLX5G5MX0xJGh4zSOWwbS2CaqDmVBZKIbyfLX66q2tl0jgWq5md2Ql2deP1Ay
 TjuDGAgdgY4z2nesZ2WUENZZMJ3i9cdxG5cs8w/0OrVRlQwDqEJI5qgIEJbhCYLCydwmr+8IL
 4DKxPOZ79PDsuvcVL70X5vQpKbFjeg1gNU2AK66SreL0RU6PwcMjK/3eSkwbVppcgHH0vmhJa
 gffB5XPrRTsZCRvJN3bBUV1DNcToIwFybzCu9s6eR5+hsiI0vj6x32vtkXhbTFvJeIiG14efl
 eG/iUfmyl2wIBcM7iFh+9AiHQrU1mbFojym+YRE1gVMGYEBghCv+bbko5w3uOKHhvif7IMh8W
 hynytk9fPA3+Kaja3wtHn7dbmAUaaulsvGNVMf7JdxJ+y6NfE8dNAQokAnoLzMm00ZVQ8Qhni
 rngvMwxUNGBdZG0pAq1Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.11.20 um 02:04 schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
>
>> On Wed, Nov 25, 2020 at 01:42:24PM -0800, Junio C Hamano wrote:
>>
>>> In the meantime, I may queue this on 'seen' but it cannot move
>>> forward without a signoff.
>>>  ...
>>   We spawn an external pack-objects process to actually send objects to
>>   the remote side. If we are killed by a signal during this process,
>>   then pack-objects may continue to run. As soon as it starts producing
>>   output for the pack, it will see a failure writing to upload-pack and
>>   exit itself. But before then, it may do significant work traversing
>>   the object graph, compressing deltas, etc, which will all be
>>   pointless. So let's make sure to kill as soon as we know that the
>>   caller will not read the result.
>
> Thanks, that reads well.
>

The patch is trivial, you don't need my sign-off.  You could record Peff
as its author, as he contributed the most to the version in seen.

Before I could submit that one (or something similar) formally, I'd need
to understand what's happening here a lot better and witness the effect
of the patch.

I understand that the main benefit of stopping the child upon
termination of the parent is to avoid using CPU cycles on a heavy task
whose results will just go to waste.  But wouldn't the orphaned child
then become a zombie?  Init would reap it eventually, but are there
perhaps init-less deployments (containerized daemon?) where such
zombies could pile up?

For a test, winning the race condition should be easy if we cheat by
letting the child loop forever.  But I struggle even with the most
basic task: Making upload-pack invoked by clone call pack-objects.
(Feeling a bit silly.)

Ren=C3=A9
