From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] repack.c: chmod +w before rename()
Date: Sat, 25 Jan 2014 08:50:48 +0900
Message-ID: <20140124235048.GA30427@glandium.org>
References: <201401242205.16313.tboegi@web.de>
 <20140124214023.GB58260@vauxhall.crustytoothpaste.net>
 <alpine.DEB.1.00.1401242318060.14982@s15462909.onlinehome-server.info>
 <20140124224911.GC58260@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, zwanzig12@googlemail.com,
	stefanbeller@googlemail.com, kusmabite@gmail.com,
	msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Sat Jan 25 00:51:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6qWi-0006jL-PD
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 00:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbaAXXvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 18:51:04 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:33555 "EHLO
	jigen.glandium.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750872AbaAXXvC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 18:51:02 -0500
Received: from mh by jigen.glandium.org with local (Exim 4.82)
	(envelope-from <mh@glandium.org>)
	id 1W6qWO-000812-SK; Sat, 25 Jan 2014 08:50:48 +0900
Content-Disposition: inline
In-Reply-To: <20140124224911.GC58260@vauxhall.crustytoothpaste.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241055>

On Fri, Jan 24, 2014 at 10:49:13PM +0000, brian m. carlson wrote:
> On Fri, Jan 24, 2014 at 11:24:36PM +0100, Johannes Schindelin wrote:
> > > In general, I'm wary of changing permissions on a file to suit Windows's
> > > rename because of the symlink issue and the security issues that can
> > > result.
> > 
> > I agree on the Windows issue.
> 
> I personally feel that if Windows needs help to change permissions for a
> rename, that code should only ever be used on Windows.  Doesn't
> mingw_rename automatically do this anyway, and if it doesn't, shouldn't
> we put the code there instead?  Furthermore, it makes me very nervous to
> make the file 666.  Isn't 644 enough?

Arguably, umask is supposed to take care of making things right. OTOH,
since it's the destination file that's the problem not the renamed file,
the equivalent to mv -f would be to unlink() that file first, not to change
its permissions. That would work properly on unix too.

Mike
