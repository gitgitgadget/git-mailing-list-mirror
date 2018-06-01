Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277771F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 20:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeFAUQY (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 16:16:24 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:43630 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeFAUQX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 16:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2FwTDVarSxfg0GQxq4BVIBeAPMiasTIts6dbOPtl+uo=; b=RrcAgvZJrFT8ufjeHWpa86eGkx
        TNi6+hC8V/d9iUfeTipAe+ACgFmM7YSUHaDWP7cbB0MLG5wbygkgZnuXIlHfbNIRb4ZDOYneOGZZr
        8EDYqegI+BGmcUtRihYhUWZX9YxEXeqVpLkCHe38xScsYGxknEClEWnT2shURSw9A/p4F5y5Yr4ys
        AzFNYji5jIB2QCMS1zW2lBThg1yGAGZ85kbAoXNvdr/kj2wl3ZR68Sjub5dJIem7VMsX8FRmNgHMl
        XjWHSS5RQhJKsjA98V+0KTWr/m5GsYolwvxXzZAEiq9rS8BsEmuArQQtHBsswoNs9RCwI0t5YeHzR
        yHhaMWXA==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:34560 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fOqTE-00BnPT-Ud
        for git@vger.kernel.org; Fri, 01 Jun 2018 16:16:21 -0400
Date:   Fri, 1 Jun 2018 16:14:12 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: how exactly can git config section names contain periods?
Message-ID: <alpine.LFD.2.21.1806011606490.11215@localhost.localdomain>
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


  more oddities in my travels, this from Doc.../config.txt:

"The file consists of sections and variables.  A section begins with
the name of the section in square brackets and continues until the
next section begins.  Section names are case-insensitive.  Only
alphanumeric characters, `-` and `.` are allowed in section names.
                                  ^ ?????

  what? how can section names contain periods? reading further,

"Sections can be further divided into subsections.  To begin a
subsection put its name in double quotes, separated by space from the
section name, in the section header, like in the example below:

--------
        [section "subsection"]


  ok, so how on earth would i use "git config" at the command line to
set a config variable with some arbitrary level of subsections? let's
try this:

  $ git config --global a.b.c.d.e rday

huh ... seemed to work fine, and added this to my ~/.gitconfig:

  [a "b.c.d"]
          e = rday

as i see it, the first component is intgerpreted as the section name,
the last component is the variable/key(?) name, and everything in
between is treated as subsection(s), which is not at all obvious from
that Doc file, or from "man git-config".

  and if a section name can contain periods, how would you specify
that at the command line?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
