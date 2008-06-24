Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,
	MSGID_FROM_MTA_HEADER,MSGID_NOFQDN1,PLING_QUERY,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: (qmail 1111 invoked by uid 111); 24 Jun 2008 08:22:57 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 24 Jun 2008 04:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758056AbYFXIWl (ORCPT <rfc822;peff@peff.net>);
	Tue, 24 Jun 2008 04:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755804AbYFXIWk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 04:22:40 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60064 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754012AbYFXIWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 04:22:37 -0400
Received: (qmail 10349 invoked by uid 90); 24 Jun 2008 08:22:14 -0000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:	"David Jeske" <jeske@google.com>
To:	Jakub Narebski <jnareb@gmail.com>
Cc:	"Avery Pennarun" <apenwarr@gmail.com>,
	"Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org
Subject: Re: why is git destructive by default? (i suggest it not be!)
X-Mailer: Willow v0.02
Date:	Tue, 24 Jun 2008 08:08:13 -0000
Message-ID: <willow-jeske-01l5kwGPFEDjCc7b>
Received: from 67.188.42.104 at Tue, 24 Jun 2008 08:08:13 -0000
References: <m3mylbl0xb.fsf@localhost.localdomain>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5kQf4FEDjCXUa>
In-Reply-To: <m3mylbl0xb.fsf@localhost.localdomain>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To re-ask the same question I asked in my last post, using your ascii
pictures...


Let's assume we're here..

.<---.<---.<---A<---X<---Y    <--- master
\
\--B<---C    <--- customer_A_branch <=== HEAD


And this person and everyone else moves their head pointers back to master
without merging:


.<---.<---.<---A<---X<---Y    <--- master              <=== HEAD
\
\--B<---C    <--- customer_A_branch


Now, five years down the road, our tree looks like:


.<---A<---X<---Y<---.<--.<--.(3 years of changes)<---ZZZ<--- master  <=== HEAD
\
\--B<---C   <--- customer_A_branch

And someone does:

git-branch -f customer_A_branch ZZZ

To bring us to:

.<---A<---X<---Y<---.<--.(3 years of changes)<---ZZZ<--- master  <=== HEAD
\                                           \
\--B<---C                                   \-- customer_A_branch


..at this point, will a GC keep "B<--C", or garbage collect the commits and
throw them away?
