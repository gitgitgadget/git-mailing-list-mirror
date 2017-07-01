Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6B3F20209
	for <e@80x24.org>; Sat,  1 Jul 2017 17:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbdGARLo (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 13:11:44 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:48202 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751851AbdGARLo (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 13:11:44 -0400
X-AuditID: 1207440e-8a7ff70000006f9a-41-5957d7cdd0ed
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 8A.58.28570.DC7D7595; Sat,  1 Jul 2017 13:11:42 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61HBcep006384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 13:11:39 -0400
Subject: Re: [PATCH v2 28/29] repack_without_refs(): don't lock or unlock the
 packed refs
To:     Jeff King <peff@peff.net>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
 <38b397dddd210f008e28d9a92218727b08a08735.1498200513.git.mhagger@alum.mit.edu>
 <20170623195600.cvn26gt7o5rtywy6@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <71e58288-483b-3cfb-00db-523a28c78549@alum.mit.edu>
Date:   Sat, 1 Jul 2017 19:11:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170623195600.cvn26gt7o5rtywy6@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1D13PTzSYPtRfYu1z+4wWTxff4Ld
        outKN5NFQ+8VZoslD18zW3RPecto8aOlh9li8+Z2FgcOj52z7rJ7LNhU6tHVfoTN41nvHkaP
        i5eUPT5vkgtgi+KySUnNySxLLdK3S+DKeHx1D0vBfc6Ka78rGhifsncxcnJICJhIfJ91jqmL
        kYtDSGAHk8Ti192sEM55JoldfU9ZQKqEBaIlXpxZzQpiiwjISnw/vJERxBYSOMQo0bS4BKSB
        WeAhk8TVu6/BitgEdCUW9TQDjeXg4BWwl/j/JBUkzCKgIvF8xWxmEFtUIELiYecusCt4BQQl
        Ts58AraLU8BFou8bRJxZQF3iz7xLzBC2vMT2t3OYJzDyz0LSMgtJ2SwkZQsYmVcxyiXmlObq
        5iZm5hSnJusWJyfm5aUW6Rrr5WaW6KWmlG5ihIQ73w7G9vUyhxgFOBiVeHg3hIRFCrEmlhVX
        5h5ilORgUhLlXXktNFKILyk/pTIjsTgjvqg0J7UY6HMOZiURXqNV4ZFCvCmJlVWpRfkwKWkO
        FiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ3mPXgBoFi1LTUyvSMnNKENJMHJwgw3mAhiu2
        gAwvLkjMLc5Mh8ifYlSUEuftvwqUEABJZJTmwfXC0tErRnGgV4R5lYHJSYgHmMrgul8BDWYC
        Giw8IwRkcEkiQkqqgVFHc8sEg7VrevfsE+rbKT51Q5P9DVlpmyfxjnEn7DqXveJmnuiQ+HbF
        OnXXpFkfdH68MDttljtfMGy2fq/U7A2d/zLXv30lEndJdH2N/yPBLwL/XZkeT16SsvzXSy7h
        Ft16o3+Rnv/n3bSdOEEpQsDizZadfFWb/WVmzww/663u0nX1+Qpd0R9KLMUZiYZazEXFiQBk
        u/38IgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/23/2017 09:56 PM, Jeff King wrote:
> On Fri, Jun 23, 2017 at 09:01:46AM +0200, Michael Haggerty wrote:
> 
>> Change `repack_without_refs()` to expect the packed-refs lock to be
>> held already, and not to release the lock before returning. Change the
>> callers to deal with lock management.
>>
>> This change makes it possible for callers to hold the packed-refs lock
>> for a longer span of time, a possibility that will eventually make it
>> possible to fix some longstanding races.
> 
> This is the sort of clue I was thinking about in my last email. :)

I'll try to be better about that in the future.

And the reason to make `packed_ref_store` fulfill the `ref_store`
interface is mostly indirect at the moment. It was important (to my
sanity, if nothing else) to simplify the interface to the packed-refs
code before rewriting its innards. Since the `ref_store` interface is
familiar and is fairly close to what is needed, it seemed logical to use it.

>> The only semantic change here is that `repack_without_refs()` used to
>> forgot to release the lock in the `if (!removed)` exit path. That
>> omission is now fixed.
> 
> s/used to forgot/previously forgot/ or similar?

Thanks; will fix.

Michael

