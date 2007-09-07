From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] HEAD, ORIG_HEAD and FETCH_HEAD are really special.
Date: Fri, 07 Sep 2007 12:29:01 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0709071222270.21186@xanadu.home>
References: <1189115308.30308.9.camel@koto.keithp.com>
 <7vsl5r8jer.fsf@gitster.siamese.dyndns.org>
 <1189133898.30308.58.camel@koto.keithp.com>
 <7vd4wu67qs.fsf_-_@gitster.siamese.dyndns.org>
 <1189181313.30308.97.camel@koto.keithp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Keith Packard <keithp@keithp.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 18:29:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITghi-0000KK-Nc
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 18:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbXIGQ3F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 12:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757775AbXIGQ3E
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 12:29:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45646 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757788AbXIGQ3D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 12:29:03 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JO000J19B4DT9B0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 Sep 2007 12:29:01 -0400 (EDT)
In-reply-to: <1189181313.30308.97.camel@koto.keithp.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58048>

On Fri, 7 Sep 2007, Keith Packard wrote:

> On Fri, 2007-09-07 at 04:21 -0700, Junio C Hamano wrote:
> 
> > This patch brings in a new world order by introducing a backward
> > incompatible change.  When the string the user gave us does not
> > contain any slash, we do not apply the first entry (i.e.
> > directly underneath .git/ without any "refs/***") unless the
> > name consists solely of uppercase letters or an underscore,
> > thereby ignoring .git/master.  The ones we often use, such as
> > HEAD and ORIG_HEAD are not affected by this change.
> 
> It seems to me that instead of introducing an incompatible (but probably
> useful) change, a sensible option would be to have the ambiguous
> reference be an error instead of a warning. One shouldn't be encouraged
> to use names in .git that conflict with stuff in refs/heads anyway.

I agree.  IMHO the sensible thing to do is to always warn, and error out 
by default.  I see no advantage for core.warnAmbiguousRefs=false other 
than allow the user to shoot himself in the foot someday.  Instead, we 
should have core.allowAmbiguousRefs set to off by default.


Nicolas
