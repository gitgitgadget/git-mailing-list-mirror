Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48977C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 18:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiGAS6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 14:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiGAS6a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 14:58:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2324A183A2
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656701906;
        bh=6aPd0l8GDg8R+fDy53tDS185eLzmrYbBTYryou1Wogs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=e0A8DTAgy3g/8POksrRA0VC6IdIKNhIxORUSEF5hz0u/tf46k7lPDtwBwcYBLAz9A
         O2aHwtshdtmFC57X0qJdMGOjHgwR5EBQVRP8mb12loJN9wVc8D6qJUfgAfYIPFQYRn
         wVcY9+U8YofyZnzWfUPN4LBnG2b05UTt8WqAFQc0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.20] ([149.233.230.9]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNct-1nPnDy3jvr-00hrbe; Fri, 01
 Jul 2022 20:58:25 +0200
Message-ID: <647f50a7-4350-fe04-fb84-b79417d98455@gmx.de>
Date:   Fri, 1 Jul 2022 20:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: undefined behavior in builtin/am.c
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <130c3636-b978-1600-df53-6a38c3414a88@gmx.de>
 <Yr80s8VP8ECCXKd+@coredump.intra.peff.net>
From:   Roland Illig <roland.illig@gmx.de>
In-Reply-To: <Yr80s8VP8ECCXKd+@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CT7Q1bFVE7dN0xYw0db7zYYmyQz7lUOMXxrzNSmzXKPjteKCAXt
 zoOCdoZJSzuWo6i94tR7HFTH7WJirGGaFGFuy4Fismvh/c1lcvLG6mgabuEgJ+3V8CapCyK
 VvIk9FrGZKl6cU/pyZW4Jb1lPLDu0ECMzHIZuO2/qTQZf3//FgwhI+vmlztjpwK7b9j4Kev
 Y/JTtj5VpJLBG25afJSWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Xqa77PT5PI=:MITL+Q2wtqGtuomYSTPO16
 xMVBqFyXzhqrPl4GFeZpBKYVytqwjBC7xxQAHY8JtPwsfeK/0xxCa3ZmoWKcNRF/So6wOxOry
 2Fh++bRnJNgeCv/qmxt5OiRobmwReMnT5VVMWG/QDrPTFh6rVrTdtpNU20/mDubMLNnnlX7sz
 pHPjNenFjNaduUBns5MUjB+Vu1Rb9AHax+61xbfdkrnB0xhq1/77uxmRL+T+/ji69pnCsnUHi
 2RWZpTt4tLiCPE8RTeLEUizPWtiDpDuAdYLTZFfXMQtbyypQqJ9+d9XG5Rv/kFk6EoO8rAktI
 g2LapEO8jE62AjVLcq17IQFfuAUdJNA4zTdmfc34ihEuhHgwhW6UPx28G3GCrnPRZmuyWWYtw
 xcXpo55cwHExz8aN6pgbRj6d4+UuRGDJVF41LvEoSNM+YSbBJJReHKL4gD6/3ed7elHk8ZU3z
 S1eZm99I4dYWav8kdcXoIc5lsdXfRL9TelXbeg0S9YLXUJ5yjb5/0o75plwjqIffkHZZPVP3u
 kXiyQrHjczq80dnRKg4cmkhUAA51xEjvojOm67+l0FcxoVo08FACQVzclBk7dn+mLYkzgHk3w
 ekRYEV9vBMAzSPTUBVLUfPp4TwWFtBjWAiD+ZZ4nKi2DdoovUknVqi1znCBGKAZFiM03AOT3y
 gj+S7ppsTKPT53+/5yeUaq4/E2POvYTCAYfO3Gsdv0UKipmwIegrq1ER/u052zoh4RETQUZfS
 sARZV64mAAQpt5K7InJabBR16EO8tq4ITcL1On4T0zFgJ2rcJfPS6lewYwCZqeVYuPIOI+30O
 J6FHk2WrZd7JQZbNx7VMGRjcUue4sASlXj2OnOq8kMrastW1FHjD8g3AB8pbFRXTQ2omBFjL4
 ZqQ4XLHHK7O6NKjUapNaUhH8mzdH0EMmtm5ruJYuZab4NfoHF82mksrRWBLFOGyi56MKTgQa9
 O8Qs/2frrM/TYKe50mumIMFoR86vH5CnSXqVJbPF2mg1UKAybcmDsbzACDHU7/jutPkSnguOx
 Z2/5m6QrvKUxF41eynpouOiH5zR1gs79wKn7bP6J1Q6VAhm0WU6v3uKJPyq9HI0Wnv6T8YGpA
 DrOZgpCt7b2ClhnAe4gzPHETWxSPGeJ+F69cnccFuHSgrAnwoW/2hRdxg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.07.2022 um 19:53 schrieb Jeff King:
> On Fri, Jul 01, 2022 at 07:03:18PM +0200, Roland Illig wrote:
>
>> The macro 'isspace' must only be called with an integer representable a=
s
>> an 'unsigned char', or with the value of the macro EOF.
>>
>> On platforms where plain 'char' is a signed integer type, any character
>> whose value is negative invokes undefined behavior (except for the one
>> character that by coincidence has the same value as the macro EOF).
>>
>> To fix this, write '!isspace((unsigned char)*str)' instead.
>>
>> I have no idea how to trigger this part of the code but for someone who
>> knows this part of Git, it should be easy. Depending on the platform,
>> this kind of error may be silently ignored or crash the program, as
>> always with undefined behavior.
>
> We don't use the system isspace(), but instead our own macro wrappers in
> git-compat-util.h. They do the cast to unsigned char themselves.

Thanks for the explanation, good to know that there's no problem. :)

Roland
