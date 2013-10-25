From: Jeff King <peff@peff.net>
Subject: Re: Fwd: Errors when diff'ing arbitrary upstream remotes are not
 intuitive if git pull --all hasn't been done
Date: Fri, 25 Oct 2013 02:14:08 -0400
Message-ID: <20131025061407.GE11810@sigill.intra.peff.net>
References: <CAGH67wSf_RQigCmqRZKOpHdV9ELqE=078mkpwA4dfnUr=AvGVQ@mail.gmail.com>
 <CAGH67wRwb1A9CzAfod_XLRVFBRyoEron8tmM+NbMGOeKDVf2Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "yaneurabeya ." <yanegomi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 08:14:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZaf2-0006NA-EL
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 08:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab3JYGOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 02:14:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:55342 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750861Ab3JYGOK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 02:14:10 -0400
Received: (qmail 4053 invoked by uid 102); 25 Oct 2013 06:14:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Oct 2013 01:14:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 02:14:08 -0400
Content-Disposition: inline
In-Reply-To: <CAGH67wRwb1A9CzAfod_XLRVFBRyoEron8tmM+NbMGOeKDVf2Hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236681>

On Thu, Oct 24, 2013 at 11:07:05AM -0700, yaneurabeya . wrote:

>     I added an arbitrary upstream remote thinking that I could just
> git diff the upstream remote's master. Turns out I needed to run git
> pull --all in order to be able to diff the file (I forgot that step).

Actually, you can just run "git fetch"; you just need to fetch the
commits from the remote, but you do not need to merge them (and pull is
a fetch plus a merge).

>     Could this error message be improved for interactive commands by
> first checking to see whether or not the path starts with a remote,
> then recommend that the remote be pulled?

That might be worth doing. We cannot definitely say the branch exists
without hitting the network (which we would not want to do in the
general case), but I think it is reasonable for git to give suggestions
(we could also give a "did you mean X..." for near-typos, as we do for
typo-ed commands like "git dif".

If you do try it, please don't just check for the remote name, but
actually complete the right-hand side of the fetch refspec for each
remote. They are equivalent in the default config, but aren't
necessarily so (and there has been talk of adjusting the layout of
remote refspecs). I don't recall offhand what functions we have to help
you, but I believe Johan (cc'd) was working in this area recently and
might be able to say more.

> If this seems sane, I could whip up a patch and post it in a github
> pull request.

If you do write a patch, please send it to the list, as the github
repository is a mirror, and actual development happens here. Details are
in Documentation/SubmittingPatches.

-Peff
