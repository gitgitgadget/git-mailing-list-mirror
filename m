From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Build configuration to skip ctime for modification test
Date: Wed, 23 Jul 2008 18:46:14 +0200
Message-ID: <20080723164614.GB5283@blimp.local>
References: <20080721173511.GB5387@steel.home> <4885897C.8010401@viscovery.net> <7vy73tltf5.fsf@gitster.siamese.dyndns.org> <20080722193901.GA5113@blimp.local> <alpine.DEB.1.00.0807222115440.8986@racer> <20080722203128.GB5113@blimp.local> <7vr69lihkt.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 18:47:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLhUk-0004nH-EM
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 18:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbYGWQqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 12:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbYGWQqS
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 12:46:18 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:12197 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbYGWQqS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 12:46:18 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f5EC7
Received: from tigra.home (Faf34.f.strato-dslnet.de [195.4.175.52])
	by post.webmailer.de (fruni mo33) (RZmta 16.47)
	with ESMTP id c02783k6NGXGYX ; Wed, 23 Jul 2008 18:46:14 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 5D2D1277BD;
	Wed, 23 Jul 2008 18:46:14 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 4615436D18; Wed, 23 Jul 2008 18:46:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vr69lihkt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89707>

Junio C Hamano, Wed, Jul 23, 2008 02:12:50 +0200:
> >> Otherwise, if you really want to tell at compile time,I think for clarity 
> >> you have to introduce another #define, since NO_TRUSTABLE_FILEMODE 
> >> definitely says something different than CTIME_IS_USELESS.
> >
> > I had that at first (NO_DEPENDABLE_CTIME, than IGNORE_CTIME), than
> > deemed it excessive.
> 
> Why is it excessive?  My initial reaction was "what does trustable
> filemode nor trust_executable_bit has anything to do with ctime".  Please
> explain.

Because exactly the file mode (the executable bit) is the reason for
checking ctime. Otherwise there is no point: Git doesn't save any
other data which when changed cause a ctime update. And exactly the
file mode is completely broken on that cygwin thing. Which is
precisely pointed by NO_TRUSTABLE_FILEMODE. Hence - just it.
