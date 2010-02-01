From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 0/2] upload-pack: pre- and post- hooks
Date: Mon, 01 Feb 2010 11:30:57 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002011116320.1681@xanadu.home>
References: <6f8b45101001150414r2661001ep10819b601953c05b@mail.gmail.com>
 <1265013127-12589-1-git-send-email-ford_prefect@gentoo.org>
 <20100201152010.GC8916@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Arun Raghavan <ford_prefect@gentoo.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 01 17:31:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbzB3-0007H4-PN
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 17:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564Ab0BAQa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 11:30:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21267 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539Ab0BAQa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 11:30:57 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KX600L5O8JL4GB0@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 01 Feb 2010 11:30:57 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100201152010.GC8916@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138623>

On Mon, 1 Feb 2010, Shawn O. Pearce wrote:

> Arun Raghavan <ford_prefect@gentoo.org> wrote:
> > This patch set reintroduces the post-upload-pack hook and adds a
> > pre-upload-pack hook. These are now only built if 'ALLOW_INSECURE_HOOKS' is set
> > at build time. The idea is that only system administrators who need this
> > functionality and are sure the potential insecurity is not relevant to their
> > system will enable it.
> 
> *sigh*
> 
> I guess this is better, having it off by default, but allowing an
> administrator who needs this feature to build a custom package.
> 
> Unfortunately... I'm sure some distro out there is going to think
> they know how to compile Git better than we do, and enable this by
> default, exposing their users to a security hole.  Ask the OpenSSL
> project about how well distros package code...  :-\
> 
> I'd like a bit more than just a compile time flag.

I think such hooks could be allowed only if triggered explicitly by the 
upload-pack caller, such as git-daemon.  That's probably the only 
scenario where a useful use case can be justified for them anyway.

And of course, to avoid any security problems, the actual hooks must not 
be provided by the repository owner but provided externally, like from 
git-daemon, via some upload-pack command line arguments.  This way the 
hooks are really controlled by the system administrator managing 
git-daemon and not by any random git repository owner.

That should be good enough for all the use cases those hooks were 
originally designed for.


Nicolas
