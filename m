From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add core.pathspecGlob config option
Date: Wed, 19 Dec 2012 16:45:01 -0500
Message-ID: <20121219214500.GA12705@sigill.intra.peff.net>
References: <20121219203449.GA10001@sigill.intra.peff.net>
 <7vfw3191bi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 22:45:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlRSM-0001tn-IB
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 22:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597Ab2LSVpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 16:45:10 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58809 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194Ab2LSVpE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 16:45:04 -0500
Received: (qmail 1056 invoked by uid 107); 19 Dec 2012 21:46:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Dec 2012 16:46:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2012 16:45:01 -0500
Content-Disposition: inline
In-Reply-To: <7vfw3191bi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211851>

On Wed, Dec 19, 2012 at 01:30:57PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/dir.c b/dir.c
> > index 5a83aa7..6e81d4f 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -126,7 +126,7 @@ static int match_one(const char *match, const char *name, int namelen)
> >  		for (;;) {
> >  			unsigned char c1 = tolower(*match);
> >  			unsigned char c2 = tolower(*name);
> > -			if (c1 == '\0' || is_glob_special(c1))
> > +			if (c1 == '\0' || (core_pathspec_glob && is_glob_special(c1)))
> >  				break;
> >  			if (c1 != c2)
> >  				return 0;
> 
> I think you can also do the same to the common_prefix(); we check
> for common leading directory prefix but punt upon seeing a directory
> component that has a glob character, and under the "literal" mode,
> it is not a special character.

Yeah, I think you're right. Will add to my re-roll.

-Peff
