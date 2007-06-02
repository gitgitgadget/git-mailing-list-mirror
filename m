From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH 3/3] Refresh VERSION file when building distribution tarball in "make dist"
Date: Sat, 2 Jun 2007 18:12:36 +0200
Message-ID: <20070602161236.GB13957@diku.dk>
References: <200705281054.05376.jnareb@gmail.com> <200705300131.17137.jnareb@gmail.com> <20070531131615.GA27044@diku.dk> <200706011834.28911.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 18:19:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuWKU-0000Wk-U9
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 18:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758302AbXFBQTo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 12:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757697AbXFBQTn
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 12:19:43 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:51189 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755979AbXFBQTn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 12:19:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 03545770005;
	Sat,  2 Jun 2007 18:19:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B7JCxSgHzMRp; Sat,  2 Jun 2007 18:19:40 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id A5CEAF003D;
	Sat,  2 Jun 2007 18:12:36 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 90C986DFB5B; Sat,  2 Jun 2007 18:10:30 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 8733E62A5D; Sat,  2 Jun 2007 18:12:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200706011834.28911.jnareb@gmail.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48934>

Jakub Narebski <jnareb@gmail.com> wrote Fri, Jun 01, 2007:
> On Thu, 31 May 2007, Jonas Fonseca wrote:
> 
> > Maybe you can test the newly released tig 0.7 tarball?
> > 
> > Your patch was added as commit 8cdf56913e7e486bb3f527c24ee4a4d19f2a4f61,
> > with a few minor adjustments.
> 
> One of those changes was using HEAD version of VERSION file in
> "make dist", instead of regenerating it and replacing it with the one
> containing _current_ version in the tar file.
> 
> $ make rpm
> sed -e 's/@@VERSION@@/0.7.4.g1995120/g' < tig.spec.in > tig.spec
> git-archive --format=tar --prefix=tig-0.7.4.g1995120/ HEAD > tig-0.7.4.g1995120.tar
> tar rf tig-0.7.4.g1995120.tar tig-0.7.4.g1995120/tig.spec
> gzip -f -9 tig-0.7.4.g1995120.tar
> rpmbuild -ta tig-0.7.4.g1995120.tar.gz
> Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.72336
> Executing(%build): /bin/sh -e /var/tmp/rpm-tmp.72336
> make[1]: Entering directory `/home/local/builddir/BUILD/tig-0.7.4.g1995120'
> cc -Wall -O2 '-DVERSION="0.7.git"'    tig.c  -lcurses -o tig
> asciidoc -b docbook -d manpage -aversion=0.7.git tig.1.txt
> xmlto -m manpage.xsl man tig.1.xml
> [...]
> 
> Note the mismatch in the versions: 0.7.4.g1995120 vs 0.7.git
> (by the way, shouldn't it be 0.7.tig?), even when building from live
> repo, and not from tarball.

Gah, somehow I didn't realize the problems of not updating the VERSION
file. Beautiful, so now it should actually work even for non-RPM builds
using the 'make dist' result. :)

-- 
Jonas Fonseca
