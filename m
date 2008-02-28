From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 02/40] Compile some programs only conditionally.
Date: Thu, 28 Feb 2008 11:57:44 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802281146050.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-3-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 28 12:59:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUhPs-0004PT-Kz
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 12:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757088AbYB1L6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 06:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756815AbYB1L6Q
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 06:58:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:41228 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757072AbYB1L6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 06:58:16 -0500
Received: (qmail invoked by alias); 28 Feb 2008 11:58:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 28 Feb 2008 12:58:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/LbmxmLbzLSgYIqtxf2h7rOjQo4hy7ywC5TJK5xf
	bHaGM+97dt42Mi
X-X-Sender: gene099@racer.site
In-Reply-To: <1204138503-6126-3-git-send-email-johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75388>

Hi,

On Wed, 27 Feb 2008, Johannes Sixt wrote:

> On MinGW, we won't compile some programs.

This explanation is good (even if I recall that we compile git-daemon.exe 
just fine now).

> @@ -264,7 +263,7 @@ PROGRAMS = \
>  	git-update-server-info$X \
>  	git-upload-pack$X \
>  	git-pack-redundant$X git-var$X \
> -	git-merge-tree$X git-imap-send$X \
> +	git-merge-tree$X \

We do not compile git-imap-send because MinGW lacks socketpair() and 
getpass().  Why not say it explicitely, and have a NO_SOCKETPAIR variable?  
Likewise, for git-daemon we should say NO_SYSLOG.

> +ifndef NO_EXTRA_PROGRAMS

The name NO_EXTRA_PROGRAMS is definitely not illustrating the reasons why 
we exclude those programs, so I'd rather not have this patch as-is.

NOTE: I think that both programs are fixable, but only git-daemon is 
important enough that I would like to see patch of the "daemon" branch in 
4msysgit.git cherry picked into this series (maybe we should implement a 
compat/syslog.c using the ReportEvent() function of the win32 API?).

Ciao,
Dscho
