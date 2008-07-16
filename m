From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix buffer overflow in git-grep
Date: Wed, 16 Jul 2008 15:47:21 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807161546240.8950@racer>
References: <1216203345-18233-1-git-send-email-dpotapov@gmail.com>  <alpine.DEB.1.00.0807161232110.8503@eeepc-johanness>  <20080716115420.GD2925@dpotapov.dyndns.org> <37fcd2780807160733o156e49c6m51314ff18764ccd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 16:48:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ8Ik-0006L4-No
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 16:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760154AbYGPOrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 10:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760151AbYGPOrV
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 10:47:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:38186 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759685AbYGPOrU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 10:47:20 -0400
Received: (qmail invoked by alias); 16 Jul 2008 14:47:18 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp039) with SMTP; 16 Jul 2008 16:47:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+P4HxvzdqPVNbJ+3FvxRD3ti/cF0pT4beB3b3MDo
	zrH4njfzAa2sFD
X-X-Sender: gene099@racer
In-Reply-To: <37fcd2780807160733o156e49c6m51314ff18764ccd5@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88684>

Hi,

On Wed, 16 Jul 2008, Dmitry Potapov wrote:

> On Wed, Jul 16, 2008 at 3:54 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> >
> > For instance, git show will show you nothing at all and exit with 0.
> > The same problem with git whatchanged. The whole history mysteriously
> > disappeared at that commit, and git whatchanged exited with 0 without
> > any error or warning... Though git log will show you all history, but
> > if you run it with -p then it will also exit with zero at this commit
> > silently like previously history do not exist at all.
> 
> It turned out that git actually crashed while doing diff, but because it
> was a forked process, the parent exited normally with code 0. I wonder
> should not the parent process to exit with a non-zero code if the child
> died by SIGSEG or another signal?

We'll probably need to use the MinGW pager handling for Unix, too, and 
check for a died child.

Not overly trivial, though.

Ciao,
Dscho
