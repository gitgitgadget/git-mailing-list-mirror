From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] strbuf_read: skip unnecessary strbuf_grow at eof
Date: Mon, 1 Jun 2015 06:59:01 -0400
Message-ID: <20150601105901.GE31792@peff.net>
References: <1433096205-14516-1-git-send-email-gjthill@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jim Hill <gjthill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 12:59:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzNR0-0007cT-CN
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 12:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbbFAK7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 06:59:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:38725 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751332AbbFAK7F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 06:59:05 -0400
Received: (qmail 30648 invoked by uid 102); 1 Jun 2015 10:59:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 05:59:04 -0500
Received: (qmail 28383 invoked by uid 107); 1 Jun 2015 10:59:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 06:59:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jun 2015 06:59:01 -0400
Content-Disposition: inline
In-Reply-To: <1433096205-14516-1-git-send-email-gjthill@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270399>

On Sun, May 31, 2015 at 11:16:45AM -0700, Jim Hill wrote:

> Make strbuf_read not try to do read_in_full's job too.  If xread returns
> less than was requested it can be either eof or an interrupted read.  If
> read_in_full returns less than was requested, it's eof. Use read_in_full
> to detect eof and not iterate when eof has been seen.

I think this makes sense. I somehow had to read this over several times
to understand that the main point is not the cleanup, but rather the
space savings from not doing an extra strbuf_grow. Perhaps it is because
the main idea is mentioned only in the subject. Or perhaps I was just
being dense.

-Peff
