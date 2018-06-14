Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 676BD1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 12:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964807AbeFNMxH (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 08:53:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:37597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755208AbeFNMxG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 08:53:06 -0400
Received: from [192.168.0.108] ([185.137.153.123]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MJWAZ-1fVNgx2rDX-0035Ts for
 <git@vger.kernel.org>; Thu, 14 Jun 2018 14:53:04 +0200
To:     git@vger.kernel.org
From:   Juan Navarro <juan.navarro@gmx.es>
Subject: (Bug report + fix) gitk "IgnCase" search doesn't ignore case
Message-ID: <fc6b89c5-f0be-97c8-b0e1-247d9dd3e1f0@gmx.es>
Date:   Thu, 14 Jun 2018 14:53:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------4A7B6D04778B46F56C6EA6D0"
Content-Language: en-US
X-Provags-ID: V03:K1:zqE6KkhXTyxt71HB31cydoGzbGMCedIiAltEhY7+gJbylc7nvIH
 loaT4Vnsagr8hl4Oe1tNq+d9UG6jVgKl5uAuoy0fxonSXS1rRo7quUPqsbwd2cIaikjDxfJ
 xYQllLdbgiD/SufK8Rn5Sm3VYC0oXsS4J5FPhANDeHU93yFPrGs6Cvgys6Hsgyyax882qDR
 Sva1x7DCJQF+oHHBHKWAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jhjiFn27jvE=:yjw41c5rq1v5skwx0k6ga+
 oFHe7fw1h2OpbnNYeXzcGRCkE5A1rDu5YN2K0EMwUFt30rxK9s+bJOeb0x0//6FS/xgKyu0ji
 IzQRizEFzbdfv64bwZs8uCPEprEb6YHy34YB3C3njiWV0qpbkOvelDYG2pQmvD+0kxhNF1XqB
 kTIU4dBtD/SVkOgGt5WlhUiWELd9Bf2PZ2F7c0iN+qn0O5yNFE3WDTNjjc2FTEe3V99iV3YMQ
 pxkwqu+CbM8sCccYIbaikYwam8qHxM++b8dYZtnZH0CNGn04z8Nlx4ViI1SJTTYIXUYVnr43E
 1XRQbUAHw76YkG2hfiU3e4NFFBelF94YBGGCAi1n23gU83Op7kd5O/E3LktqXXMuzgQMsbJaq
 dn2vGf1UN75NmvTCumMIOGSFzRLv1V9mD3cxM7MQMOHYyBu1a88fXrU3o3tX5hQYzGzK5w6T4
 7cqCV/YoNSeRgotnhaOhUgApPpggotxCt+FHqq1y+QE5+t5J3008pmWABpEJZRiHOoEokMmIc
 h2C2OL96eSgHiMWpCj8CuarDEARG3wUH1avKgyJrPUsNUVRWx1iXn9NunzMOhx1tA+05dMj7f
 3jp8fyO0EiqoOuB+T+kiP4aSzh6D7xQDThAq0otte2NZXLrCVoLJyhRXoyt0AKNIIKVenl9y8
 scZO/H+v4edWAZFslWtWnIHYoA/dUE0gKKOz9rKY/tRUuW9RHo43qiMakU82UFpiKpvRAA0NS
 cXpB8Hse4toT6xnnJdiK3XVuYfQmLT6AgF+leXoJEPGVVlMJZnB1YXUHhBs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------4A7B6D04778B46F56C6EA6D0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this question was originally posted on the Google Groups list, trying to 
get help 
(https://groups.google.com/d/topic/git-users/QAFKOQU4eUo/discussion).
Now that it's confirmed as a bug and I have a proposed solution, I'm 
posting here.

Gitk "find commit" search function doesn't follow the "IgnCase" option 
that is selectable with a combo selector on the right side of the 
window; it should be searching in a case-insensitive way, but it doesn't.

Steps to reproduce:
1. Clone any repo. I'm right now using 
https://github.com/Kurento/kms-core.git 
<https://github.com/Kurento/kms-core.git>
2. cd into the repo and launch gitk
3. In the "Find commit" bar, select "changing lines matching"
4. In the right side of the same bar, select "IgnCase"
5. Search for a term that you know exists in uppercase, but write the 
search in lowercase. In my example, I'm searching for "leaky_time".
6. No search results appear.
7. Change your search word to uppercase.
8. Some search results appear, thus proving that the search is being 
done case-sensitive.

The command that gets called when searching is in lines 4804 & 4809 
(https://github.com/git/git/blob/master/gitk-git/gitk#L4804 
<https://github.com/git/git/blob/master/gitk-git/gitk#L4804>):
git diff-tree -r -s --stdin -G<SearchTerm>

Proposed solution is almost trivial: check if the "IgnCase" option is 
enabled, and in that case add the flag "-i" to the git command. Now that 
we are at it, it's probably correct to add that option to all search modes.
A diff is attached to this email, hoping that someone is able to apply 
it (sorry I'm not familiarized with contributing with patch files, but 
the diff is pretty small anyways).

Regards,
Juan

--------------4A7B6D04778B46F56C6EA6D0
Content-Type: text/x-patch;
 name="gitk-igncase.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="gitk-igncase.diff"

4809c4809,4815
<     set cmd [concat | git diff-tree -r -s --stdin $gdtargs]
---
> 
>     set igncase_arg ""
>     if {$findtype eq [mc "IgnCase"]} {
>         set igncase_arg "-i"
>     }
> 
>     set cmd [concat | git diff-tree $igncase_arg -r -s --stdin $gdtargs]

--------------4A7B6D04778B46F56C6EA6D0--
