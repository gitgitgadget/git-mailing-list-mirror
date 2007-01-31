From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: When to repack?
Date: Wed, 31 Jan 2007 16:19:49 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701311617360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17856.37016.341839.397309@lisa.zopyra.com> <45C09335.6010601@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jan 31 16:28:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCHHy-00070q-L1
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 16:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbXAaPTz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 10:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030182AbXAaPTy
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 10:19:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:37081 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030180AbXAaPTv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 10:19:51 -0500
Received: (qmail invoked by alias); 31 Jan 2007 15:19:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 31 Jan 2007 16:19:50 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45C09335.6010601@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38258>

Hi,

On Wed, 31 Jan 2007, Andreas Ericsson wrote:

> Bill Lear wrote:
> > We have a company repo used by many people throughout the day.  When/how
> > can I repack this?  I have come to adopt this approach:
> > 
> > % mv project project.pack
> > % cd project.pack
> > % GIT_DIR=. git repack -a -d
> > % cd ..
> > % mv project.pack project
> > 
> 
> Renaming the directory isn't necessary. The packs won't be used until they
> have a .idx file. That .idx-file is written after the packfile, so any
> operations on the repo will simply use the old, loose, objects before the
> packing is completed.
> 
> The worst thing that can happen is that an object about to be fetched is
> deleted in its loose version before the upload-pack program can open it,
> but that's no worse than having the entire directory being moved out from
> under it.

AFAIR this case is handled gracefully by git. If the object it is still 
accessing moves to a(nother) pack, git will still find it.

> On a side-note, this is a grade A example of something that should 
> typically be done sunday night at 4am.

Actually, I'd recommend git-gc. It does not even call git-prune anymore, 
so there is no excuse.

I even do it interactively very often, and I just love the fact that "gc" 
is so much shorter than "repack -a -d", _plus_ it also does other cleanup 
tasks.

Ciao,
Dscho
