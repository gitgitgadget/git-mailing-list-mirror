From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git add -e documentation: rephrase note
Date: Wed, 14 Oct 2009 19:04:34 -0400
Message-ID: <20091014230434.GB29664@coredump.intra.peff.net>
References: <20091014222628.GK6115@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 01:16:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyD4j-0007Z5-A2
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 01:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762116AbZJNXFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 19:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762107AbZJNXFM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 19:05:12 -0400
Received: from peff.net ([208.65.91.99]:47353 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757271AbZJNXFL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 19:05:11 -0400
Received: (qmail 32700 invoked by uid 107); 14 Oct 2009 23:08:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Oct 2009 19:08:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Oct 2009 19:04:34 -0400
Content-Disposition: inline
In-Reply-To: <20091014222628.GK6115@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130350>

On Thu, Oct 15, 2009 at 12:26:28AM +0200, Miklos Vajna wrote:

> The original note probably wanted to suggest "edit the patch with care",
> but actually suggested just editing the first characters on certain
> lines, which is a pretty bad suggestion.

The intent of "-e" is to pick and choose lines of the diff to apply, or
even to munge the lines. So it is safe to:

  - remove lines with a '+' (don't stage the addition)

  - munge any lines with a '+' (stage modified contents)

  - add lines with a '+' (stage an addition)

  - convert lines with a ' ' to '-' (stage removal)

  - convert lines with a '-' to ' ' (don't stage removal)

It is a bad idea to:

  - delete '-' lines

  - delete ' ' lines

  - add ' ' or '-' line

  - munge the contents of ' ' or '-' lines

But that is just off the top of my head; perhaps others can come up with
corner cases where one of the safe things breaks.

> -*NOTE*: Obviously, if you change anything else than the first character
> -on lines beginning with a space or a minus, the patch will no longer
> -apply.
> +*NOTE*: Obviously, if you change the first characters of the lines or
> +lines beginning with a space or a minus, the patch will no longer apply.

So this is warning about changing or deleting ' ' or '-' lines, which is
good. But you can change the first characters of those lines, but only
by interchanging the two. So I think both the previous text and your
text don't cover all cases.

Maybe it makes sense instead to do a quick overview of what is OK and
what is not (like the list above).

-Peff
