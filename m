From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: multiple-commit cherry-pick?
Date: Thu, 6 Nov 2008 10:51:22 +0100
Message-ID: <20081106095122.GA2656@atjola.homenet>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com> <20081106032437.GA27237@euler>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Thu Nov 06 10:52:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky1Xe-0000du-U6
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 10:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632AbYKFJv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Nov 2008 04:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753567AbYKFJv3
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 04:51:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:40593 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753408AbYKFJv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 04:51:26 -0500
Received: (qmail invoked by alias); 06 Nov 2008 09:51:23 -0000
Received: from i577BA50B.versanet.de (EHLO atjola.local) [87.123.165.11]
  by mail.gmx.net (mp023) with SMTP; 06 Nov 2008 10:51:23 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18P+Jds9mQPaFB/bAFyF7o5efi5w+RGlUez570bS+
	ELB1yCs7y/B3Dc
Content-Disposition: inline
In-Reply-To: <20081106032437.GA27237@euler>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100223>

On 2008.11.05 22:24:37 -0500, Deskin Miller wrote:
> On Thu, Nov 06, 2008 at 11:45:27AM +0900, Miles Bader wrote:
> > Is there any easy way to cherry pick a _range_ of commits from some=
 other
> > branch to the current branch, instead of just one?
> >=20
> > I thought maybe git-rebase could be coerced to do this somehow, but=
 I
> > couldn't figure a way.
>=20
> Rebase is exactly what you want.  Given something like this:
>=20
> o--o--o--A--B--C--o--o--X
>     \
>      o--o--D
>=20
> where you want A, B, C to go on top of D:
>=20
> $ git checkout -b newbranch C
> $ git rebase --onto D ^A

That should be A^ ;-)

> newbranch will have <...> --D--A--B--C

=2E.. and then you can merge newbranch into the existing branch that
references D, fast-forwarding the branch. And then newbranch can be
deleted.

If you don't want to use a temporary branch, you can also do (while on
the branch onto which you want to cherry-pick):

git reset --hard C
git rebase --onto ORIG_HEAD A^

Which should get you the same result, without using a temporary branch.

Bj=F6rn
