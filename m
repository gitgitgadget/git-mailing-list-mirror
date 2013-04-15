From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Mon, 15 Apr 2013 09:35:59 +0100
Message-ID: <20130415083558.GB2278@serenity.lan>
References: <1365780835-2853-1-git-send-email-artagnon@gmail.com>
 <7v38uvcrjl.fsf@alter.siamese.dyndns.org>
 <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com>
 <7vehed7ilu.fsf@alter.siamese.dyndns.org>
 <CALkWK0k6bmjFxTSMAutgu2EjWRZ_cyTU9jZ3Er-aaV78T16RtQ@mail.gmail.com>
 <7vppxw335o.fsf@alter.siamese.dyndns.org>
 <516BA732.4080405@viscovery.net>
 <7vzjx01cqn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 10:36:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URetc-00082r-Nq
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 10:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934425Ab3DOIgM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Apr 2013 04:36:12 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:39035 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933813Ab3DOIgL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 04:36:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id C683C606570;
	Mon, 15 Apr 2013 09:36:10 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nPWIWATUQ5Ur; Mon, 15 Apr 2013 09:36:10 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 4964460656D;
	Mon, 15 Apr 2013 09:36:00 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vzjx01cqn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221203>

On Mon, Apr 15, 2013 at 12:20:32AM -0700, Junio C Hamano wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>=20
> > User says:
> >
> >    git push -- master docs release
> >
> > Then git pushes the three branches to three different upstreams. Yo=
u find
> > that confusing. Do I understanding correctly so far?
>=20
> It is far more subtle than that.  User says that while on 'next'
> branch.
>=20
> The user has been trained to think "branch.master.remote" takes
> effect while he has "master" branch checked out.
>=20
> That is where the possible confusion comes from. As I said number of
> times, you may be able to declare that the confusion is unfounded
> once you think it through.

I may be an atypical user, but my expectation currently is that
branch.<name>.remote is what is used when I run "git push" with no
additional arguments.

This is probably because whenever I add additional arguments (currently=
)
I have to specify where I am pushing to.

So I think breaking user expectations is a red herring here because the
current behaviour means that users cannot have any expectation of what
will happen in this case.  Either you don't say anything and "git push"
DTRT for your current branch or you must specify precisely what you wan=
t
to happen (or at least the remote to use if you have push.default =3D
matching or remote.<name>.mirror set).

Personally I'd vote for "git push -- master" pushing to
remote.pushdefault, but I really don't know how you handle "git push --=
"
with the na=EFve implementation of that - is it the same as "git push" =
or
"git push $(git config remote.pushdefault)"?

On the other hand, I'm really not sure how often I'd use this feature.
Normally I just use "git push" and if I'm giving any more arguments tha=
n
that then it's for something that I don't do often enough for it to be
worth setting up configuration.
