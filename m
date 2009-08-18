From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 14:10:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908181403190.6044@xanadu.home>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
 <4A8AA511.1060205@gmail.com>
 <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
 <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181147510.6044@xanadu.home>
 <alpine.LFD.2.00.0908181240400.6044@xanadu.home>
 <bdca99240908180959h69f37671k4d526fbf4814e8d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_LWBXX361kZzPXI0lrvagVw)"
Cc: Junio C Hamano <gitster@pobox.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 20:11:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdT9U-0000k4-BO
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 20:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbZHRSLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 14:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbZHRSLM
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 14:11:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24105 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbZHRSLL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 14:11:11 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOL00EGZ3BNP790@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 Aug 2009 13:59:48 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <bdca99240908180959h69f37671k4d526fbf4814e8d1@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126434>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_LWBXX361kZzPXI0lrvagVw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Tue, 18 Aug 2009, Sebastian Schuberth wrote:

> On Tue, Aug 18, 2009 at 18:43, Nicolas Pitre<nico@cam.org> wrote:
> 
> >> Well...  Given that git already uses ntohl/htonl quite extensively in
> >> its core already, I'd suggest making this more globally available
> >> instead.
> >
> > What about something like this?
> 
> I like the idea of making bswap available more globally, but I'm not
> sure if it's worth to introduce a new file for only that purpose.
> Isn't there already a central header for such things?

That central header is already quite crowded.  A bit of isolation might 
not hurt.

Furthermore, other platforms might wish to add their own (re)definitions 
for those byte swap operations, so it has the potential to grow.  I for 
example have a better implementation for ARM than what is provided by 
glibc.  (Yeah yeah, maybe glibc should be fixed instead, but that 
reasoning goes for all those other libraries too).

> Moreover, including compat/bswap.h would only give you ntohl()/htonl()
> on one platform. For consistency, I'd expect to get those for any
> platform if I include compat/bswap.h, but maybe I'm not aware of some
> Git source code rules.

You get it by default for all platforms already by including 
git-compat-util.h.  The compat/bswap.h is not meant to be included by 
random c files.  If compat/bswap.h happens to contain a better version 
for your architecture then it'll override the default one.

> Finally, there's a typo in your comment saying "sinple" instead of "simple".

Thanks


Nicolas

--Boundary_(ID_LWBXX361kZzPXI0lrvagVw)--
