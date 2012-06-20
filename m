From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] diff-no-index: exit(1) if 'diff --quiet <repo file>
 <external file>' finds changes
Date: Wed, 20 Jun 2012 12:06:08 -0400
Message-ID: <20120620160607.GA12856@sigill.intra.peff.net>
References: <1340047704-8752-1-git-send-email-tim.henigan@gmail.com>
 <7vr4tc2xhy.fsf@alter.siamese.dyndns.org>
 <CAFouethcrw3vOF7SPwHxjH4ABmF8U1df0MfyzcUGq2yTYxs4ow@mail.gmail.com>
 <20120619135814.GA3210@sigill.intra.peff.net>
 <CAFouetgRq1qkqJmThJJeu=Mdx9jS0c9dw7NPSwuJUOSpskCY2A@mail.gmail.com>
 <CAFouetgXkqJPYwjr5ob5ed_ooL-D56zXyjnOAWrVPdt_eZqw7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 18:06:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShNQC-0006U2-3H
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 18:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756981Ab2FTQGQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jun 2012 12:06:16 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:38827
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756951Ab2FTQGP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 12:06:15 -0400
Received: (qmail 24966 invoked by uid 107); 20 Jun 2012 16:06:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 12:06:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 12:06:08 -0400
Content-Disposition: inline
In-Reply-To: <CAFouetgXkqJPYwjr5ob5ed_ooL-D56zXyjnOAWrVPdt_eZqw7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200301>

On Wed, Jun 20, 2012 at 09:38:15AM -0400, Tim Henigan wrote:

> > With your patch applied, I was able to use relative paths in my tes=
ts.
> > =C2=A0I also confirmed that all the t4*.sh tests pass.
> >
> > For what its worth, your patch looks correct to me. =C2=A0Existing
> > consumers of 'prefix_path' should get the same results as before an=
d
> > the one added xmalloc is paired with a free.
>=20
> Jeff,
>=20
> Are you planning to send this patch to the list?  If not, can I
> include it as 1 of 2 before my patch?  If we go that route, I'm not
> sure how to properly show you as the author...

I'd probably get to it eventually, but I haven't touched it since I sen=
t
it. If you want to include some tests and package it with a commit
message, that would make me very happy.

You can override the author by including a "From: " header as the first
line in the body of the email (which git-am will use rather than the
identity in the email's From header). If you use git-send-email, it wil=
l
do this automatically when the patch author does not match your
identity.

I didn't sign-off the original, but please feel free to include my
sign-off, as well as add your own. And note your own contributions in
the commit message. So the resulting email would be something like:


   From: Tim Henigan <tim.henigan@gmail.com>
   Date: ...
   Subject: [PATCH 1/2] diff: handle relative paths in no-index

   From: Jeff King <peff@peff.net>

   ... some commit message body ...

   Tests and commit message by Tim Henigan.

   Signed-off-by: Jeff King <peff@peff.net>
   Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
   ---
   ... the actual patch ...

> Also, in an earlier email [1] you mentioned that it may be a good ide=
a
> to rename 'found_changes' to something like 'xdiff_found_changes'.  I
> like the idea...I could submit this change as another patch in the
> series, if you have no objections.

=46ine by me. I think "xdiff_found_changes" is not quite accurate; it i=
s
really "did builtin_diff find any changes?" since we might never call
into xdiff (e.g., for binary files). I'm not sure what the best name is=
=2E

-Peff
