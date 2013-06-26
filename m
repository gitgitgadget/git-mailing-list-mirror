From: Jeff King <peff@peff.net>
Subject: Re: Basic git-archive --remote question
Date: Wed, 26 Jun 2013 03:01:05 -0400
Message-ID: <20130626070105.GA5905@sigill.intra.peff.net>
References: <CAGpXXZJifb1KmR8=VZVW+1MKjyo7HOq=OgU_rcHs-vc5ezfG6w@mail.gmail.com>
 <CAGpXXZJuC09t8-5d=p4KNs9rQ-S347eBNuKcKWFhXZTnkLW0sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 09:01:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urjj7-0001Ap-LD
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 09:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309Ab3FZHBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 03:01:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:55084 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059Ab3FZHBI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 03:01:08 -0400
Received: (qmail 10651 invoked by uid 102); 26 Jun 2013 07:02:12 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Jun 2013 02:02:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Jun 2013 03:01:05 -0400
Content-Disposition: inline
In-Reply-To: <CAGpXXZJuC09t8-5d=p4KNs9rQ-S347eBNuKcKWFhXZTnkLW0sA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229032>

On Mon, Jun 24, 2013 at 03:53:56PM -0400, Greg Freemyer wrote:

> I'm trying to create a tarball from a git tag and I can't get the
> syntax right.  The documentation is not very clear.
> [...]
> > git archive --format=tar --remote=github.com:dkovar/analyzeMFT.git v2.0.4

Your remote should be git@github.com:dkovar/analyzeMFT.git.

But...

> > git archive --format=tar --remote=git://github.com/dkovar/analyzeMFT v2.0.4
> 
> fatal: remote error
>    Your Git client has made an invalid request:
>    003agit-upload-archive /dkovar/analyzeMFT

Your syntax is fine, but GitHub does not support remote git-archive
requests. Not over git://, and not over ssh. In both cases the error
messages are rather confusing and unhelpful, though.

> > git archive --format=tar --remote=//github.com/dkovar/analyzeMFT v2.0.4

This is wrong, as it is looking for //github.com... in the local
filesystem.

> The github page also says I can use ssh with git as the user, but that
> complains I don't have the private key (which I don't):
> 
> git archive --format=tar
> --remote=ssh://git@github/com/dkovar/analyzeMFT.git v2.0.4

If you have a GitHub account and register your public key, then you can
use ssh to fetch from the repository (using the git@github.com:user/repo
syntax). However, remote git-archive is not currently supported, so it
would not help you.

-Peff
