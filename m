From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] expand --pretty=format color options
Date: Sun, 18 Jan 2009 14:53:43 -0500
Message-ID: <20090118195342.GA612@coredump.intra.peff.net>
References: <20090117153846.GB27071@coredump.intra.peff.net> <49736331.8010003@lsrfire.ath.cx> <20090118173753.GB17434@coredump.intra.peff.net> <20090118194328.GA31180@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jan 18 20:55:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOdji-0005uM-2X
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 20:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbZARTxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 14:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753918AbZARTxq
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 14:53:46 -0500
Received: from peff.net ([208.65.91.99]:40080 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968AbZARTxp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 14:53:45 -0500
Received: (qmail 23139 invoked by uid 107); 18 Jan 2009 19:53:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 18 Jan 2009 14:53:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Jan 2009 14:53:43 -0500
Content-Disposition: inline
In-Reply-To: <20090118194328.GA31180@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106272>

On Sun, Jan 18, 2009 at 02:43:28PM -0500, Jeff King wrote:

> Here is a patch that seems to work. It predicates pretty format colors
> on diff colors, which is the same way the yellow commit header works in
> log-tree. I don't know if it makes more sense to introduce yet another
> color config option.
> 
> And I say "seems to work" because I remember there being some trickery
> with color flags sometimes not getting set properly. However, since this
> is the same flag as the yellow commit header, and called around the same
> time, I think it should be fine.

Hrm. OK, it doesn't actually work always. It does for git-log, but not
for rev-list, which leaves diff_use_color_default as -1. I don't know if
there are any other ways you can get to this code path without having
set diff_use_color_default.

Maybe it is time to do a cleanup on the color handling, which has
provided no end of these bugs. I will have to leave that for another
day, though.

-Peff
