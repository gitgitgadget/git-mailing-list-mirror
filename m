From: Nicolas Pitre <nico@cam.org>
Subject: Re: Better value for chunk_size when threaded
Date: Mon, 10 Dec 2007 08:46:09 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712100843530.555@xanadu.home>
References: <9e4733910712061558k19fbc864ia1fb7a3431fd2603@mail.gmail.com>
 <alpine.LFD.0.99999.0712062014060.555@xanadu.home> <475D1473.5090809@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Dec 10 14:46:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1ixt-0001GZ-3a
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 14:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862AbXLJNqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 08:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754991AbXLJNqL
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 08:46:11 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32161 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705AbXLJNqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 08:46:10 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSU006HQ68XXI20@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 10 Dec 2007 08:46:10 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <475D1473.5090809@op5.se>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67713>

On Mon, 10 Dec 2007, Andreas Ericsson wrote:

> Nicolas Pitre wrote:
> > If there is one besides futzing with /proc/cpuinfo I'd like to know about
> > it.  Bonus points if it is portable.
> > 
> 
> Here is such a one. I've sent it before, using git-send-email, but that
> one doesn't seem to work too well for all list-members, probably because
> my own laptop appears to be the original SMTP-server and its name can't
> be looked up. Sorry for inlining it here instead of sending it as a mail
> on its own, but I have absolutely no idea how to get git-send-email to
> do ldap authentication and connect to our tls-enabled smtp-server
> without using /usr/bin/sendmail and adding my laptop as originating
> smtp-server.
> 
> This patch replaces the one I sent earlier and *should* work on
> everything from Irix and AIX to Linux, Windows and every other
> posixish system. It passes all tests, both with and without
> THREADED_DELTA_SEARCH, and causes our weekly repack of our
> mother-ship repos to run roughly 4 times as fast (4 cores, no
> previous thread config).
> 
> Extract with
>   sed -n -e /^##SEDMEHERE##/,/##TOHERE##/p -e /^##/d
> 
> ##SEDMEHERE##
> > From ddf08303bd7962be385abbd5e964455a90ed6055 Mon Sep 17 00:00:00 2001
> From: Andreas Ericsson <ae@op5.se>
> Date: Thu, 6 Dec 2007 22:09:27 +0100
> Subject: [PATCH] pack-objects: Add runtime detection of number of CPU's
> 
> Packing objects can be done in parallell nowadays, but
> it's only done if the config option pack.threads is set
> to a value above 1. Because of that, the code-path used
> is sometimes not the most optimal one.
> 
> This patch adds a routine to detect the number of active
> CPU's at runtime, which should provide a better default
> and activate the (hopefully) better codepath more often.

Your patch is whitespace dammaged.

Also please make it into a separate .c file.  One day, maybe index-pack 
will want to use it as well.


Nicolas
