From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Fix premature free of ref_lists while writing temporary
 refs to file
Date: Wed, 27 Feb 2008 00:11:07 +0100
Message-ID: <200802270011.07733.johan@herland.net>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org>
 <alpine.LSU.1.00.0802261542080.22527@racer.site>
 <alpine.LNX.1.00.0802261752160.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristian =?iso-8859-1?q?H=F8gsberg?= <krh@redhat.com>,
	Santi =?iso-8859-1?q?B=E9jar?= <sbejar@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 00:12:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU8y0-0001se-OZ
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 00:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763370AbYBZXLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 18:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762055AbYBZXLa
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 18:11:30 -0500
Received: from smtp.getmail.no ([84.208.20.33]:49379 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761611AbYBZXL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 18:11:29 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JWV00G05CF2SW00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 27 Feb 2008 00:11:26 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JWV00D1OCEM5440@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 27 Feb 2008 00:11:10 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JWV00617CEJQ7V7@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 27 Feb 2008 00:11:08 +0100 (CET)
In-reply-to: <alpine.LNX.1.00.0802261752160.19665@iabervon.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75190>

On Wednesday 27 February 2008, Daniel Barkalow wrote:
> On Tue, 26 Feb 2008, Johannes Schindelin wrote:
> 
> > Hi,
> > 
> > On Tue, 26 Feb 2008, Johan Herland wrote:
> > 
> > > We cannot call write_ref_sha1() from within a for_each_ref() callback, 
> > > since it will free() the ref_list that the for_each_ref() is currently 
> > > traversing.
> > > 
> > > Therefore rewrite setup_tmp_ref() to not call write_ref_sha1(), as 
> > > already hinted at in a comment.
> > 
> > I guess the reason was to use a much of an API as possible.
> > 
> > If you already avoid that, why not write into .git/packed-refs directly?
> 
> Actually, it looks to me like the really right thing to do is tell 
> for_each_ref() to also include these refs temporarily, and not actually 
> write them to disk, read them back, and then delete them.

I completely agree.


...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
