From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] config.mak.uname: Darwin: define HAVE_GETDELIM for
 modern OS X releases
Date: Tue, 2 Jun 2015 16:01:34 -0400
Message-ID: <20150602200134.GA13382@peff.net>
References: <1433269138-10890-1-git-send-email-sunshine@sunshineco.com>
 <1433269138-10890-2-git-send-email-sunshine@sunshineco.com>
 <20150602184413.GA11437@peff.net>
 <20150602190403.GA12660@peff.net>
 <CAPig+cQLSF4=-4b1qOY4ChBj00=trvAO0qFEh0kOjLonJL4MBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 22:01:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzsNf-0004MJ-Rd
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 22:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbbFBUBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 16:01:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:39922 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751380AbbFBUBh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 16:01:37 -0400
Received: (qmail 20225 invoked by uid 102); 2 Jun 2015 20:01:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Jun 2015 15:01:37 -0500
Received: (qmail 11755 invoked by uid 107); 2 Jun 2015 20:01:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Jun 2015 16:01:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jun 2015 16:01:34 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQLSF4=-4b1qOY4ChBj00=trvAO0qFEh0kOjLonJL4MBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270590>

On Tue, Jun 02, 2015 at 03:57:44PM -0400, Eric Sunshine wrote:

> > Oops, I missed the trailing '.' in the regex there, and it probably
> > needs double-quotes in case the inner expr fails to match anything.
> 
> Which is messy considering the double quotes already surrounding
> $(uname_R). Suggestions?

The shell should do the right thing with nested quotes inside backticks.
So just (untested):

  $(shell expr "`expr "$(uname_R)" : '\([0-9][0-9]*\.\)'`" '>=' 11),1)

> I suppose the combination of `...` with built-in 'test' and built-in
> 'echo' would be the most efficient choice. Do you want it re-rolled?

I can live with it either way. It's all pretty horrible and ugly; the
saving grace is that we hopefully never have to touch that line again.
;)

-Peff
