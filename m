Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AEA31F453
	for <e@80x24.org>; Sat, 19 Jan 2019 17:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfASRGD (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 12:06:03 -0500
Received: from mout.web.de ([212.227.15.14]:60141 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfASRGD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 12:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1547917561;
        bh=0rznoVKft3qlaBcgn+yhimH0kgAAB5JnIkHYnCLqDqU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PPT5+M6T28/j3C9N1+JBvVnNkhUe7TyYirs8JUtQJje2kHrjqqyW0Z5iqrqC0kr6N
         4AtoxVTvQ//TsL/mhp3VybTopCpt0xxSy91g83Wk5kdHN5nGOCvQymYWFHb2KIs8yV
         hXCYllcdbVfFgZ3G0HX5ENd3YcJ0o3vyy4FxxveM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.88.149] ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MNg5K-1gqvfn0a6M-007BvP; Sat, 19
 Jan 2019 18:06:01 +0100
Subject: Re: [PATCH v2 1/1] Use size_t instead of 'unsigned long' for data in
 memory
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        git@vger.kernel.org
References: <20181117151139.22994-1-tboegi@web.de>
 <20181120050456.16715-1-tboegi@web.de>
 <5b9d020c-00cb-9340-b21f-f16f7fceb8cf@virtuell-zuhause.de>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <b28d6db2-c2a7-67fe-ce56-12598efcca7c@web.de>
Date:   Sat, 19 Jan 2019 18:06:05 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5b9d020c-00cb-9340-b21f-f16f7fceb8cf@virtuell-zuhause.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BpvA0CKUWZnAAi3ILtxh+MXLOxpZkK6Kl4RHR3gXMz92BXtcXMZ
 GoZtHAL9N/sd4TySBnBt1PFzsCXeWf9feqkpP0TRdwmm5UhrgoK70kDHfbD9+ctMKJFpMG9
 /OWg7YoiIQYZ/V4A7znmuNtGukKvf7G7dPIIQqZkhiDFqRUaifblkchKOeaqDVnaztNOrap
 Za5TOwWfxOrKHzxja3V1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AlxuoWG8Tgo=:c9SybYGSsWpig+vm2k5PVa
 +XGvp4mOg9/Pe7yVd0STZQmSI/+wGLZW/k26wNekfv56DpGCJhST7ZzsQfIzB/RsUG80F/2F+
 7+20RexKEWV1iE2qfB1Y3YrRRQP59eS05zKmfbjxk8fghId3kFWrDh32l2q0HqOBKbGuBjqul
 rbeal5+ZgdN8abpRmOwXIMkxbDdgIH4LoOucCGEJREx9l0x7mobit6Yewnlmbntrk+2Rtl9Zy
 TbWiTUtuKTrhDjAoX3Qtjs5Chp/qAEazpuPQtK5RrAio5Ltb0wJjCEsZJejpMR2usSN/3lHhK
 v0jWDSm3alBVBUW0IgjaYbXcdadytK2/GwvwnsRrWCwwXvjWw0G3GlJRCWTexwEp6BqvhUTpI
 M8940xb4W/z59AUnnjG1/evfYIQcWSBBLJ69lZUndeRvab4HnGB2e8wdz3ae4hB3YTl4k2vHE
 fgJTotpMzxo/BUUP0zdPuuAbKoKAkKyreIiVm2qFIOadMhtOYrSIWHSMD92XJksGbhkdRasAv
 TPQCa90NVtIoBbWjbKB4TvCwmSiUCI83nIdgXR4EN/Z3vimUab2lmicieXwoDYfhOFfdRo2WW
 rZxi69ogy+SE72aGH/ZE0mbZ2p6yG8HTnDEHjq0bBOS1D0q2y9QiAJIF2D37TStd04arT0AG2
 YfPq1LgmHl3nZuSrRTNDFxaxL5VUQk+p/tYjTaX7MzcQq5gYRaCO/NFQetFyyO1GAbSTdK1jY
 aQDnTx1dXyW2VOxcQRopBUTu6ccqjzA6JdotLhBPCDL0FxlTcsKdiZ7Zs643x6Ll1bk9Hkjqy
 Nke88UzQq5ebM56dajsuoSMmE+A0zUh5ufnIcKOu5j0c4esYFqZ5ugXD3eKg8WrqZU5FpcdhV
 GRWzWUJ6McDwRL9M8s8jZhTEEs/A+5aUkeeJoHk+3GeZwkL3QwR/A4jRBY+q58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16.01.19 22:46, Thomas Braun wrote:
> Am 20.11.2018 um 06:04 schrieb tboegi@web.de:
>
> I'm interested in helping getting this forward!
>
>> What we really need for this patch to fly are this branches:
>> mk/use-size-t-in-zlib
>
> In pu.

Junio, is that branch ready for master ?

>
>> tb/print-size-t-with-uintmax-format
>
> in master.
>
>> And then it is rebased on top of all cooking stuff, too many branches
>> to be mentioned here.
>>
>> It may be usefull to examine all "unsigned long" which are left after
>> this patch and turn them into (what ? unsigned int? size_t? uint32_t ?)=
.
>> And once they are settled, re-do this patch with help of a coccinelle s=
cript.
>> I don't know.
>> I probably will rebase it until Junio says stop or someone else comes w=
ith
>> a better solution.
>
> I could not spot this series in the cooking list so what is good way
> forward?
>

That patch never made it anywhere (yet)
The last update on master, which I did so far, is here:
<https://github.com/tboegi/git/pull/new/tb.190104_0635_convert_size_t_only=
_git_master_181124_mk_size_t>

Do you want to continue ?


