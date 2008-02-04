From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Mon, 4 Feb 2008 12:50:03 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org>
References: <20080202122135.GA5783@code-monkey.de> <20080203030054.GA18654@coredump.intra.peff.net> <20080203043310.GA5984@coredump.intra.peff.net> <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org> <7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 21:51:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM8HY-0004B2-Nl
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 21:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756493AbYBDUuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 15:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756014AbYBDUuj
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 15:50:39 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53115 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755393AbYBDUui (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2008 15:50:38 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m14Ko4Zb025901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Feb 2008 12:50:05 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m14Ko3tT016508;
	Mon, 4 Feb 2008 12:50:04 -0800
In-Reply-To: <alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.215 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72562>



On Mon, 4 Feb 2008, Linus Torvalds wrote:
> 
> Gaah. This is that stupid apporach.

.. and it won't actually solve the problem you pointed to. It's not enough 
that the positive commits should be connected to the negative ones, the 
problem is that no negative ones could possibly connect to the positives. 

So scratch that patch as broken too. 

Really annoying. It does look like we really want to check the *totally* 
connected case, and we simply cannot do the "two unconnected trees" 
decision case without traversing both trees fully (since we won't know 
that they are *really* unconnected until we do).

And that seems really quite expensive. I wonder if I've missed something 
again.

		Linus
