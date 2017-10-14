Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B09C20372
	for <e@80x24.org>; Sat, 14 Oct 2017 09:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbdJNJzx (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Oct 2017 05:55:53 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:34828 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbdJNJzw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Oct 2017 05:55:52 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:54182 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e3JAd-0001ol-Ds
        for git@vger.kernel.org; Sat, 14 Oct 2017 05:55:51 -0400
Date:   Sat, 14 Oct 2017 05:55:49 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: man page for "git config" re: GIT_CONFIG and "-f" seems
 weird/wrong
Message-ID: <alpine.LFD.2.21.1710140538090.5453@localhost.localdomain>
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


  (apologies to those whose email systems barfed on my domain being
badly configured WRT MX record, i have been assured by my admin it's
been fixed.)

  reading "man git-config", first, it seems awkward that the "-f"
option is explained in terms of GIT_CONFIG even when that variable
hasn't been introduced yet:

  -f config-file, --file config-file
     Use the given config file instead of the one specified by GIT_CONFIG.

the way that's worded makes it seem like GIT_CONFIG *must* have a
value somewhere that is being overridden. perhaps a more general
explanation would be something like, "Explicitly use this, and *only*
this config file, regardless of other possible config settings."

  it might also be worth mentioning that, once you specify this
option, also using any of --local, --global or --system will result in
an error:

  $ git config -l -f ~/gitc --global
  error: only one config file at a time.
  ... snip ...

  related to this, under "ENVIRONMENT", the explanation for GIT_CONFIG
seems somewhat draconian:

  GIT_CONFIG
    Take the configuration from the given file instead of .git/config.
    Using the "--global" option forces this to  ~/.gitconfig. Using
    the "--system" option forces this to $(prefix)/etc/gitconfig.

the word "forces" seems a bit heavy-handed, and the explanation is
misleading, anyway ... if you've already set GIT_CONFIG, then using
any other option of --local, --global or --system produces the same
error as before:

  $ git config -l --system
  error: only one config file at a time.
  $

in other words, if GIT_CONFIG is already set, using --global or
--system doesn't "force" anything, it's simply an error, no?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
