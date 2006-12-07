X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Explicitly add the default "git pull" behaviour to .git/config on clone
Date: Thu, 7 Dec 2006 15:52:51 +0100
Message-ID: <200612071552.51799.Josef.Weidendorfer@gmx.de>
References: <200612061207.23437.andyparkins@gmail.com> <200612070349.58521.Josef.Weidendorfer@gmx.de> <7v64cowers.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 14:53:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <7v64cowers.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33584>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsKd6-0001mx-8X for gcvg-git@gmane.org; Thu, 07 Dec
 2006 15:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032277AbWLGOwy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 09:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032275AbWLGOwy
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 09:52:54 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:54556 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1032277AbWLGOwx (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 09:52:53 -0500
Received: from dhcp-3s-49.lrr.in.tum.de (dhcp-3s-49.lrr.in.tum.de
 [131.159.35.49]) by mail.in.tum.de (Postfix) with ESMTP id 43CC52852; Thu,  7
 Dec 2006 15:52:52 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thursday 07 December 2006 04:44, Junio C Hamano wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> 
> > IMHO there only should be one place/command which is creating new branches,
> > and which is called by other porcelain commands [*1*].
> 
> Giving an option to git branch to set something like this up
> would be nice.  I would agree the division of labor you propose
> is a good way to keep the scripts maintainable.
> 
> It however is a different matter if we would want to set up the
> merge default always in the way you propose for a new branch at
> the policy level.
> 
> It also is a different matter if "git branch" has enough
> information to figure out which upstream "origin" needs to be
> fetched from, given an origin SHA-1 expression to create a new
> branch from, at the technical level

We could setup the branch.*.remote option for every tracking branch
git-clone is fetching (and git-fetch with the wildcard refspec).
And git-branch sets branch.*.remote/merge for the new branch
whenever it sees that a remote is set for the branch we are
branching off.
 
> It entirely is possible to use the same remotes/origin/
> hierarchy to track two physically different URLs (thus two
> different "origin"s) on a mobile machine that has different
> connectivity to the outside world depending on where you are
> ("that mirror is closer from here" and "I need to go over the
> firewall while I am here").  Because they track the logically
> same repository, it does not make sense to use different
> hierarchies under remotes/ for this purpose.
> 
> In such a setup, "git branch new origin/for-public" would not be
> able to tell which "origin" to fetch from

I see.
But I hope with my suggestion above, this can be looked up then
in the branch."remotes/origin/for-public".remote option.

