Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2F7B1F404
	for <e@80x24.org>; Sat, 31 Mar 2018 19:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753085AbeCaTZd (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 15:25:33 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:51386 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752949AbeCaTZc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 15:25:32 -0400
X-Greylist: delayed 1250 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Mar 2018 15:25:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fDN1ebjIba6+00tvTrw24VcTLIccaJddRKLtTywzPqA=; b=VDcpERfa9yFbDJy3Zs887GXec1
        y3Q03WYboUL5MEX0yGXVMC7zSo/A6QVpzRMaMfXBl/bAvEhnXwfU+HyVEAHRCkXN6OAEl4IaX6sU+
        RlGY6dal+R12d8ntb4OzjinTYVAIGfaEV5gIbI9OQPh0A09MiyPnFrHB4hgJHxRO/iZqPlMV3XpCn
        FNr7Vu+hk8momAwRSMhhapnmvIZ5ZnfitkBTqVEq4OBUyYNlUPPyo/PAbVgo+cv+x3mbTF5yMq2XZ
        ycta1Luy0odhec+pUq1NQOKTA0mxBC6qg2M9f0uVOKVIPhc9k+XJr5aw8wNHw56sK+L2kWs7mfR3w
        xdL3zjlw==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:43826 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1f2Lnr-0003Q8-Jx
        for git@vger.kernel.org; Sat, 31 Mar 2018 15:04:40 -0400
Date:   Sat, 31 Mar 2018 15:04:38 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [OT] how does "git review --setup" figure out my username?
Message-ID: <alpine.LFD.2.21.1803311453250.21368@localhost.localdomain>
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


  (technically not a git question, but i kind of need to know the
answer to this quickly as i'm writing some documentation and this is
something i have to explain.)

  i cloned a repository (hyperledger fabric) which has a top-level
.gitreview file:

  [gerrit]
  host=gerrit.hyperledger.org
  port=29418
  project=fabric

and, as i read it, if i want to configure to use gerrit, an initial
invocation of "git review --setup" should do that for me, which it
appears to do, as it adds the following to .git/config:

  [remote "gerrit"]
        url = ssh://rpjday@gerrit.hyperledger.org:29418/fabric
        fetch = +refs/heads/*:refs/remotes/gerrit/*

and copies over the commit-msg hook. so far, so good.

  but from where does it figure out the username (rpjday) to use when
configuring that remote? i have no gerrit configuration in my
.gitconfig file. however, i have configured gerrit at the hyperledger
end to use my SSH key, which is associated with my linux foundation ID
(rpjday) that i registered to start using that repo.

  is that where it gets the username from?

rday
