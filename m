Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F2FEB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 12:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjGUMlu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 08:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjGUMls (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 08:41:48 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A5B30C4
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 05:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689943300; x=1690548100; i=l.s.r@web.de;
 bh=GbvShqgXgTJ4I5qM8rN2hEak29+d7LnIUClEXjwL3BY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=GfpagcnhoLU/n/ELGTrnPSjFNrenPUMF4tIBed2jVLYu5Va0OxEQVsbJ8GxUVWU3zr4cYos
 ceVHVRX8U42b5V3JgAK4Kw80TVpKJWY0bwVtJ607MVnGgVzt+o/X2VkZKabWw6R7R6Up/teFj
 0ITOqtYpORebQNAVkOLGpdZoa6UPy1zqgCJ8w90yipF7AmNv6neo6MrhAE820e85osMPYW9+B
 NBfERbzYIvysAb32zx3odvD8/n0/YPKsr6h+2hI0BQik4f0lnHlt5saT8rB+WsjDLWhdvy+GA
 RB4EkQoDZd9d0UCKfz6meKyz58L+RMeW/6WdaaVPM/TDLHm1KnoQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmhnu-1pfU1d3ZXq-00kANb; Fri, 21
 Jul 2023 14:41:39 +0200
Message-ID: <ab1b29da-20ab-7139-dcb5-5b8858d31dee@web.de>
Date:   Fri, 21 Jul 2023 14:41:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] ls-tree: fix --no-full-name
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <xmqq4jm1gd2h.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq4jm1gd2h.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PwWqnrKJ0kPR50Ciz4rouNiAQwpRIliVI6FG4LZjgqEQL/gAnvQ
 UswoSa9v0L7WGDML8EcZoSKUBIURwfJ6Ea1bZY+gtyT4xx2HNBaTpG2PYTSrOkh8luCMe2H
 kt0xE0697QluFlfDGlfypPoGShKAWFOlVzy14TcFm3jHwkstqjkxGnQSgAP41/5KIC57WRU
 rQpoCbHb+OQIP6ciUkAAw==
UI-OutboundReport: notjunk:1;M01:P0:vG/UcpnEUdc=;HnKYuv3tmVtZvr4n0/9KPpOERIr
 LVLbRvzk/CWhE6bdgVrQReppIrQ9yUE/X0BfbY/mOhnGDsaDhsk2dOmhgQGA/GaRnPCnWuHy3
 cwTZA9ACoMp6yigJROEUX1nVwd3LIMMPeldSqprwYKZEDG/eX1zBuIGwCsrz8LFV1eyBjxU0Y
 LA7WaiX5LE+XPb5Uic3p8X3RpieX+E9wAOtUHjsd+gq62h098gDFWHNjd/dcu4kLDes9Sfkub
 L+JcxRJ57o1Iy9iFBY9WfRpfijsxHvqfqMvaWcQyjAuqlOgzG9M3opvYjggKTHCMhqbNlwDEG
 ddw23Njv0FJR5NE7Ztq/Ry0BCrcJAPGHdYxAACZopqW80YjEOSOvuo7/Ci6Uf8ZhWYHqY/08Y
 ePQ7wPiQVI2Jc6LUFferG+6pmF2mAgFnTkr/fTuzXYT01mM1Hn436Yx0OCe0wjRSfaEW8sgC+
 B7Zdv53SJ3lTshj5xBwfsFUSur0ZIWyuXFrZiSATw0hJu7HNDHFJuYC3VPJnURdkhl3U1JqEX
 PpKjBbMUWvQ9/STMMirwuQfzTczlnkCI3j4SCOIFVajb2JXi0U3lzM2heMypIYS7fB9Ku7QKg
 OKuJ9OZgmGm2gxlvLB9wPloemsiB8AImyrSjyqe5GuL5Rp+IQ/2rLqM1wSuf9jb6AZCTGcOtF
 qZy57CIMQTE78kfgZaKwIHh3HWKYb3eJxbrcUuvgo+YNwT/lItFwSYFidQZJfkIt+T5q5eeMb
 ffvxVv7P1i+luYIJw7X7m4vHmz6xJDecmrqWT166QjkWTNSxah1Ls5No3S24PMCpZ9ezpaFio
 Gri3YQs12zNwryjSiGZ5gY1iR7FUQAm9qX4xldzwce9ouBBnQ+VIPpiJsHGdZMBNF+eDTUMRn
 8URaDMduxi0ZErF74oJ3kUpnFq7nBgvcaPHXUG2EkRl2jIrI9+HELRFGxJhbekfNYHKeakOC7
 n7Eo1uY9QxEhKGrokiq7wVDtZG4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.07.23 um 22:49 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>  * "git commit --[no-](short|long|porcelain)" are accepted and
>>    behave as "git status" without doing any "git commit" thing,
>>    which should be corrected, I think.
>
> It turns out that this was very much deliberate that these options
> imply "--dry-run", implemented in 7c9f7038 (commit: support
> alternate status formats, 2009-09-05).
>
> So there is nothing to fix here.

The negated variants don't imply --dry-run and do actually commit
something.  Which kinda makes sense.

Ren=C3=A9
