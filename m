From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 23:02:42 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712182250040.23902@racer.site>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201> 
 <20071218204623.GC2875@steel.home>  <200712182224.28152.jnareb@gmail.com> 
 <alpine.LFD.0.9999.0712181347140.21557@woody.linux-foundation.org> 
 <7vejdjy79y.fsf@gitster.siamese.dyndns.org>
 <56b7f5510712181430w798d4a65x20a24f061c5d0eb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 00:03:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4lT8-00017m-DB
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 00:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbXLRXC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 18:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbXLRXC6
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 18:02:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:41918 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752407AbXLRXC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 18:02:58 -0500
Received: (qmail invoked by alias); 18 Dec 2007 23:02:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 19 Dec 2007 00:02:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/X/pcg/13XmihiwnDV1xUW7lWKx812WfEIpJLLTv
	IS5ltvqpRS669T
X-X-Sender: gene099@racer.site
In-Reply-To: <56b7f5510712181430w798d4a65x20a24f061c5d0eb6@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68840>

Hi,

On Tue, 18 Dec 2007, Dana How wrote:

> [lots about rev:path taking path to be relative to the project root, 
>  preferring it to be relative to the current prefix instead]
> 
> Typing an extra "./" is a big improvement over a long path prefix.

Have you tried the path completion?

Alternatively, I suggest making a script

	$ cat > $HOME/bin/git-showrel << \EOF
	#!/bin/sh
	git show "$(echo "$1" | sed "s|:|:$(git rev-parse --show-prefix)|")"
	EOF
	$ chmod a+x $HOME/bin/git-showrel

Then

	$ git showrel HEAD:file

will do what you want.

(An alias will not work, since the cwd will be the project root.)

Hth,
Dscho

P.S.: I just tried "git show HEAD~20:<filename with : in it>" and it did 
not work...  I consider this a more serious issue than the relative path 
one.
