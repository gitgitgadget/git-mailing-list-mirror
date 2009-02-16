From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: filter-branch: Remove original/*
Date: Mon, 16 Feb 2009 12:19:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902161218250.10279@pacific.mpi-cbg.de>
References: <431341160902131845g58d99635ie0735b433802d6be@mail.gmail.com> <alpine.DEB.1.00.0902142219010.10279@pacific.mpi-cbg.de> <7vvdrblcl0.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902152046090.10279@pacific.mpi-cbg.de> <7vvdrbie7k.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902152230330.10279@pacific.mpi-cbg.de> <7vbpt3id1w.fsf@gitster.siamese.dyndns.org> <7v7i3ricr4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Kidd <git@randomhacks.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 12:20:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ1WH-0002Fk-Gt
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 12:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbZBPLSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 06:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbZBPLSp
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 06:18:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:33133 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750738AbZBPLSo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 06:18:44 -0500
Received: (qmail invoked by alias); 16 Feb 2009 11:18:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 16 Feb 2009 12:18:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+t4uAfzoqtqj70xBNuOWkNfBXfdDPNxQ9hUKYNDL
	3PMB9RQ3IXOCfv
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v7i3ricr4.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110169>

Hi,

On Sun, 15 Feb 2009, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >>> That merely means whoever changes the tag and wants the record of such an
> >>> update, which is uncommon, need to make sure reflog is created for that
> >>> tag (and that tag only).
> >>
> >> The thing is: we cannot.  At least not at the moment.
> >
> > $ mkdir -p .git/logs/refs/tags
> > $ >.git/logs/refs/tags/junker
> > $ git tag junker
> > $ wc .git/logs/refs/tags/junker
> >   1   8 134 .git/logs/refs/tags/junker
> >
> > Ok, it's not 180 byte as I said, but only 134 bytes.
> 
> Having proven my superiour intelligence ;-) I think I can agree if your
> next proposal is to toggle reflog on for the tag when "git tag -f" is used
> to update an existing tag and core.logAllRefUpdates does not say "never"
> (this new value needs to be treated the same as "false" for most other
> purposes), and the tag does not already have a reflog.

Actually, to prove my inferior intelligence, I suggest going for the easy 
solution: replace the update-ref in filter-branch by a call to git tag -f, 
after making sure that the reflog exists (with >>.git/logs/$tagname).

Eric?

Ciao,
Dscho
