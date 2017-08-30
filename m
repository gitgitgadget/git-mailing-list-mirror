Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 214E71F4DD
	for <e@80x24.org>; Wed, 30 Aug 2017 03:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbdH3DZX (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 23:25:23 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44077 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751440AbdH3DZV (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Aug 2017 23:25:21 -0400
X-AuditID: 12074414-0d3ff70000006ddf-fe-59a63020b8fa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 26.B4.28127.02036A95; Tue, 29 Aug 2017 23:25:20 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC970.dip0.t-ipconnect.de [87.188.201.112])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7U3PI9b029917
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 29 Aug 2017 23:25:19 -0400
Subject: Re: [PATCH] config: use a static lock_file struct
To:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <20170827073732.546-1-martin.agren@gmail.com>
 <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
 <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
 <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com>
 <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
 <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
 <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
 <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
 <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net>
 <20170829190928.GD131745@google.com>
 <20170829191217.dt65wazf7qh5qs3k@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <01375356-5d39-99af-9e91-35083ed03f42@alum.mit.edu>
Date:   Wed, 30 Aug 2017 05:25:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170829191217.dt65wazf7qh5qs3k@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqKtosCzS4P1ZRovn60+wW3Rd6Way
        ePxwCavF3zddjBY/WnqYHVg9ds66y+6xYFOpx7PePYwenzfJBbBEcdmkpOZklqUW6dslcGXs
        vZBcsEWwYt+WZewNjB95uxg5OSQETCSWT3jP3MXIxSEksINJYsL6c+wQzgUmiU3PdrCDVAkL
        WEnceLsRzBYRcJY41/SUBcRmFpjBKHH7UBZEw3sWidl7VrKCJNgEdCUW9TQzgdi8AvYS/xfd
        ZgOxWQRUJbomngWzRQUiJPreXmaHqBGUODnzCdhQTgEXiY3/TrJDLFCX+DPvEjOELS5x68l8
        JghbXmL72znMExgFZiFpn4WkZRaSlllIWhYwsqxilEvMKc3VzU3MzClOTdYtTk7My0st0rXQ
        y80s0UtNKd3ECAl4kR2MR07KHWIU4GBU4uHdwb0sUog1say4MvcQoyQHk5Io73YdoBBfUn5K
        ZUZicUZ8UWlOavEhRgkOZiUR3suKQDnelMTKqtSifJiUNAeLkjjvt8XqfkIC6YklqdmpqQWp
        RTBZGQ4OJQlecT2gRsGi1PTUirTMnBKENBMHJ8hwHqDhr0BqeIsLEnOLM9Mh8qcYFaXEeeX1
        gRICIImM0jy4XlhCesUoDvSKMO81kHYeYDKD634FNJgJaHCs11KQwSWJCCmpBsakhA8vSmV+
        fuRo0DtRX62X8UwpxTqz2o7xn/XK/H/zn6Qv0nP43x3fULCo9NWiQi//ZOuq/CnmhRMP12vf
        zDIQK54fZJzuHXLwH6f069mdioeZbmkv2WI8fzarN++a94Yp+Sd3x2df6DwqENR/NEjbKl3i
        /xQ+TovV5/uTiuT2bna0XXCkWomlOCPRUIu5qDgRAGkF+XIjAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/29/2017 09:12 PM, Jeff King wrote:
> On Tue, Aug 29, 2017 at 12:09:28PM -0700, Brandon Williams wrote:
> 
>>> -- >8 --
>>> Subject: [PATCH] config: use a static lock_file struct
>>>
>>> When modifying git config, we xcalloc() a struct lock_file
>>> but never free it. This is necessary because the tempfile
>>> code (upon which the locking code is built) requires that
>>> the resulting struct remain valid through the life of the
>>> program. However, it also confuses leak-checkers like
>>> valgrind because only the inner "struct tempfile" is still
>>> reachable; no pointer to the outer lock_file is kept.
>>
>> Is this just due to a limitation in the tempfile code?  Would it be
>> possible to improve the tempfile code such that we don't need to require
>> that a tempfile, once created, is required to exist for the remaining
>> life of the program?
> 
> Yes. Like I wrote below:
> 
>>> ---
>>> In the long run we may want to drop the "tempfiles must remain forever"
>>> rule. This is certainly not the first time it has caused confusion or
>>> leaks. And I don't think it's a fundamental issue, just the way the code
>>> is written. But in the interim, this fix is probably worth doing.
> 
> The main issue is that the caller needs to make sure they're removed
> from the list (via commit or rollback) before being freed.
> 
> As far as I know anyway. This restriction dates back to the very early
> days of the lockfile code and has been carried through the various
> tempfile-cleanup refactorings over the years (mostly because each was
> afraid to make functional changes).
> 
> +cc Michael, who did most comprehensive cleanup of that code.

It was surprisingly hard trying to get that code to do the right thing,
non-racily, in every error path. Since `remove_tempfiles()` can be
called any time (even from a signal handler), the linked list of
`tempfile` objects has to be kept valid at all times but can't use
mutexes. I didn't have the energy to keep going and make the lock
objects freeable.

I suppose the task could be made a bit easier by using `sigprocmask(2)`
or `pthread_sigmask(3)` to make its running environment a little bit
less hostile.

Michael
