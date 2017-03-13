Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 284C720373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbdCMUsM (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:48:12 -0400
Received: from fester.cwi.nl ([192.16.191.27]:38080 "EHLO fester.cwi.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753213AbdCMUsL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:48:11 -0400
Received: from mail.cwi.nl (zwebmail.cwi.nl [194.187.76.178])
        by fester.cwi.nl (8.14.4/8.12.3) with ESMTP id v2DKm1Q7025560;
        Mon, 13 Mar 2017 21:48:01 +0100
Received: from mail.cwi.nl (localhost [127.0.0.1])
        by mail.cwi.nl (Postfix) with ESMTPS id 7C6803C0542;
        Mon, 13 Mar 2017 21:47:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.cwi.nl (Postfix) with ESMTP id 6E3583C03F7;
        Mon, 13 Mar 2017 21:47:56 +0100 (CET)
Received: from mail.cwi.nl ([127.0.0.1])
        by localhost (mail.cwi.nl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AB2FPrTRRQqK; Mon, 13 Mar 2017 21:47:56 +0100 (CET)
Received: from mail.cwi.nl (mail.cwi.nl [194.187.76.178])
        by mail.cwi.nl (Postfix) with ESMTP id 246F83C03B5;
        Mon, 13 Mar 2017 21:47:55 +0100 (CET)
Date:   Mon, 13 Mar 2017 21:47:54 +0100 (CET)
From:   Marc Stevens <Marc.Stevens@cwi.nl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Dan Shumow <danshu@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <161775901.3349663.1489438074825.JavaMail.zimbra@cwi.nl>
In-Reply-To: <CA+55aFyNi2uHwd9nzjy3dOu2L1A0jPN6AD43WKj-05km1GNtRQ@mail.gmail.com>
References: <20170301195302.3pybakmjqztosohj@sigill.intra.peff.net> <CY1PR0301MB2107112BCC2DECD215E70549C42A0@CY1PR0301MB2107.namprd03.prod.outlook.com> <20170313151322.ouryghyb5orkpk5g@sigill.intra.peff.net> <CY1PR0301MB2107B3C5131D5DC7F91A0147C4250@CY1PR0301MB2107.namprd03.prod.outlook.com> <CY1PR0301MB2107876B6E47FBCF03AB1EA1C4250@CY1PR0301MB2107.namprd03.prod.outlook.com> <20170313194848.2z2dlgpomu6e3dkh@sigill.intra.peff.net> <1e6a592f-7da1-8043-0b29-0bb7c8cda3f3@cwi.nl> <CA+55aFyNi2uHwd9nzjy3dOu2L1A0jPN6AD43WKj-05km1GNtRQ@mail.gmail.com>
Subject: Re: [PATCH] Put sha1dc on a diet
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [84.31.180.140]
X-Mailer: Zimbra 8.6.0_GA_1162 (ZimbraWebClient - GC57 (Win)/8.6.0_GA_1162)
Thread-Topic: Put sha1dc on a diet
Thread-Index: h+7Ny8eb57MAqntSDzCakiPzG0pC3g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus:
I would be surprised, the dependencies should be automatically determined.

BTW Did you make local changes to this perf branch?
Specifically did you disable the safe hash mode that is on by default?
Because if you did not, it might also be something else as all three hashes below are the same.

-- Marc

----- Original Message -----
From: "Linus Torvalds" <torvalds@linux-foundation.org>
To: "Marc Stevens" <marc.stevens@cwi.nl>
Cc: "Jeff King" <peff@peff.net>, "Dan Shumow" <danshu@microsoft.com>, "Junio C Hamano" <gitster@pobox.com>, "Git Mailing List" <git@vger.kernel.org>
Sent: Monday, March 13, 2017 9:20:02 PM
Subject: Re: [PATCH] Put sha1dc on a diet

On Mon, Mar 13, 2017 at 1:12 PM, Marc Stevens <marc.stevens@cwi.nl> wrote:
> Indeed, I've committed a fix, and a small bug fix for the new code just now.

Unrelated side note: there may be some missing dependencies in the
build infrastructure or something, because when I tried Jeff's script
that did that "test the merge and the two parents", and used the
pack-file of the kernel for testing, I got:

  5611971c610143e6d38bbdca463f4c9f79a056a0
/home/torvalds/v2.6/linux/.git/objects/pack/pack-153bb8cd11846cf9a27ef7b1069aa9cb9f5b724f.pack

  real 0m2.432s
  user 0m2.348s
  sys 0m0.084s

  5611971c610143e6d38bbdca463f4c9f79a056a0
/home/torvalds/v2.6/linux/.git/objects/pack/pack-153bb8cd11846cf9a27ef7b1069aa9cb9f5b724f.pack

  real 0m3.747s
  user 0m3.672s
  sys 0m0.076s

  5611971c610143e6d38bbdca463f4c9f79a056a0 *coll*
/home/torvalds/v2.6/linux/.git/objects/pack/pack-153bb8cd11846cf9a27ef7b1069aa9cb9f5b724f.pack

  real 0m5.061s
  user 0m4.984s
  sys 0m0.077s

never mind the performace, notice the *coll* in that last case.

But doing a "git clean -dqfx; make -j8" and re-testing the same tree,
the issue is gone.

I suspect some dependency on a header file is broken, causing some
object file to not be properly re-built, which in turn then
incorrectly causes the 'ctx2.found_collision' test to test the wrong
bit or something.

                 Linus
