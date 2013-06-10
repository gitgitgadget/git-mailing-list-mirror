From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Mon, 10 Jun 2013 19:27:08 +0200
Message-ID: <20130610172708.GH2091@goldbirke>
References: <1370637143-21336-3-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com>
 <7vd2rvqgra.fsf@alter.siamese.dyndns.org>
 <CAMP44s3Pny7JkyHbLZ3kUemNK70JhdYWdpELTjNLz0y3Z2V3+A@mail.gmail.com>
 <7vy5ajozuj.fsf@alter.siamese.dyndns.org>
 <CAMP44s38T9EUOe8EBKy1kxa-rEu7g0jb7+HB019AgCub+2SVnw@mail.gmail.com>
 <7vfvwrowd0.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Qr54+8hbkZ+jmXB628SCPwg1zZo80UBhFe2PCrgQP4Q@mail.gmail.com>
 <20130610093904.GG2091@goldbirke>
 <7vppvuj6wl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 19:27:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um5sG-0006JZ-7Z
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 19:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab3FJR1Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 13:27:16 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:54639 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab3FJR1P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 13:27:15 -0400
Received: from localhost6.localdomain6 (g227025092.adsl.alicedsl.de [92.227.25.92])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0LsywU-1UNZzi1wja-012bbv; Mon, 10 Jun 2013 19:27:08 +0200
Content-Disposition: inline
In-Reply-To: <7vppvuj6wl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:Oe/0SRnLKmEubDuJWCLIIuWTvAAw1ozikchdcHFINyz
 1eL3a/vv0JjVwYrZ9JDKzCQHK3Fv8CrSWA/P4/ZPpHpkcP27gC
 RGnrjQpiSO7J6Pq6giCkWWLNYqiCEtUMQEu6ZSTMKlNIJyh21D
 F8GIufR9rYYSa/tWd7oFPgkD2XWxR8rKlAxp8t++emqculwj1S
 T+8f2ETNjLwMJCACB7srwldaycqAaGOseD0oKwLf+GS/hAhwae
 NGHOnkZ8yQfrRo2sVddH8aii2e/kEWFnJNfwgh5snWkIbJ2bXn
 UzQkAJ5aNBc2eSDHcDaaUrT5JxKzQi5BddoqnC56/hbiEX7yFl
 k9/q4GqdyczkOjPQRYZ8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227330>

On Mon, Jun 10, 2013 at 08:56:58AM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > On Sun, Jun 09, 2013 at 03:41:54PM -0500, Felipe Contreras wrote:
> >> There
> >> will not be a need for test_string_must_be_empty() just like there=
's
> >> no need for test_string_cmp().
> >
> > Actually, if there were a test_string_cmp(), that would be the test
> > helper function I used most often.
>=20
> Hmm, there indeed are quite a many "At this point, the variable's
> value must be this" in the test scripts.  With things like this:
>=20
>     t/t0002-gitfile.sh:     test "$SHA" =3D "$(git rev-list HEAD)"
>=20
> we can go to the trash directory upon seeing a failure to run the
> command used on the RHS, but the value in $SHA is cumbersome to find
> out (either running it under sh -x or insert an extra echo before
> it), so such a helper function may be useful.
>=20
> Do you really need a general comparison ("does A sort before B") or
> just equality?  If the latter, test_string_equal (or even
> string_equal) might be a better name for it.

Yeah, I need only equality.  Or at least it would be nice to have.

My main motivation is that, like in your example, in the bash prompt
tests I only have to check a single line of output, but because of
debuggability I always did:

  echo "(master)" >expected
  __git_ps1 >actual
  test_cmp expected actual

With such a helper function this could be reduced to a single line:

  test_string_equal "(master)" "$(__git_ps1)"

without loss of functionality or debuggability, because in case of a
failure it would output something like this (bikesheddable, of
course):

  Error:
    expected: "(master)"
    got: "((deadbeef...))"

And perhaps with a description as an optional third argument to help
identify the failed check if multiple such checks are done in a single
test, e.g. the test_rev_parse() helper in t/t1501-worktree.sh, 'setup:
helper for testing rev-parse', which could be shortened as:

  test_string_equal "$1" "$(git rev-parse --is-bare-repository)" "bare"
  test_string_equal "$2" "$(git rev-parse --is-inside-git-dir)" "gitdir=
"
  test_string_equal "$3" "$(git rev-parse --is-inside-work-tree)" "work=
tree"

and if something goes wrong we'd get:

  Error: worktree
    expected: "true"
    got: "false"

Perhaps I could find some time in the days ahead to give it a go.


G=E1bor
