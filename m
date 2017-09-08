Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9713B202A4
	for <e@80x24.org>; Fri,  8 Sep 2017 08:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754298AbdIHIT4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 04:19:56 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53047 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753645AbdIHITx (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 04:19:53 -0400
X-AuditID: 1207440f-a43ff70000007960-aa-59b252a8555d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id D8.42.31072.8A252B95; Fri,  8 Sep 2017 04:19:52 -0400 (EDT)
Received: from [192.168.69.190] (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v888Jnj2020128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 04:19:50 -0400
Subject: Re: [PATCH 02/10] struct ref_transaction: add a place for backends to
 store data
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <cover.1503993268.git.mhagger@alum.mit.edu>
 <5b8c8f9ab0ccd5f85eb43a7a1535af89b0af85e3.1503993268.git.mhagger@alum.mit.edu>
 <20170908070205.3hwa7tjgok7kgknc@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <6c4cf1eb-7991-1a39-a298-7839872ed3f5@alum.mit.edu>
Date:   Fri, 8 Sep 2017 10:19:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170908070205.3hwa7tjgok7kgknc@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqLsiaFOkway7+hZrn91hsni+/gS7
        RdeVbiaLht4rzBbdU94yWvxo6WG22Ly5ncWB3WPnrLvsHgs2lXo8693D6HHxkrLH501yAaxR
        XDYpqTmZZalF+nYJXBl3Pm1kK5jLVTHh3DH2BsZ5HF2MHBwSAiYS/zbxdTFycggJ7GCS2HYn
        oYuRC8g+zyRxfOMVZpCEsEC0xPKJ79hBbBEBWYnvhzcyghQxC2xhkng3t4MdouMQo0TL430s
        IFVsAroSi3qamUBsXgF7idM//zOC2CwCKhKbe2+CTRUViJDoe3uZHaJGUOLkzCdgvZwCLhKL
        1m8Ds5kF1CX+zLvEDGGLS9x6Mp8JwpaX2P52DvMERoFZSNpnIWmZhaRlFpKWBYwsqxjlEnNK
        c3VzEzNzilOTdYuTE/PyUot0TfRyM0v0UlNKNzFCooF/B2PXeplDjAIcjEo8vCu8N0UKsSaW
        FVfmHmKU5GBSEuVtmLExUogvKT+lMiOxOCO+qDQntRgYDBzMSiK8F/2AynlTEiurUovyYVLS
        HCxK4rzqS9T9hATSE0tSs1NTC1KLYLIyHBxKErwqwKgXEixKTU+tSMvMKUFIM3FwggznARqu
        A1LDW1yQmFucmQ6RP8WoKCXO6x8IlBAASWSU5sH1wpLVK0ZxoFeEeS+AVPEAEx1c9yugwUxA
        g0uebwAZXJKIkJJqYGz/t0Rxyt7Ze3f91na+/WjLVamfDEruRtHJZu9sTHq+3dHZU8ptFVrn
        blj0/9TlrwvUrop8nHfo6oq8Hf+/HLu8Q6Q66d7Jk/m3PQqWXdT9yPLu3Iesx5JVZhuVFm1t
        /ai/8e0BYRFp3quLNl57rdkrFd3l0fQwW9RCXGHRqgnz1Q6d3XvLTaJeiaU4I9FQi7moOBEA
        nwLo0zEDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/08/2017 09:02 AM, Jeff King wrote:
> On Tue, Aug 29, 2017 at 10:20:26AM +0200, Michael Haggerty wrote:
> 
>> `packed_ref_store` is going to want to store some transaction-wide
>> data, so make a place for it.
> 
> That makes sense, although...
> 
>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index b02dc5a7e3..d7d344de73 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -242,6 +242,7 @@ struct ref_transaction {
>>  	size_t alloc;
>>  	size_t nr;
>>  	enum ref_transaction_state state;
>> +	void *backend_data;
>>  };
> 
> This is just one pointer. Once we start layering ref backends (and
> already we're moving towards a "files" layer which sits atop loose and
> packed backends, right?), how do we avoid backends stomping on each
> other (or worse, dereferencing somebody else's data as their own
> struct)?

My conception is that layered backends would be separated as much as
possible, and if the "top" layer needs to modify the "bottom" layer, it
would do so via a separate reference transaction on the bottom layer.
That transaction would be owned by the bottom layer, which would be able
to use the corresponding `backend_data` pointers however it likes.

You can see an example of this construct in patch 08.

Michael
