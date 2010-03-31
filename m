From: Eli Barzilay <eli@barzilay.org>
Subject: Re: git check-attr in bare repositories
Date: Tue, 30 Mar 2010 23:15:58 -0400
Message-ID: <19378.48750.465977.853886@winooski.ccs.neu.edu>
References: <m3iq8jn3ar.fsf@winooski.ccs.neu.edu>
	<20100328014208.GA23015@progeny.tock>
	<19376.50971.397375.810974@winooski.ccs.neu.edu>
	<19376.53419.640007.930897@winooski.ccs.neu.edu>
	<20100329231501.GA28194@progeny.tock>
	<19377.33747.838003.360864@winooski.ccs.neu.edu>
	<20100330212222.GA11192@progeny.tock>
	<m3iq8dij6r.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 05:16:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwoPf-0005mY-IG
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 05:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756318Ab0CaDQE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 23:16:04 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:44397 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755999Ab0CaDQB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 23:16:01 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1NwoPO-00008K-FS; Tue, 30 Mar 2010 23:15:58 -0400
In-Reply-To: <20100330212222.GA11192@progeny.tock>,
	<m3iq8dij6r.fsf@localhost.localdomain>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143641>

On Mar 30, Jonathan Nieder wrote:
> Eli Barzilay wrote:
> > If anything, I'd like it if `check-attr' could just use the
> > repository directly instead of the index (or a work tree) in a
> > bare repository.
>=20
> I think the right thing to do is to put this functionality in a new
> =E2=80=98git ls=E2=80=99 command.  Maybe something like this:
>=20
>  $ git ls --format=3D'%p %a(crlf)' master -- '*.txt'
>  some/path/foo.txt crlf:input
>  some/path/bar.txt crlf
>  some/path/other.txt !crlf
>  yet/another/path.txt=20

This looks useful, but it has a problem of being lower level than
`check-attr' in the sense that you need to parse this output.


On Mar 30, Jakub Narebski wrote:
>=20
> Well, that or make `git check-attr` support reading .gitattributes
> from repository (from a corresponding tree object).
>=20
> Unfortunately `git check-attr` doesn't have place to put revision...
> well unless as a parameter:
>=20
>   git check-attr [--cached|--tree <tree-ish>] <attr>... [--] <pathnam=
e>...

This looks like a better way to have what I need from it...  It also
looks useful for other uses -- for example, an attribute that is used
by a hook to specify that some file should not be deleted (so the hook
needs to look at the value before the commit).

(But in any case, I'd be happy if there was a way to make it read the
contents of a (temporary) index.)

--=20
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay=
:
                    http://barzilay.org/                   Maze is Life=
!
