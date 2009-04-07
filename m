From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 07 Apr 2009 09:13:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic>
 <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic>
 <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic>
 <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
 <fabb9a1e0904051436i1dc9c1bdhe86a23e470c756f9@mail.gmail.com>
 <alpine.LFD.2.00.0904052315210.6741@xanadu.home>
 <20090407081019.GK20356@atjola.homenet> <m3tz5023rq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_3G/wgUZfLbGu34B8f/bq4A)"
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 15:17:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrBAh-00046j-My
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 15:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756989AbZDGNOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 09:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756953AbZDGNOD
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 09:14:03 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9454 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756912AbZDGNOA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 09:14:00 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHQ00LNUFEXVPC0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 07 Apr 2009 09:13:48 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <m3tz5023rq.fsf@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115954>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_3G/wgUZfLbGu34B8f/bq4A)
Content-type: TEXT/PLAIN; charset=iso-8859-15
Content-transfer-encoding: 8BIT

On Tue, 7 Apr 2009, Jakub Narebski wrote:

> Björn Steinbrink <B.Steinbrink@gmx.de> writes:
> > On 2009.04.05 23:24:27 -0400, Nicolas Pitre wrote:
> > > On Sun, 5 Apr 2009, Sverre Rabbelier wrote:
> > > > 
> > > > I agree here, we should either say "look, we don't really support big
> > > > repositories because [explanation here], unless you [workarounds
> > > > here]" OR we should work to improve the support we do have. Of course,
> > > > the latter option does not magically create developer time to work on
> > > > that, but if we do go that way we should at least tell people that we
> > > > are aware of the problems and that it's on the global TODO list (not
> > > > necessarily on anyone's personal TODO list though).
> > > 
> > > For the record... I at least am aware of the problem and it is indeed on 
> > > my personal git todo list.  Not that I have a clear solution yet (I've 
> > > been pondering on some git packing issues for almost 4 years now).
> > > 
> > > Still, in this particular case, the problem appears to be unclear to me, 
> > > like "this shouldn't be so bad".
> > 
> > It's not primarily pack-objects, I think. It's the rev-list that's run
> > by upload-pack.  Running "git rev-list --objects --all" on that repo
> > eats about 2G RSS, easily killing the system's cache on a small box,
> > leading to swapping and a painful time reading the packfile contents
> > afterwards to send them to the client.
> 
> Than I think that "packfile caching" GSoC project (which is IIRC
> "object enumeration caching", or at least includes it) should help
> here.

NO!

Please people stop being so creative with all sort of ways to simply 
avoid the real issue and focussing on a real fix.  Git has not become 
what it is today by the accumulation of workarounds and ignorance of 
fundamental issues.

Having git-rev-list consume about 2G RSS for the enumeration of 4M 
objects is simply inacceptable, period.  This is the equivalent of 500 
bytes per object pinned in memory on average, just for listing object, 
which is completely silly. We ought to do better than that.


Nicolas

--Boundary_(ID_3G/wgUZfLbGu34B8f/bq4A)--
