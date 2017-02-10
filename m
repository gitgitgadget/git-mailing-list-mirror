Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35D331FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 12:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbdBJMdP (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 07:33:15 -0500
Received: from mout.gmx.net ([212.227.15.19]:55117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751305AbdBJMdN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 07:33:13 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIMUZ-1cZ9i61ktD-004EHM; Fri, 10
 Feb 2017 13:24:21 +0100
Date:   Fri, 10 Feb 2017 13:24:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git-for-windows@googlegroups.com
cc:     git@vger.kernel.org
Subject: Continuous Testing of Git on Windows
Message-ID: <alpine.DEB.2.20.1702101241210.3496@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KFBxcI4XTm3LNc2MgRCJYWhkvV/ya2cDI30H1z2QJUyyZi/VlEl
 jf3WaJhcLSnUzyyDrXvEf5QJPZ77bxxCKPyxydbLXlKSSy1n8HuqMBeHVqEPCFBjxnlSIJU
 cx9PDGYL9+qseo8WcJAkAOt1LM7Q5Cptvz1UYykO7JPlx1YEgPwbXpO0EglTIzpPpBWmhXH
 iHoYNgUndU4dWzYn3TfwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uVBmC6saMTg=:0Xykt+V0v7hhKDWPb/yovz
 IMTUhpcl16DKEHycKKOiJBn90MORy8AsfssvpUvoLiZp501aBppvCpcEgjQgSq5Q077hQYQ10
 jlO94n796Hb/bfZD36XHEJUDPi9Rjg24Br1izyNwpqTg9Fq1ZeA+z8u4rUKhgbNPef8nYOsYO
 B1MnlhVFPOer/7MFf22PeR75LkvHN/ccyVmIyP1kPl+AghTaNGep40Be71ldJM3J/QxBAqCW8
 svoBGZ+HSRRjZnetEVGI0BglYxTkql0wXbUWCMtqMy49AhaxfDsMpPnklJA7fzxyJ64XUEXYx
 X/wiKdtXf2wTExHFLeKhKJ9j8Z7QJS4f6+8+TEg8Q2W/aB6pautDFI4J3mb4Pm8KcAX4rO0DI
 /GnzWjTzhH42NQkfOIrtP8dRbD1eehZ8/waXeempJCDKibvbJ0s4AcvSirFEJtVjlfQ8M+7R1
 lohwe2Ysv4yLdBhBa9aJpdQUfCrGzJ8nW/xXCGY2F1i0RrEUNwCwKRQQVRcSsimaXLj4pCOgG
 JL2gOHNLlIPF+AzQtRsV6Qog6wT26E1G3aGeipuT5yhd9vX3dmq61BGLeamxdHcW+YzJwQU7L
 yN0Giq8boCXni06izTEo0cnyFIKSEzpBDgSigBlRpjFktvKM9axxpsmgSiQRIrkw32lBnn13t
 fJ6Ev0tTfHwqeQzHiDMzKI0zrgGFto7Gfh+8zO0k8bL44ZbChfPYq9ThN/W+IhqARd1lhVuLW
 z18nifTzsF4mJMIkH5nYpGWMXgybv0XOX1WKWSGeWV13421mFG4AJEwDiMMqGYxLugXDdYQNo
 caKJmCd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

at the GitMerge conference, I heard a couple of times "I do not bother
reporting bugs in `pu` or `next` on MacOSX and Windows anymore, only Linux
seems to be truly supported" or some variation thereof.

This is a strong indicator that we have some room for improvement here.

Active readers of the Git mailing list will not be surprised to read that
I think we have to react to build/test failures quicker, that it is not
enough to declare it okay for those integration branches to fail the test
suite or even to fail to build[*1*].

In that vein, I worked quite a bit on "Continuous Integration", or more
appropriately: Continuous Testing. That is, I created an ensemble of jobs
that build & test the four integration tests of upstream Git (`maint`,
`master`, `next` and `pu`) to verify the *basic* validity of their
respective current revisions.

Most CI integrations these days require custom configuration files to be
committed, and certain knobs to be twisted on GitHub (which I cannot turn
because I have no special privileges on git/git). After struggling with
making it work *somehow* anyway (even trying to get in touch with Travis,
but they have not bothered to reply to my requests in over a year...), I
decided to go with the Visual Studio Team Services (or short, VSTS; it
does come in handy that it is developed by distant colleagues of mine, so
they *have* to reply to my requests) where the CI configuration can be
separated from the source code.

The entire setup is a little bit more complex than your grandfather's CI
setup: it has to orchestrate five separate Git repositories, two of them
generated and updated from live 32/64-bit Git for Windows SDKs, using a
custom pool of build agents due to high resource demands, using three
separate Git for Windows installations to support 32/64-bit as well as
updating git.exe via `git pull`[*2*].

There is currently only one downside to that setup: the ability to have
publicly accessible build logs on VSTS is still in development.

This is not *such* a big downside: if the MacOSX/Linux CI based on
Travis[*3*] is any indicator, few people, if any, give a flying,
fornicating fly about public build logs.

However, we should strive to improve our software development practices,
and one such well-known Best Practice is to use Continuous Testing more
effectively, i.e. *not* to ignore it.

That is why I taught the Git for Windows CI job that tests the four
upstream Git integration branches to *also* bisect test breakages and then
upload comments to the identified commit on GitHub. See an example here
(the identified breakage seems to have disappeared in the meantime):

https://github.com/git/git/commit/5a12b3d76973#commitcomment-20802488

The code that generates this comment can be seen here:

https://github.com/git-for-windows/build-extra/blob/50c392c7d107/please.sh#L1648-L1665

So here is hoping to a quicker turnaround from breakage to fix in the
future!

Ciao,
Johannes

P.S.: I realize that these commit comments may *still* be ignored, but I
simply was not yet ready to annoy everybody by having automated mails sent
out.

Footnote *1*: It would be kind of okay if, say, `pu` would simply pick up
*all* patches so that they would not be forgotten. But that is not the
case. Even worse: it was stated recently that the expectation is that the
*submitters* of patches find bugs in their code, that the patches should
essentially be bug-free by the time they were submitted. This reasoning
falls flat on its face considering the very real failures, of course,
demonstrating our dear need for Continuous Testing.

Footnote *2*: I will describe the entire setup, including links to the
involved repositories, in a separate mail at a later stage.

Footnote *3*: Look at https://travis-ci.org/git/git/builds, and be happy
if you have a red/green deficiency so you cannot see all that red.
