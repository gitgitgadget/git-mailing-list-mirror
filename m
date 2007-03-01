From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Implement core.symlinks to support filesystems without symlinks
Date: Thu, 1 Mar 2007 02:18:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703010213420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11726125012895-git-send-email-johannes.sixt@telecom.at>
 <200702280013.45598.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.63.0702280101560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200702282348.51478.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 02:18:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMZwE-0007jt-2R
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 02:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932897AbXCABS0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 20:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932896AbXCABS0
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 20:18:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:51353 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932897AbXCABSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 20:18:25 -0500
Received: (qmail invoked by alias); 01 Mar 2007 01:18:24 -0000
X-Provags-ID: V01U2FsdGVkX1/g0yBwP0Pgizuj/itPaLsxKhaTh1HJOZvUgvLdtx
	L+qw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702282348.51478.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41028>

Hi,

On Wed, 28 Feb 2007, Robin Rosenberg wrote:

> onsdag 28 februari 2007 01:07 skrev Johannes Schindelin:
>
> > Your solution would fall short if one of the two files is changed. 
> > Since they are supposed to be symlinks, the application expects them 
> > to be identical, and weird sh*t happens.
>
> As will it when the file contain something completly different than 
> expected.

My points are these:

- If your project depends on symlinks, and you are on a system that does 
  not do symlinks, you're screwed. However, you might want to checkout the 
  project nevertheless.

- If you have a symlink, and your system does not do symlinks, you want 
  the information where the symlink points to, at least _somewhere_. 
  Without digging deep into Git internals.

- If you have a symlink, and your system ..., you want it to fail _early_.

The last point is reaaaaally important. There is a reason why we have 
compiler errors, instead of just blindly compiling it, and if that 
particular code path is triggered, explode in the face of the user.

So, all I would like to do on top of Johannes' patch is to add a _big_ 
_fat_ warning whenever Git realizes it has to substitute a file for a 
link, but I DON'T WANT THE BLOODY FILE TO BE COPIED.

Ciao,
Dscho
