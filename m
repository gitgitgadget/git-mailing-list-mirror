Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2700202A0
	for <e@80x24.org>; Mon,  6 Nov 2017 07:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbdKFHAj (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 02:00:39 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:64334 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750928AbdKFHAi (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2017 02:00:38 -0500
X-AuditID: 1207440e-be1ff70000007085-50-5a000893b2f2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 8B.B9.28805.398000A5; Mon,  6 Nov 2017 02:00:36 -0500 (EST)
Received: from [192.168.69.190] (p57BCCA7E.dip0.t-ipconnect.de [87.188.202.126])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id vA670UEB012876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 6 Nov 2017 02:00:33 -0500
Subject: Re: [PATCH v1 1/2] refs: extract function to normalize partial refs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Rafael_Ascens=c3=a3o?= <rafa.almas@gmail.com>,
        git@vger.kernel.org, me@ikke.info, hjemli@gmail.com,
        pclouds@gmail.com, ilari.liusvaara@elisanet.fi
References: <20171104004144.5975-1-rafa.almas@gmail.com>
 <20171104004144.5975-2-rafa.almas@gmail.com>
 <4dc4eefc-56b9-1b13-ae46-83a3af9c7ee3@alum.mit.edu>
 <xmqqwp34jj3h.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <1ae0c199-f0fe-4468-1481-c7217ef6cc11@alum.mit.edu>
Date:   Mon, 6 Nov 2017 08:00:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqwp34jj3h.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqDuFgyHK4OASTYuuK91MFg29V5gt
        ls56w2ixcs0eZotXHe2MFt1T3jJafDp4k8WB3WPl2VqPnbPusnv8uvuSzePiJWWPz5vkAlij
        uGxSUnMyy1KL9O0SuDI2vN7CVLCIteJX01LWBsY5LF2MnBwSAiYS7ZfXs3cxcnEICexgkrjY
        1c8C4Zxnkvi1ewobSJWwgI/E3QndYLaIgJrExLZDYN3MApsYJd7ezoRoOMco8WPDZ0aQBJuA
        rsSinmYmEJtXwF7i99bnrCA2i4CKxJSu2ewgtqhAhMTz5vesEDWCEidnPgEbyilgLdHfMYkN
        YoG6xJ95l5ghbHGJW0/mM0HY8hLb385hnsAoMAtJ+ywkLbOQtMxC0rKAkWUVo1xiTmmubm5i
        Zk5xarJucXJiXl5qka6xXm5miV5qSukmRkg88O1gbF8vc4hRgINRiYd3wZz/kUKsiWXFlbmH
        GCU5mJREea+8/BMpxJeUn1KZkVicEV9UmpNafIhRgoNZSYTXmYUhSog3JbGyKrUoHyYlzcGi
        JM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMErxQbUKFiUmp5akZaZU4KQZuLgBBnOAzT8BSvI
        8OKCxNzizHSI/ClGY44bD6//YeJ4NvN1A7MQS15+XqqUOO8ekFIBkNKM0jy4abCU9opRHOg5
        Yd4AkKU8wHQIN+8V0ComoFWzOYB+5C0uSURISTUwli0N4d548uTyI0VztJdOf7ee+zSv7NsT
        PLu+6Yokx52S7tnDbfD1NWdhXbvXWZ8VDQva2Lbyr8qRs3jSnFJ8e8bXx4xq+9u9su/u9WH9
        x8tnGsi51ty232T3a7W6OXWJfBs+/ly85byGmJxXAM+KJ9zChQtTey16OC+c/ezRF3uNNcz/
        y6L1SizFGYmGWsxFxYkAfvQ/SUQDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/06/2017 02:23 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> [1] I say "almost entirely" because putting them in one function means
>> that only `pattern` needs to be scanned for glob characters. But that is
>> an unimportant detail.
> 
> That could actually be an important detail, in that even if prefix
> has wildcard, we'd still append the trailing "/*" as long as the
> pattern does not, right?

That's correct, but I was assuming that the prefix would always be a
hard-coded string like "refs/tags/" or maybe "refs/". (That is the case
now.) It doesn't seem very useful to use a prefix like "refs/*/".

Michael
