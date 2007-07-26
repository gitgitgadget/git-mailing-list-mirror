From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Add is_absolute_path(), make_absolute_path() and
 normalize_path()
Date: Thu, 26 Jul 2007 14:58:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707261456040.14781@racer.site>
References: <Pine.LNX.4.64.0707260724010.14781@racer.site>
 <7v1wevac63.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 15:59:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE3rz-0007pD-T3
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 15:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756577AbXGZN7I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 09:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755871AbXGZN7I
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 09:59:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:46581 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754158AbXGZN7F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 09:59:05 -0400
Received: (qmail invoked by alias); 26 Jul 2007 13:59:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp001) with SMTP; 26 Jul 2007 15:59:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+prcAV8gmpUVa+K/V7fSJZ2JB1jtUoLWBG1xrNGy
	96kqogDe4n6d6V
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1wevac63.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53831>

Hi,

On Wed, 25 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +/* strip out .. and . */
> > +char *normalize_path(char *path)
> > +{
> 
> This always makes one worry what should happen when foo/../bar
> is _not_ bar in reality (i.e. foo is symlink to a directory
> elsewhere).
> 
> It depends on what kind of "path" you feed to the function (and
> its caller, make_absolute_path()).  If you always feed a path
> >from the index (or a path obtained by recursively reading a
> tree), it is Ok.  If it is arbitrary path obtained from the user
> or the filesystem, it is not.

Agree.  Maybe a comment above the function, like

	/*
	 * The function normalize_path() converts ".." and "." names in 
	 * the given path so that "foo/../bar/./" will come out as "bar".
	 *
	 * Note: normalize_path() does not follow symlinks, so if "foo" is
	 * a symlink in the example above, the result will not work as 
	 * expected.
	 */

Hmm?

Ciao,
Dscho
