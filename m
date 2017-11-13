Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C537E1F43C
	for <e@80x24.org>; Mon, 13 Nov 2017 10:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbdKMKW0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 05:22:26 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:37078 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbdKMKWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 05:22:25 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:60926 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eEBsn-0000Bd-6z
        for git@vger.kernel.org; Mon, 13 Nov 2017 05:22:25 -0500
Date:   Mon, 13 Nov 2017 05:21:59 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: "man git-clean" doesn't clarify the *default* behaviour of "git
 clean"
Message-ID: <alpine.LFD.2.21.1711130519270.11152@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  (against my better judgment at this point, i'm going to suggest a
slight reworking of "man git-clean" to make the OPTIONS more
comprehensible.)

  while the man page for "git clean" explains how options like -d and
-e and -x and -X, etc etc, alter the default behaviour of "git clean",
that man page doesn't clearly explain what that initial default
behaviour *is*.

  this sort of goes back to an earlier question of mine -- what is the
precise definition of files that are "[un]known to Git", because
that's what you read in that man page:

  "Normally, only files unknown to Git are removed, ..."

but i submit that unless the reader knows precisely what that means,
then all of the OPTIONS explanations are potentially confusing since
they're all worded in the sense of, "it's the default behaviour, but
with this alteration."

  based on a few simple tests, it *seems* that, in this case, the
absolutely default behaviour of just "git clean" (with no options) is
to remove files that are all of:

  1) untracked
  2) not ignored
  3) 1) and 2) above within only *tracked* directories
  4) not within subdirs named ".git"

is this accurate? because if this were explicitly listed at the
opening of that man page, it would make the subsequent OPTIONS far
more understandable, in that each option would now clearly show the
change from the default operation. does that make sense? and two more
things.

  first, the exclusion options mention overriding both of .gitignore
and $GIT_DIR/info/exclude, but what about one's personal
core.excludesFile setting? does that not play a part in this?

  finally, just an observation, but it seemed that as i was playing
with testing cleaning of tracked versus untracked directories, it
appeared that simply *staging* a directory made it "known" to git for
the purposes of cleaning. thinking about it, that seems to make sense,
but i've never seen that mentioned anywhere.

rday

p.s. with respect to trying to improve the docs, i am not trying to be
difficult, i am merely succeeding. :-)

  as hard as this may be to believe, i actually teach courses in git,
and often, i just display the man page for a command and walk through
it to explain its operation, and there are times when that man page is
simply not clear which is why i'm working so hard at trying to improve
them.

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

