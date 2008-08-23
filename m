From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: nicer frontend to get rebased tree?
Date: Sat, 23 Aug 2008 22:08:45 +0200
Message-ID: <20080823200845.GA17374@atjola.homenet>
References: <20080822174655.GP23334@one.firstfloor.org> <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org> <20080822182718.GQ23334@one.firstfloor.org> <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org> <20080823071014.GT23334@one.firstfloor.org> <alpine.LFD.1.10.0808230853170.3363@nehalem.linux-foundation.org> <20080823164546.GX23334@one.firstfloor.org> <20080823181827.GA15993@atjola.homenet> <alpine.LFD.1.10.0808231152250.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 22:09:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWzQo-0002QM-A4
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 22:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180AbYHWUIu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Aug 2008 16:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753759AbYHWUIu
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 16:08:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:56391 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753394AbYHWUIt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 16:08:49 -0400
Received: (qmail invoked by alias); 23 Aug 2008 20:08:47 -0000
Received: from i577BB1D4.versanet.de (EHLO atjola.local) [87.123.177.212]
  by mail.gmx.net (mp022) with SMTP; 23 Aug 2008 22:08:47 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19XSVpNuilX+QDbczi3Ma3RroZM1fsHYcSnSwXJ7O
	QJHnLtrSdy2/Cx
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808231152250.3363@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93485>

On 2008.08.23 11:56:27 -0700, Linus Torvalds wrote:
> On Sat, 23 Aug 2008, Bj=F6rn Steinbrink wrote:
> > So, how would you make it less obscure and unobvious then the curre=
nt
> > method? The current method would be:
> >=20
> > git fetch linux-next
> > git checkout linux-next/whatever
> >=20
> > Which seems neither obscure nor unobvious to me...
>=20
> One thing that I admit we haven't done is _document_ this in some
> obvious place.

One thing I experienced in #git is that people seem to have problems
understanding remote tracking branches like linux-next/whatever in the
above example. Quite often, there have been requests like:

 How can I pull into all of my branches at once?

And after some back and forth about pull being fetch+merge and that you
can only merge into your current branch etc. it usually turns out that
those folks just have a local branch for each remote tracking branch,
even if all they want is just the state of the remote tracking branch
anyway.

So they end up doing stuff like:

git checkout foo
git pull
git checkout my_work_on_top_of_foo
git rebase foo

Where "foo" is always just fast-forwarded to origin/foo.

So I think a major part of the problem is that remote tracking branches
are not understood or at least not valued enough. Unfortunately, I have
no real idea how we could improve that.

Once on #git, I explained how branches (ie. the refs in refs/heads) are
special and that HEAD becomes a symbolic ref when you check them out,
while it becomes a plain reference to a commit when you check out
something else (tag, remote tracking branch, commit, whatever). And tha=
t
operations like commit dereference HEAD until they find a non-symbolic
ref and update _that_ ref. I think that explanation worked quite well
for the person I was talking to and made him realize that you only need
branches when you really want create your own commits. But OTOH, tellin=
g
people that local branches are the actual special case might as well
confuse the hell out of them (me thinks). And besides that, I'm no good
at writing "static" documentation anyway.

Bj=F6rn
