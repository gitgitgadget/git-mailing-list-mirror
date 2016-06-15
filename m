From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch: document that pruning happens before fetching
Date: Tue, 14 Jun 2016 23:46:29 -0400
Message-ID: <20160615034629.GB3013@sigill.intra.peff.net>
References: <20160613235850.GA8009@sigill.intra.peff.net>
 <CACsJy8Ds_DnBLJ0jx7Pp9EH1coG-xAtri4w4hh__=nigCmBbdA@mail.gmail.com>
 <20160614102210.GA14357@sigill.intra.peff.net>
 <CACsJy8Bbd0=vnbaj4-2m7WKfvWG6PfyXLg1h+970HPsak1hnMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Tom Miller <jackerran@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 05:46:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD1mp-0005fp-A5
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 05:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbcFODqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 23:46:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:55012 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751113AbcFODqc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 23:46:32 -0400
Received: (qmail 30568 invoked by uid 102); 15 Jun 2016 03:46:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 23:46:32 -0400
Received: (qmail 2831 invoked by uid 107); 15 Jun 2016 03:46:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 23:46:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 23:46:29 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8Bbd0=vnbaj4-2m7WKfvWG6PfyXLg1h+970HPsak1hnMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297352>

On Tue, Jun 14, 2016 at 05:36:35PM +0700, Duy Nguyen wrote:

> > or what would happen if the packfile
> > fetch failed (we'd already have deleted the old refs, but wouldn't fetch
> > the new ones).
> 
> Off topic, but this sounds like a bug to me. We could have kept ref
> update more consistent (maybe at some point we could even do atomic
> transaction update for all refs if there's a need for it).

I do think atomic ref transactions are a nice idea, and would probably
not be too hard to implement these days (the main thing is just
refactoring the deep call stack in git-fetch).

It's possible it could be annoying when you have a single broken ref
(and would prefer to just ignore it), but that _should_ be the rare
case.

-Peff
