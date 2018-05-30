Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FD431F51C
	for <e@80x24.org>; Wed, 30 May 2018 11:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeE3LCk (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 07:02:40 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:52136 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbeE3LCj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 07:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YBfKxSQAzjNXc5WwxM5lBR/nuoSxJrRDcjAw0mZB1W8=; b=wrCIayfL/D7wNky5THF8hf3Eo5
        FO5AK5xhgsqgVMEDlOqhV9mSEMJ7WLUAThcKwQZpF2pqOcC+7QzFBxsvN5kX6TmIcYOCWBGkSN+d8
        j0oo6nZ8xkodQP3xteC4m32alDy+b0BAdmFf+cRDxE21hI28/L/OETkEKt8rIg7+N6V0Nd/96FTBj
        0+xxVXxyTMrqeBj6sw6EhcWxArcj/kHGEQZkjKV3m73xXNoyWEMarvKTvffl6jRByIklNMPKb1uwG
        Z9ySzMmFf3lQIYzIJg3VDi1wHYjIF0aPSGxV+G3Fu53ZXfgeLtekvfbRnr4DW9C2VrH6wKv6g4tHg
        D3cSzzLQ==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:51012 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fNysC-00EBcC-Kc
        for git@vger.kernel.org; Wed, 30 May 2018 07:02:38 -0400
Date:   Wed, 30 May 2018 07:00:36 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: some (fairly simple) questions about hooks
Message-ID: <alpine.LFD.2.21.1805300700190.7958@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
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


  just want to clarify a few things about hooks to make sure i'm not
missing anything when i write my own hooks tutorial.

  first, for any hook to be active, it *must* be marked as executable
-- that much seems clear from the man page.

  next, "core.hooksPath" aside, the hooks related to any repository
are (by default) in $GIT_DIR/hooks and *only* in that directory. AIUI,
there is no way to extend or enhance the per-repo hooks with, perhaps,
a common subset of hooks in a common directory, is there? (i'm
ignoring the possibility that one could populate $GIT_DIR/hooks with a
few symlinks to share some common hooks among a number of repos --
would that work? and is it something that is even considered good
programming practice?)

  next, AIUI, the use of "core.hooksPath" *completely* overrides any
hooks in $GIT_DIR/hooks, yes? that is, that config setting does not
support any sort of enhancement of existing hooks, it's all or
nothing, correct?

  and sticking with core.hooksPath, one could set it either globally
to affect all repos, or one could of course set it locally to take
advantage of it just for *some* repos, but not all of them.

  finally, if you run "git init" for an existing repo, as i read it,
based on the templates content in effect, that will install new hooks
in a repo but *only* hooks for which there is no existing equivalent
-- it will *never* overwrite an existing hook by the same name.

  oh, and related to that last paragraph, running "git init" related
to hooks should be unaffected by core.hooksPath, is that correct? so
that even if "git init" installs some new hooks in an existing repo,
those new hooks will have no effect if core.hooksPath is set to refer
somewhere else, yes?

  am i missing any important features of hooks in the above?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
