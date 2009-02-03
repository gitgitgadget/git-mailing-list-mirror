From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] add -p: optionally prompt for single characters
Date: Tue, 3 Feb 2009 01:24:37 -0500
Message-ID: <20090203062437.GB21367@sigill.intra.peff.net>
References: <7vljspjk8n.fsf@gitster.siamese.dyndns.org> <1233611191-18590-4-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Suraj Kurapati <sunaku@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 03 07:26:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUEjZ-0002T4-4r
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 07:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbZBCGYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 01:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbZBCGYm
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 01:24:42 -0500
Received: from peff.net ([208.65.91.99]:33758 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbZBCGYl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 01:24:41 -0500
Received: (qmail 15947 invoked by uid 107); 3 Feb 2009 06:24:53 -0000
Received: from c-75-75-4-229.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.4.229)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 03 Feb 2009 01:24:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Feb 2009 01:24:37 -0500
Content-Disposition: inline
In-Reply-To: <1233611191-18590-4-git-send-email-trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108151>

On Mon, Feb 02, 2009 at 10:46:30PM +0100, Thomas Rast wrote:

> +interactive.readkey::
> +	Attempt to use Term::ReadKey facilities to allow typing
> +	one-letter input with a single key.  Currently only used by
> +	the `\--patch` mode of linkgit:git-add[1].  Silently disabled
> +	if Term::ReadKey is not available.

Minor nit: the name of this variable implies that it will be used across
all interactive commands (including any future ones). But the
description is intimately linked with perl. Maybe structure it like
"here is what this does in general, but here are some specific caveats".
Something like:

  interactive.readkey::
        In interactive programs, allow the user to provide one-letter
        input with a single key (i.e., without hitting enter). Currently
        this is used only by the `\--patch` mode of linkgit:git-add[1].
        Note that this feature is silently disabled for Perl programs
        (like git-add) if Term::ReadKey is not available.

But since there is only _one_ place it is used now, and since that
program _is_ a Perl program, maybe this is overengineering.

Other than that, your series looks OK to me. I think it would be nice to
have a 5/4 that extends the feature to other menus for the sake of
consistency. But like you, I really just use "git add -p" myself.

-Peff
