From: Jeff King <peff@peff.net>
Subject: Re: git diff bug?
Date: Mon, 6 Apr 2009 11:53:04 -0400
Message-ID: <20090406155303.GA3275@sigill.intra.peff.net>
References: <m2ocvdkyul.fsf@boostpro.com> <20090404014527.GA13350@coredump.intra.peff.net> <1BF9172A-BE91-4D1C-932A-EB9FD79BA402@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 17:54:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqr9q-0008Mw-4H
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 17:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbZDFPxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 11:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbZDFPxK
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 11:53:10 -0400
Received: from peff.net ([208.65.91.99]:33773 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbZDFPxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 11:53:09 -0400
Received: (qmail 24769 invoked by uid 107); 6 Apr 2009 15:53:26 -0000
Received: from 97-81-69-92.dhcp.athn.ga.charter.com (HELO sigill.intra.peff.net) (97.81.69.92)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 06 Apr 2009 11:53:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Apr 2009 11:53:04 -0400
Content-Disposition: inline
In-Reply-To: <1BF9172A-BE91-4D1C-932A-EB9FD79BA402@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115847>

On Mon, Apr 06, 2009 at 05:09:32AM -0400, David Abrahams wrote:

> Hmm, so I tried sticking this .gitattributes in my repo
>
>   *.el   diff=el
>   [diff "el"]
>         xfuncname = "^(\\(def[a-z]+ .+)$"
>
> and git diff barfed with

As Michael explained, the first line goes into .gitattributes, and the
second two go into your .git/config.

The reason is that the first line is describing a property of files
in the repo: "*.el is of type 'el' for diffing". And thus it makes sense
for it to be committed along with the content in the repo.

But the latter two lines are about preference: "here is how _I_ would
like to generate diffs for el files". So they go in your personal config
which is not shipped with the repo. And most likely you would want to
put them not in per-repo config, but in your user config:
$HOME/.gitconfig.

All of that being said, it is obviously a documentation failure if it
didn't explain in which files the various parts go. If you don't mind,
can you skim over the documentation you read one more time and point out
where it led you wrong?  Maybe we can make it a little clearer.

-Peff
