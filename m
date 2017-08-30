Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F21CA1F4DD
	for <e@80x24.org>; Wed, 30 Aug 2017 03:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbdH3DAH (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 23:00:07 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:56805 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751318AbdH3DAG (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Aug 2017 23:00:06 -0400
X-AuditID: 12074412-1fdff7000000748d-c7-59a62a356ae7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id B1.12.29837.53A26A95; Tue, 29 Aug 2017 23:00:05 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC970.dip0.t-ipconnect.de [87.188.201.112])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7U3011t028570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 29 Aug 2017 23:00:02 -0400
Subject: Re: [PATCH 04/10] packed_delete_refs(): implement method
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <cover.1503993268.git.mhagger@alum.mit.edu>
 <7c61f04574e32d6172062a6a8ffa8ade5c90bb1d.1503993268.git.mhagger@alum.mit.edu>
 <20170829180732.GA131745@google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <5237dffe-fcb4-37b9-2645-3f0f0dc5bd19@alum.mit.edu>
Date:   Wed, 30 Aug 2017 05:00:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170829180732.GA131745@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqGuqtSzSYMNhFYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovuKW8ZLX609DBbbN7czuLA7rFz1l12jwWbSj2e9e5h9Lh4Sdnj8ya5ANYo
        LpuU1JzMstQifbsEroxvR46yFlzkrVhzvpupgXEidxcjJ4eEgInE7U0drCC2kMAOJom+faJd
        jFxA9gUmia3vLgElODiEBRwlWq+lgdSICGhI3Dt8kBHEZhZYySQxY6UURP16RonvN2cwgSTY
        BHQlFvU0g9m8AvYSU/sWgtksAqoSb7+8YAaxRQUiJPreXmaHqBGUODnzCQvILk4BQ4nZb7gh
        5qtL/Jl3iRnCFpe49WQ+E4QtL7H97RzmCYwCs5B0z0LSMgtJyywkLQsYWVYxyiXmlObq5iZm
        5hSnJusWJyfm5aUW6Zrp5WaW6KWmlG5ihESC0A7G9SflDjEKcDAq8fDuKF0aKcSaWFZcmXuI
        UZKDSUmUd6rcskghvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIryXFYFyvCmJlVWpRfkwKWkOFiVx
        3p+L1f2EBNITS1KzU1MLUotgsjIcHEoSvDaaQI2CRanpqRVpmTklCGkmDk6Q4TxAw8s0QIYX
        FyTmFmemQ+RPMSpKifNKgTQLgCQySvPgemGJ6hWjONArwrzJIO08wCQH1/0KaDAT0OBYr6Ug
        g0sSEVJSDYwHS6b2RvWKcz77HPeJYX8vv1HHyq1nPeZ/2SRZdtRkqQHDDA2ld1KVx/67NvYf
        7Oll0tLJeCfE/y9+YoKlmsQ6q3/RSVJCmX03M1R/PilpubVz2z7jn1IPH0Wlaq9Pfs6ub2X0
        /jW3xbXPE6WTF0/d//5lson+GUetmdbn7/2JqJ/Yy+vYfVeJpTgj0VCLuag4EQANwZS2LwMA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/29/2017 08:07 PM, Brandon Williams wrote:
> On 08/29, Michael Haggerty wrote:
>> [...]
>> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
>> index d19b3bfba5..83a088118f 100644
>> --- a/refs/packed-backend.c
>> +++ b/refs/packed-backend.c
>> @@ -1082,7 +1082,50 @@ static int packed_initial_transaction_commit(struct ref_store *ref_store,
>>  static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
>>  			     struct string_list *refnames, unsigned int flags)
>>  {
>> -	die("BUG: not implemented yet");
>> +	struct packed_ref_store *refs =
>> +		packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
>> +	struct strbuf err = STRBUF_INIT;
>> +	struct ref_transaction *transaction;
>> +	struct string_list_item *item;
>> +	int ret;
>> +
>> +	(void)refs; /* We need the check above, but don't use the variable */
> 
> Can't say I've seen a line like this before, Is the intent to just mark
> that this variable won't be used like you mention in the comment?


The `(void)refs;` part tells the compiler not to complain about a
variable that is defined but never used.

So why define the variable in the first place? I could instead do

    (void)packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs");

My reason (which people might disagree with) is that I like to keep this
boilerplate consistent from method to method. To switch to the second
variant, not only would the line look different, but it would also have
to be moved down several lines, past the other variables' declarations,
to avoid the dreaded "ISO C90 forbids mixed declarations and code".

I'd prefer to be able to mix declarations and code, but the project's
style prohibits it.

Michael
