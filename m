From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] update-server-info: create info/* with mode 0666
Date: Tue, 6 Jan 2015 14:39:51 -0500
Message-ID: <20150106193950.GB28440@peff.net>
References: <20150106034702.GA11503@peff.net>
 <20150106035048.GB20087@peff.net>
 <xmqqh9w3px0a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Sokolovsky <paul.sokolovsky@linaro.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 20:40:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8Zyv-0006cI-Og
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 20:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756453AbbAFTjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 14:39:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:59642 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756243AbbAFTjx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 14:39:53 -0500
Received: (qmail 12614 invoked by uid 102); 6 Jan 2015 19:39:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jan 2015 13:39:53 -0600
Received: (qmail 12874 invoked by uid 107); 6 Jan 2015 19:40:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jan 2015 14:40:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jan 2015 14:39:51 -0500
Content-Disposition: inline
In-Reply-To: <xmqqh9w3px0a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262095>

On Tue, Jan 06, 2015 at 10:47:01AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +test_expect_success POSIXPERM 'info/refs is readable in unshared repo' '
> > +	rm -f .git/info/refs &&
> > +	test_unconfig core.sharedrepository &&
> > +	umask 002 &&
> > +	git update-server-info &&
> > +	echo "-rw-rw-r--" >expect &&
> > +	modebits .git/info/refs >actual &&
> > +	test_cmp expect actual
> > +'
> 
> Hmm, the label and the test look somewhat out-of-sync.  "readable as
> long as umask allows it" would be more in line with what the fix is
> about (i.e. I would expect a test with that title to pass even if I
> changed 'umask 002' to 'umask 007', but that is not what we want in
> this series).

That is definitely not what the series means to accomplish. I think
naming the test "info/refs respects umask in unshared repo" is probably
a better title for the test.

-Peff
