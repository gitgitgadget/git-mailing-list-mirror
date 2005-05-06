From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: How do I...
Date: Fri, 06 May 2005 20:10:27 +0100
Message-ID: <1115406628.16187.353.camel@hades.cambridge.redhat.com>
References: <427B3DB3.4000507@tuxrocks.com>
	 <Pine.LNX.4.58.0505060905090.2233@ppc970.osdl.org>
	 <7vsm10cnx3.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0505061006060.2233@ppc970.osdl.org>
	 <1115404771.16187.343.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0505061158520.2233@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Sorenson <frank@tuxrocks.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 21:05:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU87I-0003ie-Jq
	for gcvg-git@gmane.org; Fri, 06 May 2005 21:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVEFTKp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 15:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVEFTKp
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 15:10:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34444 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261274AbVEFTKe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 15:10:34 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DU8DV-0001sp-00; Fri, 06 May 2005 20:10:29 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505061158520.2233@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-05-06 at 11:59 -0700, Linus Torvalds wrote:
> I don't do no steenking GUI's. That's for others, and you'll need to
> parse the git-rev-list output yourself to do that.

When I said 'show' I meant merely provide sufficient information. 

I believe that what you get at the moment from the command you showed is
an unconnected list of commits, each of which may be in different
branches, where the _parent_ of each commit you show may not even be
included in the list. 

I.e. you're giving them a bag of unconnected objects which each look
something like this...

		 (COMMIT)--> 
or
		 (COMMIT)--->
		         \-->


But you need to give them a _graph_...

	/------> (COMMIT) --> (COMMIT) --\
 (COMMIT)                                 -> (COMMIT) 
	\-----------> (COMMIT) ----------/

Leaving the pretty GUI as an exercise for the reader is fine. But we do
actually have to give enough information to allow them to connect the
bits together.

My recursive script attempted this but wasn't quite good enough -- we
had enough information to track _merges_ but not _branches_. Hence I was
only giving this much information...

	/------> (COMMIT) --> (COMMIT) --\
 (COMMIT)                                 -> (COMMIT) 
	              (COMMIT) ----------/

(...or this one, depending on which order I parsed the tree...)

	         (COMMIT) --> (COMMIT) --\
 (COMMIT)                                 -> (COMMIT) 
	\-----------> (COMMIT) ----------/

-- 
dwmw2

