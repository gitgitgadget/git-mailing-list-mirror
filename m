X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Michael Loeffler <zvpunry@zvpunry.de>
Subject: Re: [PATCH 2/3] git-fetch: do not use "*" for fetching multiple
	refs
Date: Wed, 06 Dec 2006 19:16:40 +0100
Message-ID: <1165429001.993.35.camel@ibook.zvpunry.de>
References: <1165261102.20055.9.camel@ibook.zvpunry.de>
	 <el1tud$n07$2@sea.gmane.org> <1165422865.29714.13.camel@ibook.zvpunry.de>
	 <el6sni$re3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 18:17:12 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <el6sni$re3$1@sea.gmane.org>
X-Mailer: Evolution 2.6.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33501>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs1KM-00070z-3H for gcvg-git@gmane.org; Wed, 06 Dec
 2006 19:17:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937030AbWLFSQu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 13:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937037AbWLFSQu
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 13:16:50 -0500
Received: from mx01.ap-wdsl.de ([88.198.184.82]:36991 "EHLO mx01.ap-wdsl.de"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937030AbWLFSQt
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 13:16:49 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Am Mittwoch, den 06.12.2006, 17:58 +0100 schrieb Jakub Narebski:
...
> We could use perl for that, but embedded perl is a bit horrible.
I had the same idea after the sed problems with macos/solaris, but
embedded perl is really a bit horrible.

...
> '*' in destination part would mean $n / \n (n-th match for *).
> And you need some way to mark if it is prefix match, or whole path match.
> Ending prefix match with '/' is one way of doing this... Unless it would
> be prefix match always, but I think this leads way to confusion.
Then we could just use (.*) and \1..9 and use extended REs. The only
problem is this stupid sed thing, only GNU-sed has the -r
option to use extended REs.

> Just a thought.
I would prefer the following ways to do this globfetch stuff:

1.) The original refspec:
    Pull: refs/heads/master:refs/remotes/origin/master

2.) The one with "prefix match":
    Pull: refs/heads/:refs/remotes/origin/

3.) The one with extended regex:
    Pull: refs/heads/(.*):refs/remotes/origin/\1


