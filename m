X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Light-weight checkouts via ".gitlink"
Date: Sat, 9 Dec 2006 02:46:20 +0100
Message-ID: <200612090246.20770.Josef.Weidendorfer@gmx.de>
References: <200612082252.31245.Josef.Weidendorfer@gmx.de> <200612090025.24234.Josef.Weidendorfer@gmx.de> <200612090053.48186.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 01:46:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.5
In-Reply-To: <200612090053.48186.jnareb@gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33787>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsrIU-0001rl-8z for gcvg-git@gmane.org; Sat, 09 Dec
 2006 02:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947813AbWLIBq1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 20:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947817AbWLIBq0
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 20:46:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:38895 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1947813AbWLIBqZ
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 20:46:25 -0500
Received: (qmail invoked by alias); 09 Dec 2006 01:46:24 -0000
Received: from p5496AEC2.dip0.t-ipconnect.de (EHLO noname) [84.150.174.194]
 by mail.gmx.net (mp020) with SMTP; 09 Dec 2006 02:46:24 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Saturday 09 December 2006 00:53, Jakub Narebski wrote:
> Josef Weidendorfer wrote:
> > On Friday 08 December 2006 23:54, Josef Weidendorfer wrote:
> >> Jakub Narebski wrote:
> >>> NAME = name
> > 
> > Forgot to mention in the proposal:
> > If you recursively have light-weight checkouts inside each other,
> > the real "name" (for .git/external/<name/ and for further submodule
> > configuration e.g. in .git/modules of the base repository)
> > should of course be the concatenation of the names in the .gitlink
> > files while going up to the base repository.
> 
> Why concatenation? I thought the name would be ID of submodule,
> and should be just somehow unique.
> 
> And if concatenation, pehaps some forbidden character inserted between
> them? Like '/' for example ;-)

Yes, you are right.
Nesting of submodules really is an important issue. The .gitlink
file allows us to put the submodule GITDIR somewhere in the supermodul's
GITDIR. The idea is that you can clone the submodule GITDIR if you
want. With submodule "inner" nesting inside of  submodule "outer", 
the GITDIR of "outer" should have the GITDIR of inner inside to allow
for cloning "outer" together with its submodule "inner".

So it is not enough to have a submodule "outer" and a submodule
"outer/inner" in the supermodule. We want

	super.git/ext/outer.git/

to be the GITDIR for submodule "outer", and inside 

	super.git/ext/outer.git/ext/inner.git
.

Actually, it would be nice if this .gitlink proposal did not have to
deal with it. Instead, a .gitlink should be so flexible to allow such
nesting if needed. 

