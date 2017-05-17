Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FE71201A7
	for <e@80x24.org>; Wed, 17 May 2017 15:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbdEQPtY (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 11:49:24 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56850 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751155AbdEQPtX (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 11:49:23 -0400
X-AuditID: 12074413-0e1ff70000001dc3-ed-591c71029ff3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B6.79.07619.2017C195; Wed, 17 May 2017 11:49:22 -0400 (EDT)
Received: from [192.168.69.190] (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HFnHlW012599
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 11:49:20 -0400
Subject: Re: [PATCH 09/23] files-backend: move `lock` member to
 `files_ref_store`
To:     Jeff King <peff@peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <9b52c29411fa11ac0d8227d5ae78ba2768485b3f.1495014840.git.mhagger@alum.mit.edu>
 <20170517131459.uznay3pmzgxijunm@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <ca2a1d69-8407-fde4-edb8-34cbffcd46ae@alum.mit.edu>
Date:   Wed, 17 May 2017 17:49:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170517131459.uznay3pmzgxijunm@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqMtUKBNp8HuboMXaZ3eYLLqudDNZ
        NPReYbZY8vA1s0X3lLeMFj9aepgtNm9uZ3Fg99g56y67x4JNpR5d7UfYPJ717mH0uHhJ2ePz
        JrkAtigum5TUnMyy1CJ9uwSujEvbnrMVzGaruLLiJXsD40uWLkZODgkBE4mWE4sYuxi5OIQE
        djBJ/J67nAXCOcckMaXrLhNIlbBAsMTJ1oNsILaIgKzE98MboToOMUqc2PqZGSTBLLCJSWLr
        WXsQm01AV2JRTzNYM6+AvcTdxefBbBYBVYl/y9vABokKREg87NzFDlEjKHFy5hOwkzgFXCQe
        7NnCDjFTXeLPvEtQ8+Ultr+dwzyBkX8WkpZZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5
        MS8vtUjXXC83s0QvNaV0EyMk0IV3MO46KXeIUYCDUYmHNyJAJlKINbGsuDL3EKMkB5OSKO/+
        B9KRQnxJ+SmVGYnFGfFFpTmpxUCvczArifDuzwEq501JrKxKLcqHSUlzsCiJ86otUfcTEkhP
        LEnNTk0tSC2CyWpwcAjcXdK7gVGKJS8/L1VJgndJPtAQwaLU9NSKtMycEoRSJg5OkEU8QItm
        g9TwFhck5hZnpkPkTzHqcsy59/U9kxDYIClx3gl5QEUCIEUZpXlwc2CJ6xWjONCLwrz7QEbx
        AJMe3KRXQEuYgJY0g3zKW1ySiJCSamCUOTHXQrZVMmNliZjPvxjhJX7tGaVcUndLbLfyWQtK
        P+bbenTKvu9lFb5afrkpT6drfDijHSm6uz3qze7ZIUxbGGeuiw8SWPOzpvSpmreENe+pxSnm
        PipfK8sff6uVEK41O5JRcGneoQcGD6IZf388+GC96myeGx6eidU/pvtuaD1jrW7Snq3EUpyR
        aKjFXFScCAABHRmINwMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17/2017 03:15 PM, Jeff King wrote:
> On Wed, May 17, 2017 at 02:05:32PM +0200, Michael Haggerty wrote:
> 
>> @@ -70,6 +61,13 @@ struct files_ref_store {
>>  
>>  	struct ref_cache *loose;
>>  	struct packed_ref_cache *packed;
>> +
>> +	/*
>> +	 * Iff the packed-refs file associated with this instance is
>> +	 * currently locked for writing, this points at the associated
>> +	 * lock (which is owned by somebody else).
>> +	 */
>> +	struct lock_file *packlock;
> 
> I'm glad to see you renamed this from just "lock", though the short
> "pack" makes me think of packed objects. I don't know if
> "packed_refs_lock" would be too verbose (I see it's just "packed" above,
> so maybe "packed_lock").
> 
> </bikeshed>

I'll rename it to `packed_refs_lock`.

Michael

