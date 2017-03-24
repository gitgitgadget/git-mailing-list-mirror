Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 440631FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 12:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933153AbdCXMgL (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 08:36:11 -0400
Received: from siwi.pair.com ([209.68.5.199]:28476 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932434AbdCXMgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 08:36:09 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D24C384626;
        Fri, 24 Mar 2017 08:36:07 -0400 (EDT)
Subject: Re: [PATCH v2 5/7] name-hash: perf improvement for
 lazy_init_name_hash
To:     Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
 <1490276825-41544-6-git-send-email-git@jeffhostetler.com>
 <e987714e-473f-cad1-159b-18459ffeb241@ramsayjones.plus.com>
 <CAGZ79kZKri4jsnGCWhpV_WjSef5DxSwMTxYOour9kjzTWOFcxA@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <89375f59-8716-3ddc-b163-5669452273c5@jeffhostetler.com>
Date:   Fri, 24 Mar 2017 08:36:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZKri4jsnGCWhpV_WjSef5DxSwMTxYOour9kjzTWOFcxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/23/2017 1:45 PM, Stefan Beller wrote:
> On Thu, Mar 23, 2017 at 8:25 AM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>> +     /*
>>> +      * Either we have a parent directory and path with slash(es)
>>> +      * or the directory is an immediate child of the root directory.
>>> +      */
>>> +     assert((parent != NULL) ^ (strchr(prefix->buf, '/') == 0));
>>
>
> Also this seems part of the actual shipped code, not testing code.
> In that case we prefer
>
>     if (<condition>)
>         die("BUG: <description>");
>
> This is because asserts may be omitted by the compiler,
> when compiled with NDEBUG.

I mainly wrote that for myself while testing.  Now that I'm
past that, I'm comfortable removing it completely or converting
it to an actual if-die.

Jeff
