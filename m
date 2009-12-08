From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git config does not reuse section name
Date: Tue, 8 Dec 2009 03:01:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912080258010.4985@pacific.mpi-cbg.de>
References: <4B1D360B.4070203@ubicom.com> <7vy6le35zv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Yakup Akbay <yakbay@ubicom.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 02:57:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHpK1-0003Y3-BS
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 02:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935268AbZLHB4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 20:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbZLHB4u
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 20:56:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:57614 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935172AbZLHB4t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 20:56:49 -0500
Received: (qmail invoked by alias); 08 Dec 2009 01:56:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp072) with SMTP; 08 Dec 2009 02:56:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19RKq4qsu5RLpjyZWsNehtHTbTJlqy17Etgv9FdjQ
	2sp6vP34H668/c
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vy6le35zv.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134800>

Hi,

On Mon, 7 Dec 2009, Junio C Hamano wrote:

> Yakup Akbay <yakbay@ubicom.com> writes:
> 
> > When I repeat the following n times
> >
> >    $ git config color.ui always
> >    $ git config --unset color.ui
> >
> >
> > it ends up the section name [color] n times in the .git/config file.
> >
> >
> >
> > like this for n=4:
> >
> >    [color]
> >    [color]
> >    [color]
> >    [color]
> >
> >
> > Using git version 1.6.5.3 (I don't know whether this is already fixed
> > in in later versions)
> 
> If I recall correctly, this hasn't been even noticed/reported/recognized
> as an issue, ever since the "git repo-config" was introduced (which later
> was renamed to "git config").  Dscho, do you remember details?

IIRC, due to technical limitations, the config machinery only recognizes 
sections if there is at least _one_ entry in them.  This is because 
git_config() is used to determine (from the current file position) where 
the section begins.

And likewise, due to those technical limitations, the section header is 
not removed when the last entry in the section is removed (this was 
because I did not want to change the location of the section, but due to 
the mentioned limitation, that did not work out).

Ciao,
Dscho
