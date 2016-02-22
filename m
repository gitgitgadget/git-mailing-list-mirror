From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon.c: mark a file-local symbol as static
Date: Mon, 22 Feb 2016 16:18:27 -0500
Message-ID: <20160222211827.GB15595@sigill.intra.peff.net>
References: <56C9F4F2.1060100@ramsayjones.plus.com>
 <20160221232510.GB4094@sigill.intra.peff.net>
 <56CA5753.9030308@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 22:18:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXxsI-0002eu-HK
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 22:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539AbcBVVSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 16:18:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:46955 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751937AbcBVVSa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 16:18:30 -0500
Received: (qmail 17716 invoked by uid 102); 22 Feb 2016 21:18:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 16:18:29 -0500
Received: (qmail 22218 invoked by uid 107); 22 Feb 2016 21:18:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 16:18:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 16:18:27 -0500
Content-Disposition: inline
In-Reply-To: <56CA5753.9030308@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286953>

On Mon, Feb 22, 2016 at 12:33:23AM +0000, Ramsay Jones wrote:

> > Thanks, will do. You notice these with sparse, as I recall? I've meant
> > to look into running that myself, but it looks like we are not
> > warning-free with sparse currently. I see complaints like:
> > 
> >   connect.c:377:40: warning: incorrect type in argument 2 (invalid types)
> >   connect.c:377:40:    expected union __CONST_SOCKADDR_ARG [usertype] __addr
> >   connect.c:377:40:    got struct sockaddr *ai_addr
> > 
> > As far as I can tell, that's just noise. Do you have a ready-made recipe
> > for silencing it?
> 
> Ah, I think you must be on a very old version of sparse.

I have whatever comes with debian unstable. Looks like 0.5.0 from
November. So not _that_ old, but I can well believe it is missing tweaks
found at the tip of their development.

I guess I was wondering whether I should be adding "make sparse" to my
set of pre-submission checks. But I can't say I'm enthused about
manually keeping another tool up to date. :)

> On Linux, there is a single warning, which results from a hard-coded
> value (max size of memcpy et. al., used for the kernel) which should
> at least be settable from the command line (I have a patch somewhere
> which I have not sent upstream).

Yeah, I saw that one, for a large zeroing memset of a heap buffer. I
don't think it's _wrong_, though it would probably not hurt to use
xcalloc instead.

Thanks for the pointers.

-Peff
