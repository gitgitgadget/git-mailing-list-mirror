From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/5] run_hook(): allow more than 9 hook arguments
Date: Fri, 16 Jan 2009 22:05:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901162203260.3586@pacific.mpi-cbg.de>
References: <20090116172521.GD28177@leksak.fem-net> <1232133002-21725-1-git-send-email-s-beyer@gmx.net> <1232133002-21725-2-git-send-email-s-beyer@gmx.net> <1232133002-21725-3-git-send-email-s-beyer@gmx.net> <1232133002-21725-4-git-send-email-s-beyer@gmx.net>
 <1232133002-21725-5-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>, gitster@pobox.com
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 22:06:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNvt6-00058Z-4Q
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 22:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759751AbZAPVEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 16:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759558AbZAPVEO
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 16:04:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:58990 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755258AbZAPVEN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 16:04:13 -0500
Received: (qmail invoked by alias); 16 Jan 2009 21:04:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 16 Jan 2009 22:04:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gQ1MS5l5gS+5PLGd4S6XZTRghW9A/0iMMwa7ffi
	/lSi7bYsz67XZV
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232133002-21725-5-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105995>

Hi,

On Fri, 16 Jan 2009, Stephan Beyer wrote:

> This is accomplished using the ALLOC_GROW macro.
> 
> 5 cells are initially allocated for the argv array, allowing
> four actual arguments without reallocating memory.
> 
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
> 
> 	I was a little unsure if it looks better to
> 	initialize i = 0, alloc = 0
> 	and do:
> 		ALLOC_GROW(argv, i + 1, alloc);
> 		argv[i++] = git_path("hooks/%s", name);
> 	instead of the xmalloc().
> 
> 	Do some people care about details like that?

	Actually, you need to do it before setting argv[0], and I think it 
	would look better to let ALLOC_GROW() handle the allocation: less 
	opportunity for bugs to lurk.

	Besides that, ALLOC_GROW() will allocate 16 entries initially, 
	plenty enough for anyone, I guess.

Ciao,
Dscho
