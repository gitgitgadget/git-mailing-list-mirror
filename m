From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] completion: add missing configuration variables
Date: Wed, 15 Dec 2010 08:00:47 -0500
Message-ID: <20101215130046.GB25647@sigill.intra.peff.net>
References: <1292395613-12859-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 14:00:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSqyX-0001mP-L0
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 14:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828Ab0LONAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 08:00:52 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44335 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880Ab0LONAv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 08:00:51 -0500
Received: (qmail 24582 invoked by uid 111); 15 Dec 2010 13:00:50 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 15 Dec 2010 13:00:50 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Dec 2010 08:00:47 -0500
Content-Disposition: inline
In-Reply-To: <1292395613-12859-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163755>

On Wed, Dec 15, 2010 at 07:46:53AM +0100, Martin von Zweigbergk wrote:

> The color.grep.external option has been deleted. Should it be deleted
> from here or do we want to help users run e.g.
> 'git config --unset color.grep.external'? Same goes for
> add.ignore-errors.

IMHO, they should go away. People who have them can figure out how to
delete them, but it is more important not to advertise them to people
who are adding variables.

As an aside, I would think "--unset" should actually choose from the set
of configured variables for completion (i.e., "git config --list | cut
-d= -f1"). But that would obviously be a separate patch.

> I didn't find any references to 'diff.renameLimit.' even in 98171a0
> (bash completion: Sync config variables with their man pages,
> 2008-12-15) in which it was introduced in the completions script. I
> hope it was safe to remove it.

Yeah, I don't think it has ever existed.

> Some variables are documented with camelCase but read in all
> lowercase in the code. Not worth updating the code just for that, is
> it?

All variables are case-insensitive. The config parser down-cases them,
so all code should treat tham as all-lowercase. However, we tend to
document them as camelCase for readability.

The completion code should match case-insensitively, too. It doesn't
seem to now, but I suspect it is not a problem in practice because the
first camelCase word is often enough to get a match, and is lowercase
itself.

> I hope none of the added variables are deprecated. After having a
> quick look in git-config(1), I think they should not be.

All looked OK from my quick glance.

One note:

>  		color.diff
>  		color.diff.commit
>  		color.diff.frag
> +		color.diff.func
>  		color.diff.meta
>  		color.diff.new
>  		color.diff.old
>  		color.diff.plain
>  		color.diff.whitespace

We have color.diff.branch coming soon (I think it is in 'next' now).

-Peff
