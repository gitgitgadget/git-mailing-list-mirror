From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Respecting core.autocrlf when showing objects
Date: Wed, 11 Jun 2008 20:06:08 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806112000400.1783@racer>
References: <7vprqqdwh7.fsf@gitster.siamese.dyndns.org> <cover.1213084587.git.marius@trolltech.com> <alpine.DEB.1.00.0806101632570.1783@racer> <7vk5gxc4gz.fsf@gitster.siamese.dyndns.org> <484F6A27.1040602@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 21:08:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6VgD-0004bY-RG
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 21:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbYFKTHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 15:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754149AbYFKTHY
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 15:07:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:47306 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753643AbYFKTHX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 15:07:23 -0400
Received: (qmail invoked by alias); 11 Jun 2008 19:07:21 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp042) with SMTP; 11 Jun 2008 21:07:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182fgctHJg27nD7C3E/aIvGfkIGvI5cXk00rRWy9S
	bsevFyypGinmp7
X-X-Sender: gene099@racer
In-Reply-To: <484F6A27.1040602@trolltech.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84641>

Hi,

On Wed, 11 Jun 2008, Marius Storm-Olsen wrote:

> Well, consider this:
>
> Say you are merging two branches, and know that you want to just use the 
> parts which conflict from the branch being merged in. Then you simply 
> do:
>
> 	git merge side
> 	git show :3:file.txt > file.txt

This is not really how I would do things.  I would do

	git checkout side file.txt here.

The _point_ is: "git show" is supposed to show you the contents _in the 
repository_.  For example, no smudge/clean filters will be heeded, and 
neither other attributes.

Further, "git show" will work without any problems in any bare repository.

In other words: "git show" is _not_ an operation on a working directory.

"git checkout" is.  So use that instead.

> Given that 'git show' *is* porcelain, I'd expect it to work 'naturally' 
> in my workflow, and not dump raw object store content.

Do not confuse porcelain with "works on the working directory".

> The fact that the stage files are in the index doesn't matter. I'd want 
> CRLF files from 'git show v1.5.6-rc0:builtin-log.c' as well.

But it _does_ matter!

The index works on raw objects, not on smudged files.  Period.

Ciao,
Dscho
