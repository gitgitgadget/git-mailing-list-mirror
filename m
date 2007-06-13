From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Stupid quoting...
Date: Wed, 13 Jun 2007 13:21:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706131316390.4059@racer.site>
References: <86ir9sw0pi.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 14:24:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyRtr-0001j2-G0
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 14:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756510AbXFMMYe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 08:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756468AbXFMMYe
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 08:24:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:36292 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753633AbXFMMYd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 08:24:33 -0400
Received: (qmail invoked by alias); 13 Jun 2007 12:24:32 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 13 Jun 2007 14:24:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WzPYH3/EW+Fpv4InVf5Q+Fl90VBa9FscDGbt/jp
	hFtqYdnWRt4FqJ
X-X-Sender: gene099@racer.site
In-Reply-To: <86ir9sw0pi.fsf@lola.quinscape.zz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50053>

Hi,

On Wed, 13 Jun 2007, David Kastrup wrote:

> what is the point in quoting file names and their characters in
> git-diff's output?  And what is the recommended way of undoing the
> damage?

The recommended way is not using spaces to begin with. I mean, does 
"David" contain spaces? People seem not to see the problem, and fail to 
blame Microsoft for all the damage they have done, introducing that 
stupid, stupid concept of filenames containing spaces, and _enforcing_ it.

> I have something like
> 
> git-diff -M -C --name-status -r master^ master | {
>     while read -r flag name
>     do
> 	case "$name" in *\\[0-3][0-7][0-7]*)
> 		name=$(echo -e $(echo "$name"|sed 's/\\\([0-3][0-7][0-7]\)/\\0\1/g;s/\\\([^0]\)/\\\\\1/g'))
> 	esac
>         [...]
> 
> in order to get through the worst with utf-8 file names, and it is a
> complete nuisance (double quotemarks are treated later).

Please understand that the quotes are not there for you, but for 
processing by other programs.

However, I _suspect_ that you want to do something like

	name="$(echo $name)"

because "echo" is exactly one of the programs this quoting was invented 
for.

Ciao,
Dscho
