From: Jeff King <peff@peff.net>
Subject: Re: A little help with error?
Date: Wed, 10 Aug 2011 06:21:21 -0600
Message-ID: <20110810122121.GB17071@sigill.intra.peff.net>
References: <752985D1B23046F994920F9018B53DF8@rustydogink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Rusty Dog Ink <chris@rustydogink.com>
X-From: git-owner@vger.kernel.org Wed Aug 10 14:21:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qr7mt-0006jw-Da
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 14:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965Ab1HJMV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Aug 2011 08:21:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52016
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931Ab1HJMVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 08:21:25 -0400
Received: (qmail 16267 invoked by uid 107); 10 Aug 2011 12:22:01 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Aug 2011 08:22:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Aug 2011 06:21:21 -0600
Content-Disposition: inline
In-Reply-To: <752985D1B23046F994920F9018B53DF8@rustydogink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179066>

On Sun, Aug 07, 2011 at 02:16:57PM -0700, Rusty Dog Ink wrote:

> git add --force /Users/chris/Sites/mattSchubert/public/css/browserfix.css => "Crappy Error"
> Yields this error.
> fatal: '/Users/chris/Sites/mattSchubert/public/css/browserfix.css' is outside repository 

We can't say if this is reasonable or not without knowing more. Which
directory are you in? Which git repository do you expect to be found?
Which repository does git actually find (try "git rev-parse --git-dir")?
Do you have GIT_WORK_TREE set in the environment, or core.worktree set
in your config?

> This command does gives the same error. 
> git add --force /public/css/browserfix.css => "Same error"
> But this command, works. Why?
> git add --force public/css/browserfix.css => "Works yeah"

The top one seems nonsensical, unless your git repository is at one of:

  /.git
  /public/.git
  /public/css/.git

The bottom one makes sense; you are looking at files in the current
directory, which is going to be inside your repository (unless you are
setting some of worktree variables I mentioned above).

Are you trying to do something clever with symlinks to /public? If so,
show us.

-Peff
