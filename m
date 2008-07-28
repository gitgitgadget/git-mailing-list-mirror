From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Fundamental problem with relative system paths] [PATCH 2/2]
 run-command (Windows): Run dashless "git <cmd>"
Date: Mon, 28 Jul 2008 13:13:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807281310170.2725@eeepc-johanness>
References: <1217224228-31303-1-git-send-email-prohaska@zib.de> <1217224228-31303-2-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 13:13:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNQf9-0000Q7-Mj
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 13:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbYG1LML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 07:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753717AbYG1LML
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 07:12:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:48060 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753472AbYG1LMK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 07:12:10 -0400
Received: (qmail invoked by alias); 28 Jul 2008 11:12:08 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp058) with SMTP; 28 Jul 2008 13:12:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UC4hSB+UUw2bDWeiGrJ+xiB8w8NZ7a0O78VvU0a
	BAlRz8tDiz7WfA
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1217224228-31303-2-git-send-email-prohaska@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90441>

Hi,

On Mon, 28 Jul 2008, Steffen Prohaska wrote:

> This might solve a fundamental problem we have with the computation of 
> system directories based on relative paths in combination with the new 
> gitexecpath 'libexec/git-core'. The problem is that the program 'git' is 
> hardlinked to directories with different depth.  It is either used as 
> 'bin/git' (1 directory) or as 'libexec/git-core/git-*' (2 directories).  
> Thus, using the same relative path in system_path() yields different 
> results when starting from the two locations.  I recognized the problem 
> because /etc/gitconfig is no longer be read.

I seem to recall that I already suggested stripping 
"/libexec/git-core/<name>" if it is found, and fall back to 
stripping one directory level (catching "/bin/<name>").

IMHO system_path() should really be that intelligent.

(Of course, the way it is set up now, the _caller_ of git_set_argv0_path() 
has to do the intelligent thing...)

Ciao,
Dscho
