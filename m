From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Thu, 10 Dec 2009 12:08:40 +0100
Message-ID: <20091210110840.GA12098@atjola.homenet>
References: <20091208144740.GA30830@redhat.com>
 <7vfx7lcj18.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0912090941420.470@ds9.cixit.se>
 <20091209093758.GA2977@redhat.com>
 <alpine.DEB.2.00.0912091150470.470@ds9.cixit.se>
 <20091209112237.GA27740@atjola.homenet>
 <alpine.DEB.2.00.0912091414460.470@ds9.cixit.se>
 <20091209134133.GA30596@atjola.homenet>
 <alpine.DEB.2.00.0912100937580.22606@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Dec 10 12:08:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIgt8-0002GS-Cv
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 12:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760594AbZLJLIk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Dec 2009 06:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760456AbZLJLIk
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 06:08:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:45307 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933609AbZLJLIj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 06:08:39 -0500
Received: (qmail invoked by alias); 10 Dec 2009 11:08:45 -0000
Received: from i59F576CC.versanet.de (EHLO atjola.homenet) [89.245.118.204]
  by mail.gmx.net (mp047) with SMTP; 10 Dec 2009 12:08:45 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX183bXwZgMc3PUYdhwSyz2fjJzF6CZpMcRtbP2aakg
	ZosIgeVd9LUJiY
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0912100937580.22606@ds9.cixit.se>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135017>

On 2009.12.10 09:43:51 +0100, Peter Krefting wrote:
> Bj=F6rn Steinbrink:
> >"git merge" is about merging histories. --squash and the A..B you
> >suggest make it degenerate into merging changes (and you can't
> >record that using the commit DAG). So that messes things up
> >conceptually.
>=20
> I know, this is the one "feature" of CVS that I sometimes miss in
> Git, that I cannot "merge" just parts of a history, and have that
> recorded in the history tree. I know it's wrong, I know I could do
> it better, but sometimes it's the shortcut that would make life
> easier for me. :-)

Hm, does CVS really record the fact that things were merged? I've never
seriously used CVS, so I have no idea... And if it does, is it just the
same thing as the svn "merge"-tracking?

> But the reason I mentioned it was because of the discussion on
> whether the "reverse rebase" should be an option to "cherry-pick" or
> not, and I mentioned that it could just as well be "merge" since it
> can be used to throw away history as well.

OK, and I disagreed because I think that "merge --squash" is already
wrong. And given your comment below about retiring "merge --squash", I
guess we're in agreement now, right?

> >Anyway, "git merge" with a range simply makes no sense at all
> >given how git's merge works (opposed to svn's idea of merging,
> >which is about changes, not about histories). If you want a squash
> >flag, tell cherry-pick to handle ranges and teach such a flag to
> >it.
>=20
> And tell "merge" to tell me that if I try, so that if I try
>=20
>   $ git merge A..B
>=20
> I would get a message saying something like
>=20
>   Cannot merge a range of commits. Try "git cherry-pick A..B" or
>   "git rebase --reverse A..B".

Hm, for an error message that "range of commits" is probably on the edg=
e
of being confusing. After all "git merge B" will create a new commit M
that "says" that M^1..M^2 was merged to M^1. But I can't come up with a
better error message either.

> And perhaps we could also in the same way retire --squash?
>=20
>   $ git merge --squash B
>   The "--squash" option is obsolete. Please use "git cherry-pick
>   --squash B".

git cherry-pick --squash ..B # Not just B itself, but the whole range

> (with a transition period where it would just call the other). Or
> whatever the options to simulate the old behaviour would be. This
> would make it clearer that "merge" preserves history while
> "cherry-pick" and "rebase" do not.

I'd certainly like that.

Bjoern
