From: Jeff King <peff@peff.net>
Subject: Re: Find the starting point of a local branch
Date: Mon, 24 Dec 2012 10:34:15 -0500
Message-ID: <20121224153415.GA28670@sigill.intra.peff.net>
References: <20121224035825.GA17203@zuhnb712>
 <201212240409.qBO49wkV020768@no.baka.org>
 <CACsJy8CNd3W_WUMbZ1QZ4ReZ5ziX90QejK9mh1TMs0ig33kGMw@mail.gmail.com>
 <20121224061938.GA25186@sigill.intra.peff.net>
 <CACsJy8Dt94XLSa8Sg3T0URJYG9cHD_sUySuhm3Vu4ESy-VrXag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Seth Robertson <in-gitvger@baka.org>,
	Woody Wu <narkewoody@gmail.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 16:34:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnA31-0004ow-85
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 16:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab2LXPeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 10:34:18 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35148 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597Ab2LXPeR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 10:34:17 -0500
Received: (qmail 20418 invoked by uid 107); 24 Dec 2012 15:35:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Dec 2012 10:35:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Dec 2012 10:34:15 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8Dt94XLSa8Sg3T0URJYG9cHD_sUySuhm3Vu4ESy-VrXag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212113>

On Mon, Dec 24, 2012 at 06:16:05PM +0700, Nguyen Thai Ngoc Duy wrote:

> > The reason that git does not bother storing "where did I start this
> > branch" is that it is usually not useful. The right question is usually
> > "what is the merge base". There are exceptions, of course (e.g., if you
> > are asking something like "what work did I do while checked out on the
> > 'foo' branch"). But for merging and rebasing, I think the computed
> > merge-base is much more likely to do what people want.
> 
> Rebasing is exactly why I want this. Merge base works most of the time
> until you rewrite upstream (which I do sometimes).

True, although wouldn't you generally want to rebase it on top of the
rewritten upstream in that case (which is what "pull --rebase" will do,
by scanning the reflog for the last version of the upstream that you
actually built on).

> There are also cases when I create a branch without upstream, or when
> upstream is renamed. Still, making "rebase -i --topic" == "rebase -i
> $(git merge-base HEAD @{upstream})" would be cool.

Yeah. I usually just do "rebase -i @{upstream}" which picks the same
commits, but moves to the updated version of upstream (IOW, I both
rewrite and move forward at the same time). But there is value in
rewriting without moving forward in many workflows. That seems like a
sensible feature to me.

-Peff
