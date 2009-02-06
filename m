From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/4] add -p: prompt for single characters
Date: Fri, 6 Feb 2009 09:01:26 -0500
Message-ID: <20090206140126.GA18364@coredump.intra.peff.net>
References: <7v63jqorza.fsf@gitster.siamese.dyndns.org> <1233822507-9612-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <junio@pobox.com>,
	Suraj Kurapati <sunaku@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Feb 06 15:03:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVRIL-0003E8-2b
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 15:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbZBFOB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 09:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752310AbZBFOB3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 09:01:29 -0500
Received: from peff.net ([208.65.91.99]:47473 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbZBFOB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 09:01:28 -0500
Received: (qmail 21939 invoked by uid 107); 6 Feb 2009 14:01:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 06 Feb 2009 09:01:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2009 09:01:26 -0500
Content-Disposition: inline
In-Reply-To: <1233822507-9612-1-git-send-email-trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108708>

On Thu, Feb 05, 2009 at 09:28:26AM +0100, Thomas Rast wrote:

> +my $use_readkey = 0;
> +if ($repo->config_bool("interactive.singlekey")) {
> +	eval {
> +		use Term::ReadKey;
> +		$use_readkey = 1;
> +	};
> +}

Sorry, I am way behind on git mails, so I didn't catch this sooner. But
it should be "require Term::ReadKey", as "use" statements are done at
compile time:

  $ perl -e 'eval { use Bogosity } or print "not found\n"'
  Can't locate Bogosity.pm in @INC ...

  $ perl -e 'eval { require Bogosity } or print "not found\n"'
  not found

So add--interactive in 'next' is currently broken on non-readkey
platforms.

-Peff
