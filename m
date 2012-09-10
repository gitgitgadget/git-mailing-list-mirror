From: Jeff King <peff@peff.net>
Subject: Re: checkout extra files
Date: Mon, 10 Sep 2012 13:19:55 -0400
Message-ID: <20120910171954.GA15583@sigill.intra.peff.net>
References: <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org>
 <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com>
 <7vpq61dfn9.fsf@alter.siamese.dyndns.org>
 <7v8vcpdat2.fsf@alter.siamese.dyndns.org>
 <7vk3w5woc4.fsf@alter.siamese.dyndns.org>
 <20120910161904.GC9435@sigill.intra.peff.net>
 <7vpq5told4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 19:20:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB7eZ-0005yw-EX
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 19:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab2IJRT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 13:19:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39801 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549Ab2IJRT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 13:19:58 -0400
Received: (qmail 30272 invoked by uid 107); 10 Sep 2012 17:20:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 13:20:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 13:19:55 -0400
Content-Disposition: inline
In-Reply-To: <7vpq5told4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205151>

On Mon, Sep 10, 2012 at 10:09:43AM -0700, Junio C Hamano wrote:

> > Does it make sense to join that final paragraph into what is now the
> > third bullet, and then add your new text (the fourth bullet) after?
> 
> I am not sure.  After re-reading it, I do not think the fileglob
> discussion belongs to the existing "Here are the rules" list in the
> first place.

I had a vague feeling that it did not quite belong, too, but I was not
sure where it should go.

> It should probably be the extended description for the
> first point (revisions then paths) to explain what kind of "paths"
> we accept there.

I do not think so. That point is about the order of revisions and paths,
and has nothing to do with the syntax of paths. Really, every element of
that list is about handling revisions versus paths. I think this content
does not necessarily go in such a list.

> I generally consider follow-up paragraphs after bulleted list to be
> enhancements on any of the points in the list, not necessarily
> applying to all of them.

I would argue the opposite; if it is about a specific point, then put it
with the point. Otherwise, you are asking the reader to remember back to
an earlier point (that they may not even have read; in reference
documentation, the point of a list is often to let readers skip from
bullet to bullet easily).

If it is a synthesis of multiple elements in the list, then that makes
more sense. And I think that is what you are implying here:

> The existing structure is:
> 
>     * point A (revisions and paths)
>     * point B (-- can be used to disambiguate)
>     * point C (ambiguation leads to an error)
> 
>     Note that point B and point C taken together imply corollary BC.

Which is fine by me. But inserting a point D that is not related to B,
C, or BC, only makes it harder to read.

> So perhaps something like this squashed in on top of the patch in
> question?
> 
>  Documentation/gitcli.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git c/Documentation/gitcli.txt w/Documentation/gitcli.txt
> index c70cd81..4413489 100644
> --- c/Documentation/gitcli.txt
> +++ w/Documentation/gitcli.txt
> @@ -38,9 +38,9 @@ arguments.  Here are the rules:
>     you have to say either `git diff HEAD --` or `git diff -- HEAD` to
>     disambiguate.
>  
> - * Many commands allow wildcards in paths, but you need to protect
> -   them from getting globbed by the shell.  These two mean different
> -   things:
> +Many commands allow wildcards in paths (see pathspec in
> +linkgit:gitglossary[7]), but you need to protect them
> +from getting globbed by the shell.  These two mean different things:
>  +
>  --------------------------------
>  $ git checkout -- *.c

I don't think that makes it any better. You went from:

  * A
  * B
  * C
  * D

  By the way, B and C imply BC.

to:

  * A
  * B
  * C

  By the way, D.

  Also, B and C imply BC.

I think it would make more sense to do:

  * A
  * B
  * C

  By the way, B and C imply BC.

  Also, D.

(where obviously my "connecting" phrases do not need to be part of the
text, but are meant to illustrate how I am thinking about the
structure).

-Peff
