From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: [PATCH] Don't define _XOPEN_SOURCE on MacOSX and FreeBSD as it
	is too restricting
Date: Fri, 22 Dec 2006 06:53:27 +0000
Organization: Berlin University of Technology
Message-ID: <20061222065327.GA3773@peter.daprodeges.fqdn.th-h.de>
References: <Pine.LNX.4.64.0612201524230.3576@woody.osdl.org> <caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com> <7vtzzq3wo6.fsf@assigned-by-dhcp.cox.net> <caf068570612201654s3949202cl55bd21307ca59453@mail.gmail.com> <7vodpy3vxi.fsf@assigned-by-dhcp.cox.net> <86vek6vyc7.fsf@blue.stonehenge.com> <caf068570612201735o776e01a8he2e9ab90fc2ee4f@mail.gmail.com> <20061221103938.GA7055@fiberbit.xs4all.nl> <20061221112835.GA7713@fiberbit.xs4all.nl> <7v64c492fv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-From: git-owner@vger.kernel.org Fri Dec 22 07:53:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxeHr-0003Vl-NH
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 07:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423186AbWLVGxd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 01:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423185AbWLVGxd
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 01:53:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:37518 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423186AbWLVGxb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 01:53:31 -0500
Received: (qmail invoked by alias); 22 Dec 2006 06:53:29 -0000
Received: from cable-62-117-24-190.cust.blue-cable.de (EHLO peter.daprodeges.fqdn.th-h.de) [62.117.24.190]
  by mail.gmx.net (mp052) with SMTP; 22 Dec 2006 07:53:29 +0100
X-Authenticated: #1642131
Received: from peter.daprodeges.fqdn.th-h.de (peter [192.168.0.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id C147C20F02
	for <git@vger.kernel.org>; Fri, 22 Dec 2006 06:53:28 +0000 (UTC)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v64c492fv.fsf@assigned-by-dhcp.cox.net>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: peter.daprodeges.fqdn.th-h.de (FreeBSD 6.2-PRERELEASE i386)
User-Agent: Mutt/1.5.13-pdmef (2006-11-28)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35136>

Hi,

* Junio C Hamano [06-12-21 16:52:52 -0800] wrote:
>Marco Roeland <marco.roeland@xs4all.nl> writes:

>> We want our symbols "avilable" so lets not use _XOPEN_SOURCE on Darwin!

>Personally, I think hiding interfaces such as strXXX and memXXX
>based on _XOPEN_SOURCE level is already a bug in the system
>header implementation.  The symbols that begin with str are
>already reserved by the standard and I do not see any point
>in the system headers to try avoiding namespace contamination.

Well, it depends, I'd say. Different strXXX functions may be introduced 
by different versions of standards and with _POSIX_C_SOURCE one can, for 
example, define to be compile for a specific standard version only.

>Two and half questions.

> #1   __APPLE__ vs __APPLE_CC__ is not something I can decide (I
>      do not run a Mac).  If MaxOS is derived from FreeBSD, does
>      it by chance define __FreeBSD as well?

> #2   Terje's patch excludes _XOPEN_SOURCE_EXTENDED as well on a
>      Mac, but yours doesn't.  Is there a reason that you would
>      want '#define _XOPEN_SOURCE_EXTENDED 1'?  Do both FreeBSD
>      and Mac behave well with it defined?

First of all, the combined patch posted is wrong since __FreeBSD doesn't 
work on FreeBSD, but __FreeBSD__ does.

Second, a grep over the FreeBSD headers in /usr/include shows that 
_XOPEN_SOURCE_EXTENDED only affects 2 curses header files, so it's safe 
to exclude it, i.e. define it for FreeBSD.

   bye, Rocco
-- 
:wq!
