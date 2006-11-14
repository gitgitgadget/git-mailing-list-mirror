X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Missing features in git
Date: Tue, 14 Nov 2006 10:40:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611141037120.3327@woody.osdl.org>
References: <20061114134958.5326.qmail@science.horizon.com>
 <200611141815.24236.jnareb@gmail.com> <20061114173657.GC5453@diana.vm.bytemark.co.uk>
 <200611141845.18930.jnareb@gmail.com> <20061114174939.GB4299@spearce.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-1317512096-1163529630=:3327"
NNTP-Posting-Date: Tue, 14 Nov 2006 18:41:08 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061114174939.GB4299@spearce.org>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31360>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk3DT-0002So-6z for gcvg-git@gmane.org; Tue, 14 Nov
 2006 19:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933469AbWKNSk7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 13:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933470AbWKNSk7
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 13:40:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8382 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S933469AbWKNSk6 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 13:40:58 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAEIeWoZ013170
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 14
 Nov 2006 10:40:32 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAEIeU7g011207; Tue, 14 Nov
 2006 10:40:31 -0800
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-1317512096-1163529630=:3327
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 14 Nov 2006, Shawn Pearce wrote:

> Jakub Narebski <jnareb@gmail.com> wrote:
> > Dnia wtorek 14. listopada 2006 18:36, Karl Hasselström napisa?:
> > >
> > > For example, we could skip the "bisect" branch, since
> > > you aren't supposed to commit to that anyway.
> > 
> > Well, to have "branch" to which you could not commit, just put ref
> > outside refs/heads. 
> > 
> > Another solution would be to be able to put non-head ref in HEAD,
> > but allow to commit only if the prefix is refs/heads/
> 
> That's not a bad idea.  Then you can checkout a tag and have
> 'ref: refs/tags/v1.11' in HEAD, which means anyone who puts
> $(git-symbolic-ref) calls into their PS1 will see "refs/tags/v1.11"
> as their current branch, reminding them they are looking at the past.

I agree. This would probably be a good way to do "read-only branches".

Allowing people to do a "git checkout" on anything committish, but then 
not allowing them to commit to that, is probably the right thing to do.

Together with a nice readable error message from "git commit" (and merge, 
and pull - although you might well allow "fetch" to update the thing that 
current HEAD points to, though), this would be a lot easier to use for 
people who just follow somebody elses branch.

Junio, what do you think? It wouldn't even be backwards incompatible, 
because we're strictly allowing a superset of what we used to..

			Linus
