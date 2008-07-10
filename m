From: Nicolas Pitre <nico@cam.org>
Subject: Re: THREADED_DELTA_SEARCH
Date: Thu, 10 Jul 2008 12:21:09 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807101212000.12484@xanadu.home>
References: <20080710075327.GD24819@artemis.madism.org>
 <7vy749pxbe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_4sOPwUNDh3fimiKFmQx0wA)"
Cc: Pierre Habouzit <madcoder@debian.org>, Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 18:23:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGyvG-0001kQ-Pj
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 18:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbYGJQWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 12:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbYGJQWM
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 12:22:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57403 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbYGJQWL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 12:22:11 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K3S00FYSTFA9GL0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 10 Jul 2008 12:21:10 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vy749pxbe.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87990>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_4sOPwUNDh3fimiKFmQx0wA)
Content-type: TEXT/PLAIN; charset=utf-8
Content-transfer-encoding: 8BIT

On Thu, 10 Jul 2008, Junio C Hamano wrote:

> Pierre Habouzit <madcoder@debian.org> writes:
> 
> >   I'm using it in production for quite a long time now, and I wonder if
> > there is any specific reason why it's not default. Debian activated it
> > by default too a couple of weeks ago, which means that it's in
> > production on quite a large scale, and there are no issues reported
> > either. Would a patch making it default be accepted ? It's quite handy
> > given that SMP machines are really pervasive nowadays…
> 
> There were two issues, IIRC.
> 
>  (1) resulting pack could be suboptimal, due to delta-chain getting cut
>      betweeen the worker thread boundary.
> 
>  (2) exploding memory use, suspected to be due to malloc pool
>      fragmentation under multithreading.
> 
> The former was only an issue with early iterations of the code and the
> current code has much improved behaviour on this point,

I would say it is even negligible.

> but I do not
> recall the latter issue has been addressed.

Well, for "standard" repositories such as the Linux kernel, things 
always worked just fine.  And commit eac12e2d is apparently helping a 
lot with the remaining odd cases.  And if someone has problems due to 
this then a simple 'git config --global pack.threads 1' would restore 
the non threaded behavior.


Nicolas

--Boundary_(ID_4sOPwUNDh3fimiKFmQx0wA)--
