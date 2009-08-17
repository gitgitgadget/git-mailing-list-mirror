From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: sparse support in pu
Date: Mon, 17 Aug 2009 11:15:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171113420.4991@intel-tinevez-2-302>
References: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com>  <fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com> <2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 17 11:16:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McyK1-0006HC-IO
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 11:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757540AbZHQJP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 05:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757536AbZHQJP6
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 05:15:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:34845 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757528AbZHQJP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 05:15:57 -0400
Received: (qmail invoked by alias); 17 Aug 2009 09:15:57 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp059) with SMTP; 17 Aug 2009 11:15:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19r1BMa0C9rFPMFvvshX/fzDyWbzHNksMBX6jOOkW
	rXq/jy+Wy1Qb6r
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126148>

Hi,

On Mon, 17 Aug 2009, skillzero@gmail.com wrote:

> On Mon, Aug 17, 2009 at 1:17 AM, Nguyen Thai Ngoc Duy<pclouds@gmail.com> wrote:
> > On Mon, Aug 17, 2009 at 1:09 PM, <skillzero@gmail.com> wrote:
> >> 1. Have people decided whether it should be on by default if you have 
> >>    a .git/info/sparse file? I'd definitely like it to be on by 
> >>    default.  When I first tried it, I didn't realize I had to use 
> >>    --sparse to git checkout to get it to use the sparse rules. The 
> >>    same goes for a merge I did that happened to have a file in the 
> >>    excluded area (it included it because I didn't use --sparse to git 
> >>    merge).
> >
> > I tend to make it enabled by default too. I have made it stricter to 
> > trigger reading sparse in unpack_trees() -- only do it when 
> > unpack_opts.update is TRUE. This should make it safer to be enabled by 
> > default.
> 
> Other than it being new and not-widely-tested code, is there any 
> additional risk to having it enabled by default if there are no sparse 
> patterns defined?

I think that in and of itself is reason enough to turn off the feature 
when .git/info/sparse is not present.

It also may have a runtime cost, dunno.

> It would be nice if .git/info/sparse is there by default (like
> .git/info/exclude) with some commented out instructions (also like
> .git/info/exclude).

I'm not a fan of this idea.

> >> 3. One thing that was confusing is that I needed a trailing slash on 
> >>    directories in .git/info/sparse to get them excluded. This seems 
> >>    different than .gitignore, which works for me without the trailing 
> >>    slash.
> >
> > Hmm.. probably because Git feeds directories to .gitignore handling 
> > functions. There is not much I can do, index does not have 
> > directories. I don't know if it's worth generating "directories" from 
> > index.
> 
> Maybe just add a note in the documentation? If there's a default 
> .git/info/sparse file then it might be good place to put a note as well.

I rather think that this should be fixed.  Maybe you can come up with a 
patch to the tests which shows this behavior (with test_expect_failure)?  
Then it will be much easier to come up with a fix.

Ciao,
Dscho
