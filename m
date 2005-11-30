From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Question about handling of heterogeneous repositories
Date: Wed, 30 Nov 2005 15:40:34 +0100
Message-ID: <200511301540.34776.Josef.Weidendorfer@gmx.de>
References: <81b0412b0511220850w429d2f36lafe9de7ce19ce8f@mail.gmail.com> <81b0412b0511300515u5d2840ccv92be6e374dd795be@mail.gmail.com> <Pine.LNX.4.63.0511301457040.2284@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 30 16:53:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhT8Z-0001bt-IV
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 15:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVK3Okl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 09:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVK3Okl
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 09:40:41 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:14059 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751244AbVK3Okk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 09:40:40 -0500
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id 8469E2612;
	Wed, 30 Nov 2005 15:40:36 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <Pine.LNX.4.63.0511301457040.2284@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13003>

On Wednesday 30 November 2005 14:58, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 30 Nov 2005, Alex Riesen wrote:
> 
> > On 11/30/05, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> > >
> > > To detect inter-repository renaming, one has to see both repositories. 
> > > Currently, git/cogito etc. commands only work with one repository 
> > > only.
> > 
> > This case is somewhat special: one is _guaranteed_ to see both 
> > repositories.
> 
> It is even more so: it is guaranteed that git cannot reconstruct this 
> as a move operation.

Say it in another way: because currently, git commands only work in the
scope of one repository, there is no need to want to detect an
inter-repository rename.

Git has no explicit support for renaming, but can do it. Why should it
be a problem to write a tool which is able to detect inter-repository
renames? Still, such a search probably would be very expensive.

git-mv could support this. Additional to deleting from
one repository and adding to the new, it could generate a remark for
the commit message, like:

 Added file xxx is from remote repo '/path/myrepo' with name 'yyy'
 (file SHA1: 123445... from remote commit SHA1: 345667...)

This info could be interesting both for humans and a history browsing tool.
The tool still would have to know where to look for repo '/path/myrepo'.
It could also work for moving subdirectories (ie. trees instead of files).

Josef
