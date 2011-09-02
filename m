From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] remote: "rename o foo" should not rename ref
 "origin/bar"
Date: Fri, 2 Sep 2011 11:55:21 -0400
Message-ID: <20110902155521.GA19690@sigill.intra.peff.net>
References: <1314841843-19868-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1314841843-19868-2-git-send-email-martin.von.zweigbergk@gmail.com>
 <20110901024617.GD31838@sigill.intra.peff.net>
 <alpine.DEB.2.00.1109012022110.7267@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 02 17:55:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzW5a-0003gH-QY
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 17:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203Ab1IBPzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 11:55:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54812
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011Ab1IBPzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 11:55:25 -0400
Received: (qmail 31513 invoked by uid 107); 2 Sep 2011 15:56:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Sep 2011 11:56:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2011 11:55:21 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1109012022110.7267@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180616>

On Thu, Sep 01, 2011 at 08:35:01PM -0400, Martin von Zweigbergk wrote:

> > To be totally correct, shouldn't this check each ref against the RHS of
> > the remote's old refspec, and rename it according to the remote's new
> > refspec?
> 
> That's what I thought too, but was planning on leaving it for a
> separate patch. However, after changing patch 1 to only update the
> fetch refspecs from "refs/remotes/$OLD" to "refs/remotes/$NEW", there
> is no other place in the fetchspec where a remote name can occur and
> 'git remote rename' still understands it. So since we're now being
> more conservative about updating refspecs, I guess we need to be
> equally conservative about updating ref names.

Yeah, I think with the change in patch 1, your patch 2 is very
reasonable. It is admitting that "git remote" is really about tweaking
the default remote config, and punting on config that doesn't appear to
follow it. And doing it consistently. I don't think there's nothing
wrong with that.

-Peff
