Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF01B1F461
	for <e@80x24.org>; Tue, 14 May 2019 11:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfENLRf (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 07:17:35 -0400
Received: from goliath.siemens.de ([192.35.17.28]:54104 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfENLRf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 07:17:35 -0400
Received: from mail2.siemens.de (mail2.siemens.de [139.25.208.11])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id x4EBHQdw028085
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 13:17:26 +0200
Received: from [147.54.65.49] (MD11GXTC.ad001.siemens.net [147.54.65.49])
        by mail2.siemens.de (8.15.2/8.15.2) with ESMTP id x4EBHQh6006381;
        Tue, 14 May 2019 13:17:26 +0200
Subject: Re: [PATCH] sha1dc: update from upstream
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <3cabed9e-3949-93cc-2c9c-500a9cd9d4cd@siemens.com>
 <20190513221701.1837-1-avarab@gmail.com>
From:   "Osipov, Michael" <michael.osipov@siemens.com>
Message-ID: <09f64da1-b8aa-3cd7-89d7-475b8722e176@siemens.com>
Date:   Tue, 14 May 2019 13:17:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513221701.1837-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Am 2019-05-14 um 00:17 schrieb Ævar Arnfjörð Bjarmason:
> Update sha1dc from the latest version by the upstream
> maintainer[1]. See 07a20f569b ("Makefile: fix unaligned loads in
> sha1dc with UBSan", 2019-03-12) for the last update.
> 
> This fixes an issue where HP-UX IA64 was wrongly detected as a
> Little-endian instead of a Big-endian system, see [2] and [3].
> 
> 1. https://github.com/cr-marcstevens/sha1collisiondetection/commit/855827c583bc30645ba427885caa40c5b81764d2
> 2. https://public-inbox.org/git/603989bd-f86d-c61d-c6f5-fb6748a65ba9@siemens.com/
> 3. https://github.com/cr-marcstevens/sha1collisiondetection/pull/50
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> n Thu, May 09 2019, Osipov, Michael wrote:
> 
>> Hey there,
>>
>> Am 2019-05-09 um 09:32 schrieb Ævar Arnfjörð Bjarmason:
>>>
>>> On Wed, May 08 2019, Osipov, Michael wrote:
>>>
>>>> Hi folks,
>>>
>>> Hi see Documentation/SubmittingPatches for how to submit patches inline
>>> instead of as attachments.
>>
>> Do you want me to resend the configure.ac change as per wiki article?
>> I can also create a PR on GitHub. I am happy with both as long as I
>> don't have to retain the patch for myself only ;-)
> 
> Yeah that patch to git.git should be done separately. I see your PR
> went in upstream, here's a patch to update our code to match.

To avoid misunderstandings, I have factored out the Git patch and 
created a PR: https://github.com/git/git/pull/608

Looks good to me now:
> osipovmi@deblndw024v:~/git
> $ uname -a
> HP-UX deblndw0 B.11.31 U ia64 HP-UX
> osipovmi@deblndw024v:~/git
> $ ./git --version
> git version 2.22.0.rc0.dirty
> osipovmi@deblndw024v:~/git
> $ ldd ./git
> 
> ./git:
>         libz.so =>      /opt/ports/lib/hpux32/libz.so
>         libiconv.so.8 =>        /opt/ports/lib/hpux32/libiconv.so.8
>         libintl.so.9 => /opt/ports/lib/hpux32/libintl.so.9
>         libc.so.1 =>    /usr/lib/hpux32/libc.so.1
>         libc.so.1 =>    /usr/lib/hpux32/libc.so.1
>         libc.so.1 =>    /usr/lib/hpux32/libc.so.1
>         libc.so.1 =>    /usr/lib/hpux32/libc.so.1
>         libdl.so.1 =>   /usr/lib/hpux32/libdl.so.1

Looking forward for a merge.

Regards,

Michael
