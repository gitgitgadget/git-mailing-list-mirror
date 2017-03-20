Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA55620958
	for <e@80x24.org>; Mon, 20 Mar 2017 22:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754858AbdCTWjY (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 18:39:24 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:63604 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753305AbdCTWjX (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 18:39:23 -0400
X-AuditID: 12074414-807ff70000002bfd-fa-58d05a194941
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 5D.C5.11261.91A50D85; Mon, 20 Mar 2017 18:39:21 -0400 (EDT)
Received: from [192.168.69.190] (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KMdJ6L031931
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 18:39:20 -0400
Subject: Re: [PATCH 11/20] refs: record the ref_store in ref_cache, not
 ref_dir
To:     Jeff King <peff@peff.net>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
 <745f1ed3781083f99da31a33dec08f03bffa7d4f.1490026594.git.mhagger@alum.mit.edu>
 <20170320175145.zwfqp7varl4hwink@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <5e015cd9-f53e-b27b-ff73-d95706df3223@alum.mit.edu>
Date:   Mon, 20 Mar 2017 23:39:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170320175145.zwfqp7varl4hwink@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsUixO6iqCsZdSHC4GyrkUXXlW4mi4beK8wW
        Sx6+ZrbonvKW0eJHSw+zA6vHzll32T262o+weTzr3cPocfGSssfnTXIBrFFcNimpOZllqUX6
        dglcGWv3TGAsmCRQ8an5OmsD40+eLkZODgkBE4nT89awdjFycQgJ7GCSONn/iRHCucAkcerK
        dCaQKmGBQIlJ02+C2SICshLfD2+EKjrEKHHj5FZmEIdZYDujxMubC9hBqtgEdCUW9TQDdXBw
        8ArYS0w8HQ4SZhFQlXg5cS8LiC0qECIxZ+EDRhCbV0BQ4uTMJ2BxTgEXiWN7NzGD2MwC6hJ/
        5l2CsuUltr+dwzyBkX8WkpZZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXQi83
        s0QvNaV0EyMkmEV2MB45KXeIUYCDUYmHd8WV8xFCrIllxZW5hxglOZiURHmrfC9ECPEl5adU
        ZiQWZ8QXleakFgO9zsGsJMJb6wGU401JrKxKLcqHSUlzsCiJ835brO4nJJCeWJKanZpakFoE
        k5Xh4FCS4L0aAdQoWJSanlqRlplTgpBm4uAEGc4DNLwQpIa3uCAxtzgzHSJ/ilFRSpy3CSQh
        AJLIKM2D64Ulm1eM4kCvCPO6RAJV8QATFVz3K6DBTECDl904AzK4JBEhJdXAmNSvY/93fwnj
        p7dnqu/73pge9tvqIYsF4zKN7yz2B/fPEuzKCJFqfOP9QfbVvO8ixyX//4tJFg3X3FFQlnLJ
        8kJyxhmzHYtXvhf3cBXJ1wpljJm8rt7rrduDoIv1ZpNlri7dMS3YSWtnklxrLvfSnTbznm79
        ceH3z4lbDb8oNn64777ULn7BTSWW4oxEQy3mouJEAEyxFeERAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/20/2017 06:51 PM, Jeff King wrote:
> On Mon, Mar 20, 2017 at 05:33:16PM +0100, Michael Haggerty wrote:
> 
>> Instead of keeping a pointer to the ref_store in every ref_dir entry,
>> store it once in `struct ref_cache`, and change `struct ref_dir` to
>> include a pointer to its containing `ref_cache` instead. This makes it
>> easier to add to the information that is stored in `struct ref_cache`
>> without inflating the size of the individual entries.
> 
> This last sentence confused me. It's a pointer either way, no?
> 
> Do you just mean that we are free to add whatever we like to the
> "ref_cache" without polluting the "ref_store" that is a more public data
> structure?

Yeah, that's explained poorly. It might be clearer as

> This makes it easier to add to the information that is accessible
> from a `ref_dir` without increasing the size of every `ref_dir`
> instance.

It used to be that `ref_dir` contained a pointer to the `ref_store` that
contains it. (BTW, such a pointer *can't* be turned into a pointer to
the `ref_cache` because (1) the `ref_dir` shouldn't have to know what
kind of `ref_store` it is being used with, and (2) a `packed_ref_cache`
can be detached from its old `ref_cache` if the stat info indicates that
the `packed-refs` file has been modified since it was last read.)

But we want to add a `fill_ref_dir` callback pointer in a place that is
reachable from the `ref_dir` so that it can fill itself when necessary.
We could add it to the `ref_dir` struct, but that would inflate its
size. Instead, it makes more sense for the `ref_dir` to have a pointer
to the enclosing `ref_cache`, and store the `fill_ref_dir` pointer in
`ref_cache`. The `ref_cache` also gets a pointer to the enclosing
`ref_store`; that way a `ref_dir` also has a way to access the
`ref_store` that contains it.

An alternative would be to pass a pointer to the `ref_cache` down the
call stack when it is being accessed, but that seemed like a lot of work
that wouldn't lead to a very clean result.

Michael

