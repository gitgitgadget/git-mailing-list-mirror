From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: warning: no common commits - slow pull
Date: Wed, 27 Feb 2008 14:28:15 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802271411280.19665@iabervon.org>
References: <200802102007.38838.lenb@kernel.org> <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org> <200802261438.17014.lenb@kernel.org> <7vir0byoc2.fsf@gitster.siamese.dyndns.org> <7voda2yksf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Len Brown <lenb@kernel.org>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 20:29:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURxa-0005a6-H6
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756190AbYB0T2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 14:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756247AbYB0T2T
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 14:28:19 -0500
Received: from iabervon.org ([66.92.72.58]:57471 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755776AbYB0T2S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 14:28:18 -0500
Received: (qmail 28558 invoked by uid 1000); 27 Feb 2008 19:28:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2008 19:28:15 -0000
In-Reply-To: <7voda2yksf.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75289>

Correcting the transport code is important (and should probably be done in 
transport.c, if possible), but I think we're being a bit silly in 
autofollowing tags anyway. If we decide to fetch T due to having T^{}, we 
should tell the remote up front that we have T^{}, before we mention 
anything else, because it's obviously true and it's also absolutely 
certain to make the remote immediately do the right thing. It's silly to 
decide to fetch T because we will only need that one object, and then not 
instantly tell the server we only need that one object. (And, as luck 
would have it, yesterday I wrote code to cause for_each_ref return some
specific values in addition to and before the actual stored refs.)

Of course, we shouldn't do this until we make the transport code more 
correct, because it's certain to hide any possible bug there.

Am I missing something in my analysis?

	-Daniel
*This .sig left intentionally blank*
