From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] make update-server-info more robust
Date: Mon, 15 Sep 2014 19:56:59 -0400
Message-ID: <20140915235659.GA5019@peff.net>
References: <20140913201538.GA24854@peff.net>
 <20140913201920.GB27082@peff.net>
 <xmqqlhpk7mpb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 01:57:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTg90-0003yj-Dj
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 01:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642AbaIOX5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 19:57:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:48629 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755534AbaIOX5D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 19:57:03 -0400
Received: (qmail 11859 invoked by uid 102); 15 Sep 2014 23:57:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Sep 2014 18:57:02 -0500
Received: (qmail 26198 invoked by uid 107); 15 Sep 2014 23:57:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Sep 2014 19:57:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Sep 2014 19:56:59 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlhpk7mpb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257117>

On Mon, Sep 15, 2014 at 11:39:12AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Since "git update-server-info" may be called automatically
> > as part of a push or a "gc --auto", we should be robust
> > against two processes trying to update it simultaneously.
> > However, we currently use a fixed tempfile, which means that
> > two simultaneous writers may step on each other's toes and
> > end up renaming junk into place.
> 
> Thanks.  I'll queue these clean-ups but we may want to start
> thinking about deprecating and removing the dumb http support.

Yeah, I have often thought about that (especially the push support,
which has always been flaky and underused). However, some possible
schemes for resumable clone could be easily implemented by shunting the
cloner to a dumb-http conversation. So it may be worth keeping at least
the fetch side around for the time being. Food for thought.

-Peff
