From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 1/2] Documentation: 'git add -A' can remove files
Date: Mon, 7 Dec 2009 09:48:11 +0100
Message-ID: <20091207084811.GA31622@atjola.homenet>
References: <4B1C384A.8000106@gmail.com>
 <7vr5r7el2q.fsf@alter.siamese.dyndns.org>
 <20091207005732.GA20909@atjola.homenet>
 <7vbpib9r10.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Bj=F6rn?= Gustavsson <bgustavsson@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 09:48:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHZGm-0003do-3y
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 09:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934769AbZLGIsL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2009 03:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934767AbZLGIsL
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 03:48:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:36133 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934722AbZLGIsK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 03:48:10 -0500
Received: (qmail invoked by alias); 07 Dec 2009 08:48:14 -0000
Received: from i59F572C7.versanet.de (EHLO atjola.homenet) [89.245.114.199]
  by mail.gmx.net (mp004) with SMTP; 07 Dec 2009 09:48:14 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19kM4lnBRxkQ7Rh47rgwzShB+hHD9ibNCrH2Pb3jI
	av5YWTOj03hrC1
Content-Disposition: inline
In-Reply-To: <7vbpib9r10.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134726>

On 2009.12.06 23:34:03 -0800, Junio C Hamano wrote:
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>=20
> > What I usually say on #git is something like:
> >
> > 	"git add <path>" looks at the working tree to find files
> > 	matching <path>.  "git add -u <path>" looks at the index, and
> > 	"git add -A <path>" looks at both. Therefore "add" and "add -A"
> > 	can add new files to the index, and "add -u" and "add -A" can
> > 	remove files from it.
> >
> > 	And for convenience, -u and -A default to "." as the path argument=
=2E
>=20
> Hmm, an interesting way of teaching. How effective is it with the rea=
l new
> to mid-level users we see on the #git channel?

Hm, I wanted to check the channel logs for some reactions, but couldn't
find much. Apparently, I've not answered many question about add -u/-A
on #git since I switched to the above explanation (instead of saying
"git add -A is like git add . && git add -u" as I did in the past). For
the cases I found, the users didn't reply to the explanation. I can't
tell whether the explanation sucks, or whether the user was happy with
it or simply didn't care because he got the command he wanted.

I have two more data points for that kind of explanation in my Jabber
history, but those users aren't "new to mid-level" anymore.

And I recall only one really new user I told this to in face-to-face
"teaching", and that was right after explaining the index, so the
concept was present.

I guess the explanation might not be as easy to grok for someone that
doesn't have a good understanding of the index. For example, those that
still think that the index only stores changes (and is empty when no
"changes" have been staged) probably won't be able to make any sense ou=
t
of it.

Guess I'll have to apply a bunch of context when choosing which
explanation to use.

>=20
> > So maybe something like this?
> > ...
> > -A, --all
> >     Like -u, but matches <filepattern> against files in the index i=
n
> >     addition to the files in working tree. This means that it can f=
ind
> >     new files as well.
>=20
> Sounds easier to read to me but I think this description of "-A" seem=
s
> backwards from your explanation.  "Like -u" means "matches the index"=
 and
> the difference is it in addition matches with the work tree, so it sh=
ould
> probably be the other way around, i.e.
>=20
>      Like -u, but matches <filepattern> against files in the work tre=
e in
>      addition to the index. This means that it can find new files as =
well.

Hm, I meant that to show that while -u uses the index _instead_ of the
working tree, -A uses the index _in_addition_to_ the working tree, i.e.
I meant to say how -A differs from -u WRT its effect compared to a plai=
n
"git add".

IOW, I treat "git add" (working tree only) as the default behaviour. An=
d
-u changes it to "index only", while -A changes it to "working tree +
index". Your version makes it look more like -A is a modification of -u=
=2E

OTOH, I also used to say "to update all tracked files, use add -u, and
to also add new files use add -A", which is better matched by your
wording. Though I'd go for this then:

    Like -u, but also match <filepattern> against files in the working
    tree. This means that it can find new files as well

Which just says what -A does on top of -u, without repeating what -u
does.

Bj=F6rn
