Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACBFC43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 15:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbiFIPFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 11:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiFIPFv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 11:05:51 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC321DF139
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 08:05:50 -0700 (PDT)
Received: (qmail 11207 invoked by uid 109); 9 Jun 2022 15:05:49 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jun 2022 15:05:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Thu, 9 Jun 2022 11:05:49 -0400
From:   Jeff King <peff@peff.net>
To:     Tassilo Horn <tsdh@gnu.org>
Cc:     Tao Klerks <tao@klerks.biz>, git@vger.kernel.org
Subject: Re: [BUG?] Major performance issue with some commands on our repo's
 master branch
Message-ID: <YqIMTYR2wM8iZCUN@coredump.intra.peff.net>
References: <87h750q1b9.fsf@gnu.org>
 <CAPMMpohzqKo-+q-tOcXymmzGxuOY-mf2NPRviHURm8-+3MPjZg@mail.gmail.com>
 <87y1yb2xc8.fsf@gnu.org>
 <YqEyh5opAaJxph2+@coredump.intra.peff.net>
 <87mtembcjl.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mtembcjl.fsf@gnu.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 09, 2022 at 07:51:36AM +0200, Tassilo Horn wrote:

> > So probably setting diff.renamelimit correctly is not that bad a
> > solution.
> 
> Does your statement imply diff.renameLimit = 10000 is an incorrect
> setting?  The thing is that I mostly work with java codebases where
> every file rename implies a change in file contents, too.  A large
> renameLimit seems to help in correctly detecting renames/copies although
> I don't have empirical data but only gut feeling.

Well, for some definition of incorrect. :) You are telling Git to spend
extra time computing renames, and then you were annoyed when it spent a
long time computing renames. So in that sense it was not what you
wanted.

It may be that you want different limits in different contexts, and the
current config is not sufficient to express that.

-Peff
