X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: Subprojects tasks
Date: Mon, 18 Dec 2006 08:44:41 +0100
Message-ID: <20061218074441.GJ12411@admingilde.org>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net> <200612171401.10585.jnareb@gmail.com> <20061217134848.GH12411@admingilde.org> <200612180023.45815.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nO3oAMapP4dBpMZi"
NNTP-Posting-Date: Mon, 18 Dec 2006 07:44:54 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612180023.45815.Josef.Weidendorfer@gmx.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34722>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwDB1-0007zw-3T for gcvg-git@gmane.org; Mon, 18 Dec
 2006 08:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753469AbWLRHoo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 02:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbWLRHon
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 02:44:43 -0500
Received: from mail.admingilde.org ([213.95.32.147]:47296 "EHLO
 mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753469AbWLRHon (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 02:44:43 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GwDAv-0004W7-VJ; Mon, 18 Dec 2006 08:44:41 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org


--nO3oAMapP4dBpMZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Dec 18, 2006 at 12:23:45AM +0100, Josef Weidendorfer wrote:
> I see that you always use "refs/heads/master" in the submodule.
> What happens if you do development in the submodule, create a new commit
> there, and want to switch supermodule branch afterwards?
> Wouldn't you lose your new work, as "refs/heads/master" has to be reset
> to another commit when you switch the supermodule branch?

It should behave the same as for files:
Refuse to update the working directory if files (or the submodule here)
are dirty.  I guess this is not yet handled correctly by my prototype,
but it should not be hard to do.

> IMHO it would be nice to have refs in the submodule matching all the
> branches/tags of the supermodule.
> Meaning: "this is the commit which is used by branch/tag XYZ in the
> supermodule". This can be valuable information, and a "gitk --all" in
> the submodule would show you all the uses of your subproject in the
> scope of the given superproject.

I like the idea.  Perhaps make them available similiar to the remotes
information in refs/tracked/{heads,tags} or something.

> When switching branches in the supermodule, it simply would switch
> to the same name in submodules.

Nice idea, but I don't yet know how it really works out.
It may be confusing to the user if he manually switches the branch in
the submodule to another branch of the supermodule.  Then he really is
using one tracked branch, but not the currently tracked branch.

> Thus, this would allow to do bug fix commits for a submodule at all
> places where the supermodule has a branch, without the need to switch
> supermodule branches.

Hmm, but when switching to another supermodule branch it would try to
update the submodule branch.
And simply allow the current submodule branch to be a fast forward of
the submodule version that the parent wants to set is a bad, as you
would not be able to go back to an old supermodule version then.

> > > Second, if you want to do some independent work on the module not rel=
ated
> > > to work on submodule you should really clone (clone -l -s) submodule
> > > and work in separate checkout;
> >=20
> > Yes.
> > But I really like the possibility to switch one module to a branch which
> > is not tracked by the parent, because it perhaps contains some debugging
> > code which is needed to debug some other submodule.  You can't move it
> > out because you need the common build infrastructure but you don't want
> > to branch the entire toplevel project because you don't want your
> > debugging changes to ever become visible at that level.
>=20
> In general, I agree with not following submodule's HEAD for supermodule
> commits. As you cannot store any submodule branch names, this really
> would be confusing, as after switching to another supermodule branch
> and back again, the submodule branch name would reset to a given name
> ("master" in your current implementation).
>=20
> But why wouldn't you create a temporary branch "debug_submodule1" in the
> supermodule for your use case? Branches are cheap with git, even in super=
modules.
> Supermodule branches also are pure local, you never have to publish
> it somewhere, and can delete it afterwards.

Sure, you can of course always use supermodule branches.
I just wanted to point out that it still is useful to have submodule
branches which are independent from supermodule branches.

--=20
Martin Waitz

--nO3oAMapP4dBpMZi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFhkbpj/Eaxd/oD7IRAt1BAJ93SuzWNQwWWR2ojsaiVLQZWVXhLgCeMvoj
Oz2v7uXzDkJTf9y0fqBxcb8=
=1IUm
-----END PGP SIGNATURE-----

