From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 7/7] t7006-pager: if stdout is not a terminal, make
 a new one
Date: Sun, 21 Feb 2010 02:30:59 -0500
Message-ID: <20100221073058.GC2840@coredump.intra.peff.net>
References: <20100219065010.GA22258@progeny.tock>
 <20100219071857.GF29916@progeny.tock>
 <7v8wanq0c3.fsf@alter.siamese.dyndns.org>
 <20100221020317.GA7651@progeny.tock>
 <20100221020922.GB7651@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 08:34:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj6HT-0007CC-Dx
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 08:31:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab0BUHbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 02:31:00 -0500
Received: from peff.net ([208.65.91.99]:45786 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579Ab0BUHa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 02:30:59 -0500
Received: (qmail 8292 invoked by uid 107); 21 Feb 2010 07:31:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 21 Feb 2010 02:31:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Feb 2010 02:30:59 -0500
Content-Disposition: inline
In-Reply-To: <20100221020922.GB7651@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140599>

On Sat, Feb 20, 2010 at 08:09:22PM -0600, Jonathan Nieder wrote:

> Testing pagination requires (fake or real) access to a terminal so we
> can see whether the pagination automatically kicks in, which makes it
> hard to get good coverage when running tests without --verbose.  There
> are a number of ways to work around that:
> 
>  - Replace all isatty calls with calls to a custom xisatty wrapper
>    that usually checks for a terminal but can be overridden for tests.
>    This would be workable, but it would require implementing xisatty
>    separately in three languages (C, shell, and perl) and making sure
>    that any code that is to be tested always uses the wrapper.
> 
>  - Redirect stdout to /dev/tty.  This would be problematic because
>    there might be no terminal available, and even if a terminal is
>    available, it might not be appropriate to spew output to it.
> 
>  - Create a new pseudo-terminal on the fly and capture its output.
> 
> This patch implements the third approach.

Just to wrap up my end of this patch discussion, I think the approach
you take here is the sanest one. While it would be nice to get test
coverage on every system, I don't think it is worth the effort of
trying to write portable terminal creation code. And this way at least
the code in git is fairly minimal.

So looks good to me.

-Peff
