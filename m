Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE4141F424
	for <e@80x24.org>; Sun, 21 Jan 2018 04:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750853AbeAUEly (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 23:41:54 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:47886 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750817AbeAUElx (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 20 Jan 2018 23:41:53 -0500
X-AuditID: 12074412-c85ff70000000b7d-82-5a641a10a4cf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 9D.D5.02941.01A146A5; Sat, 20 Jan 2018 23:41:52 -0500 (EST)
Received: from [192.168.69.190] (p4FC6EAAB.dip0.t-ipconnect.de [79.198.234.171])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w0L4fn5c030836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 20 Jan 2018 23:41:50 -0500
Subject: Re: [PATCH v3] packed_ref_cache: don't use mmap() for small files
To:     Jeff King <peff@peff.net>, Kim Gybels <kgybels@infogroep.be>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20180115235251.GA21900@sigill.intra.peff.net>
 <20180116193815.4568-1-kgybels@infogroep.be>
 <20180117220902.GA14952@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <29c51594-6e29-be34-3d5f-2b9f399490f2@alum.mit.edu>
Date:   Sun, 21 Jan 2018 05:41:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180117220902.GA14952@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqCsglRJlsGeFjkXXlW4mi4beK8wW
        /cu72CwOds5ktfjR0sPswOrx4WOcR9+RNYwez3r3MHpcvKTs8XmTXABrFJdNSmpOZllqkb5d
        AlfGjyPnmAv+8lQsWLeOsYHxPFcXIyeHhICJxNGOx+xdjFwcQgI7mCR+LtsD5Vxgkth1t5MF
        pEpYwEti6pKD7CC2iICDxJa5BxlBbGaBMokT72dBNcxilGg5uwOsgU1AV2JRTzMTiM0rYC+x
        eMlZsAYWAVWJ3es3gtmiAhESU9auZYGoEZQ4OfMJmM0pYC2x7OcMqAXqEn/mXWKGsMUlbj2Z
        zwRhy0tsfzuHeQIj0FaE9llIWmYhaZmFpGUBI8sqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0z
        vdzMEr3UlNJNjJDQF9rBuP6k3CFGAQ5GJR7eA/OTo4RYE8uKK3MPMUpyMCmJ8t61TYoS4kvK
        T6nMSCzOiC8qzUktPsQowcGsJMI7+yFQOW9KYmVValE+TEqag0VJnPfnYnU/IYH0xJLU7NTU
        gtQimKwMB4eSBK+YZEqUkGBRanpqRVpmTglCmomDE2Q4D9DwJxJANbzFBYm5xZnpEPlTjLoc
        N168bmMWYsnLz0uVEufNACkSACnKKM2DmwNLWa8YxYHeEubVB1nHA0x3cJNeAS1hAloysTcR
        ZElJIkJKqoFRlP/5pp/vDRbfS5APnKb7/+C3Vw/+35rx5e70BNFbLRt/ucyXtzwbdmmqzv4o
        lq6IZ3s2WGtJyy78c0Vg201tndzfYRvyJ/avLrmqmDfrZdpa2RxH1ZY7pxbW1i079e5z+yt/
        RdaPJRNkc0/1nJk+x2/VgvRXy211fsqyTVOWFQk02/950/Nvq5VYijMSDbWYi4oTAWrnaEM0
        AwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/17/2018 11:09 PM, Jeff King wrote:
> On Tue, Jan 16, 2018 at 08:38:15PM +0100, Kim Gybels wrote:
> 
>> Take a hint from commit ea68b0ce9f8 (hash-object: don't use mmap() for
>> small files, 2010-02-21) and use read() instead of mmap() for small
>> packed-refs files.
>>
>> This also fixes the problem[1] where xmmap() returns NULL for zero
>> length[2], for which munmap() later fails.
>>
>> Alternatively, we could simply check for NULL before munmap(), or
>> introduce xmunmap() that could be used together with xmmap(). However,
>> always setting snapshot->buf to a valid pointer, by relying on
>> xmalloc(0)'s fallback to 1-byte allocation, makes using snapshots
>> easier.
>>
>> [1] https://github.com/git-for-windows/git/issues/1410
>> [2] Logic introduced in commit 9130ac1e196 (Better error messages for
>>     corrupt databases, 2007-01-11)
>>
>> Signed-off-by: Kim Gybels <kgybels@infogroep.be>
>> ---
>>
>> Change since v2: removed separate case for zero length as suggested by Peff,
>> ensuring that snapshot->buf is always a valid pointer.
> 
> Thanks, this looks fine to me (I'd be curious to hear from Michael if
> this eliminates the need for the other patches).

`snapshot->buf` can still be NULL if the `packed-refs` file didn't exist
(see the earlier code path in `load_contents()`). So either that code
path *also* has to get the `xmalloc()` treatment, or my third patch is
still necessary. (My second patch wouldn't be necessary because the
ENOENT case makes `load_contents()` return 0, triggering the early exit
from `create_snapshot()`.)

I don't have a strong preference either way.

Michael
