Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30434202A0
	for <e@80x24.org>; Sun,  5 Nov 2017 05:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbdKEFgw (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 01:36:52 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:44753 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750730AbdKEFgw (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2017 01:36:52 -0400
X-AuditID: 1207440f-a5bff70000007960-56-59fea37140ed
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 42.74.31072.173AEF95; Sun,  5 Nov 2017 01:36:50 -0400 (EDT)
Received: from [192.168.69.190] (p4FC6E019.dip0.t-ipconnect.de [79.198.224.25])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id vA55ajK4011013
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 5 Nov 2017 01:36:47 -0400
Subject: Re: [PATCH 2/2] refs_resolve_ref_unsafe: handle d/f conflicts for
 writes
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Krey <a.krey@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>
References: <20171006143745.w6q2yfgy6nvd2m2a@sigill.intra.peff.net>
 <20171006144217.y6oxux26hh2fb7og@sigill.intra.peff.net>
 <38c17fdc-7a3b-d166-1abe-afe64fc823c5@alum.mit.edu>
 <20171006171623.kjzeavnzopowvqzv@sigill.intra.peff.net>
 <cae7028d-b92e-a7ca-6d33-713665848da3@alum.mit.edu>
Message-ID: <267a64d4-2551-e5ae-c289-5d9d21d217fb@alum.mit.edu>
Date:   Sun, 5 Nov 2017 06:36:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <cae7028d-b92e-a7ca-6d33-713665848da3@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsUixO6iqFu0+F+kwe6NUhbLjnUyWnRd6Way
        aOi9wmzRPeUto8WPlh5mB1aPnbPusnt8+Bjn8ax3D6PHxUvKHp83yQWwRnHZpKTmZJalFunb
        JXBlvPn2m7XgK0/F80evWRoYp3F1MXJySAiYSJx5f5MJxBYS2MEksfufeBcjF5B9jkni/rNV
        bCAJYYFgiflTGxhBbDYBXYlFPc1gDSICshLfD29kBGlgFjjJKHF8yjpGiO7FTBJLl74A6+AV
        sJd4+f8L0CQODhYBFYmfb/xATFGBCIkNG/khKgQlTs58wgJicwo4SGw78w9sL7OAusSfeZeY
        IWxxiVtP5jNB2PIS29/OYZ7AKDALSfssJC2zkLTMQtKygJFlFaNcYk5prm5uYmZOcWqybnFy
        Yl5eapGuiV5uZoleakrpJkZI2PPvYOxaL3OIUYCDUYmH94THv0gh1sSy4srcQ4ySHExKorxX
        Xv6JFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCqzUVqJw3JbGyKrUoHyYlzcGiJM6rvkTdT0gg
        PbEkNTs1tSC1CCYrw8GhJMHbuwioUbAoNT21Ii0zpwQhzcTBCTKcB2i4CUgNb3FBYm5xZjpE
        /hSjLsezma8bmIVY8vLzUqXEeY1BigRAijJK8+DmwNLVK0ZxoLeEeXNAqniAqQ5u0iugJUxA
        S2Zz/AFZUpKIkJJqYAww1hFnyowyKZwnFL1SRLxwz/ec2ekc5k7HZn+JmOnMvmuSwuePb84w
        9Tsvli6/HrXF8KN311rJHyzFU5ZPqVnEHP/18cQCz2VOh9/v832h8dvpyzsWceX9J433ti3l
        +CscGFepfMbKeEf9ujDvzff+zoi7Zqh1cWeFOM8L6VCv5XlrNzyvKVdiKc5INNRiLipOBADR
        HD59MgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/07/2017 06:36 AM, Michael Haggerty wrote:
> On 10/06/2017 07:16 PM, Jeff King wrote:
>> On Fri, Oct 06, 2017 at 07:09:10PM +0200, Michael Haggerty wrote:
>>
>>> I do have one twinge of uneasiness at a deeper level, that I haven't had
>>> time to check...
>>>
>>> Does this patch make it easier to *set* HEAD to an unborn branch that
>>> d/f conflicts with an existing reference? If so, that might be a
>>> slightly worse UI for users. I'd rather learn about such a problem when
>>> setting HEAD (when I am thinking about the new branch name and am in the
>>> frame of mind to solve the problem) rather than later, when I try to
>>> commit to the new branch.
>>
>> Good question. The answer is no, it's allowed both before and after my
>> patch. At least via git-symbolic-ref.
>>
>> I agree it would be nice to know earlier for such a case. For
>> symbolic-ref, we probably should allow it, because it's plumbing that
>> may be used for tricky things. For things like "checkout -b", you'd
>> generally get a timely warning as we try to create the ref.
>>
>> The odd man out is "checkout --orphan", which leaves the branch unborn.
>> It might be nice if it did a manual check that the ref is available (and
>> also that it's syntactically acceptable, though I think we may do that
>> already).
>>
>> But all of that is orthogonal to this fix, I think.
> 
> Thanks for checking. Yes, I totally agree that this is orthogonal.

I also just checked but there don't seem to be any docstrings that need
updating.

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

(both patches in this series).

Michael




