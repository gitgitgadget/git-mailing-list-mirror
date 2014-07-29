From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] use a hashmap to make remotes faster
Date: Tue, 29 Jul 2014 13:46:42 -0400
Message-ID: <20140729174642.GB20042@peff.net>
References: <25222.0938886865-sendEmail@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git <git@vger.kernel.org>
To: Patrick Reynolds <patrick.reynolds@github.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 19:46:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCBUA-0004Ux-Ta
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 19:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbaG2Rqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 13:46:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:42597 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750857AbaG2Rqq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 13:46:46 -0400
Received: (qmail 1767 invoked by uid 102); 29 Jul 2014 17:46:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jul 2014 12:46:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2014 13:46:42 -0400
Content-Disposition: inline
In-Reply-To: <25222.0938886865-sendEmail@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254449>

On Tue, Jul 29, 2014 at 02:43:39PM +0000, Patrick Reynolds wrote:

> Remotes are stored as an array, so looking one up or adding one without
> duplication is an O(n) operation.  Reading an entire config file full of
> remotes is O(n^2) in the number of remotes.  For a repository with tens of
> thousands of remotes, the running time can hit multiple minutes.
> 
> Hash tables are way faster.  So we add a hashmap from remote name to
> struct remote and use it for all lookups.  The time to add a new remote to
> a repo that already has 50,000 remotes drops from ~2 minutes to < 1
> second.
> 
> We retain the old array of remotes so iterators proceed in config-file
> order.
> 
> Signed-off-by: Patrick Reynolds <patrick.reynolds@github.com>

As observers might have guessed, I already reviewed this off-list, but
to make it clear:

  Reviewed-by: Jeff King <peff@peff.net>

-Peff
