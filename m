Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30B7F202A4
	for <e@80x24.org>; Fri,  8 Sep 2017 10:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754255AbdIHKEP (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 06:04:15 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53666 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754216AbdIHKEO (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 06:04:14 -0400
X-AuditID: 1207440f-a43ff70000007960-fc-59b26b1d0207
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 8C.83.31072.D1B62B95; Fri,  8 Sep 2017 06:04:13 -0400 (EDT)
Received: from [192.168.69.190] (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v88A4A7X024500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 06:04:11 -0400
Subject: Re: [PATCH 06/10] files_initial_transaction_commit(): use a
 transaction for packed refs
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <cover.1503993268.git.mhagger@alum.mit.edu>
 <92b29defc3c4ddb65a948b7d142ded941eaccefd.1503993268.git.mhagger@alum.mit.edu>
 <20170908072758.d3qvwsrm5t54kc63@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <0b1b1276-5a69-6db3-ab5d-0733bc9781b1@alum.mit.edu>
Date:   Fri, 8 Sep 2017 12:04:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170908072758.d3qvwsrm5t54kc63@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsUixO6iqCubvSnSYPUJEYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovuKW8ZLX609DBbbN7czuLA7rFz1l12jwWbSj2e9e5h9Lh4Sdnj8ya5ANYo
        LpuU1JzMstQifbsEroz/azuZC94zV7w4I9nAOJm5i5GTQ0LAROL4zb1sXYxcHEICO5gk9r/Y
        zg7hnGeSuLxoExNIlbBAksTRq+tYQGwRAVmJ74c3MoIUMQtsYZJ4N7cDquMQo8TmL6fAOtgE
        dCUW9TSD2bwC9hIz7/1jA7FZBFQkVn55CBYXFYiQ6Ht7mR2iRlDi5MwnQBs4ODgFXCQuLNEA
        CTMLqEv8mXeJGcIWl7j1ZD4ThC0vsf3tHOYJjAKzkHTPQtIyC0nLLCQtCxhZVjHKJeaU5urm
        JmbmFKcm6xYnJ+blpRbpmujlZpbopaaUbmKERAP/Dsau9TKHGAU4GJV4eFd4b4oUYk0sK67M
        PcQoycGkJMrbMGNjpBBfUn5KZUZicUZ8UWlOajEwFDiYlUR4L/oBlfOmJFZWpRblw6SkOViU
        xHnVl6j7CQmkJ5akZqemFqQWwWRlODiUJHhfZAI1ChalpqdWpGXmlCCkmTg4QYbzAA1XyAIZ
        XlyQmFucmQ6RP8Woy3Hj4fU/TEIsefl5qVLivP4ggwRAijJK8+DmwJLYK0ZxoLeEeWNARvEA
        EyDcpFdAS5iAlpQ83wCypCQRISXVwJhwVOKas4398aAO/gkCj/Zd/bupe1nWmqAJ37RaehfX
        9q9uXvrN0KvyaO/W7Q6WTowyV7Y3HVasU2/TucN3/5pUb2lKbfd67azUJbfMlz6wUnFbnh8u
        t+LfwpdPbSzl+DYl+V8w3ZM5i9N54QvPhSzuHUp9e1OaP01ey8zHtd4qxXnfjP5je5RYijMS
        DbWYi4oTAVISleE9AwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/08/2017 09:27 AM, Jeff King wrote:
> On Tue, Aug 29, 2017 at 10:20:30AM +0200, Michael Haggerty wrote:
> 
>> Used a `packed_ref_store` transaction in the implementation of
>> `files_initial_transaction_commit()` rather than using internal
>> features of the packed ref store. This further decouples
>> `files_ref_store` from `packed_ref_store`.
> 
> Very nice to see these couplings going away.
> 
> Minor nit: s/Used/Use/ in the commit message.

Thanks; will fix.

Michael
