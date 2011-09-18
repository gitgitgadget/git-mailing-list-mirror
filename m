From: Jeff King <peff@peff.net>
Subject: Re: Most elegant way to reference to SVN from GIT?
Date: Sat, 17 Sep 2011 23:43:18 -0400
Message-ID: <20110918034318.GC17977@sigill.intra.peff.net>
References: <j53c2h$gff$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
X-From: git-owner@vger.kernel.org Sun Sep 18 05:43:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R58Ht-0006Y9-NQ
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 05:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756319Ab1IRDnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Sep 2011 23:43:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43749
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755485Ab1IRDnU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 23:43:20 -0400
Received: (qmail 11257 invoked by uid 107); 18 Sep 2011 03:44:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 Sep 2011 23:44:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Sep 2011 23:43:18 -0400
Content-Disposition: inline
In-Reply-To: <j53c2h$gff$2@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181602>

On Sun, Sep 18, 2011 at 01:51:44AM +0200, Manuel Reimer wrote:

> Now someone offered to contribute a translation. This translation is
> hosted on a SVN server.
> 
> How can I get his work into my GIT tree and how can I keep things updated?

You can pull their commits into git using git-svn, and then merge them.
Try:

  # make a new repo side by side with your project that contains
  # their translation
  cd /path/to/your-project/..
  git svn clone https://host/their-subversion-repo their-translation

  # inspect with "git log", "ls", etc to make sure it looks sane
  # if so, then merge it in
  cd ../your-project
  git pull ../their-translation git-svn

  # months later, get an update
  cd their-translation
  git svn fetch
  cd ../your-project
  git pull ../their-translation git-svn

I think you could also do it all in one repo by using "git svn init" and
"git svn fetch", but you'd have to check "git help svn" for the exact
syntax.

-Peff
