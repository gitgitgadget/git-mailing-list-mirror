From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 00/21] git notes merge
Date: Fri, 22 Oct 2010 17:41:25 +0200
Message-ID: <201010221741.25390.johan@herland.net>
References: <1287626936-32232-1-git-send-email-johan@herland.net> <AANLkTi=YJd023C3rX_G+NEM_0N-nZqd0uP7yyTSt1tHj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 17:47:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9JqI-0006C6-7g
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 17:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757467Ab0JVPrh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 11:47:37 -0400
Received: from smtp.opera.com ([213.236.208.81]:46845 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756231Ab0JVPrg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 11:47:36 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o9MFfPsx012212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Oct 2010 15:41:25 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <AANLkTi=YJd023C3rX_G+NEM_0N-nZqd0uP7yyTSt1tHj@mail.gmail.com>
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.64 on 213.236.208.81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159703>

On Thursday 21 October 2010, Sverre Rabbelier wrote:
> On Wed, Oct 20, 2010 at 21:08, Johan Herland wrote:
> > - Fetching and pushing note refs:
> > =C2=A0- Add refs/notes/* to default fetch refspec?
> > =C2=A0- A way to specify (at clone time) which refspec(s) to set up=
?
> > =C2=A0- A way for the remote repo to hint at which refspecs you mig=
ht
> > want to set up (by default?)
>
> Didn't we already discuss this earlier? Can you summarize (or at
> least link to) that discussion?

Yes, sorry for not answering you earlier. Here's what you wrote in the=20
previous thread:

On Saturday 09 October 2010, Sverre Rabbelier wrote:
> Heya,
>
> On Sat, Oct 9, 2010 at 03:08, Johan Herland <johan@herland.net> wrote=
:
> > - Fetching and pushing note refs:
> >  - Add refs/notes/* to default fetch refspec?
>
> Or at least add a '--notes[=3D<notes namespace>]' to fetch, pull, and
> push.

Agreed, at least that.

In order to promote sharing of notes, though, I'd like for it to be=20
possible to configure the repo so that a vanilla 'git fetch' also=20
updates your notes. In fact, I wonder if this should even be made the=20
default.

> >  - A way to specify (at clone time) which refspec(s) to set up?
>
> How would that look like?

Maybe add an option to 'git clone' (and 'git remote add') that specifie=
s=20
the refspec you want to use in your config for that remote. Something=20
like:

  git clone --fetch=3D"+refs/heads/*:refs/remotes/origin/*" \
            --fetch=3D"+refs/notes/*:refs/remotes/origin/notes/*" \
            <source_url> ...

=2E..will set up the following config:

  [remote "origin"]
        url =3D <source_url>
        fetch =3D +refs/heads/*:refs/remotes/origin/*
        fetch =3D +refs/notes/*:refs/remotes/origin/notes/*

Obviously, we would probably want to provide shorthands for the most=20
common refspecs, like:

  git clone --fetch=3Ddefault,notes <source_url> ...

or

  git clone --fetch-heads --fetch-notes <source_url> ...

> >  - A way for the remote repo to hint at which refspecs you might
> > want to set up (by default?)
>
> I assume this would be a generic mechanism of sorts? Are there any
> other use cases for this other than notes?

Yes, I believe so (although I haven't thought much about this, yet).=20
There's been earlier discussions on hiding certain branches from view.=20
This could maybe be solved by the server suggesting a refspec that=20
excludes the stuff you don't want to share (by default). Similary, the=20
refspec could _include_ notes namespaces that you do want to share.

Of course (as today) the client should be free to demand a different=20
refspec, e.g. if it wants access to everything, or if it's only=20
interested in a subset of the "default" refs.


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
