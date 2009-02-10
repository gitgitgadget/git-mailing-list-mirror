From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] builtin-branch: highlight current remote branches with
	an asterisk
Date: Tue, 10 Feb 2009 12:50:36 +0100
Message-ID: <20090210115036.GG1320@atjola.homenet>
References: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com> <20090210075214.GC1320@atjola.homenet> <20090210111907.GD12089@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 12:52:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWrAE-0006VX-ED
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 12:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbZBJLvC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2009 06:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753320AbZBJLvB
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:51:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:35765 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753372AbZBJLvA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 06:51:00 -0500
Received: (qmail invoked by alias); 10 Feb 2009 11:50:56 -0000
Received: from i577B9B52.versanet.de (EHLO atjola.local) [87.123.155.82]
  by mail.gmx.net (mp054) with SMTP; 10 Feb 2009 12:50:56 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19jXgpgf7BjRn8DLtncSxJgUFdN249C6mP1Y3epg7
	VISgH1sSBx1PDd
Content-Disposition: inline
In-Reply-To: <20090210111907.GD12089@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109215>

On 2009.02.10 06:19:07 -0500, Jeff King wrote:
> On Tue, Feb 10, 2009 at 08:52:14AM +0100, Bj=F6rn Steinbrink wrote:
>=20
> > still don't really see what I'd use it for. From what I've heard, s=
ome
> > people just consider origin/HEAD a clone artifact without much use,=
 and
> > so far, I think I agree. But maybe there's more to it?
>=20
> The ref "origin" will resolve to "refs/remotes/origin/HEAD", if it
> exists. So you can use it as a shorthand for "origin/master" (or
> whatever branch is most interesting to you on the remote).

Yeah, that's what I meant when I said "short-shortname". Maybe it's jus=
t
me, but I really can't see myself using that. Would be likely that
"origin" references something else than what I expect, especially when
switching from one repo to another. And doing "git branch -r" to find
out if "origin" is the right thing is slower than just typing the full
shortname right away. Well, just my 2 cents.

> > If the <name>/HEAD symref would be created for all remotes and woul=
d get
> > updated, that would at least make the marker more meaningful, but I
>=20
> It has been noted in the past that it should _not_ be automatically
> updated, since it is really about "what is the user's preference for =
the
> 'most interesting' branch in this remote". And we don't want to
> overwrite some preference that they specified.

Yeah, as I said in the other mail, having it as a default would make ad=
d
-m quite pointless.

> So I think it makes sense to:
>=20
>   - if it doesn't exist, set it up based on the remote's HEAD. Clone
>     already does this, but "git remote add -f" should probably do it,
>     too. I'm not sure if every fetch should do it.

=46WIW, I would hate fetch for doing that. I dislike the whole
<remote>/HEAD thing, and wouldn't want fetch to recreate that for me al=
l
the time.

>   - give the user some nice interface (probably via "git remote") to
>     move the pointer around (right now, it is "git symbolic-ref
>     refs/remotes/$remote/HEAD refs/remotes/$remote/$branch").

Maybe "git remote set-master"? Though I kinda dislike the "master" part
of the name, which I just took from the -m option to "remote add",
though. I guess that could increase the confusion about the "master"
branch as pre-setup by "git init" being special, and might lead to
interesting conclusions about that command affecting the remote
repository.

>   - give the user some nice interface to re-fetch the remote HEAD and
>     update refs/remotes/$remote/HEAD with it. Probably as an option t=
o
>     the "git remote" invocation above.

Yeah, would make sense.

Bj=F6rn
