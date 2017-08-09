Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4180208B5
	for <e@80x24.org>; Wed,  9 Aug 2017 14:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752808AbdHIO4J (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 10:56:09 -0400
Received: from mout.web.de ([212.227.17.12]:50117 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751864AbdHIO4J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 10:56:09 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LjJL9-1d4U5V1kvH-00dWJz; Wed, 09
 Aug 2017 16:55:46 +0200
Subject: Re: [PATCH 2/2] hashcmp: use memcmp instead of open-coded loop
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20170809101106.p45y34uk6wcruqxv@sigill.intra.peff.net>
 <20170809101645.7wv4mcsmnejxzhvs@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2b111a78-dea4-85ff-3d8f-94d2eee0ca26@web.de>
Date:   Wed, 9 Aug 2017 16:55:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170809101645.7wv4mcsmnejxzhvs@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:STvN75hxL9q38Z4H6+7I8e/tfdchFxW9vVE7oqk8Fi7HDyaR5Cm
 dM+ndSpJIs3XclYhsR8xEr/yiRIEbq4qH1J/OnzEC+bpkG8HoEJ06r0b+Kea/lr+ZPPYDmW
 DXP8whtjletg1os3hVc/orW9gTC12+h1w8NdwnuYsSDwuQRUwR694UJBgRFLKXvMJxiqIOw
 uytTc3+CiRmpUV4JIYN6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1g4k7pv0fi4=:mx+w1rFp7li7c8PcOV5Y8J
 R3Q3/krvBNT0FVGw8R9Ho3ZYS4QNz25UvM5pjXVedC0BpRPa4qMj0fKYZCYmm5z2Nw7p315Eb
 Xz3Anip1uJ8wkNlIb7eXs+0JzsZptHTSdQ9RaDKnOBCmBIJfXXaH+QHEnXbPmkdNj1aknaRYI
 8WDRb2RdgGJRkisX7SmJXGGlO11JtlncZXY4L5KMnWyMTMtRtwQdladibHdDxyYyvujQe+l0H
 qyFfQk0giitxaFpalWG5FYqiRt99H8tYf20KmF57jpy81mel8BkRlh5XnKVQzWMNTytctvtmf
 1/zSLrttc3SgZAA//k1vrn685L2lKNrwlfsZFQiH0P0HD9FAaFzGS+rYsxOIBTJezYqxD+lKm
 eGjMlG7hLmh25D9xIsF54tFoGPU0uNVN/iHJ4U2/dBjMzaboj8GLGXEbt0MZJQb3F15Acqj4N
 mqzfp/avbqWiMGCy3BU/c8hJN0UgeEoI5Xy1bP1g9NsVTfHGEzyl08vb+JhhnQmBwFpnjHPw+
 XHIj6ZOf8TxeihDkNZtylGvzCpleA186+oMDVfBbukDTVHkcHuvq0quQOyDrq7t894XepFqQW
 fIeITYiqWqRyPIG5Z5DVBUWB7HhSsL21x0mYRMY86K/chg/dJjwgsRjtJ9TqcK79WUrRYELhN
 ngwX1pVWYisZnKAmRrBls8/PvRqfsdlJjoM2YvPZZyPicT94aJU1qnGHFgokrR5YtND512yl0
 A70xKmT02UIZ/0rTdl5B5a/tiZN4jY6REnpxSxgr/5n4VDZT1VtJOb0ss5l15SRrV+DQCR+mj
 1yM/X66cKCnkWAlDu0mcBIbJ2F24TXt+2pxyIPBfV8QcGC4Un0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.08.2017 um 12:16 schrieb Jeff King:
> In 1a812f3a70 (hashcmp(): inline memcmp() by hand to
> optimize, 2011-04-28), it was reported that an open-coded
> loop outperformed memcmp() for comparing sha1s.
> 
> Discussion[1] a few years later in 2013 showed that this
> depends on your libc's version of memcmp(). In particular,
> glibc 2.13 optimized their memcmp around 2011. Here are
> current timings with glibc 2.24 (best-of-five, on
> linux.git):
> 
>    [before this patch, open-coded]
>    $ time git rev-list --objects --all
>    real	0m35.357s
>    user	0m35.016s
>    sys	0m0.340s
> 
>    [after this patch, memcmp]
>    real	0m32.930s
>    user	0m32.630s
>    sys	0m0.300s

Nice.  And here's the size of the git executable in my build:

         unstripped stripped
  before    8048176  2082416
  after     8006064  2037360

> I also wondered if using memcmp() could be a hint to the compiler to use
> an intrinsic or some other trick, especially because the "len" here is a
> constant. But in a toy function compiled with "gcc -S", it looks like we
> do keep the call to memcmp (so the speedup really is glibc, and not some
> compiler magic).

GCC 7 inlines memcmp() if we only need a binary result:

	https://godbolt.org/g/iZ11Ne

René
