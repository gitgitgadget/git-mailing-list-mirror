From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: pack v4 trees with a canonical base
Date: Tue, 10 Sep 2013 16:17:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309101615080.20709@syhkavp.arg>
References: <alpine.LFD.2.03.1309091517380.20709@syhkavp.arg>
 <CACsJy8C+SFBRD1czeeK5VBDYT4xA6K+61HgLRnjB+CYJ-2g+uA@mail.gmail.com>
 <xmqqbo40xwnv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 22:17:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJUNn-00081T-8A
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 22:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494Ab3IJURv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 16:17:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46866 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab3IJURt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 16:17:49 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSX000T0F14DK20@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 10 Sep 2013 16:17:28 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 2435C2DA0625; Tue, 10 Sep 2013 16:17:28 -0400 (EDT)
In-reply-to: <xmqqbo40xwnv.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234478>

On Tue, 10 Sep 2013, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > On Tue, Sep 10, 2013 at 2:25 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> An eventual optimization to index-pack when completing a pack would be
> >> to attempt the encoding of appended tree objects into the packv4 format
> >> using the existing dictionary table in the pack, and fall back to the
> >> canonical format if that table doesn't have all the necessary elements.
> >
> > Yeah, it's on the improvement todo list. The way pack-objects creates
> > dictionaries right now, the tree dict should contain all elements the
> > base trees need so fall back is only necessary when trees are have
> > extra zeros in mode field.
> 
> Careful.
> 
> There may be trees in the wild that record 100775 or 100777 in the
> mode field for executable blobs, which also need to be special
> cased.

All the file mode bits are always preserved.  So this is not really a 
special case as far as the pack v4 encoding is concerned.


Nicolas
