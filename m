From: Jeff King <peff@peff.net>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Fri, 1 May 2015 01:36:00 -0400
Message-ID: <20150501053559.GA13393@peff.net>
References: <1430343059.14907.18.camel@ubuntu>
 <20150429214817.GA2725@peff.net>
 <1430346576.14907.40.camel@ubuntu>
 <20150429231150.GB3887@peff.net>
 <20150430003750.GA4258@peff.net>
 <1430355983.14907.55.camel@ubuntu>
 <20150430011612.GA7530@peff.net>
 <1430358345.14907.62.camel@ubuntu>
 <20150430033725.GB12361@peff.net>
 <1430450954.22711.69.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 01 07:36:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yo3cO-0004Ui-UI
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 07:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbbEAFgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 01:36:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:52612 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751956AbbEAFgD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 01:36:03 -0400
Received: (qmail 12541 invoked by uid 102); 1 May 2015 05:36:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 00:36:03 -0500
Received: (qmail 12584 invoked by uid 107); 1 May 2015 05:36:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 01:36:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 01:36:00 -0400
Content-Disposition: inline
In-Reply-To: <1430450954.22711.69.camel@ubuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268110>

On Thu, Apr 30, 2015 at 08:29:14PM -0700, David Turner wrote:

> >   4. Return the last object we could resolve, as I described. So
> [...]
> 
> Actually, I think 4 has an insurmountable problem.  Here's the case I'm
> thinking of:
> 
> ln -s ..  morx
> 
> Imagine that we go to look up 'morx/fleem'.  Now morx is the "last
> object we could resolve", but we don't know how much of our input has
> been consumed at this point.  So consumers don't know that after they
> exit the repo, they still need to find fleem next to it.

Yes, agreed (my list was written before Andreas brought up the idea of
symlinks in the intermediate paths). I think to let the caller pick up
where you left off, you would have to create a new string that has the
"remainder" concatenated to it.

-Peff
