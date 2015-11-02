From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] setup: do not create $X/gitdir unnecessarily when
 accessing git file $X
Date: Mon, 2 Nov 2015 15:52:53 -0500
Message-ID: <20151102205252.GA12181@sigill.intra.peff.net>
References: <xmqqwpu7klmu.fsf@gitster.mtv.corp.google.com>
 <1446491306-13493-1-git-send-email-pclouds@gmail.com>
 <20151102203507.GB10722@sigill.intra.peff.net>
 <xmqqtwp4dt17.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, rappazzo@gmail.com, kyle@kyleam.com,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 21:53:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtM67-0006w9-LX
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 21:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbbKBUw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 15:52:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:51650 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753258AbbKBUwz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 15:52:55 -0500
Received: (qmail 14622 invoked by uid 102); 2 Nov 2015 20:52:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Nov 2015 14:52:55 -0600
Received: (qmail 16921 invoked by uid 107); 2 Nov 2015 20:53:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Nov 2015 15:53:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Nov 2015 15:52:53 -0500
Content-Disposition: inline
In-Reply-To: <xmqqtwp4dt17.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280718>

On Mon, Nov 02, 2015 at 12:51:16PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > [2] I suspect this code should use write_file_gently(). What happens if
> >     I have a read-only linked checkout?
> 
> Or you may not be the owner of the repository, you think you are
> doing a read-only operation, and you silently end up creating a file
> that cannot be written by the repository owner?
> 
> Honestly, I think this whole "just in case the user moved without
> telling us, we sneakily fix things without telling the user" should
> just go away.  This is not the first incidence of a tool trying to
> be overly clever and pretend to know better than the end user biting
> us, is it?

I have to admit, that was my gut feeling, too, but I do not know enough
about the problem it is solving to say whether it is a good tradeoff.
Unfortunately 23af91d102e1efaff33b77ab7746356835a3d600 did not have much
discussion. I didn't dig into the mailing list, though. I was hoping Duy
could summarize it. :)

-Peff
