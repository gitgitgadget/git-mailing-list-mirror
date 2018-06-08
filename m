Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72EFB1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 20:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752969AbeFHUSk (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 16:18:40 -0400
Received: from siwi.pair.com ([209.68.5.199]:11439 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752897AbeFHUSi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 16:18:38 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 10ECE3F4854;
        Fri,  8 Jun 2018 16:18:38 -0400 (EDT)
Received: from [10.160.98.81] (unknown [167.220.148.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C4A703F40BE;
        Fri,  8 Jun 2018 16:18:37 -0400 (EDT)
Subject: Re: [PATCH v8 1/2] json_writer: new routines to create data in JSON
 format
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180607141209.24423-1-git@jeffhostetler.com>
 <20180607141209.24423-2-git@jeffhostetler.com>
 <CAPig+cRBCr2dKOBFnUF_D1SXfPTE5SPbB4t=y51VGa_jLQGkcA@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9cfabdad-e4eb-a334-5e6c-aad6dfee8b87@jeffhostetler.com>
Date:   Fri, 8 Jun 2018 16:17:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRBCr2dKOBFnUF_D1SXfPTE5SPbB4t=y51VGa_jLQGkcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/7/2018 1:24 PM, Eric Sunshine wrote:
> On Thu, Jun 7, 2018 at 10:12 AM,  <git@jeffhostetler.com> wrote:
>> Add a series of jw_ routines and "struct json_writer" structure to compose
>> JSON data.  The resulting string data can then be output by commands wanting
>> to support a JSON output format.
>> [...]
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>> diff --git a/t/t0019-json-writer.sh b/t/t0019-json-writer.sh
>> @@ -0,0 +1,236 @@
>> +test_expect_success 'simple object' '
>> +       cat >expect <<-\EOF &&
>> +       {"a":"abc","b":42,"c":3.14,"d":true,"e":false,"f":null}
>> +       EOF
>> +       test-json-writer >actual \
>> +               @object \
>> +                       @object-string a abc \
>> +                       @object-int b 42 \
>> +                       @object-double c 2 3.140 \
>> +                       @object-true d \
>> +                       @object-false e \
>> +                       @object-null f \
>> +               @end &&
>> +       test_cmp expect actual
>> +'
> 
> To make it easier on people writing these tests, it might be nice for
> this to be less noisy by getting rid of "@" and "\". To get rid of
> "\", the test program could grab its script commands from stdin (one
> instruction per line) rather than from argv[]. For instance:
> 
>      test-json-writer >actual <<-\EOF &&
>          object
>              object-string a abc
>              ...
>          end
>      EOF
> 
> Not a big deal, and certainly not worth a re-roll.
> 

I hadn't thought about doing it that way.  Might be a little easier
to use.  Let me take a look and see if it would be much work to switch.

Thanks
Jeff
