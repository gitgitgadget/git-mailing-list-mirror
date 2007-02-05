From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Mon, 5 Feb 2007 10:43:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702051014040.8424@woody.linux-foundation.org>
References: <Pine.LNX.4.63.0702020028540.18776@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070201234706.GP17617@mellanox.co.il>
 <Pine.LNX.4.63.0702020050190.18870@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz3xmju9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702021146440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz3wdjxu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702051245050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz3smqpp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 19:44:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE8p3-0001fT-V0
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 19:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbXBESoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 13:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbXBESoJ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 13:44:09 -0500
Received: from smtp.osdl.org ([65.172.181.24]:54634 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932436AbXBESoH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 13:44:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l15IhLQ5021421
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Feb 2007 10:43:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l15IhJhg027707;
	Mon, 5 Feb 2007 10:43:20 -0800
In-Reply-To: <7vmz3smqpp.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.308 required=5 tests=AWL,HTML_MESSAGE,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.173 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38766>



On Mon, 5 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > 	git clone git://.../git.git#html
> >
> > to mean "just fetch the branch html, and check it out".
> 
> Except that I do not particularly think the URL fragment
> notation is such a "cool" syntax.

I think the cogito '#'<branch> syntax is braindead.

Much better to use native git syntax, which is to just list the branch 
separately. Why? Not only is it the way we do things for pull and friends, 
it's also what allows us to specify *multiple* branches.

So I would personally welcome a "clone just a particular branch", but in 
that case I'd like it to be able to say more than one too..

(In general, even if I clone _everything_, I'd also like to perhaps set 
the default 'master' branch to track something else than what I'm cloning 
from. In fact, I think I'd generally prefer cloning everything, but 
sometimes I'd like to say "I'm going to track the upstreams branch xyzzy 
rather than their default branch").

I realize that the

	git clone <repo> [<dir>]

means that we can't have the same syntax as "git pull" (which doesn't take 
the <dir> part), but that doesn't make the "#branch" syntax any better.

So I much prefer the

	git clone [--default branch] [--branch x]* <repo> [<dir>

kind of syntax.

			Linus
