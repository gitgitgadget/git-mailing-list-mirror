Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714611FAF4
	for <e@80x24.org>; Fri, 10 Feb 2017 10:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbdBJK2C (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 05:28:02 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:57117 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751577AbdBJK2A (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Feb 2017 05:28:00 -0500
X-AuditID: 1207440f-d47ff700000009a2-87-589d959f9acf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 9A.3B.02466.F959D985; Fri, 10 Feb 2017 05:27:44 -0500 (EST)
Received: from [192.168.69.190] (p57906495.dip0.t-ipconnect.de [87.144.100.149])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1AARfDI023221
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 10 Feb 2017 05:27:42 -0500
Subject: Re: [PATCH 0/5] Store submodules in a hash, not a linked list
To:     Jeff King <peff@peff.net>
References: <cover.1486629195.git.mhagger@alum.mit.edu>
 <20170209195812.dbbmko4sas3wtdy5@sigill.intra.peff.net>
 <9ba16176-b388-4c70-a479-fda4c9244e67@alum.mit.edu>
 <20170210004033.cgqmovhvoylad5cf@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <8cbfdb6e-1aab-d40f-16dc-06d4c57873b8@alum.mit.edu>
Date:   Fri, 10 Feb 2017 11:27:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170210004033.cgqmovhvoylad5cf@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqLtg6twIgxdXZSy6rnQzWTT0XmG2
        6F/exWax5OFrZovuKW8ZLX609DBbbN7czuLA7rFz1l12jw8f4zwWbCr16Go/wubxrHcPo8fF
        S8oenzfJBbBHcdmkpOZklqUW6dslcGVcnXGWpWARb8XOTSYNjNu4uhg5OSQETCSev+ti7GLk
        4hASuMwo8fH2MhYI5wKTxOOJR9hBqoQF3CTWrFjGCGKLCMhKfD+8EarjIaPEwYa/zCAOs8B8
        Jon+B2+YQKrYBHQlFvU0g9m8AvYSC382s4LYLAKqElP2zAebJCoQIjFn4QNGiBpBiZMzn7CA
        2JwCLhLPn94C62UWUJf4M+8SM4QtL7H97RzmCYz8s5C0zEJSNgtJ2QJG5lWMcok5pbm6uYmZ
        OcWpybrFyYl5ealFuiZ6uZkleqkppZsYIQHPv4Oxa73MIUYBDkYlHt4XNXMihFgTy4orcw8x
        SnIwKYny2jbMjRDiS8pPqcxILM6ILyrNSS0+xCjBwawkwmvTAZTjTUmsrEotyodJSXOwKInz
        qi9R9xMSSE8sSc1OTS1ILYLJynBwKEnwRk8BahQsSk1PrUjLzClBSDNxcIIM5wEa3ghSw1tc
        kJhbnJkOkT/FqCglzrsCJCEAksgozYPrhSWkV4ziQK8I8/4GqeIBJjO47ldAg5mABl8/PQtk
        cEkiQkqqgTFw7jPTWxl7HqXkM1cIF5uvjpjamRCqPjmEM6lbdyd7UXtBGNODsNAu5p68lIWR
        fM96Gz77T58lIx/xfbWg8e0eUd51ovmdX95MyRN9fi31qaTyo9jXqvdmBlwtOSyx9V311r4/
        XupPbgQc7mjuX755ge0UA4X84Bi3iov/3+rvzPllzyV1V4mlOCPRUIu5qDgRAOtbytsjAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/10/2017 01:40 AM, Jeff King wrote:
> On Thu, Feb 09, 2017 at 10:23:35PM +0100, Michael Haggerty wrote:
> 
>>>> So push the submodule attribute down to the `files_ref_store` class
>>>> (but continue to let the `ref_store`s be looked up by submodule).
>>>
>>> I'm not sure I understand all of the ramifications here. It _sounds_ like
>>> pushing this down into the files-backend code would make it harder to
>>> have mixed ref-backends for different submodules. Or is this just
>>> pushing down an implementation detail of the files backend, and future
>>> code is free to have as many different ref_stores as it likes?
>>
>> I don't understand how this would make it harder, aside from the fact
>> that a new backend class might also need a path member and have to
>> maintain its own copy rather than using one that the base class provides.
> 
> Probably the answer is "I'm really confused".
> 
> But here's how my line of reasoning went:
> 
>   Right now we have a main ref-store that points to the submodule
>   ref-stores. I don't know the current state of it, but in theory those
>   could all use different backends.
> 
>   This seems like it's pushing that submodule linkage down into the
>   backend.
> 
> But I think from your response that the answer is no, the thing that is
> being pushed down is not the right way for the main ref store and the
> submodules to be linked. In fact, there is no reason at all for the
> main ref store to know or care about submodules. Anybody who wants to
> know about a submodule's refs should ask the hashmap.

That's correct; the main ref store and submodule ref stores know nothing
of each other.

Michael

