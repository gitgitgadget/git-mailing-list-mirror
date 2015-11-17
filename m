From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] blame: avoid checking if a file exists on the working
 tree if a revision is provided
Date: Tue, 17 Nov 2015 17:48:10 -0500
Message-ID: <20151117224809.GE27862@sigill.intra.peff.net>
References: <1447723762-32309-1-git-send-email-eantoranz@gmail.com>
 <CAPig+cTjg8yvmLO0uuWZt4nATUnfxJOj4f_AmvRP9mHsGRmEOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Edmundo Carmona Antoranz <eantoranz@gmail.com>,
	Git List <git@vger.kernel.org>, Max Kirillov <max@max630.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 23:48:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zyp2v-0003W7-Qt
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 23:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869AbbKQWsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 17:48:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:58998 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751163AbbKQWsM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 17:48:12 -0500
Received: (qmail 15142 invoked by uid 102); 17 Nov 2015 22:48:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Nov 2015 16:48:12 -0600
Received: (qmail 30937 invoked by uid 107); 17 Nov 2015 22:48:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Nov 2015 17:48:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Nov 2015 17:48:10 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cTjg8yvmLO0uuWZt4nATUnfxJOj4f_AmvRP9mHsGRmEOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281425>

On Tue, Nov 17, 2015 at 12:11:25AM -0500, Eric Sunshine wrote:

> > blame content even if the path provided does match an existing
> > blob on said revision.
> 
> git-blame documentation does not advertise "blame <file> <rev>" as a
> valid invocation. It does advertise "blame <rev> -- <file>", and this
> case already works correctly even when <file> does not exist in the
> worktree.

Hmm. Out of curiosity I tried:

  git blame v2.4.0 -- t/t6031-merge-recursive.sh

and it segfaults. This bisects to Max's recent 1b0d400 (blame: extract
find_single_final, 2015-10-30), but I do not see anything obviously
wrong with it from a quick glance.

-Peff
