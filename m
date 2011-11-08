From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Tue, 8 Nov 2011 13:14:42 -0500
Message-ID: <20111108181442.GA17317@sigill.intra.peff.net>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
 <20111107172218.GB3621@sigill.intra.peff.net>
 <CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
 <20111107183938.GA5155@sigill.intra.peff.net>
 <CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
 <20111107210134.GA7380@sigill.intra.peff.net>
 <CAMP44s089xbEo4VT8rqgS=BJMUu=qsb8Hm5z8bTR2akU8-5QhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 19:14:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNqC9-0002th-PQ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 19:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694Ab1KHSOp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 13:14:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37115
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751891Ab1KHSOo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 13:14:44 -0500
Received: (qmail 7138 invoked by uid 107); 8 Nov 2011 18:14:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Nov 2011 13:14:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2011 13:14:42 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s089xbEo4VT8rqgS=BJMUu=qsb8Hm5z8bTR2akU8-5QhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185102>

On Tue, Nov 08, 2011 at 07:31:09PM +0200, Felipe Contreras wrote:

> > =C2=A02. update remote refs with local values, including pushing an=
ything
> > =C2=A0 =C2=A0 new that we don't have locally (--sync-new)
>=20
> Anything new that we don't have *remotely*.

Sorry, yeah.

> > =C2=A01. git push --prune <remote> :
> >
> > =C2=A0 =C2=A0 I.e., use the "matching" refspec to not push new thin=
gs, but turn
> > =C2=A0 =C2=A0 on pruning.
>=20
> I guess so, but ":" seems a bit obscure.

Yeah, it is. It's also the default, so you could just do:

  git push --prune <remote>

Although some people have argued for changing the default in future
versions. I don't know what the status of that is.

> > =C2=A02. git push <remote> refs/heads/*
> >
> > =C2=A0 =C2=A0 Turn off pruning, but use an explicit refspec, not ju=
st "matching",
> > =C2=A0 =C2=A0 which will push all local branches.
>=20
> Isn't refs/heads/* the same as --all? BTW. I think --all is confusing=
,
> should be --branches, or something.

Doesn't --all mean all refs, including tags and branches? I thought tha=
t
was the thing you were avoiding. We could add syntactic sugar to make
--branches mean "refs/heads/*". But I do worry that pseudo-options like
that just end up creating more confusion (I seem to recall there being =
a
lot of confusion about "--tags", which is more or less the same thing).

-Peff
