From: Jeff King <peff@peff.net>
Subject: Re: Local clone checks out wrong branch based on remote HEAD
Date: Thu, 19 Mar 2009 00:02:29 -0400
Message-ID: <20090319040229.GA32435@coredump.intra.peff.net>
References: <b97024a40903171219k8841508p774d9dc4295a09bc@mail.gmail.com> <20090318005413.GC25454@coredump.intra.peff.net> <49C0C769.8020401@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tom Preston-Werner <tom@github.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 05:06:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk9WC-0007Ke-Eg
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 05:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbZCSECk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 00:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbZCSECj
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 00:02:39 -0400
Received: from peff.net ([208.65.91.99]:48705 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbZCSECj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 00:02:39 -0400
Received: (qmail 29377 invoked by uid 107); 19 Mar 2009 04:02:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Mar 2009 00:02:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2009 00:02:29 -0400
Content-Disposition: inline
In-Reply-To: <49C0C769.8020401@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113712>

On Wed, Mar 18, 2009 at 11:05:29AM +0100, Michael J Gruber wrote:

> One might even argue that in case of ambiguities, checking out a
> detached head would be most appropriate. Really, why impose creation of
> certain local branches on a user at all, unless asked for? Detached
> heads are natural in git! But I don't really expect positive consensus
> on that one...

I'm not sure that detached HEADs are all that natural. It means that:

  git clone repo-with-ambiguous-HEAD foo
  cd foo
  hack hack hack
  git commit -a -m msg

is putting your commits "nowhere" (i.e., not on any ref). They are not
accessible for pushing, and when you checkout another branch, they will
be lost (except to the reflog).

So it clearly requires that the user be aware of what is going on, and
that they understand the subtleties of detached HEADs (something that
has caused new user confusion before, I think).

-Peff
