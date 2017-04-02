Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FAF820964
	for <e@80x24.org>; Sun,  2 Apr 2017 05:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751024AbdDBFgF (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 01:36:05 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57740 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750944AbdDBFgC (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 2 Apr 2017 01:36:02 -0400
X-AuditID: 12074412-4a3ff70000000b04-68-58e08dbf1066
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 02.E1.02820.FBD80E85; Sun,  2 Apr 2017 01:36:00 -0400 (EDT)
Received: from [192.168.69.190] (p4FEDFC76.dip0.t-ipconnect.de [79.237.252.118])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v325ZtYk026518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 2 Apr 2017 01:35:57 -0400
Subject: Re: [PATCH v6 4/5] dir_iterator: refactor state machine model
To:     "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <1491107726-21504-1-git-send-email-bnmvco@gmail.com>
 <1491107726-21504-5-git-send-email-bnmvco@gmail.com>
 <CAEA2_RJuxw+sZ0CABCfTMnY+Wy5KD2totG76FDWfpH1Uht2taw@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <235ce437-9f87-e309-cec4-8214bb76b47f@alum.mit.edu>
Date:   Sun, 2 Apr 2017 07:35:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CAEA2_RJuxw+sZ0CABCfTMnY+Wy5KD2totG76FDWfpH1Uht2taw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42IRYndR1D3Q+yDCoPWHjcXjT2/ZLLqudDNZ
        NPReYbbonvKW0eJHSw+zxebN7SwObB47Z91l91iwqdTjWe8eRo+Ll5Q9Pm+SC2CN4rJJSc3J
        LEst0rdL4Mr4sHQ9U8FM4YqHG0saGKfydzFyckgImEj86mtl6mLk4hAS2MEkMXfmZDYI5zyT
        xM0r/awgVcICbhKfmvawgNgiAukSBw+sBIsLCexjlFizyBSkgVmgj1Gibc9NdpAEm4CuxKKe
        ZiYQm1fAXqL/QhMbiM0ioCIx/1AvI4gtKhAiMWfhA0aIGkGJkzOfgC3gFAiUWPlnLdgcZgF1
        iT/zLjFD2PIS29/OYZ7AyD8LScssJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRr
        ppebWaKXmlK6iRES0kI7GNeflDvEKMDBqMTD6/HifoQQa2JZcWXuIUZJDiYlUd7vxfcihPiS
        8lMqMxKLM+KLSnNSiw8xSnAwK4nw1j4BKudNSaysSi3Kh0lJc7AoifP+XKzuJySQnliSmp2a
        WpBaBJOV4eBQkuCt7nkQISRYlJqeWpGWmVOCkGbi4AQZzgM0/BxIDW9xQWJucWY6RP4Uo6KU
        OO/0bqCEAEgiozQPrheWcl4xigO9Isx7C6SdB5iu4LpfAQ1mAhps8fUuyOCSRISUVANjgPtR
        wejKY1N7lp8NvCtnen5HV6nnhvavvH7vGe/4HzwtbD7l+bxt2oK1s4+9f6TYIvo4Z3VMKX8K
        52nBrgRjr0LrGUbvHj7s/N0YHrX6dPjpvSy3D1okTvz3W7J1ltUlretv5/zlCDw1UW3aoaa8
        QPmtbvNTLpxaoPc7V2m2grrPPdnv1VZSSizFGYmGWsxFxYkAScNHkRQDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/02/2017 06:46 AM, Daniel Ferreira (theiostream) wrote:
> Gah, I just realized I failed to correct refs/files-backend.c's
> behavior and kept 0 instead of DIR_ITERATOR_PRE_ORDER_TRAVERSAL as its
> flag. I'll correct this on a v7, but I'll wait for the rest of your
> reviews before sending that revision.

Even if I make that change, a lot of tests fail, both when I run the
tests against your commit 4/5 and when I run them against 5/5.

I tested by applying your patch series to the current upstream master
branch. When I apply the patches, there is one conflict (related to
#includes), in entry.c. Maybe the failure is because you are working
from a different branch point. What commit are you branching your series
off of?

You should definitely run the full test suite against each of your
commits before you submit. One convenient way to do so is with my tool
`git-test` [1], which runs the tests and keeps track of their results to
avoid testing the same commit over and over again:

    # One-time setup (adjust the "-j" values based on what's
    # fastest on your computer):
    git test add "make -j8 && make -j16 test"

    # Run tests against a range of commits:
    git test run master..mybranch

Even better is to run the tests in a separate linked worktree, so that
you can continue working in your main repository while the tests are
running. The `git-test` README explains how.

It also speeds things up (and gives better output) if you use `prove` to
run the tests, and run the tests on a ramdisk if possible. To do so, I
include the following lines in my `config.mak`:

    TMP := /var/tmp
    ROOT := $(TMP)/git-tests-$(shell git rev-parse --show-toplevel |
sha1sum | head -c10)
    DEFAULT_TEST_TARGET = prove
    GIT_TEST_OPTS = -q --root=$(ROOT) --tee
    GIT_PROVE_OPTS = --timer --jobs 16 --state=fresh,hot,slow,save

(On my system `/var/tmp` is a ramdisk.)

Finally, when I submit a patch series, I usually also push a copy to my
GitHub fork of the project and include a reference to that branch in my
cover letter. That makes it easier for casual readers to fetch the code
and/or look at it online, and also makes it 100% clear what branch point
I've chosen. This is by no means obligatory but I find it helpful.

There doesn't seem to be much point reviewing broken code, so I'll wait
for your feedback and/or fix.

Michael

[1] https://github.com/mhagger/git-test

