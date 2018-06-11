Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87C021F403
	for <e@80x24.org>; Mon, 11 Jun 2018 10:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932705AbeFKKkg (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 06:40:36 -0400
Received: from siwi.pair.com ([209.68.5.199]:42261 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932472AbeFKKkf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 06:40:35 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CD7263F40BC;
        Mon, 11 Jun 2018 06:40:34 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8C2F93F4097;
        Mon, 11 Jun 2018 06:40:34 -0400 (EDT)
Subject: Re: [PATCH v8 1/2] json_writer: new routines to create data in JSON
 format
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180607141209.24423-1-git@jeffhostetler.com>
 <20180607141209.24423-2-git@jeffhostetler.com>
 <515709a2-3cfe-b147-6176-ff95455e1692@web.de>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <293b890c-3d8f-a6b9-7f3c-f14e76ce7687@jeffhostetler.com>
Date:   Mon, 11 Jun 2018 06:40:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <515709a2-3cfe-b147-6176-ff95455e1692@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/8/2018 4:32 PM, René Scharfe wrote:
> Am 07.06.2018 um 16:12 schrieb git@jeffhostetler.com:
>>    Makefile                    |   2 +
>>    json-writer.c               | 419 ++++++++++++++++++++++++++++++++
>>    json-writer.h               | 113 +++++++++
>>    t/helper/test-json-writer.c | 572 ++++++++++++++++++++++++++++++++++++++++++++
>>    t/t0019-json-writer.sh      | 236 ++++++++++++++++++
>>    5 files changed, 1342 insertions(+)
>>    create mode 100644 json-writer.c
>>    create mode 100644 json-writer.h
>>    create mode 100644 t/helper/test-json-writer.c
>>    create mode 100755 t/t0019-json-writer.sh
> 
> $ git grep 'static inline' '*json*'
> json-writer.c:static inline void indent_pretty(struct json_writer *jw)
> json-writer.c:static inline void begin(struct json_writer *jw, char ch_open, int pretty)
> json-writer.c:static inline void assert_in_object(const struct json_writer *jw, const char *key)
> json-writer.c:static inline void assert_in_array(const struct json_writer *jw)
> json-writer.c:static inline void maybe_add_comma(struct json_writer *jw)
> json-writer.c:static inline void fmt_double(struct json_writer *jw, int precision,
> json-writer.c:static inline void object_common(struct json_writer *jw, const char *key)
> json-writer.c:static inline void array_common(struct json_writer *jw)
> json-writer.c:static inline void assert_is_terminated(const struct json_writer *jw)
> t/helper/test-json-writer.c:static inline int scripted(int argc, const char **argv)
> t/helper/test-json-writer.c:static inline int my_usage(void)
> 
> Do you need all those inline keywords?  I'd rather leave the decision
> about inlining to the compiler and (via optimization flags) the user
> as much as possible.  Not a biggie, but the high frequency of that
> word made me blink..
> 
> René
> 

I was just trying to match the patterns I found elsewhere in the code.

     $ grep "static inline" *.c builtin/*.c | wc -l
     111

But yeah, it's no big deal.  I can remove them.

Jeff
