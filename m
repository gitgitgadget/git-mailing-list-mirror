From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-send-pack: don't consider branch lagging behind as   errors.
Date: Fri, 20 Jun 2008 11:55:08 +0200
Message-ID: <20080620095508.GB26765@artemis.madism.org>
References: <1213872715-11182-1-git-send-email-madcoder@debian.org> <20080619133747.GA31209@sigill.intra.peff.net> <20080619135159.GA19560@artemis.madism.org> <20080619151110.GA31654@sigill.intra.peff.net> <20080619162801.GA2468@artemis.madism.org> <7vhcbpuvfb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="1LKvkjL3sHcu1TtY";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 11:56:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9dLm-0002fr-1A
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 11:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbYFTJzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 05:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbYFTJzN
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 05:55:13 -0400
Received: from pan.madism.org ([88.191.52.104]:52022 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbYFTJzL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 05:55:11 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id F1458374BA;
	Fri, 20 Jun 2008 11:55:09 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 914E59AE; Fri, 20 Jun 2008 11:55:08 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vhcbpuvfb.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85612>


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On jeu, jun 19, 2008 at 06:33:12 +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > On Thu, Jun 19, 2008 at 03:11:10PM +0000, Jeff King wrote:
> >> On Thu, Jun 19, 2008 at 03:52:00PM +0200, Pierre Habouzit wrote:
> >> > >   - there is a possible danger with "git push -f", in that you for=
ce
> >> > >     both rejected branches as well as stale branches. Junio and I
> >> >   Well afaict this is a separate issue, as we're (with such a patch)
> >> > only changing what gets printed on the console, not the internal
> >> > behavior. So solving this second issue should not really be a
> >> > precondition to the inclusion of such a patch.
> >>=20
> >> It is a separate issue, but it is exacerbated by hiding stale refs.
> >> Imagine:
> >>=20
> >> $ git push
> >> To /path/to/repo
> >>    ! [rejected]        master -> master (non-fast forward)
> >>=20
> >> $ git push -f
> >> To /path/to/repo
> >>    + 0abfa88...c1ed93b master -> master (forced update)
> >>    + 0329485...3498576 stale_branch -> stale_branch (forced update)
> >>=20
> >> I think that is a nasty surprise to spring on an unsuspecting user.
> >> Another solution might be "-f" not pushing rewound branches, but then =
we
> >> need a way to specify "no, really, push this rewound branch". Perhaps
> >> "-f -f"?
> >
> >   Well then we could keep the [stalled] lines for now until this issue
> > is resolved then, despite what the people at the beginning of the other
> > thread complained about. My real issue is that I have my shell
> > configured so that my prompt becomes inverted if the last command
> > failed. So do many people I know, and well, git push for stalled
> > references should just not generate an error. _this_ is my sole concern
> > :)
>=20
> There are two cases the push does not fast forward.  The case where you
> are truly behind (aka "stale") and you and the pushed-to repository have
> diverged history.  Reporting success when you did not push due to the
> latter is unacceptable.  I personally rely on the fast-forward safety in
> my push-out scripts, but I do not think it is just me.  The exit status f=
rom
> commands are designed to be used that way.

  Sure, but when you use `git push` or `git push <remote>` forms of the
commands, you usually don't mean to push "everything", but rather
"everything that has new stuff". Stalled branches that you didn't
fast-forwarded yet should not generate issues IMHO.

  Of course, for git-push <remote> <branch> this could be different.

> The thing is, the user asked to push certain refs, and some did not get
> updated.  The user has the right to expect a failure indication from the
> command.  If you choose to _ignore_ the failure, that is _your_ choice,
> like:
>=20
> 	$ git push || :

  I don't want to ignore push failures. It's just that in my
workflow[0], stalled branches are _not_ a problem, whereas non
fast-forward are. I cannot rely on the exit status, to know if all was
fine, and that's annoying, really (Not a _major_ PITA, but an annoyance
nonetheless).


  [0] we have quite a few branches for our different releases and
      production branches. I rarely do fixes there, but still have
      tracking branches for those, and when I'm pushing my master, I get
      errors each time another coworker pushed a production fix, until I
      git stash, git checkout <stalled-branch>, git merge
      <origin/stalled-branch>, git checkout back, git stash apply
      *PHEEEW* all that for git push[1] ? No thanks.

  [1] I know I can `git update-ref refs/heads/<stalled-branch> $(git
      rev-parse origin/<stalled-branch>)` to fix that in one step but:
        - it's plumbing ;
	- if you forget the refs/heads it don't DWIM ;
	- it's easy to mess things up with such use patterns
	  (sub-problem of `it's plumbing`).
      So I don't really think this is the proper answer to my problem.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhbfnwACgkQvGr7W6Hudhzz3QCgmgCuhjuQqZAoy+8SQDcKivy3
TGYAnRTN8GvMDebDa8q7LWR9DAGH9IBO
=HWzU
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
