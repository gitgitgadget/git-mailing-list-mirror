Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B0DE20951
	for <e@80x24.org>; Fri, 17 Mar 2017 13:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbdCQNvu (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 09:51:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:45901 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751018AbdCQNvu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 09:51:50 -0400
Received: (qmail 31828 invoked by uid 109); 17 Mar 2017 13:51:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 13:51:47 +0000
Received: (qmail 3133 invoked by uid 111); 17 Mar 2017 13:51:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 09:51:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Mar 2017 09:51:44 -0400
Date:   Fri, 17 Mar 2017 09:51:44 -0400
From:   Jeff King <peff@peff.net>
To:     Okash Khawaja <okash.khawaja@gmail.com>
Cc:     stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
Subject: Re: Viewing untracked+stashed files in git stash show
Message-ID: <20170317135144.scnbtyug2cqbg77p@sigill.intra.peff.net>
References: <CAOtcWM3mrQEqDnjMipzea7Kp+VueBFsZDL2zcJ=y0wgj9N4Vjw@mail.gmail.com>
 <295db01e-6252-6acc-88d8-d2f366397ea0@atlas-elektronik.com>
 <CAOtcWM1jExsj_L4HRm194F57bt9LPuf8fFSpyuGWiPG7U_4v8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOtcWM1jExsj_L4HRm194F57bt9LPuf8fFSpyuGWiPG7U_4v8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 09:50:29AM +0000, Okash Khawaja wrote:

> Hi,
> 
> On Fri, Mar 17, 2017 at 8:20 AM,  <stefan.naewe@atlas-elektronik.com> wrote:
> > Am 16.03.2017 um 17:34 schrieb Okash Khawaja:
> >> Hi,
> >>
> >> If you have some untracked files and your run `git stash -u`. Then
> >> `git stash show` doesn't show the untracked files. Is there a flag
> >> that can be passed to git stash show to report untracked files?
> >
> > Not for 'git stash' but you can use 'git show stash@{0}^3
> 
> Okay that's fine as long as you know. But the first thing that comes
> to your mind is that you've lost those untracked files. Is there a
> reason why git stash show doesn't show those files?

No, I don't think there is a good reason. The "untracked" option was
added to git-stash much later, and nobody considered how it interacted
with "stash show".

Changes from the index have the same problem. Probably "stash show"
should have options "--index" and "--untracked" to show:

  # index
  git diff $stash^1 $stash^2

  # untracked
  git diff $stash^1 $stash^3

Possibly it should even show those by default when they are non-empty.

-Peff
