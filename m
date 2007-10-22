From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: git filter-branch --subdirectory-filter error
Date: Mon, 22 Oct 2007 13:37:50 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200710221337.50730.wielemak@science.uva.nl>
References: <200710221227.13279.wielemak@science.uva.nl> <Pine.LNX.4.64.0710221218150.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 13:44:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijvhm-00045I-V9
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 13:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbXJVLoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 07:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbXJVLoK
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 07:44:10 -0400
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:4932 "EHLO
	smtp-vbr12.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbXJVLoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 07:44:09 -0400
Received: from gollem.science.uva.nl (gollem.science.uva.nl [146.50.26.20])
	(authenticated bits=0)
	by smtp-vbr12.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9MBi6qQ015957;
	Mon, 22 Oct 2007 13:44:06 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0710221218150.25221@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61993>

Dscho,

On Monday 22 October 2007 13:20, Johannes Schindelin wrote:
> Hi,
>
> On Mon, 22 Oct 2007, Jan Wielemaker wrote:
> > Finished a big re-shuffle of a big project, while other developers
> > continued. Worked really well. Thanks guys! But now I have two top
> > directories and I want to create two new repositories, each containing
> > one of these directories (because the one holds copyrighted data and we
> > want the other to become public software). So, I happily run
> >
> > 	$ git filter-branch --subdirectory-filter RDF HEAD
> >
> > Where RDF is an existing directory.  I get:
> >
> > Rewrite 95807fe01c39d3092e3ac3a98061711323154d77 (1/12)fatal: Not a valid
> > object name 95807fe01c39d3092e3ac3a98061711323154d77:RDF
> > Could not initialize the index
>
> I guess that 95807fe01 is the parent of a commit adding the RDF/
> directory.
>
> The subdirectory filter does not look kindly upon a history where some
> commits lack the subdirectory in question.  However, this should work:
>
> 	git filter-branch --subdirectory--filter RDF 95807fe01..HEAD

Thanks, but ... hmmm.

$ git filter-branch --subdirectory-filter RDF 
95807fe01c39d3092e3ac3a98061711323154d77..HEAD
Rewrite 0a43c802dd60f53d48136a32526a4b2a5f0d43e5 (1/11)fatal: Not a valid 
object name 0a43c802dd60f53d48136a32526a4b2a5f0d43e5:RDF
Could not initialize the index

$ git show 0a43c802dd60f53d48136a32526a4b2a5f0d43e5
commit 0a43c802dd60f53d48136a32526a4b2a5f0d43e5
Merge: 49fa961... 95807fe...
Author: XXX
Date:   Thu Oct 18 17:45:26 2007 +0200

    Merge branch 'master' of 
hildebra@gollem.science.uva.nl:/home/eculture/eculture

Tried 0a43c802dd60f53d48136a32526a4b2a5f0d43e5..HEAD, just to get
another one :-( I guess this will go on a little while :-( Before I
start writing a script that performs this procedure findind a place
where it does work I'd like to share some history with you.

This started as a big project with a lot of history in CVS, including
moved (read deleted and re-created) files. This was moved to SVN and
from there immediately to GIT. In GIT lots of things have been renamed.
The RDF directory was created quite recent in the project and things
from various subdirectories were moved there.

Is there something that might be worth a try or should we go the simple
way: keeping the old combined repo for later reference and create two
new ones from fresh files?

	Cheers --- Jan
