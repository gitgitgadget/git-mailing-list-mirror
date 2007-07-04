From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: Avoid an error message in the map function.
Date: Wed, 4 Jul 2007 12:08:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707041205250.4071@racer.site>
References: <11835356473029-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org, j.sixt@eudaptics.com
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Jul 04 13:09:30 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I62je-0002Eb-1y
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 13:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761448AbXGDLIm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 07:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761424AbXGDLIj
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 07:08:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:56049 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761100AbXGDLIg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 07:08:36 -0400
Received: (qmail invoked by alias); 04 Jul 2007 11:08:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 04 Jul 2007 13:08:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WI5J/uShWU6Odj8aYQQ8L6WKpUhEF3s48wGuSfi
	KLYtRFu5fCqTM2
X-X-Sender: gene099@racer.site
In-Reply-To: <11835356473029-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51593>

Hi,

On Wed, 4 Jul 2007, Johannes Sixt wrote:

> -	test -r "$workdir/../map/$1" || echo "$1"
> -	cat "$workdir/../map/$1"
> +	test -r "$workdir/../map/$1" &&
> +	cat "$workdir/../map/$1" ||
> +	echo "$1"

I think this does not do what you want. If I read it correctly, it will 
not do anything if $workdir/../map/$1 is not readable. I think you need 
this:

	(test -r "$workdir/../map/$1" &&
	cat "$workdir/../map/$1") ||
	echo "$1"

But that is a little too cute, so I personally would prefer an 
if-then-else-fi, because that is the idea of that code snippet.

Ciao,
Dscho
