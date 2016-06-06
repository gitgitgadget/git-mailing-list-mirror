From: Jeff King <peff@peff.net>
Subject: Re: `man 1 git`: Invalid link to online documentation
Date: Mon, 6 Jun 2016 19:19:36 -0400
Message-ID: <20160606231936.GB22756@sigill.intra.peff.net>
References: <ed8f000f-b8a2-ca92-e0f2-e26ff9928bbe@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Campbell <zlg@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 01:19:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA3o8-00035M-H0
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 01:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbcFFXTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 19:19:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:50021 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752290AbcFFXTj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 19:19:39 -0400
Received: (qmail 689 invoked by uid 102); 6 Jun 2016 23:19:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Jun 2016 19:19:38 -0400
Received: (qmail 23621 invoked by uid 107); 6 Jun 2016 23:19:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Jun 2016 19:19:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jun 2016 19:19:36 -0400
Content-Disposition: inline
In-Reply-To: <ed8f000f-b8a2-ca92-e0f2-e26ff9928bbe@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296573>

On Sun, Jun 05, 2016 at 08:59:00PM -0700, Daniel Campbell wrote:

> In `man 1 git`, the Description section outlines an address to
> pre-generated documentation [0]. That link returns a 404 error. Playing
> around, I found the repository at [1] and found that it hasn't been
> updated since August 2015. Given that 2.8.3 is more recent than that, it
> seems like this is something that should be updated (if the
> pre-generated docs still exist somewhere) or removed altogether.
> 
> Also worth considering is Google Code was shut down earlier this year.
> While archives exist, it can't be relied upon for future use. The
> closest approximation I could find that was up to date is [2], though
> [3] is a repository that's even fresher than 2.8.3.

Yeah, I think Google Code is out. The git-scm.com page automatically
pulls in released versions of the pages, but not the tip of master
(which is what the git-htmldocs repository has).

That repository is hosted at kernel.org and at GitHub, so either of:

  https://git.kernel.org/cgit/git/git-htmldocs.git/plain/git.html

  https://raw.githubusercontent.com/gitster/git-htmldocs/master/git.html

but in both cases the content-type is such that it doesn't render in a
browser (and at least in the GitHub case, that is intentional; we don't
want people using their repos directly as a CDN. They should build a
Pages site and push to it).

So I think the options are basically:

  1. Point to git-scm.com/docs as "new enough" as it covers released
     versions (and lets you walk back to earlier versions, too). People
     who want bleeding edge can clone htmldocs themselves.

  2. Make git-htmldocs a real site on GitHub. I think this should be as
     simple as pushing to the `gh-pages` branch of the repository, which
     would make it available as https://gitster.github.io/git-htmldocs.
     You can do a bunch of Jekyll magic, but you don't have to; it should
     serve arbitrary html files (though I think we'd maybe want to add
     an "index.html"; we may also want to host it under a git/htmldocs
     project just to make the repo more official looking).

  3. Publish to some other Pages-like service. I don't think kernel.org
     has one, but it's not like there's a lack of sites you can push
     static HTML files to. I mentioned GitHub in (2) mostly because
     Junio already pushes there.

-Peff
