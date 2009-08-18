From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] stash: reject stash name starting with a dash.
Date: Tue, 18 Aug 2009 19:35:35 -0400
Message-ID: <20090818233535.GB6304@sigill.intra.peff.net>
References: <7vbpmcc1sc.fsf@alter.siamese.dyndns.org>
 <1250631523-10524-1-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-2-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-3-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 19 01:35:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdYDR-00061M-Ht
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 01:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbZHRXfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 19:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbZHRXfg
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 19:35:36 -0400
Received: from peff.net ([208.65.91.99]:60631 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbZHRXfg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 19:35:36 -0400
Received: (qmail 16406 invoked by uid 107); 18 Aug 2009 23:35:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 18 Aug 2009 19:35:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Aug 2009 19:35:35 -0400
Content-Disposition: inline
In-Reply-To: <1250631523-10524-4-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126482>

On Tue, Aug 18, 2009 at 11:38:43PM +0200, Matthieu Moy wrote:

> This avoids typos like 'git stash save --invalid-option', particularly
> nasty since one can omit the 'save' subcommand. The syntax
> 'git stash save -- "-name starting with dash" still allows such stash name.

Aside from the documentation and usage lines, this one is actually
independent of the other two, and I think makes sense regardless of what
happens.

> +test_expect_success 'stash --invalid-option' '
> +       echo bar5 > file &&
> +       echo bar6 > file2 &&
> +       git add file2 &&
> +       ! git stash --invalid-option &&
> +       test bar5,bar6 = $(cat file),$(cat file2) &&
> +       git stash -- -message-starting-with-dash &&
> +       test bar,bar2 = $(cat file),$(cat file2)
> +'

Should this actually be "git stash save --invalid-option", since it is
really testing the actual save option parsing, and not the behavior to
automatically push options to "git stash save"?

Other than that, patch looks good.

-Peff
