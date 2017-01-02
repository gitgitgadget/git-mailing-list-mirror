Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47128205F4
	for <e@80x24.org>; Mon,  2 Jan 2017 15:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756426AbdABPab (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:30:31 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:54112 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756423AbdABPaa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Jan 2017 10:30:30 -0500
X-AuditID: 1207440d-8cfff700000009ba-ed-586a720fe01b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 8D.4E.02490.F027A685; Mon,  2 Jan 2017 10:30:23 -0500 (EST)
Received: from [192.168.69.190] (p5B10411C.dip0.t-ipconnect.de [91.16.65.28])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v02FULvK030922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 2 Jan 2017 10:30:22 -0500
Subject: Re: [PATCH 14/17] sha1_file: introduce an nth_packed_object_oid
 function
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20170101191847.564741-1-sandals@crustytoothpaste.net>
 <20170101191847.564741-15-sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <8c205558-928d-42ac-d401-e73e19c96030@alum.mit.edu>
Date:   Mon, 2 Jan 2017 16:30:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170101191847.564741-15-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsUixO6iqMtflBVhsPGKpUXXlW4mix8tPcwW
        bTN/MDkweyy/+ZfJ41nvHkaPz5vkApijuGxSUnMyy1KL9O0SuDK+L/jGWtDKV3Fm8zzWBsaF
        3F2MnBwSAiYSX1beZ+li5OIQErjMKHGmaSMbhHOGSaJz70x2kCphgWCJPZM+soHYIgJeEvMf
        zWAFsYUEaiRaN7azgNjMArIS61f8ZQSx2QR0JRb1NDOB2LwC9hJXmjqZQWwWARWJv0dmgtWI
        CoRIXJ5zlA2iRlDi5MwnYHM4BVwk5t5bwQgxU09ix/VfrBC2vMT2t3OYJzDyz0LSMgtJ2Swk
        ZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrp5WaW6KWmlG5ihAQp7w7G/+tkDjEKcDAq
        8fB2RGVFCLEmlhVX5h5ilORgUhLlTdiQESHEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhDcoE6ic
        NyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBa1gI1ChYlJqeWpGWmVOC
        kGbi4AQZzgM0/FIByPDigsTc4sx0iPwpRkUpcV5nkGYBkERGaR5cLyyJvGIUB3pFmDcPpIoH
        mIDgul8BDWYCGvw1Lh1kcEkiQkqqgbG9x9d1nnvVSoeOba8/rnJV2r7gvuIG7VmOGwyu5uTd
        zK47zHxTPqN4jVCekbSLrkLWGq9jZzfNML29X525feXBEq8d1a9F/55+Jd+v+lnBvvSBe4pz
        ZqTIg/1coSYMmc/0WdVLd9epKmRveyf+bMPctk2qSSuc2JfNPrcjIoN1x8mrn4VkRZVYijMS
        DbWYi4oTAfTlmWf9AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/01/2017 08:18 PM, brian m. carlson wrote:
> There are places in the code where we would like to provide a struct
> object_id *, yet read the hash directly from the pack.  Provide an
> nth_packed_object_oid function that mirrors the nth_packed_object_sha1
> function.
> 
> The required cast is questionable, but should be safe on all known
> platforms.  The alternative of allocating an object as an intermediate
> would be too inefficient and cause memory leaks.  If necessary, an
> intermediate union could be used; this practice is allowed by GCC and
> explicitly sanctioned by C11.  However, such a change will likely not be
> necessary, and can be made if and when it is.

I have the feeling that this design decision has been discussed on the
mailing list. If so, could you include a URL here?

The obvious alternative to allocating a new object to return to the
caller would be to have the caller of `nth_packed_object_oid()` pass a
`struct object_id *` argument to be filled in (by copying the hash into
it). Aside from being legal C, this would also be a more robust step
towards a post-SHA-1 world, where the suggested hack wouldn't work.

Of course, the question is what the callers want to do with the
`object_id`. Are the return values of `nth_packed_object_sha1()` stored
to other longer-lived structures that rely on the lifetime of the
packfile mmap to keep the value valid? If so, then keeping track of the
lifetime of the `struct object_id` could be a big chore, not to mention
that needing to keep a 20-byte `struct object_id` around rather than a
8- or 4-byte pointer would also cost more RAM.

As you probably can tell, I'm not psyched about straying outside of
legal C. It would be nice to see more justification.

> [...]

Michael

