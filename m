Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51E551F42D
	for <e@80x24.org>; Tue, 22 May 2018 07:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbeEVH71 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 03:59:27 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:44674 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbeEVH7T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 03:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZfKMU3KUWdiAx3+I3iWM4clerlKTfXJWeggHMjnO36M=; b=hEnLyyj0D+AAVVuoV+H+4aaXyF
        z6lqeTObtkiv7mabhAqmJwcoo+PMKgIvysZ7imcKw9vFUGv4tmp0PmIY5v//J3hTj/JPfRNzFUIxv
        LLQHRcAh9t81P585TMPSvIYYZH6XyRP9hzqfD8Lp04QOeya0cYnBfK3kyraRoT8ez8GHo9WiPrAXP
        sI/NSRZf7ekKjzlU2KjYJI1JVea9TMoHuKnm682o14Bd759cnRJghC3TBIbHCiW2zb2DLf+I5QGlr
        i+wE6eszmnjAwDJhlLVNqyw3DHDiPBzx9pP/e92DQbDZExn4qKn+nPjj6LOIDJtJhddfZ516Xlo5e
        Gbo7lQWA==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:55316 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fL2CS-002h5I-V8
        for git@vger.kernel.org; Tue, 22 May 2018 03:59:17 -0400
Date:   Tue, 22 May 2018 03:57:45 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: should config options be treated as case-sensitive?
Message-ID: <alpine.LFD.2.21.1805220353370.989@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
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


  in my wanderings, more oddities, such as this:

$ grep -ir blankboundary *
builtin/blame.c:	if (!strcmp(var, "blame.blankboundary")) {
Documentation/config.txt:blame.blankBoundary::
Documentation/blame-options.txt:	be controlled via the `blame.blankboundary` config option.
Documentation/RelNotes/2.15.1.txt: * Description of blame.{showroot,blankboundary,showemail,date}
Documentation/RelNotes/2.16.0.txt: * Description of blame.{showroot,blankboundary,showemail,date}
$

where you can see the single instance of "blankBoundary" in
Doc/config.txt (with the upper case 'B'), while the rest have no such
thing.

  for fun, i checked another of blame's config settings, with similar
results:

builtin/blame.c:	if (!strcmp(var, "blame.showemail")) {
Documentation/config.txt:blame.showEmail::
Documentation/RelNotes/2.15.1.txt: * Description of blame.{showroot,blankboundary,showemail,date}
Documentation/RelNotes/2.5.0.txt: * "git blame" learned blame.showEmail configuration variable.
Documentation/RelNotes/2.16.0.txt: * Description of blame.{showroot,blankboundary,showemail,date}
Documentation/git-blame.txt:	This can also be controlled via the `blame.showEmail` config
t/t8002-blame.sh:test_expect_success 'setup showEmail tests' '
t/t8002-blame.sh:test_expect_success 'blame with showemail options' '
t/t8002-blame.sh:test_expect_success 'blame with showEmail config false' '
t/t8002-blame.sh:	git config blame.showEmail false &&
t/t8002-blame.sh:test_expect_success 'blame with showEmail config true' '
t/t8002-blame.sh:	git config blame.showEmail true &&

  thoughts?

rday

p.s. i am not *trying* to be annoyingly pedantic, i am merely
succeeding.
