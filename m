Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0EB1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 21:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfFCVnw (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 17:43:52 -0400
Received: from siwi.pair.com ([209.68.5.199]:49043 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfFCVnv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 17:43:51 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8C13E3F40FA;
        Mon,  3 Jun 2019 17:35:40 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:59ab:b3d9:a0d9:493a] (unknown [IPv6:2001:4898:a800:1012:adf:b3d9:a0d9:493a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E09503F40EB;
        Mon,  3 Jun 2019 17:35:39 -0400 (EDT)
Subject: Re: [PATCH v2 0/9] Filter combination
To:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, jrn@google.com, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com,
        emilyshaffer@google.com
Cc:     matvore@comcast.net
References: <20190601003603.90794-1-matvore@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <4ec3a011-0f08-542e-f131-ee6de7749bce@jeffhostetler.com>
Date:   Mon, 3 Jun 2019 17:35:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190601003603.90794-1-matvore@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/31/2019 8:35 PM, Matthew DeVore wrote:
> Here is a roll-up with hopefully all comments applied or responded to. Notable
> changes since the last one include:
> 
>   - Added an ALLOC_GROW_BY which is used twice by this patchset to make growing
>     arrays safer and cleaner
>   - Cleaned up the URL-encoding by (1) using hex_to_bytes rather than rolling my
>     own helpers and (2) making error-string-generation non-conditional
>   - Switched to an array-based data structure rather than a linked list for both
>     LOFC_COMBINE filter spec objects and the filter object itself
>   - Changed the list_objects_filter API to be cleaner to use
>   - Changed test cases to use sparse:oid= rather than sparse:path= since the
>     latter is being disabled.
> 
> Thank you,
> 
> Matthew DeVore (9):
>    list-objects-filter: make API easier to use
>    list-objects-filter: put omits set in filter struct
>    list-objects-filter-options: always supply *errbuf
>    list-objects-filter: implement composite filters
>    list-objects-filter-options: move error check up
>    list-objects-filter-options: make filter_spec a strbuf
>    list-objects-filter-options: allow mult. --filter
>    list-objects-filter-options: clean up use of ALLOC_GROW
>    list-objects-filter-options: make parser void
> 
>   Documentation/rev-list-options.txt  |  16 ++
>   builtin/rev-list.c                  |   2 +-
>   cache.h                             |  22 ++
>   list-objects-filter-options.c       | 264 ++++++++++++++++++---
>   list-objects-filter-options.h       |  32 ++-
>   list-objects-filter.c               | 345 +++++++++++++++++++++-------
>   list-objects-filter.h               |  35 ++-
>   list-objects.c                      |  55 ++---
>   t/t5616-partial-clone.sh            |  19 ++
>   t/t6112-rev-list-filters-objects.sh | 197 +++++++++++++++-
>   transport.c                         |   1 +
>   upload-pack.c                       |   4 +-
>   12 files changed, 816 insertions(+), 176 deletions(-)
> 

This looks much nicer.
Thanks
Jeff
