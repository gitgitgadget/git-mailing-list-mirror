Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2C4D1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 17:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeCZRgn (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 13:36:43 -0400
Received: from siwi.pair.com ([209.68.5.199]:58178 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752626AbeCZRgn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 13:36:43 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A265D3F400D;
        Mon, 26 Mar 2018 13:36:42 -0400 (EDT)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5AD833F4006;
        Mon, 26 Mar 2018 13:36:42 -0400 (EDT)
Subject: Re: [RFC PATCH v2 1/1] json-writer: add cast to uintmax_t
To:     Wink Saville <wink@saville.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, jeffhost@microsoft.com,
        ramsay@ramsayjones.plus.com
References: <cover.1521916335.git.wink@saville.com>
 <1a6a4983b824e7b9f4eb1f7b83a39d24f72e552f.1521916335.git.wink@saville.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f8db1d34-122b-8381-e273-6d955948ea56@jeffhostetler.com>
Date:   Mon, 26 Mar 2018 13:36:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1a6a4983b824e7b9f4eb1f7b83a39d24f72e552f.1521916335.git.wink@saville.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/24/2018 2:38 PM, Wink Saville wrote:
> Correct a compile error on Mac OSX by adding a cast to uintmax_t
> in calls to strbuf_addf.
> 
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Tested-by: travis-ci
> Signed-off-by: Wink Saville <wink@saville.com>
> ---
>   json-writer.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/json-writer.c b/json-writer.c
> index 89a6abb57..1f40482ff 100644
> --- a/json-writer.c
> +++ b/json-writer.c
> @@ -120,7 +120,7 @@ void jw_object_uint64(struct json_writer *jw, const char *key, uint64_t value)
>   	maybe_add_comma(jw);
>   
>   	append_quoted_string(&jw->json, key);
> -	strbuf_addf(&jw->json, ":%"PRIuMAX, value);
> +	strbuf_addf(&jw->json, ":%"PRIuMAX, (uintmax_t)value);
>   }
>   
>   void jw_object_double(struct json_writer *jw, const char *fmt,
> @@ -225,7 +225,7 @@ void jw_array_uint64(struct json_writer *jw, uint64_t value)
>   	assert_in_array(jw);
>   	maybe_add_comma(jw);
>   
> -	strbuf_addf(&jw->json, "%"PRIuMAX, value);
> +	strbuf_addf(&jw->json, "%"PRIuMAX, (uintmax_t)value);
>   }
>   
>   void jw_array_double(struct json_writer *jw, const char *fmt, double value)
> 

FYI.  I included and squashed this change into V4 of my json-writer series.

Jeff

