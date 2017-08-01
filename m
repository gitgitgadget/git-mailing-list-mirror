Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A46F72047F
	for <e@80x24.org>; Tue,  1 Aug 2017 13:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbdHANPS (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 09:15:18 -0400
Received: from siwi.pair.com ([209.68.5.199]:39002 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751937AbdHANOw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 09:14:52 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 104A8845FE;
        Tue,  1 Aug 2017 09:14:51 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BD3F2845FC;
        Tue,  1 Aug 2017 09:14:50 -0400 (EDT)
Subject: Re: [PATCH] convert any hard coded .gitmodules file string to the
 MACRO
To:     Stefan Beller <sbeller@google.com>, bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
References: <20170718190527.78049-4-bmwill@google.com>
 <20170731231142.15053-1-sbeller@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <413e4f55-5f8b-a80f-775b-b456c4de8a46@jeffhostetler.com>
Date:   Tue, 1 Aug 2017 09:14:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170731231142.15053-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/31/2017 7:11 PM, Stefan Beller wrote:
> I used these commands:
>    $ cat sem.cocci
>    @@
>    @@
>    - ".gitmodules"
>    + GITMODULES_FILE
> 
>    $ spatch --in-place --sp-file sem.cocci builtin/*.c *.c *.h
> 
> Feel free to regenerate or squash it in or have it as a separate commit.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   submodule.c    | 18 +++++++++---------
>   unpack-trees.c |  2 +-
>   2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 37f4a92872..b75d02ba7b 100644
> --- a/submodule.c
> +++ b/submodule.c
>   
> @@ -233,18 +233,18 @@ void gitmodules_config(void)
>   		strbuf_addstr(&gitmodules_path, "/.gitmodules");

Did you mean to also change "/.gitmodules" ??

>   		if (read_cache() < 0)
>   			die("index file corrupt");
> -		pos = cache_name_pos(".gitmodules", 11);
> +		pos = cache_name_pos(GITMODULES_FILE, 11);
>   		if (pos < 0) { /* .gitmodules not found or isn't merged */
>   			pos = -1 - pos;
>   			if (active_nr > pos) {  /* there is a .gitmodules */

It might also be nice to change the literals in the comments to
use the macro.

Jeff

