Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EBDFA3740
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 11:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJ3L6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 07:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJ3L6W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 07:58:22 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687EBBF7D
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 04:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667131093; bh=WGKRpNw2WvaTn4KNGSiujrJYoJK2/0GvD+Q1cn8a7MA=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=dD+KXnxrkvbRbHy+fF0yWNVJE8mci8vW5jDwuu9C0PC3WE9lDpFYX3bWXJ1SlxjSn
         ZdDH3jtp3bOEfu1WTGJ5PLHY3ScTMFnB4kUpa6m9EZajTP4KEfoyY/sVEaTOiwTBOy
         MCCNdm71jw7QbBopvHJdi4p3IQYS6gj8oSUNck1bIy4TjPK937MiwuEPCkRLIuTWC3
         Dp29L8Q/3zcRBkr7bjh8hMZ9sXZYMcgcy2vqZIKDNWQdQCgHNRHoiaV1mCad9edBpP
         q0W9eT6+PWMxVDPgZUbIiM5vQTMTMzhVupMTazu8YubsTPLIQiwZoiTyY2HhVN9kNB
         /tdMq/+qBhcFQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWQud-1oZMII2OLL-00XvsJ; Sun, 30
 Oct 2022 12:58:13 +0100
Message-ID: <c14503ea-0b76-464a-02d5-0b001a462083@web.de>
Date:   Sun, 30 Oct 2022 12:58:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v2 0/12] run-command: remove run_command_v_*()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
In-Reply-To: <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oT6o06FiQ2TuCwUx910KLG23j0wwB/Pz6o+7itLoKpfIalWzdSs
 FD/uaKgkc15gfnk8BP6dfxr5ZGJNNQg5oxTXA6vwX6tb9GMrZc5AQ+B5DyDgGMxDOXFI0vk
 Ckb9LCQ73sYyjzdxepBsAe4QzOf5Y+VSGOH5pLfgr1qa0Owktei9E+YKmzdwokczOJSePUy
 F+NCApozQ9ArqilEyeACA==
UI-OutboundReport: notjunk:1;M01:P0:fEqPYsaenWk=;C4Wy2+OCPlXQrBQe5/ONLw2MjGp
 CGzSc5Ymzfe9WYHX1Tmu29ELxEBDw1LXlMwsf7xi4VW3JfDLXf6rXKw11pJyh3vKYRK08HdW/
 GTrmteIvTcVnFEeVzx3gw9YV9tt/QTEu9ccJmKn0mUHNxLpX/RfaKXJGgjmMS/9WSEDIvO20e
 fyHl6sbGKaZcqSL/WaccE5dnwaxmdt/Al/JhWTPniLizDeLcON2YdL9qELe+p4w0BOEO737GM
 HrUx/TjxzrlBbq21iMBmzwOlmvTNRylrqdpVTCoaCc4JicQg91IpvJWzZlB05PyMeZ+0EaJnt
 IunjKgj7JjuuGDJO18VhWMUKMUuf8NdpVwxSNdkG/facqsRYswvLwar2d2XTjzJYOiZJJcapP
 nzXYkewEObQ0Kv4HXuxbjHHZM0vLCoAY29fEe40CsqQbkpv1fIZ9BQJ+lm4OaH5t30GDLk/Oj
 5wi/hxHd82BvFsZJG3sJrAGYhf7u9zhE32rfDY+N7z6+IdIgzSjZv+NC+zY+GsB96eSBMbwvb
 Rqo/HYuKI4y5eRNCwt1cK1l22XvYFKf9356rNo8u+fjTSDlBmtyuvmu7vDTQOTe3irq+Q5akL
 hoobadJ9OysQYh+tWgngUlWIMCyjASAUPS29qk0baymwiF907HuC2ejNIw8mMw6oNTht2W7R2
 MwY+8AKdN/RnqVclEy6kj9gw/3fuMz4pfFNGzzE34N6UwpM8aMdCEmu0ZRd3wRkOEE6jl3Yqa
 jQCk0mwEAGmI7xkOg2ak9EqL3iwS16ksAiNT5+aKSBnIOx1Vf2OKyCQ4qICe/suEPaCPwaFAf
 GdOnZT/o1eBRStoYse5OjvZR/GeSI8hkM0KW/BzfjCZVMGxi3A8poTRXWyGRQXFQThyug0I8x
 lL+hgWcO++qSVX7NiqcDC8uriHWvlBC7aurlZoEL9vrj9CLyFFmI6usMo8WE9qoNRs6QP8DfU
 ivS7LdGUO2/XGg6fRhAqtktQ4nQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.10.22 um 12:40 schrieb Ren=C3=A9 Scharfe:
> Replace the convenience functions run_command_v_opt() et. al. and use
> struct child_process and run_command() directly instead, for an overall
> code reduction and a simpler and more flexible API that allows creating
> argument lists without magic numbers and reduced risk of memory leaks.
>
> Changes since v1:
> - Do the return value fix earlier; it was only an afterthought before.
>   Keep the colon (no "while at it, ...").
> - Break out the xstrdup(), oid_to_hex_r() and C99 cleanups.
> - Convert tricky string arrays before strvecs because =C3=86var didn't l=
ike
>   the opposite order.
> - Extend the example code in tmp-objdir.h so it still only requires
>   "cmd".

Forgot one:
- Fix grammar error in run-command.h added by the series in a comment
  that goes away at the end.

Ren=C3=A9
