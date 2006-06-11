From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: [PATCH] Implement safe_strncpy() as strlcpy() and use it more. [Take 2]
Date: Sun, 11 Jun 2006 15:05:59 +0200
Message-ID: <20060611130559.GD10430@bohr.gbar.dtu.dk>
References: <20060611120328.GC10430@bohr.gbar.dtu.dk> <20060611123332.GA3832@robert.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jun 11 15:06:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpPdn-0003JC-3P
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 15:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWFKNGD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 09:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWFKNGD
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 09:06:03 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:30094 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1751268AbWFKNGB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 09:06:01 -0400
Received: (qmail 6226 invoked by uid 5842); 11 Jun 2006 15:05:59 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060611123332.GA3832@robert.daprodeges.fqdn.th-h.de>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21655>

On Sun, Jun 11, 2006 at 12:33:32PM +0000, Rocco Rutte wrote:
> Hi,
> 
> * Peter Eriksen [06-06-11 14:03:28 +0200] wrote:
> 
> >-char *safe_strncpy(char *dest, const char *src, size_t n)
> >+size_t safe_strncpy(char *dest, const char *src, size_t size)
> >{
> >-	strncpy(dest, src, n);
> >-	dest[n - 1] = '\0';
> >+	size_t ret = strlen(src);
> 
> At least FreeBSD's strlen() requires a non-NULL argument, i.e. with 
> src==NULL, this will segfault.
> 
> If you can ensure that src!=NULL, then it's okay, but the safe_ prefix 
> implies something different.

By eyeballing the source code of strlcpy() from FreeBSD and OpenBSD
(which are quite similar), it seems they will segfault if given source
string, which is NULL.  So, from what I've understood, safe_strncpy()
is not more unsafe than strlcpy() or the current safe_strncpy().  It does
have different semantics, because the current one pads will NULL, since
it uses strncpy().

Peter
