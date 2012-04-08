From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: In tree object, Must the
Date: Sun, 08 Apr 2012 15:20:17 +0200
Message-ID: <1333891217.7419.5.camel@centaur.lab.cmartin.tk>
References: <CAFT+Tg-+s5=pFNwY7ZMxem4z6YHu53kyOs0B_rkmphq=mEtpTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-V913WP3gFpNnM55Ise7y"
Cc: git@vger.kernel.org
To: semtlenori@gmail.com
X-From: git-owner@vger.kernel.org Sun Apr 08 15:20:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGs2g-0003vC-8D
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 15:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440Ab2DHNUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 09:20:23 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:47808 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233Ab2DHNUW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 09:20:22 -0400
Received: from [192.168.1.17] (brln-4db9cec9.pool.mediaWays.net [77.185.206.201])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 8017146057;
	Sun,  8 Apr 2012 15:20:03 +0200 (CEST)
In-Reply-To: <CAFT+Tg-+s5=pFNwY7ZMxem4z6YHu53kyOs0B_rkmphq=mEtpTg@mail.gmail.com>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194997>


--=-V913WP3gFpNnM55Ise7y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2012-04-08 at 12:43 +0900, Yi, EungJun wrote:
> Hello,
>=20
> I'm implementing Git using node.js, and I have a question while I
> write some code to store tree object.
>=20
> Tree object looks a table consists of three fields: blob's mode, name
> and id, as below.
>=20
> e.g.)
> $ git cat-file -p 45799547
> 100644 blob cd242b1e5bb403500feb49a1aa656c21c6c0be69	Makefile
> 100644 blob bf382321749577d52bd2fbf2281df0510b4bad31	README.md
> 100644 blob 5441bb48428611a3cb140d8192d39484fcf3b742	fsutil.js
> 100644 blob 0af680a5c0dd4482b09aa7f8e837234bed0b7cfa	package.json
> 040000 tree 39a4d45669addfb1e8f0a499deebc5b97b4edfa0	test
>=20
> It seems that the table is stored in order by blob's name.

Yes, the entries in the tree are alpha-sorted. The exception are trees,
where you have to pretend that there is a trailing slash. In other
words, the order is the same as you'd see in the index (as there, the
test/ directory in your example would be stored with a slash and the
name of the subdirs and files in it.

>=20
> If it is true, what happens if it is not ordered?

fsck complains for one.

>=20
> Does that cause any troubles to users to use a git repository created
> and managed by my Git implementation?

How does your implementation store things? You haven't said (maybe
hinted that you may be writing trees with the wrong order). Depending on
the particular implementation of whatever is reading the git repository,
it might not be able to find an entry in your tree, as it's wrongly
sorted, but that depends on the exact implementation and possibly luck.

Do you need to write this in pure js? There are some bindings for
node.js[0] already for libgit2 so you don't need to redo the low-level
work.

Cheers,
   cmn

[0] https://github.com/libgit2/node-gitteh


--=-V913WP3gFpNnM55Ise7y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAABAgAGBQJPgZCRAAoJEHKRP1jG7ZzTejYIAKFRDZk1pn4YqcekROhM8wN8
kEBcFnrA7k44I7CRo8J0mISUkyogfTqTDn91/oaTJXcTb24vEROtQajaBxaCZapF
jRq5MLrUcNMR9YAsnmamsWMHRLpbg9RBoRigPsvpN6uKj37M4DGndkV6wyOkMHW+
Vyvejc6NhfsvwuFwAw0NQLqm/lL2h80/GLr6cCM6ssXs7NSUq4GZUFpCPoPbX+ha
1i9l29qLjvAwcynGAhRok62XbNWIY6hTx8Yt6K1I7L4R6+tbgk9lt/G/7HaKqbVL
d74G5rEo9yntL7HZXY98IuHaDZoj7gU3NfVB1UUW7tJG28uDgLKygWqmkH0NZC8=
=5Z1l
-----END PGP SIGNATURE-----

--=-V913WP3gFpNnM55Ise7y--
