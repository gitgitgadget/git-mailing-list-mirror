Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 495001F403
	for <e@80x24.org>; Wed,  6 Jun 2018 20:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeFFULr (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 16:11:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:36706 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751812AbeFFULq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 16:11:46 -0400
Received: (qmail 30059 invoked by uid 109); 6 Jun 2018 20:11:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Jun 2018 20:11:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8612 invoked by uid 111); 6 Jun 2018 20:11:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Jun 2018 16:11:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jun 2018 16:11:44 -0400
Date:   Wed, 6 Jun 2018 16:11:44 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Thomas Fischer <thomasfischer@fastmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>, git@vger.kernel.org
Subject: Re: git rm bug
Message-ID: <20180606201144.GA32098@sigill.intra.peff.net>
References: <1528313557.2662346.1398855328.3E0F8023@webmail.messagingengine.com>
 <alpine.LFD.2.21.1806061532420.9259@localhost.localdomain>
 <1528314421.2665575.1398886712.579F37CE@webmail.messagingengine.com>
 <20180606200137.GJ3094@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180606200137.GJ3094@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 06, 2018 at 04:01:38PM -0400, Todd Zullinger wrote:

> Thomas Fischer wrote:
> > I agree that the entire chain of empty directories should not be tracked, as git tracks content, not files.
> > 
> > However, when I run 'rm path/to/some/file', I expect path/to/some/ to still exist.
> > 
> > Similarly, when I run 'git rm path/to/some/file', I expect path/to/some/ to exist, *albeit untracked*.
> > 
> > I do NOT expect git to *track* empty directories. But I also do NOT expect it to remove untracked directories.
> 
> It looks like this behavior has been in place for many
> years, since d9b814cc97 ("Add builtin "git rm" command",
> 2006-05-19).  Interestingly, Linus noted in the commit
> message that the removal of leading directories was
> different than when git-rm was a shell script.  And he
> wondered if it might be worth having an option to control
> that behavior.
> 
> I imagine that most users either want the current behavior
> or they rarely run across this and are surprised, given how
> long git rm has worked this way.

It's also consistent with other parts of Git that remove files. E.g.,
"git checkout" to a state that does not have the file will remove the
leading directories (if they're empty, of course).

> It does seem like something which could be noted in the git
> rm docs.  Perhaps you'd care to take a stab at a patch to
> add a note to Documentation/git-rm.txt Thomas?  Maybe a note
> at the end of the DISCUSSION section?

Yeah, agreed.

-Peff
