X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Rationale for the "Never commit to the right side of a Pull
 line" rule
Date: Thu, 26 Oct 2006 10:11:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610261003590.3962@g5.osdl.org>
References: <ehqp1u$j4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 26 Oct 2006 17:12:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ehqp1u$j4$1@sea.gmane.org>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30241>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd8lx-0001FI-0Q for gcvg-git@gmane.org; Thu, 26 Oct
 2006 19:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423504AbWJZRLz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 13:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423514AbWJZRLz
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 13:11:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22434 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1423504AbWJZRLy (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 13:11:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9QHBpPo032555
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 26
 Oct 2006 10:11:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9QHBoTY021607; Thu, 26 Oct
 2006 10:11:50 -0700
To: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
Sender: git-owner@vger.kernel.org



On Thu, 26 Oct 2006, Jerome Lovy wrote:
> 
> Could someone please point me to / give me the rationale for the "Never commit
> to the right side of a Pull line" rule ?

It's not a technical rule per se.

It's just a way to avoid what will almost inevitably otherwise be a 
horribly horribly confusing situation.

I say "almost inevitably", because if you really have worked with git 
enough, and understand how it works on a very fundamental level, there are 
actually no problems at all with doing so, and maybe you could have 
perfectly fine reasons to break the rule, and commit to a branch that is 
officially "maintained in another repository" and then push it out.

But it's a good rule in general, just because it makes a certain common 
workflow explicit. In fact, we really probably should start to always use 
the "refs/remote/origin/HEAD" kind of syntax by default, where you can't 
even _switch_ to the branch maintained in the remote repository, because 
it's not a real branch locally.

So normally you should consider the "origin" branch to be a pointer to 
WHAT YOU FETCHED LAST - and that implies that you shouldn't commit to it, 
because then it loses that meaning (now it's "what you fetched last and 
then committed your own work on top of", which is something totally 
different).

