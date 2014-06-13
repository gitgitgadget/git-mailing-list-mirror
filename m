From: Jeff King <peff@peff.net>
Subject: Re: Confusing error message in rebase when commit becomes empty
Date: Fri, 13 Jun 2014 03:31:13 -0400
Message-ID: <20140613073113.GE7908@sigill.intra.peff.net>
References: <alpine.DEB.2.00.1406111321090.6307@ds9.cixit.se>
 <CABURp0rC3yktDiRVQwo9E+x5_wKLnLVRx87ej+m+TyUdBkMpOA@mail.gmail.com>
 <alpine.DEB.2.00.1406111854180.21431@ds9.cixit.se>
 <CABURp0q1c+75VzMfttDWVXhTFma3g=Tj938J_9i9xhG1yuMpdQ@mail.gmail.com>
 <alpine.DEB.2.00.1406130823251.27436@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phil Hord <phil.hord@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Fabian Ruch <bafain@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Jun 13 09:31:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvLxH-0001Gz-T0
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 09:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbaFMHbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 03:31:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:43238 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750855AbaFMHbP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 03:31:15 -0400
Received: (qmail 9468 invoked by uid 102); 13 Jun 2014 07:31:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 02:31:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 03:31:13 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1406130823251.27436@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251525>

On Fri, Jun 13, 2014 at 08:25:43AM +0100, Peter Krefting wrote:

> >Yes, but empty commits are discouraged on some projects.  If you want your
> >"change + revert = empty" commit to appear after the squash, I would
> >expect you would want to use --keep-empty on your inital rebase command.
> >But I'm not sure that will do what you expected either; it may only keep
> >previously-empty commits during the rebase.
> 
> The thing is that I wasn't expecting it to come out empty, as I had another
> commit to squash into it. That the interim throw-away squashed commit was
> empty should have been an internal matter to rebase, IMHO.

That's a good point that I neglected in my other response. Maybe the
right solution is for "rebase --interactive" to always pass
"--allow-empty" when doing a squash. And then either:

  1. Always keep such empty commits. A user who is surprised by them
     being empty can then revisit them. Or drop them by doing another
     rebase without --keep-empty.

  2. Notice ourselves that the end-result of the whole squash is an
     empty commit, and stop to let the user deal with it.

-Peff
