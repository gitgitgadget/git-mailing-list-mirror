Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25FAC4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 17:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiLBRBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 12:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbiLBRBt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 12:01:49 -0500
Received: from cventin.lip.ens-lyon.fr (cventin.lip.ens-lyon.fr [140.77.13.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5274E331
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 09:01:47 -0800 (PST)
Received: from vlefevre by cventin.lip.ens-lyon.fr with local (Exim 4.96)
        (envelope-from <vincent@vinc17.net>)
        id 1p19Q0-00AnNw-0y;
        Fri, 02 Dec 2022 18:01:44 +0100
Date:   Fri, 2 Dec 2022 18:01:44 +0100
From:   Vincent Lefevre <vincent@vinc17.net>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
Subject: Re: git cherry-pick -x: missing blank line before the "cherry picked
 from commit" line
Message-ID: <20221202170144.GC5599@cventin.lip.ens-lyon.fr>
References: <20221202141153.GA5599@cventin.lip.ens-lyon.fr>
 <75e00d43-3184-dcf8-4621-cdf02c9f7320@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75e00d43-3184-dcf8-4621-cdf02c9f7320@dunelm.org.uk>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.2.9+50 (c79959e1) vl-149028 (2022-11-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 2022-12-02 16:41:23 +0000, Phillip Wood wrote:
> On 02/12/2022 14:11, Vincent Lefevre wrote:
> > With git 2.38.1 under Debian, when I use "git cherry-pick -x"
> > on a commit such that the last line of the log message starts
> > with "note:" (case insensitively), the blank line before the
> > "cherry picked from commit" line is missing.
> > 
> > For instance:
> > 
> >      New commit
> >      foo
> >      nOtE:
> >      (cherry picked from commit 3ba643e2eec4bdc1cd46b478ab36ee0707d241c2)
> 
> "git cherry-pick -x" takes care not to add a blank line if there are
> trailers such as Signed-off-by: at the end of the message (if it did then
> the trailers would no longer be recognized as trailers as they would not be
> the last paragraph). In this case the "nOtE:" line looks like a trailer and
> so no blank line is added.
> 
> I can see it is annoying in this case but I'm afraid I don't have any ideas
> of how we could avoid it without breaking the case where the message does
> contain trailers.

First, one issue is that this is not documented (I was not aware of
the notion of trailers, well, at least concerning a special handling
by Git).

Then perhaps there should be some configuration to define which
tokens are allowed (or forbidden) for trailers. For instance,
I would say that "Note" is too common in log messages to be
regarded as a trailer token.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)
