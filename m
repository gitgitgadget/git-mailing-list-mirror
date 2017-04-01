Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DA9C1FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 05:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750841AbdDAFRH (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 01:17:07 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:44937 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750796AbdDAFRH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Apr 2017 01:17:07 -0400
X-AuditID: 12074413-f4fff700000077e1-d5-58df37cdc31e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B4.CF.30689.DC73FD85; Sat,  1 Apr 2017 01:17:03 -0400 (EDT)
Received: from [192.168.69.190] (p57906954.dip0.t-ipconnect.de [87.144.105.84])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v315GuZj024759
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 1 Apr 2017 01:16:59 -0400
Subject: Re: [PATCH v2 00/20] Separate `ref_cache` into a separate module
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
 <xmqq1std1lmb.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <13eaacf0-5923-ad33-79ed-2cec47660904@alum.mit.edu>
Date:   Sat, 1 Apr 2017 07:16:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq1std1lmb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42IRYndR1D1vfj/C4NQNG4u1z+4wWXRd6Way
        aOi9wmyx5OFrZovuKW8ZLX609DBbbN7czuLA7rFz1l12jwWbSj262o+weTzr3cPocfGSssfn
        TXIBbFFcNimpOZllqUX6dglcGd8e/2MtWMlTsbC1lb2B8TlnFyMHh4SAicT/fWFdjFwcQgI7
        mCQau3+wQTjnmCRetO8Acjg5hAU8JRYvn80KYosIqElMbDvEAmILCWRIHD28jAmkgVlgG5PE
        pBePwIrYBHQlFvU0M4HYvAL2Ev9efQEbxCKgIvF+USsziC0qECIxZ+EDRogaQYmTM58ADWXn
        4BSwlvgvAxJlFtCT2HH9FyuELS+x/e0c5gmM/LOQNMxCUjYLSdkCRuZVjHKJOaW5urmJmTnF
        qcm6xcmJeXmpRbrmermZJXqpKaWbGCEhLryDcddJuUOMAhyMSjy8J7zvRQixJpYVV+YeYpTk
        YFIS5f1eDBTiS8pPqcxILM6ILyrNSS0+xCjBwawkwpv4BSjHm5JYWZValA+TkuZgURLnVVui
        7ickkJ5YkpqdmlqQWgSTleHgUJLgdTa7HyEkWJSanlqRlplTgpBm4uAEGc4DNJwVpIa3uCAx
        tzgzHSJ/ilFRSpxXASQhAJLIKM2D64WloFeM4kCvCPNGglTxANMXXPcroMFMQIMtvt4FGVyS
        iJCSamBszUjczc6Rbacf7Li5/ULtk8uulu+vudy5c2zy56MLGGcx+u4qvzlTzneW6tLaxCsb
        1nz91eNVrtNWn/O07tl3Z8Yay/2FgTzsMhOYPic4cf95GZ94unpeReQiybIpkY45evy1jBNv
        +mQlcXhXr8ibsPPPL4OZfxL8t38OUxPd9FmTY/U29nIlluKMREMt5qLiRADaqJUVHAMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/31/2017 06:01 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This version literally only contains a few commit message changes and
>> one minor comment changes relative to v1. The code is identical. I
>> wasn't sure whether it is even worth sending this patch series to the
>> ML again; Junio, if you'd prefer I just send a link to a published
>> branch in such cases, please let me know.
> 
> The review on the list is not about letting me pick it up, but is
> about giving reviewing contributors a chance to comment.  I think
> for a series this important ;-) it is good that you are giving it
> multiple exposures so that people who were offline the last time can
> have a chance to look at it, even if the update is minimum.
> 
>> This patch series is also available from my GitHub fork [2] as branch
>> "separate-ref-cache". These patches depend on Duy's
>> nd/files-backend-git-dir branch.
> 
> I am getting the impression that the files-backend thing as well as
> this topic are ready for 'next'.  Please stop me if I missed something
> in these topics (especially the other one) that needs updating
> before that happens.

I don't know of any remaining problems with these two patch series
(aside from a couple of cosmetic problems that I just pointed out about
v7 of nd/files-backend-git-dir). I'm pretty confident about both of them.

Duy, have you looked over my patch series? Since you've been working in
the area, your feedback would be very welcome, if you have the time for it.

Michael

