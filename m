From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Tue, 24 Jul 2007 19:30:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241923450.14781@racer.site>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222223460.14781@racer.site>
 <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222255010.14781@racer.site>
 <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707230000020.14781@racer.site> <20070723035644.GC32566@spearce.org>
 <7v1wezohi4.fsf@assigned-by-dhcp.cox.net> <46A5B5F5.6000202@trolltech.com>
 <Pine.LNX.4.64.0707241002410.14781@racer.site> <7vd4yigmla.fsf@assigned-by-dhcp.cox.net>
 <46A5DF1F.2030307@trolltech.com> <Pine.LNX.4.64.0707241337470.14781@racer.site>
 <46A5FDF0.3060801@trolltech.com> <Pine.LNX.4.64.0707241431540.14781@racer.site>
 <46A63EAA.6080203@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 20:30:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDP9S-0004eN-NH
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 20:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756925AbXGXSaZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 14:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756594AbXGXSaZ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 14:30:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:49854 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754522AbXGXSaX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 14:30:23 -0400
Received: (qmail invoked by alias); 24 Jul 2007 18:30:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 24 Jul 2007 20:30:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180PCkBAOg0BANZW+HmTmvRxJzw2gAoTpOheEXCxZ
	ZtRSdIxbx1798g
X-X-Sender: gene099@racer.site
In-Reply-To: <46A63EAA.6080203@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53624>

Hi,

On Tue, 24 Jul 2007, Marius Storm-Olsen wrote:

> 1) IMO, git should on Windows always do CRLF conversion, as this is what
> Windows developers in general expect. (CRLF text-files that is, not the
> conversion.) Meaning that
>     core.autocrlf = Windows
> by default. Where 'Windows' would be of true/false value which is true
> when on Windows and false when on other platforms. (Not that we should
> _have_ such an option, but the concept at least.)

I do not think so.

core.autocrlf is only about the relationship between the working tree and 
the repository.

So if you want CR/LF line endings always, just do not set that flag 
(which defaults to false).

If you want LF line endings in the repo, but not necessarily in the 
working tree, set core.autocrlf to input.

If you want LF line endings sometimes, but CR/LF at other times, but do 
not care if the revisions in the repository will have LF or CR/LF, do not 
set that flag.

Git is really slowed down tremendously just by the fact that it runs on 
Windows.  You should not add to that.

IMHO in most cases -- even on Windows -- you do not want to set autocrlf 
at all.  Because you do not need to store the file different from the 
version you have in the working tree.

The only situation where I think it makes sense, is when you have both 
Windows and Unix developers, _and_ your Windows tools sometimes produce 
CR/LF stupidly.  But then I'd set it to "input".

BTW no need to fuzz about binary files, which want to be in the object 
database without being converted.  Our heuristics has so far been pretty 
successful in discerning binary from text files.

Ciao,
Dscho
