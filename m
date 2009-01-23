From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH v3 3/3] archive.c: add basic support for submodules
Date: Fri, 23 Jan 2009 20:57:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901232054360.21467@intel-tinevez-2-302>
References: <1232659071-14401-1-git-send-email-hjemli@gmail.com>  <1232659071-14401-2-git-send-email-hjemli@gmail.com>  <1232659071-14401-3-git-send-email-hjemli@gmail.com>  <1232659071-14401-4-git-send-email-hjemli@gmail.com>  <alpine.DEB.1.00.0901230044300.3586@pacific.mpi-cbg.de>
 <8c5c35580901231040i380c6458x1a6103cd6f55c479@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 20:59:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQSBl-0004XV-SW
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 20:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558AbZAWT6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 14:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753562AbZAWT6K
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 14:58:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:58308 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753398AbZAWT6J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 14:58:09 -0500
Received: (qmail invoked by alias); 23 Jan 2009 19:58:06 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp058) with SMTP; 23 Jan 2009 20:58:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/oYal3BfzojRl/2QHl3K44TqZxoVEGjSS5aEO1Qh
	iKIHn0mTBnMaGa
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <8c5c35580901231040i380c6458x1a6103cd6f55c479@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106907>

Hi,

On Fri, 23 Jan 2009, Lars Hjemli wrote:

> On Fri, Jan 23, 2009 at 00:44, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Thu, 22 Jan 2009, Lars Hjemli wrote:
> >
> >> The new --submodules option is used to trigger inclusion of checked out
> >> submodules in the archive.
> >>
> >> The implementation currently does not verify that the submodule has 
> >> been registered as 'interesting' in .git/config, neither does it 
> >> resolve the currently checked out submodule HEAD but instead uses the 
> >> commit SHA1 recorded in the gitlink entry to identify the submodule 
> >> root tree.
> >
> > Please understand that I skipped the rest of the patch.
> 
> That's too bad, I hoped on some feedback from you on the part of the 
> commit message which you didn't quote:

Well, you ignored my comments, so what do you expect me to do?  Be happy?

There are two issues there:

- presence of a specific commit object being present in the repository 
  does not necessarily mean that it is reachable by any ref, and therefore 
  can mean that the tree/blob objects are not reachable, because it could 
  be an interrupted fetch; in all of Git, we try to assume that only 
  reachable objects are valid objects.

- presence of a specific commit in the supermodule is a _lousy_ indicator 
  that the user wants to include that submodule in the archive.

Until both issues are addresse, I will not dance a little song and be 
merry over this issue.

Ciao,
Dscho
