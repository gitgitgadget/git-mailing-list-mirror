From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] filter-branch: pass tag name via stdin without newline
Date: Mon, 7 Dec 2015 15:44:40 -0500
Message-ID: <20151207204440.GC30203@sigill.intra.peff.net>
References: <1449451046-19752-1-git-send-email-ericvw@gmail.com>
 <xmqqd1ujnf1i.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Eric N. Vander Weele" <ericvw@gmail.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:44:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a62eN-0001lv-E9
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 21:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932997AbbLGUon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 15:44:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:38491 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932967AbbLGUon (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 15:44:43 -0500
Received: (qmail 16323 invoked by uid 102); 7 Dec 2015 20:44:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 14:44:42 -0600
Received: (qmail 23138 invoked by uid 107); 7 Dec 2015 20:44:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 15:44:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Dec 2015 15:44:40 -0500
Content-Disposition: inline
In-Reply-To: <xmqqd1ujnf1i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282119>

On Sun, Dec 06, 2015 at 06:55:21PM -0800, Junio C Hamano wrote:

> "Eric N. Vander Weele" <ericvw@gmail.com> writes:
> 
> > "git filter-branch --tag-name-filter" fails when the user-provided
> > command attempts to trivially append text to the originally tag name,
> > passed via stdin, due to an unexpected newline ('\n').  The newline is
> > introduced due to "echo" piping the original tag name to the
> > user-provided tag name filter command.
> 
> Is there any other place where we feed such an incomplete line
> (i.e. a line without the terminating LF) to the filters in this
> command?

I suspect we would break filters if we did. On some systems, tools like
`sed` and `tr` often behave funny when there is no trailing newline, but
I do not recall all of the specific instances (if one felt like engaging
in some light masochism, searching the mailing list archive will
probably turn up results).

-Peff
