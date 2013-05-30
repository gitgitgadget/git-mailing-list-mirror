From: Erik de Castro Lopo <mle+tools@mega-nerd.com>
Subject: Re: Retrieving a file at a before a specified commit
Date: Thu, 30 May 2013 10:49:32 +1000
Organization: Erik Conspiracy Secret Labs
Message-ID: <20130530104932.d7ba4bfb426044ab9653057e@mega-nerd.com>
References: <20130529164735.5489ab47953406745d9034ef@mega-nerd.com>
	<20130529075811.GA7204@sigill.intra.peff.net>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 02:49:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhr3k-0002Y1-IK
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 02:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759696Ab3E3Ath (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 20:49:37 -0400
Received: from hendrix.mega-nerd.net ([203.206.230.162]:37861 "EHLO
	hendrix.mega-nerd.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759687Ab3E3Atf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 20:49:35 -0400
Received: from rollins.mnn (pharoah-vpn [10.9.8.2])
	by hendrix.mega-nerd.net (Postfix) with SMTP id C4B88106DF9;
	Thu, 30 May 2013 10:49:32 +1000 (EST)
In-Reply-To: <20130529075811.GA7204@sigill.intra.peff.net>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225904>

Jeff King wrote:

> Yes, that should work as long as the file is modified and not added. You
> can also say "4d77a3cee^:A/B/C" if you do not want to look up the parent
> id yourself.

Thanks, that's useful to know.

> Note that for a merge commit with multiple parents, the question is more
> complex, as there are two previous states that are merged.

This is not the case in the one I am currently looking at. There is a single
parent commit.

> You say that it doesn't work in one particular case. What is that case?
> What happens?

Here is an example. Grab this repository:

    git clone git://github.com/qca/open-plc-utils.git
    cd open-plc-utils/

Look at this commit:

    git log --name-status f51ac745a6d4087cc4d77a3cee01db0412955c79

and notice that one of the files modified is "pib/chkpib2.7", so lets
look at the parent version of that file:

    git show f51ac745a6d4087cc4d77a3cee01db0412955c79^:pib/chkpib2.7

which produces no output and exits with 0 status.

However looking at the diff for commit f51ac745a suggests that while
the file pib/chkpib2.7 may have existed before that commit, it must
have been empty (ie zero length).

Does this explanation make sense?

Erik
-- 
----------------------------------------------------------------------
Erik de Castro Lopo
http://www.mega-nerd.com/
