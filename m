From: Jeff King <peff@peff.net>
Subject: Re: [POC PATCH 5/5] completion: avoid compgen to fix expansion
 issues in __gitcomp_nl()
Date: Fri, 28 Sep 2012 11:46:16 -0400
Message-ID: <20120928154615.GA24933@sigill.intra.peff.net>
References: <20120928100530.GL10144@goldbirke>
 <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
 <1348826975-2225-5-git-send-email-szeder@ira.uka.de>
 <20120928150852.GA13081@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 17:46:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THclt-00085o-Gg
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 17:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757917Ab2I1PqX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2012 11:46:23 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33715 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757585Ab2I1PqX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 11:46:23 -0400
Received: (qmail 13333 invoked by uid 107); 28 Sep 2012 15:46:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Sep 2012 11:46:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Sep 2012 11:46:16 -0400
Content-Disposition: inline
In-Reply-To: <20120928150852.GA13081@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206585>

On Fri, Sep 28, 2012 at 05:08:52PM +0200, SZEDER G=C3=A1bor wrote:

> On Fri, Sep 28, 2012 at 12:09:35PM +0200, SZEDER G=C3=A1bor wrote:
> >  __gitcomp_nl ()
> >  {
> >  	local IFS=3D$'\n'
> > -	COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cu=
r}"))
> > +	COMPREPLY=3D($(echo "$1" |sed -n "/^${3-$cur}/ {
>=20
> $cur can be a path, so it can contain /, which then breaks this sed
> expression.  Here's a fixup:

Worse than that, can't $cur contain arbitrary regex characters that wil=
l
be interpreted by sed?

-Peff
