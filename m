Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C27C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 10:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8562C2077B
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 10:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfLMK0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:26:46 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:37688 "EHLO steffen.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfLMK0q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 05:26:46 -0500
X-Greylist: delayed 1570 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Dec 2019 05:26:45 EST
Received: from [216.208.232.130] (port=14615 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1ifhkP-0000US-D4
        for git@vger.kernel.org; Fri, 13 Dec 2019 05:00:34 -0500
Date:   Fri, 13 Dec 2019 05:00:33 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: how to add a (history-laden) subdirectory into a repo?
Message-ID: <alpine.LFD.2.21.1912130447510.5127@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  (i suspect there's an easy solution -- possibly involving
filter-branch or elijah newren's git-filter-repo, or possibly
something even simpler, so let me try to be brief.)

  i have a xilinx petalinux (vendor) repo that i started from scratch,
with a certain amount of history that i would like to hang onto --
assume the top-level structure (as created by the petalinux-create
tool) is:

  board_name/
    dir1/
    dir2/
    ... etc etc ...

and so on, and so on. that is the structure of my current repo,
totally isolated from other content.

  now, at this client site, they're using petalinux, but their
existing repository buried the petalinux project content inside a
larger build infrastructure that involves docker and other tools, so
the client's single repo has the structure:

  client_repo/
    blah1/
    blah2/
      woof1/
      woof2/
      board_name/      <---- subdir content in client repo
        dir1/
        dir2/
        ... etc etc ...

from my perspective, the ideal solution would have been for the client
to develop its build infrastructure, and include the PL project as a
submodule or subtree, as that content really is independent from the
build infrastructure but, for whatever reason, the above is all just
one honking big repo with commits to the build content intermixed with
content related to the PL project.

  i'd like to add my PL repo into that structure -- as you can see,
all my commits will be relative to the dir structure "board_name/",
while the corresponding content in the client repo will be relative to
"client_repo/blah2/woof2/board_name/".

  if submodules or subtrees are not an option, what is the easiest way
to insert my content into the appropriate subdirectory in the client
repo, while retaining my history? i'm sure there's a simple way to do
this, it just escapes me at the moment.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
