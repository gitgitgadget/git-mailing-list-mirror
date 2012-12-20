From: Aaron Schrab <aaron@schrab.com>
Subject: Re: RFC: "git config -l" should not expose sensitive information
Date: Thu, 20 Dec 2012 10:49:15 -0500
Message-ID: <20121220154915.GA5162@pug.qqx.org>
References: <50CF039A.7010800@gmx.de>
 <20121220150408.GD27211@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 16:49:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TliNf-0003vs-9E
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 16:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab2LTPtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 10:49:22 -0500
Received: from pug.qqx.org ([50.116.43.67]:42828 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832Ab2LTPtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 10:49:16 -0500
Received: by pug.qqx.org (Postfix, from userid 1000)
	id EB6821D428; Thu, 20 Dec 2012 10:49:15 -0500 (EST)
Mail-Followup-To: Jeff King <peff@peff.net>,
	Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20121220150408.GD27211@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+117 (g1ec2bd0) (2012-12-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211899>

At 10:04 -0500 20 Dec 2012, Jeff King <peff@peff.net> wrote:
>The problem seems to be that people are giving bad advice to tell 
>people to post "git config -l" output without looking at. Maybe we 
>could help them with a "git config --share-config" option that dumps 
>all config, but sanitizes the output. It would need to have a list of 
>sensitive keys (which does not exist yet), and would need to not just 
>mark up things like smtppass, but would also need to pull credential 
>information out of remote.*.url strings. And maybe more (I haven't 
>thought too long on it).

If such an option is added, it is likely to cause more people to think 
that there is no need to examine the output before sharing it.  But, I 
don't think that the sanitizing could ever be sufficient to guarantee 
that.

Tools outside of the core git tree may add support for new config keys 
which are meant to contain sensitive information, and there would be no 
way for `git config` to know about those.

Even for known sensitive keys, the person entering it might have made a 
typo in the name (e.g.  smptpass) preventing it from being recognized as 
sensitive by the software, but easily recognizable as such by a human.

There's also the problem of varying opinions on what is considered as 
sensitive.  You mention credential information in URLs, but some people 
may consider the entire URL as something which they would not want to 
expose.

I think that attempting to do this would only result in a false sense of 
security.
