From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Tue, 20 Nov 2012 07:19:12 -0500
Message-ID: <20121120121912.GC7096@odin.tremily.us>
References: <20121117153007.GB7695@book.hvoigt.net>
 <20121117192026.GI22234@odin.tremily.us>
 <7vd2z9t7y2.fsf@alter.siamese.dyndns.org>
 <20121120011628.GD321@odin.tremily.us>
 <7v1ufou92h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 13:19:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tamnb-0003qr-3Y
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 13:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241Ab2KTMTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 07:19:16 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:31535 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab2KTMTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 07:19:16 -0500
Received: from odin.tremily.us ([unknown] [72.68.98.228])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MDS00H5RCW0IF70@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 20 Nov 2012 06:19:13 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 2C7936984E0; Tue,
 20 Nov 2012 07:19:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1353413952; bh=4Id+28dpEaJ0PwbmYR3dZX+NuDHfvV/3nv1bGoVC/Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ECnwYOep1/hn27tbr6RQNNtW+DmeUN0tAdOFn17ZQxHABvBbwa8C1UJ5ZzmZsvAmb
 9Mk+JEDK+DMsWpejgKp2nCzObitkCiqaqRDulZym5kvQa0uiAZoKyjJm8s2OMaH/+O
 TA+VQUow+qmz8QftuqrOU4FwOO0kkn/CtURzAyBA=
Content-disposition: inline
In-reply-to: <7v1ufou92h.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210097>


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2012 at 09:39:34PM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
>=20
> > On Mon, Nov 19, 2012 at 04:49:09PM -0800, Junio C Hamano wrote:
> >> "W. Trevor King" <wking@tremily.us> writes:
> >> ...
> >> > I think it's best to have users craft their own commit messages
> >> > explaining why the branch was updated.  That said, an auto-generated
> >> > hint (a la "git merge") would probably be a useful extra feature.
> >>=20
> >> I am not quite sure I agree.  When the project says "Use the tip of
> >> 'bar' branch for the submodule 'foo'" at the top-level, does an
> >> individual user who is not working on the submodule 'foo' but merely
> >> is using it have any clue as to why the submodule's 'foo' branch
> >> 'foo' moved, or does he necessarily even care?
> >
> > If he doesn't care, why is he updating the submodule gitlink?
>=20
> He may not be updating the gitlink with "git add foo" at the
> top-level superproject level.  He is just using that submodule as
> part of the larger whole as he is working on either the top-level or
> some other submodule.  And checkout of 'foo' is necessary in the
> working tree for him to work in the larger context of the project,
> and 'foo' is set to float at the tip of its 'bar' branch.  And that
> checkout results in a commit that is different from the commit the
> gitlink suggests, perhaps because somebody worked in 'foo' submodule
> and advanced the tip of branch 'bar'.

The superproject gitlink should only be updated after

  $ git submodule update --pull

A plain

  $ git submodule update

would still checkout the previously-recorded SHA, not the new upstream
tip.  The uncaring user should skip the "--pull", and there will be no
superproject changes to worry about.

> Or are you envisioning that such a check-out will and should show a
> local difference at the submodule 'foo' by leaving the index of the
> top-level superproject unchanged,

A plain "git submodule update" will, yes.  And this will clobber any
changes that have happened in the submodule directory and its index
(because the user explicitly asked to checkout the
superproject-recorded SHA)

> and the user should refrain from using "git commit -a" to avoid
> having to describe the changes made on the 'bar' branch in the
> meantime in his top-level commit?

What would "git commit -a" be picking up?  Nothing in the superproject
has changed?

> That is certainly fine by me (I am no a heavy submodule user to
> begin with), but I am not sure if that is useful and helpful to the
> submodule users.

The benefit is that =C6var's

  $ git submodule foreach 'git checkout $(git config --file $toplevel/.gitm=
odules submodule.$name.branch) && git pull'

becomes

  $ git submodule update --pull

Still an explicit pull, but much easier to remember.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQq3U+AAoJEEUbTsx0l5OMuskQAIkqDczB+lB7oLgvlrh1WAal
BC9gDGK4SnbCc/TUtBi7BpuyhNT8CVLirFDBmUoMxJKehIjOsercz0EXe6YLSW3h
31wOqkPQKBLZb0pEgJbDMa5wFB+tRiMZKKjpwvU/sqTeMTPJ5uJAFV2jHSdV2cXi
lQJ8lWjL0UxyqK3YR9IQO4MIYCK9wTxJkW/ghkfcoJ02WjdlN+1JeB7kSu7at0F5
xQm7OYqvJkhpTdf5Dqw87y5UkKgi2N18Zklcw8l6QCX6OLzidxlxBjj7iw4xIDlZ
LXUgv7O9c9xNT4jdcGbL9AqbU/JIG006d+M354ExBu+QExjpv09najvGCj3g0wWe
l04sQFEqtxjJT3lmoqwl1mS9qXT0NgGW7NZy4/8RzTxc99gonb8XSuzsjiCB9f0b
OJ9w08qYxO4+WjKglNUg8QCCZu5yyjA9ExNiM/iU4DtdwQwLqskKmXUI8UXekVof
bQeGjGqPTAH5HzuByj+gzQjPcrfp2seWHeK+36gBtsxryMOy+u1TBjHTD5kf1EzA
6WprNYrxocmuY8XN+OaQjCNwLe6+bzHQqPTgsZ0ngvn3P+3KsZLQqlM85015JQnS
iL/hH9nWzXpRyIJYyMcK6I0+/VvfnQkkiVWaHc+lHu+jqPXLjxPqvqRuItygoTJq
XM9sJK8kHsUyJ6s7FBpz
=YaYa
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
