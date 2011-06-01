From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] git-am: provide configuration to enable signoff by
 default
Date: Wed, 1 Jun 2011 12:39:19 -0400
Message-ID: <20110601163919.GC7132@sigill.intra.peff.net>
References: <1306917751-27999-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sekhar Nori <nsekhar@ti.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:39:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRoS7-0007OK-Hj
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 18:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180Ab1FAQjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 12:39:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58506
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696Ab1FAQjW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 12:39:22 -0400
Received: (qmail 14089 invoked by uid 107); 1 Jun 2011 16:39:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Jun 2011 12:39:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2011 12:39:19 -0400
Content-Disposition: inline
In-Reply-To: <1306917751-27999-1-git-send-email-nsekhar@ti.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174879>

On Wed, Jun 01, 2011 at 02:12:31PM +0530, Sekhar Nori wrote:

> Provide a git config option to enable --signoff a
> default when using git-am. This should be handy
> for maintainers who regularly apply patches from
> mailing lists to send them upstream and want to
> be on the sign-off path.

I think people have complained about auto-signoff features before,
because it was supposed to be a conscious act. I don't recall if it was
ever resolved, and I don't have an opinion myself, but it may be worth
searching the archives for past arguments.

> diff --git a/git-am.sh b/git-am.sh
> index 6cdd591..8e2a693 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -328,6 +328,11 @@ then
>      keepcr=t
>  fi
>  
> +if test "$(git config --bool --get am.signoff)" = true
> +then
> +    sign=t
> +fi
> +
>  while test $# != 0
>  do
>  	case "$1" in

Shouldn't this be turned off if --rebasing is passed? Otherwise you
would introduce signoffs during rebase (I didn't check, though, so maybe
there is some other mechanism preventing it).

-Peff
