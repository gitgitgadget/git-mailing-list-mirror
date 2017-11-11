Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAACA201C8
	for <e@80x24.org>; Sat, 11 Nov 2017 11:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753382AbdKKLnS (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 06:43:18 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:36878 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbdKKLnS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 06:43:18 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:48176 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eDUBx-0005rJ-HU
        for git@vger.kernel.org; Sat, 11 Nov 2017 06:43:17 -0500
Date:   Sat, 11 Nov 2017 06:42:53 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: should "git bisect" support "git bisect next?"
Message-ID: <alpine.LFD.2.21.1711110639120.5632@localhost.localdomain>
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


  the man page for "git bisect" makes no mention of "git bisect next",
but the script git-bisect.sh does:

#!/bin/sh

USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|replay|log|run]'
                                               ^^^^
LONG_USAGE='git bisect help
        print this long help message.
git bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]
                 [--no-checkout] [<bad> [<good>...]] [--] [<pathspec>...]
        reset bisect state and start bisection.
git bisect (bad|new) [<rev>]
        mark <rev> a known-bad revision/
                a revision after change in a given property.
git bisect (good|old) [<rev>...]
        mark <rev>... known-good revisions/
                revisions before change in a given property.
git bisect terms [--term-good | --term-bad]
        show the terms used for old and new commits (default: bad, good)
git bisect skip [(<rev>|<range>)...]
        mark <rev>... untestable revisions.
git bisect next
        find next bisection to test and check it out.

  ... snip ...

case "$#" in
0)
        usage ;;
*)
        cmd="$1"
        get_terms
        shift
        case "$cmd" in
        help)
                git bisect -h ;;
        start)
                bisect_start "$@" ;;
        bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
                bisect_state "$cmd" "$@" ;;
        skip)
                bisect_skip "$@" ;;
        next)
                # Not sure we want "next" at the UI level anymore.
                bisect_next "$@" ;;

  ... snip ...

so, is it supported or not? should be consistent.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
