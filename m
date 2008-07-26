From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Set up argv0_path correctly, even when argv[0] is just
 the basename
Date: Sat, 26 Jul 2008 19:42:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807261940450.26810@eeepc-johanness>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de> <alpine.DEB.1.00.0807261613120.26810@eeepc-johanness> <7vod4kft7d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 19:42:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMnms-0000ve-1J
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 19:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbYGZRle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 13:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753797AbYGZRle
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 13:41:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:49323 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753732AbYGZRld (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 13:41:33 -0400
Received: (qmail invoked by alias); 26 Jul 2008 17:41:31 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp037) with SMTP; 26 Jul 2008 19:41:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ARWkSZmCAjdAwVRYp+TkfDTHa7hYRiGrPOr3xC0
	tXUTAVd94fc+P2
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vod4kft7d.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90265>

Hi,

On Sat, 26 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > However, argv0_path needs the full path, so add a function to discover 
> > the program by traversing the PATH manually.
> 
> I think unconditionally requiring argv0_path to be set is the root cause 
> of the bug.  Unless we do not fix _that_, we will have to make a 
> needless call to lookup_program_in_path() even when nobody needs that 
> information, which is unacceptable.

Fair enough.  How about having a function called from system_path() which 
has a flag so it is run only once, and then calls lookup_program_in_path() 
provided that argv0_path contains no slashes _and_ exec_path is relative?

Ciao,
Dscho
