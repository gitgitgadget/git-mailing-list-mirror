From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: auto-merge after push?
Date: Mon, 11 May 2009 17:18:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905111714250.4973@intel-tinevez-2-302>
References: <20090511142326.GA18260@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:18:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3XGp-00042p-0v
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 17:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbZEKPSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 11:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756144AbZEKPSK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 11:18:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:44077 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754647AbZEKPSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 11:18:09 -0400
Received: (qmail invoked by alias); 11 May 2009 15:18:07 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp018) with SMTP; 11 May 2009 17:18:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+KAR5emhyKoe02lsek9HzFva6WANmIDI693QceMc
	ouRqflpWLVkarz
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090511142326.GA18260@redhat.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118807>

Hi,

On Mon, 11 May 2009, Michael S. Tsirkin wrote:

> I'm working on two machines, and git allows me to switch between them 
> and sync by means of git pull. When one machine is behind a firewall, I 
> can sometimes only do pushes, but then I have to rememeber to merge when 
> I log into remote machine.
> 
> Is there a way to trigger merge on remote after push somehow,
> so that running on local machine:
> >git push remote
> would be equivalent to
> >ssh remote git pull local

How about something like

$ git config alias.reverse-pull '!sh -c "git push remote HEAD:TO_MERGE && \
	ssh remote \"cd directory && \
		git merge TO_MERGE && git branch -d TO_MERGE\""'

?

The thing is, a merge can fail.  And then you already need direct access 
to the working directory in question.

If you were actually talking about fast-forward pushes (because you did 
the merge locally already), this might help you:

	http://thread.gmane.org/gmane.comp.version-control.git/110251

Ciao,
Dscho
