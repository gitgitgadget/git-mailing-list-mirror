Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 563712018A
	for <e@80x24.org>; Fri,  1 Jul 2016 17:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbcGAREj (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 13:04:39 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43122 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752201AbcGAREh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2016 13:04:37 -0400
X-AuditID: 12074412-0b3ff7000000491f-35-5776a2a35b7d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id E3.6C.18719.3A2A6775; Fri,  1 Jul 2016 13:04:36 -0400 (EDT)
Received: from [192.168.69.130] (p508EA4A4.dip0.t-ipconnect.de [80.142.164.164])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u61H4VZG014440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 1 Jul 2016 13:04:32 -0400
Subject: diff heuristics dramatically improved by considering line indentation
 and blank lines
To:	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
References: <20160616174620.1011-1-sbeller@google.com>
 <20160617153637.GA9314@sigill.intra.peff.net>
 <CAGZ79kZgdbqnWW9uqeBHNDbyGVfc0x5gTJbyD0Nyi1i3SNvENQ@mail.gmail.com>
 <576C1803.5050905@alum.mit.edu> <57752478.1000302@alum.mit.edu>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <5776A29F.4020609@alum.mit.edu>
Date:	Fri, 1 Jul 2016 19:04:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
MIME-Version: 1.0
In-Reply-To: <57752478.1000302@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsUixO6iqLtkUVm4wcGf4hZdV7qZLBp6rzBb
	7F7cz2zxd888NosfLT3MFotuHWC1+Pj+PZvFuQu9zBabN7ezOHB6LJz1nMVj56y77B4LNpV6
	POvdw+hx8ZKyx+dNcgFsUdw2SYklZcGZ6Xn6dgncGeee6hR8l6pYffc8SwPjecEuRk4OCQET
	ieWr1zB3MXJxCAlsZZTY0jGRFcI5zyTRvvsSE0iVsECCRP/Mb8wgtoiAo8SLZwvZIYreM0o8
	P9zEBOIwC/QwSqzd+ZENpIpNQFdiUU8zWDevgLbErz2LwOIsAioSM+c8B4uLCoRInF+3lRWi
	RlDi5MwnLCA2p4COxLZ7EL3MAuoSf+ZdYoaw5SW2v53DPIGRfxaSlllIymYhKVvAyLyKUS4x
	pzRXNzcxM6c4NVm3ODkxLy+1SNdMLzezRC81pXQTIyT8hXYwrj8pd4hRgINRiYdXYHZpuBBr
	YllxZe4hRkkOJiVRXpfpZeFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHgFgFEnxJuSWFmVWpQP
	k5LmYFES5/25WN1PSCA9sSQ1OzW1ILUIJivDwaEkwft9IVCjYFFqempFWmZOCUKaiYMTZDiX
	lEhxal5KalFiaUlGPCgq44uBcQmS4gHaexyknbe4IDEXKArReopRl+PI/ntrmYRY8vLzUqXE
	eZ+CFAmAFGWU5sGtgCW7V4ziQB8L8zKBvMADTJRwk14BLWECWsJcWgyypCQRISXVwKinc/3n
	Fg5VprnBs0KEr5+30pIJtue/8qd5pdr8lKSlk8/quq1z+f6X/WtNT8wak6CLh4r7JPt5ph+L
	C+pt8HkvnnL/s+yXwnqZzUYv9mTLG0kHJ3Y5q3DG9i5nZGw69UV6jvTW6aH+j3kf7zM/56xc
	9Vm80OKAYBRfJYeDwxnbu+u9Di9dpMRSnJFoqMVcVJwIAJtEkUdRAwAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/30/2016 03:54 PM, Michael Haggerty wrote:
> On 06/23/2016 07:10 PM, Michael Haggerty wrote:
>> On 06/17/2016 06:09 PM, Stefan Beller wrote:
>>> I think before spending more time on discussing and implementing new
>>> (hopefully better) heuristics, I'd want to step back and try to be a bit more
>>> systematic, i.e. I'll want to collect lots of test cases in different languages
>>> and use cases. A mini test suite, maybe?
>>
>> Stefan,
>>
>> I've also been playing around with diff heuristics and also trying to
>> find some good test data. Have you put together some test cases yet?
> 
> I put quite of work into tooling to evaluate diff heuristics, and just
> published it on GitHub:
> 
>     https://github.com/mhagger/diff-slider-tools

Today I hand-optimized about 2700 diff sliders in 12 different
repositories and used that as a reference corpus against which I tested
the accuracy of four different algorithms. The tools and the
hand-optimized values are now in the GitHub repository mentioned above.
See also this pull request [1].

If I didn't make any mistakes, the number of errors (i.e., cases where
the algorithm choose a different slider shift than the one I picked by
hand) look like this:

> | repository           | default | compaction | indent | indent-favor-edges |
> | -------------------- | ------- | ---------- | ------ | ------------------ |
> | ant                  |     225 |        102 |      7 |                  7 |
> | bugzilla             |     208 |         81 |     14 |                 14 |
> | couchdb              |      44 |         24 |     13 |                 10 |
> | docker               |     180 |        160 |     29 |                 18 |
> | git                  |     446 |         59 |     27 |                 19 |
> | ipython              |     358 |        163 |     61 |                 11 |
> | junit                |     146 |         67 |      5 |                  5 |
> | nodejs               |     489 |         78 |     12 |                 12 |
> | phpmyadmin           |     330 |         49 |      1 |                  0 |
> | test-more            |      15 |          2 |      2 |                  0 |
> | test-unit            |      33 |         13 |      4 |                  4 |
> | -------------------- | ------- | ---------- | ------ | ------------------ |
> | totals               |    2474 |        798 |    175 |                100 |

The algorithms are:

* default -- the default behavior `git diff` on the current master
* compaction -- `git diff --compaction-heuristic`
* indent -- the indent-based algorithm as reported earlier in
  this thread
* indent-favor-edges -- the indent-based algorithm, with some
  improved heuristics regarding sliders near the begin/end of file
  and probably one or two fixes

I encourage other people to run the tests against some code samples in
their favorite programming languages so that the testing can cover a
wider range of inputs, and submit your data to the GitHub project. Also
feel free to tweak the heuristic (there's probably still room for
improvement). All the tools and raw data for my experiments are already
there.

I'll be going on vacation for the next two weeks so I probably can't
follow up on this for a while. But I think we should build an algorithm
like this into Git!

Michael

[1] https://github.com/mhagger/diff-slider-tools/pull/1

