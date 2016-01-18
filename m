From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/5] ls-remote: add support for showing symrefs
Date: Mon, 18 Jan 2016 17:20:12 -0500
Message-ID: <20160118222012.GA24740@sigill.intra.peff.net>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-6-git-send-email-t.gummerer@gmail.com>
 <20160118195159.GD1009@sigill.intra.peff.net>
 <20160118220913.GI7100@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 23:20:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLI9r-0007xT-UR
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 23:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbcARWUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 17:20:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:55740 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932372AbcARWUP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 17:20:15 -0500
Received: (qmail 8434 invoked by uid 102); 18 Jan 2016 22:20:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 17:20:14 -0500
Received: (qmail 14657 invoked by uid 107); 18 Jan 2016 22:20:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 17:20:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2016 17:20:12 -0500
Content-Disposition: inline
In-Reply-To: <20160118220913.GI7100@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284333>

On Mon, Jan 18, 2016 at 11:09:13PM +0100, Thomas Gummerer wrote:

> > +test_expect_failure 'ls-remote with filtered symrefs (--heads)' '
> > +	git symbolic-ref refs/heads/foo refs/tags/mark &&
> > +	cat >expect <<-\EOF &&
> > +	ref: refs/heads/bar	refs/tags/mark
> > +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
> > +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
> > +	EOF
> > +	git ls-remote --symrefs --heads . >actual &&
> > +	test_cmp expect actual
> > +'
> 
> I'm a bit confused by this.  Shouldn't the "ref: refs/heads/bar
> refs/tags/mark" line only show up when we use --tags, not --heads?
> Also should refs/heads/bar be refs/heads/foo?

Yes, sorry, I bungled this. It should expect:

  ref: refs/tags/mark\trefs/heads/foo

I changed my mind about which refs to use halfway through writing, and
of course because it is marked to expect failure, running the test
didn't clue me in. :)

-Peff
