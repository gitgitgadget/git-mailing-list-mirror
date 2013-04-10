From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lint-duplicates: Only check for numbered test cases
Date: Wed, 10 Apr 2013 12:00:37 -0400
Message-ID: <20130410160037.GB10749@sigill.intra.peff.net>
References: <201304030754.03100.tboegi@web.de>
 <20130403142804.GB10494@sigill.intra.peff.net>
 <516573CA.2000804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 10 18:00:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPxS4-0002Zl-Dq
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 18:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab3DJQAo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 12:00:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38810 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106Ab3DJQAn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 12:00:43 -0400
Received: (qmail 3471 invoked by uid 107); 10 Apr 2013 16:02:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 12:02:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 12:00:37 -0400
Content-Disposition: inline
In-Reply-To: <516573CA.2000804@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220698>

On Wed, Apr 10, 2013 at 04:14:34PM +0200, Torsten B=C3=B6gershausen wro=
te:

> >  test-lint-duplicates:
> > -	@dups=3D`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d=
` && \
> > +	@dups=3D`echo $(T) | tr ' ' '\n' | \
> > +		sed -e 's,.*/,,' -e 's/\(t[0-9][0-9][0-9][0-9]\)-.*/\1/' | \
> > +		sort | uniq -d` && \
> >  		test -z "$$dups" || { \
> >  		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
> > =20
> >=20
> > -Peff
> I thinkg we need both the striping of the path and the "grepping" for
> numbered test cases only.
> I'll send a patch in a minute

I think it is fine either way. My command above turns:

  /path/to/test-one.sh
  /path/to/test-two.sh

into

  test-one.sh
  test-two.sh

which is fine for running through uniq. If you use "sed -n", you simply
end up with an empty list, which is also fine.

-Peff
