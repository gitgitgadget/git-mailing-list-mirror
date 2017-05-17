Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B123201A7
	for <e@80x24.org>; Wed, 17 May 2017 14:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754470AbdEQOVg (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 10:21:36 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:57010 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753341AbdEQOVf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 10:21:35 -0400
X-AuditID: 1207440d-dcfff70000000e33-b2-591c5c6d4a15
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 9E.82.03635.D6C5C195; Wed, 17 May 2017 10:21:33 -0400 (EDT)
Received: from [192.168.69.190] (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HELUAR007680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 10:21:31 -0400
Subject: Re: [PATCH 05/23] refs_ref_iterator_begin(): don't check prefixes
 redundantly
To:     Jeff King <peff@peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <c9e1d561825a63630a09a2815b9b296c9e4bd1f5.1495014840.git.mhagger@alum.mit.edu>
 <20170517125947.npk4x65e2wqwqvkh@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <cf706fbc-98aa-ef0a-e2e2-4ecda7fd5366@alum.mit.edu>
Date:   Wed, 17 May 2017 16:21:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170517125947.npk4x65e2wqwqvkh@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqJsbIxNpcPCvtsXaZ3eYLLqudDNZ
        NPReYbZY8vA1s0X3lLeMFj9aepgtNm9uZ3Fg99g56y67x4JNpR5d7UfYPJ717mH0uHhJ2ePz
        JrkAtigum5TUnMyy1CJ9uwSujD0/FQo2sld03jrK3MD4nbWLkZNDQsBEoqXhEJDNxSEksINJ
        Yk3/PSjnHJPEsuNn2UGqhAUiJD5MvQ1miwjISnw/vJERougQo8SeszuZQBLMApuYJLaetQex
        2QR0JRb1NIPFeQXsJW6/uM0MYrMIqEpsO/MALC4KNPRh5y52iBpBiZMzn7CA2JwCLhIfTm9m
        hpipLvFn3iUoW15i+9s5zBMY+WchaZmFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JS
        i3SN9HIzS/RSU0o3MULCnHcH4/91MocYBTgYlXh4IwJkIoVYE8uKK3MPMUpyMCmJ8u5/IB0p
        xJeUn1KZkVicEV9UmpNaDPQ6B7OSCK9YBFA5b0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2
        ampBahFMVoaDQ0mC91QUUKNgUWp6akVaZk4JQpqJgxNkOA/Q8M8gNbzFBYm5xZnpEPlTjLoc
        c+59fc8kxJKXn5cqJc57CaRIAKQoozQPbg4sPb1iFAd6S5jXNhqoigeY2uAmvQJawgS0pBnk
        O97ikkSElFQDY/tWd4ZTe0M8Ty18Hxqw5FKwX5LrkitTzePzOs5Zb3tubK+4XHLv9TDHp05S
        fs46V/va7Z9nlP/Zx//686sCk5LOd/3bmdZ1/2cxm/Wo+0uOzIlV/AosmVxFNzM3vw9TyOvg
        51hcd27S/Kuzw6ZkB97m1upia6y57Nrb69x9aL7bxeBG0x59JZbijERDLeai4kQAr7gQ3ioD
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17/2017 02:59 PM, Jeff King wrote:
> On Wed, May 17, 2017 at 02:05:28PM +0200, Michael Haggerty wrote:
> 
>> The backend already takes care of the prefix. By passing the prefix
>> again to `prefix_ref_iterator`, we were forcing that iterator to do
>> redundant prefix comparisons. So set it to the empty string.
> 
> Hmm. So givne a refname like "refs/heads/foo" and a prefix like
> "refs/heads/", would we trim down to "foo" and then further try to
> remove "refs/heads" again?

No, the prefix is used to choose which references to let through and the
trim value is then used to munge the refname. They are orthogonal,
though AFAIK the trim value is always set to 0 or to strlen(prefix).

`refs->be->iterator_begin()` only has the `prefix` feature; it doesn't
trim anything. So we can rely on it to discard the references that
aren't in `prefix`. All we need the `prefix_ref_iterator` for is the
trimming.

Michael

