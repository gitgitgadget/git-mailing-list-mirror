Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44CDE1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 14:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbdBIOoP (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 09:44:15 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:48607 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752383AbdBIOoP (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2017 09:44:15 -0500
X-AuditID: 1207440f-d47ff700000009a2-1c-589c803bf486
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 85.96.02466.B308C985; Thu,  9 Feb 2017 09:44:12 -0500 (EST)
Received: from [192.168.69.190] (p4FEDF6A1.dip0.t-ipconnect.de [79.237.246.161])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v19EiAHC026800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 9 Feb 2017 09:44:11 -0500
Subject: Re: [RFD] should all merge bases be equal?
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <8a9b3f20-eed2-c59b-f7ea-3c68b3c30bf5@alum.mit.edu>
Date:   Thu, 9 Feb 2017 15:44:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqGvTMCfCoOkpr0XXlW4mi4beK8wO
        TB4XLyl7fN4kF8AUxWWTkpqTWZZapG+XwJXx/fwbloKzwhWv2vexNDBe4u9i5OCQEDCRuDAh
        qIuRi0NI4DKjxON785khnPNMEl9nHANyODmEBYwl3m1/A2aLCFhL/P75nQnEFhKwkjjfeJQV
        xGYT0JVY1NMMFucVsJeY/uQ5I4jNIqAi8a11GZgtKhAiMWfhA0aIGkGJkzOfsIDYnEAzey6t
        BOtlFtCT2HH9FyuELS+x/e0c5gmMfLOQtMxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJ
        eXmpRbomermZJXqpKaWbGCFBx7+DsWu9zCFGAQ5GJR7eFzVzIoRYE8uKK3MPMUpyMCmJ8soW
        AIX4kvJTKjMSizPii0pzUosPMUpwMCuJ8GpVAOV4UxIrq1KL8mFS0hwsSuK86kvU/YQE0hNL
        UrNTUwtSi2CyMhwcShK8rvVAjYJFqempFWmZOSUIaSYOTpDhPEDDU0BqeIsLEnOLM9Mh8qcY
        FaXEeY/VASUEQBIZpXlwvbCk8IpRHOgVYV5VkHYeYEKB634FNJgJaPD107NABpckIqSkGhhl
        708oN5jRvsP8UqpR6oT/Vx7X5YeHl+QsviJ6rFDqKfsh4Q+LTlvOV17+MokzVdd61cnJn+bz
        qMhXvzaZtvT7jMef0/axtitXzVzFUDrb6ZDEisuvJiTJvDF7xMr9Vde6vzzMMnyu9qwMs6qC
        vN2toq+y1I23C3/tk5CY6icr7z5lgUOj/B4lluKMREMt5qLiRACCYy7q5QIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/18/2016 12:28 AM, Junio C Hamano wrote:
> [...]
> Being accustomed how fast my merges go, there is one merge that
> hiccups for me every once in a few days: merging back from 'master'
> to 'next'.  [...]
> 
> The reason why this merge is slow is because it typically have many
> merge bases.  [...]

I overlooked this topic until just now :-(

I spent a lot of time looking at merge bases a couple of years ago [1],
originally motivated by the crappy diffs you get from

    git diff master...branch

when the merge base is chosen poorly. In that email I include a lot of
data and suggest a different heuristic, namely to define the "best"
merge base $M to be the one that minimizes the number of non-merge
commits between $M and either of the branch tips (it doesn't matter
which one you choose); i.e., the one that minimizes

    git rev-list --count --no-merges $M..$TIP

. The idea is that a merge base that is "closer" content-wise to the
tips will probably yield smaller diffs. I would expect that merge base
also to yield simpler merges, though I didn't test that. Relying on the
number of commits (rather than some other measure of how much the
content has been changed) is only a heuristic, but it seems to work well
and it can be implemented pretty cheaply.

We actually use an algorithm like the one I described at GitHub, though
it is implemented as a script rather than ever having been integrated
into git. And (for no particular reason) we include merge commits in the
commit count (it doesn't make much difference whether merges are
included or excluded).

Your idea to look at the first-parent histories of the two branch tips
is an interesting one and has the nice theoretical property that it is
based on the DAG topology rather than a count of commits. I'd be very
curious to see how the sizes of asymmetric diffs differ between your
method and mine, because for me smaller and more readable diffs are one
of the main benefits of better merge bases.

I would worry a bit that your proposed algorithm won't perform as well
for people who use less disciplined workflows than git.git or the Linux
kernel. For example, many people merge a lot more frequently and
chaotically, maybe even with the parents reversed from the canonical order.

Anyway, I mostly wanted to remind you of the earlier discussion of this
topic. There's a lot more information there.

Michael

[1] http://public-inbox.org/git/539A25BF.4060501@alum.mit.edu/

