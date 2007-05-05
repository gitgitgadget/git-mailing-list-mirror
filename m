From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: FFmpeg considering GIT
Date: Fri, 4 May 2007 21:15:54 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705042106370.3819@woody.linux-foundation.org>
References: <loom.20070502T111026-882@post.gmane.org>
 <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz>
 <loom.20070504T143538-533@post.gmane.org> <87y7k4lahq.wl%cworth@cworth.org>
 <20070504202448.GD14859@MichaelsNB>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-2016407147-1178338554=:3819"
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: Michael Niedermayer <michaelni@gmx.at>
X-From: git-owner@vger.kernel.org Sat May 05 06:16:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkBhN-00081k-EI
	for gcvg-git@gmane.org; Sat, 05 May 2007 06:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031732AbXEEEQF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 00:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031733AbXEEEQF
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 00:16:05 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:53955 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031732AbXEEEQC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2007 00:16:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l454FtZV022708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 May 2007 21:15:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l454Fsbt021950;
	Fri, 4 May 2007 21:15:54 -0700
In-Reply-To: <20070504202448.GD14859@MichaelsNB>
X-Spam-Status: No, hits=-2.976 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46242>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-2016407147-1178338554=:3819
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT



On Fri, 4 May 2007, Michael Niedermayer wrote:
> 
> we have a nice svn policy which explains that, also people wont receive
> write access without having submitted a few clean patches first
> so i dont know if more education would really help, the problems are IMHO
> rather caused by a mix of lazyness, arrogance and plain oversight
> but please dont missunderstand, these problems are not that common, its
> rather once every few month

[ I was away for a few days, so others probably answered already ... ]

With git, the right way to do thigns is to not ever give "write access" to 
the "standard" tree to developers, but to make each developer have their 
own tree, and then one or more developers are the ones that merge other 
peoples work. 

Since I'm the one who does the merging for the kernel, I've made damn sure 
that merging other peoples work is as easy as humanly possible, so that I 
can just sit there, sipping my foofy tropical drink, drunk as a skunk and 
enjoying every moment of seeing my peons work their little fingers to the 
bone, when I do a "git pull ..." and in two seconds I've downloaded their 
work and merged it, and I can take another sip of the Piña Colada. 

Burp.

And git also makes it really easy to see when somebody does something 
stupid. The one thing it always shows to the person doing the merging is 
the diffstat from the result, so if somebody re-indented the source base, 
the merger goes "Whaa", and assuming he's not too drunk to type, he should 
just send a sternly worded message to the developer who did the bad deed, 
and tell them that their work was unacceptable, and won't be pulled.

A simple "git reset --hard ORIG_HEAD" will undo the merge, so the 
person(s) who actually does the integration again doesn't actually have to 
work all that hard.

In other words, the proper sequence really should be to *not* let the 
horribly buggy commits into the standard version in the first place! Sure, 
individual developers will make mistakes, but the fact that they screwed 
up should in _no_ way mean that they can screw up the main repository. The 
whole point in being distributed is that developers can screw up in their 
own _private_ repositories and still have all the power of a proper SCM 
tool, but without actually getting to screw up the main repo.

(And yes, then very occasionally both the developer *and* the maintainer 
screws up, and something bad gets through, and yeah, then you need to 
revert, but the point I'm arguing is that with a fairly good flow of 
development, you don't have to worry about the more clueless people 
screwing up - they can still do development, and you can still pull from 
them, but *if* they screw up, you can tell them to clean up their mess 
*before* you actually put it into any standard tree, and the mess can be 
entirely their _local_ mistake and never visible anywhere else).

			Linus
---1463790079-2016407147-1178338554=:3819--
