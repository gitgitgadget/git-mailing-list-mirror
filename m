From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH 1/4] Add history graph API
Date: Mon, 7 Apr 2008 01:06:01 -0700
Message-ID: <20080407080600.GA9298@adamsimpkins.net>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net> <20080407072629.GA5168@mithlond.arda.local>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon Apr 07 10:06:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JimNM-0000j8-FE
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 10:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbYDGIGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 04:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbYDGIGE
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 04:06:04 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:55538 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbYDGIGD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 04:06:03 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 39A2F1B4068;
	Mon,  7 Apr 2008 04:06:02 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 186021B404D;
	Mon,  7 Apr 2008 04:06:02 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 21F4514100BB; Mon,  7 Apr 2008 01:06:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080407072629.GA5168@mithlond.arda.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78959>

On Mon, Apr 07, 2008 at 10:26:29AM +0300, Teemu Likonen wrote:
> 
> As I've spent some time in testing the --graph functionality I'm
> spamming my discoveries here.
> 
> When limiting the log output to a subdirectory or to a file the graph
> becomes quite hard to understand. Probably the easiest way to
> demonstrate my point is to compare side by side (for example)
> 
>   git log --graph --pretty=oneline -- Documentation/
>  
> and
> 
>   gitk -- Documentation/
> 
> in the Git repository. gitk draws lines between commits even when they
> are not in direct parent-child relationship (i.e. there is longer series
> of commits between them). With log --graph it's hard to tell which
> development line some commits come from.

Interesting, I wasn't aware of this gitk behavior.  I took a look at
the gitk code, and they're able to do this by passing the "--parents"
option to "git log".  This causes git to rewrite the parent
information so that it lists the most recent ancestor that is in the
resulting commit set, instead of the actual parent.

It was pretty easy to change "git log --graph" to do the same; I just
sent out a new patch for it.

Thanks for all the testing!

-- 
Adam Simpkins
adam@adamsimpkins.net
