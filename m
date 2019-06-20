Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB0E1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 19:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfFTTM0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 15:12:26 -0400
Received: from siwi.pair.com ([209.68.5.199]:43054 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfFTTM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 15:12:26 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2EFCD3F409F;
        Thu, 20 Jun 2019 15:12:24 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:4dc2:af85:669c:b0a] (unknown [IPv6:2001:4898:a800:1012:fef5:af85:669c:b0a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id ED7843F4083;
        Thu, 20 Jun 2019 15:12:23 -0400 (EDT)
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20190619095858.30124-1-pclouds@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1d24e390-5269-2a9a-4301-d4c462052e25@jeffhostetler.com>
Date:   Thu, 20 Jun 2019 15:12:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190619095858.30124-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/19/2019 5:58 AM, Nguyễn Thái Ngọc Duy wrote:
> This is probably just my itch. Every time I have to do something with
> the index, I need to add a little bit code here, a little bit there to
> get a better "view" of the index.
> 
> This solves it for me. It allows me to see pretty much everything in the
> index (except really low detail stuff like pathname compression). It's
> readable by human, but also easy to parse if you need to do statistics
> and stuff. You could even do a "diff" between two indexes.
> 
> I'm not really sure if anybody else finds this useful. Because if not,
> I guess there's not much point trying to merge it to git.git just for a
> single user. Maintaining off tree is still a pain for me, but I think
> I can manage it.
> 
> Nguyễn Thái Ngọc Duy (8):
>    ls-files: add --json to dump the index
>    split-index.c: dump "link" extension as json
>    fsmonitor.c: dump "FSMN" extension as json
>    resolve-undo.c: dump "REUC" extension as json
>    read-cache.c: dump "EOIE" extension as json
>    read-cache.c: dump "IEOT" extension as json
>    cache-tree.c: dump "TREE" extension as json
>    dir.c: dump "UNTR" extension as json
> 
>   Documentation/git-ls-files.txt |   5 ++
>   builtin/ls-files.c             |  30 +++++--
>   cache-tree.c                   |  41 ++++++++--
>   cache-tree.h                   |   5 +-
>   cache.h                        |   2 +
>   dir.c                          |  56 ++++++++++++-
>   dir.h                          |   4 +-
>   fsmonitor.c                    |   9 +++
>   json-writer.c                  |  30 +++++++
>   json-writer.h                  |  29 +++++++
>   read-cache.c                   | 139 ++++++++++++++++++++++++++++++---
>   resolve-undo.c                 |  36 ++++++++-
>   resolve-undo.h                 |   4 +-
>   split-index.c                  |  13 ++-
>   14 files changed, 376 insertions(+), 27 deletions(-)
> 

Thanks for working on this!  I've been wanting to do something
like this for a while.  I too am tired of digging thru hex dumps
or "od" output whenever I have an odd problem to investigate.
This will certainly help.

Jeff
