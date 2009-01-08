From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: collapsing commits with rebase
Date: Thu, 8 Jan 2009 12:07:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901081205120.30769@pacific.mpi-cbg.de>
References: <93c3eada0901071608r190a723bma502b68c4ab81a08@mail.gmail.com>  <alpine.DEB.1.00.0901080144270.30769@pacific.mpi-cbg.de> <93c3eada0901071759u2496835dy134d92613bf4244b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 12:07:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKsjy-0006Kz-TA
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 12:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964AbZAHLGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 06:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754925AbZAHLGb
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 06:06:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:59788 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752105AbZAHLGa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 06:06:30 -0500
Received: (qmail invoked by alias); 08 Jan 2009 11:06:28 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 08 Jan 2009 12:06:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+c3rwko3Kc2gN6Ujm2OXaM8a14xsdkXth2hJHjK/
	OlwYcmsitdhOHK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <93c3eada0901071759u2496835dy134d92613bf4244b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104914>

Hi,

On Thu, 8 Jan 2009, Geoff Russell wrote:

> On Thu, Jan 8, 2009 at 11:15 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > Alternatively, something like this should work for you:
> >
> >        $ git checkout A
> >        $ git read-tree -u -m D
> >        $ git commit -m "My message"
> >        $ git cherry-pick E
> >        $ git cherry-pick F
> 
> Plan B is looking good, because I'd generally like the commit message to 
> be the concatenation of the messages for B,C and D.

Replace the commit call by this:

	$ for commit in B C D
	  do
		git cat-file commit $commit | sed '1,/^$/d'
		# possibly add an empty line between the commit messages,
		# git commit will strip away empty lines at the end.
	  done |
	  git commit -F -

Hth,
Dscho
