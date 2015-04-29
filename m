From: Jeff King <peff@peff.net>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 19:05:43 -0400
Message-ID: <20150429230543.GA3887@peff.net>
References: <1430341032.14907.9.camel@ubuntu>
 <xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
 <1430343059.14907.18.camel@ubuntu>
 <20150429214817.GA2725@peff.net>
 <20150429221907.GS5467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 01:05:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynb39-0001Ed-NP
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 01:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbbD2XFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 19:05:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:51938 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750883AbbD2XFq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 19:05:46 -0400
Received: (qmail 26686 invoked by uid 102); 29 Apr 2015 23:05:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 18:05:46 -0500
Received: (qmail 31886 invoked by uid 107); 29 Apr 2015 23:06:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 19:06:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2015 19:05:43 -0400
Content-Disposition: inline
In-Reply-To: <20150429221907.GS5467@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268035>

On Wed, Apr 29, 2015 at 03:19:07PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> >   1. Git has to make a decision about what to do in corner cases. What
> >      is our cwd for relative links? The project root?
> 
> I don't follow.  Isn't symlink resolution always relative to the
> symlink, regardless of cwd?

Yeah, I was being silly to think this was a concern for intra-repository
links. It's well-defined there.  E.g., if "foo/bar/baz" points to
"../moof", that is just "foo/moof".

But if we leave the git tree the location of our root matters. E.g., if
"foo/bar/baz" points to "../../../../moof", where is that anchored in
the filesystem? So perhaps "cwd" is not the right term. It is really
"where are we pretending our working tree is".

-Peff
