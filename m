From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Build configuration to skip ctime for modification test
Date: Tue, 22 Jul 2008 22:31:29 +0200
Message-ID: <20080722203128.GB5113@blimp.local>
References: <20080721173511.GB5387@steel.home> <4885897C.8010401@viscovery.net> <7vy73tltf5.fsf@gitster.siamese.dyndns.org> <20080722193901.GA5113@blimp.local> <alpine.DEB.1.00.0807222115440.8986@racer>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 22 22:33:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLOXC-0007Si-2D
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 22:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbYGVUbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 16:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbYGVUbe
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 16:31:34 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:50607 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbYGVUbd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 16:31:33 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44jepV
Received: from tigra.home (Fa955.f.strato-dslnet.de [195.4.169.85])
	by post.webmailer.de (fruni mo53) (RZmta 16.47)
	with ESMTP id 2034efk6MIq4uF ; Tue, 22 Jul 2008 22:31:29 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 11359277BD;
	Tue, 22 Jul 2008 22:31:29 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 0DB1436D17; Tue, 22 Jul 2008 22:31:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807222115440.8986@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89523>

Johannes Schindelin, Tue, Jul 22, 2008 22:17:21 +0200:
> Hi,
> 
> On Tue, 22 Jul 2008, Alex Riesen wrote:
> 
> > +#ifndef NO_TRUSTABLE_FILEMODE
> >  	if (ce->ce_ctime != (unsigned int) st->st_ctime)
> >  		changed |= CTIME_CHANGED;
> > +#endif
> 
> Surely you meant trust_executable_bit instead, right?

No. Just what I said: we don't have filemode (like "at all") - so no
ctime as well. But maybe you're right, and trust_executable_bit is
more flexible. Or maybe both (the #ifdef _and_ trust_executable_bit)
and must be used...

> Otherwise, if you really want to tell at compile time,I think for clarity 
> you have to introduce another #define, since NO_TRUSTABLE_FILEMODE 
> definitely says something different than CTIME_IS_USELESS.

I had that at first (NO_DEPENDABLE_CTIME, than IGNORE_CTIME), than
deemed it excessive.
