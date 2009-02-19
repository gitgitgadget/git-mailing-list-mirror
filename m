From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/8] Support coverage testing with GCC/gcov
Date: Thu, 19 Feb 2009 14:46:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902191227260.6223@intel-tinevez-2-302>
References: <7v7i3nqk0x.fsf@gitster.siamese.dyndns.org> <cover.1235041345.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 19 14:48:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La9Fe-00073K-Cp
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 14:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbZBSNqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 08:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbZBSNqN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 08:46:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:58341 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751420AbZBSNqM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 08:46:12 -0500
Received: (qmail invoked by alias); 19 Feb 2009 13:46:10 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp036) with SMTP; 19 Feb 2009 14:46:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TCMV1adzTcDvGXzQ8WTt2j2nN3XyAx2sADnlUVc
	zSKsn0qfepZDnh
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1235041345.git.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110698>

Hi,

On Thu, 19 Feb 2009, Thomas Rast wrote:

> Junio C Hamano wrote:
> > [Will merge to 'next' soon]
> > 
> > * tr/gcov (Sun Feb 15 23:25:45 2009 +0100) 8 commits
> >  - Test git-patch-id
> >  - Test rev-list --parents/--children
> >  - Test log --decorate
> >  - Test fsck a bit harder
> >  - Test log --graph
> >  - Test diff --dirstat functionality
> >  - Test that diff can read from stdin
> >  - Support coverage testing with GCC/gcov
> 
> I noticed two small things that I'd like to fix before this goes
> 'next', so here they are:
> 
> * [1/8] Support coverage testing with GCC/gcov
> 
>   Changed it so the compilation (but not the testing) uses the same -j
>   flags as the caller, so that compilation can be done in parallel.
>   (It's rather minor compared to the slow testing with optimizations
>   turned off, but still.)

I strongly disagree that it is minor.  _Especially_ since the tests are 
slow, -j makes a huge difference.

And also without making the tests slower, -j makes a dramatic difference 
here:

	$ /usr/bin/time make -j50 test
	...
	60.41user 213.92system 2:49.34elapsed 162%CPU
	(0avgtext+0avgdata 0maxresident)k
	160inputs+401944outputs
	(0major+37204627minor)pagefaults 0swaps

	$ /usr/bin/time make test
	...
	88.08user 314.96system 7:28.28elapsed 89%CPU
	(0avgtext+0avgdata 0maxresident)k
	0inputs+401008outputs
	(0major+37223584minor)pagefaults 0swaps

Ciao,
Dscho
