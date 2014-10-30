From: Eric Wong <normalperson@yhbt.net>
Subject: Re: differences between old clone and new  Re: git-svn performance
Date: Thu, 30 Oct 2014 00:21:36 +0000
Message-ID: <20141030002136.GA31920@dcvr.yhbt.net>
References: <20141028074104.GA7762@dcvr.yhbt.net>
 <1414540742.41763.YahooMailBasic@web172305.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 01:21:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjdUl-00018i-L3
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 01:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757855AbaJ3AVk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2014 20:21:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53483 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755398AbaJ3AVj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Oct 2014 20:21:39 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E958F1F7C9;
	Thu, 30 Oct 2014 00:21:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1414540742.41763.YahooMailBasic@web172305.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> On Tue, 28/10/14, Eric Wong <normalperson@yhbt.net> wrote:
>=20
> > So both merges
>  are correct, but we lose one, and gain one?
>  I'll try to check more closely tomorrow.=C2=A0
>  Can you point out
>  the exact revisions in the
>  R repo?=C2=A0 Thanks.
>=20
>=20
> The missing merge on branch "R-2-14-branch" is:
>=20
> commit 93af4d4cc3a5e0039944dd4e340d26995be8a252
> Merge: 121990f 6ff1b87
> Author: ripley <ripley@00db46b3-68df-0310-9c12-caf00c1e9a41>
> Date:   Wed Feb 22 13:45:34 2012 +0000
>=20
>     port r58453 from trunk
>=20
>     git-svn-id: https://svn.r-project.org/R/branches/R-2-14-branch@58=
454 00db46b3-68df-0310-9c12-caf00c1e9a41

I'm curious if you can tell me which version of git-svn you used to get
that as a merge commit.  git-svn mergeinfo handling has changed
(hopefully improved) over the years, so some differences in history
can be (unfortunately) expected, I think.

I cannot reproduce your original merge on Junio's current master.  Usin=
g
Junio's master[1] without any recent git-svn changes, a partial clone
doing:

   git svn clone -s -r52000:58600 svn+ssh://127.0.0.1/path/to/my/R-mirr=
or

=2E..causes the merges in r58454 to be ignored as cherry-picks, too.
I suspect it's correct for git-svn to ignore those as cherry-picks
nowadays.

Here's a snippet of what I see from the above command:
----------------------------------8<-----------------------------------
r58452 =3D ebf3a1ca312ca7cc03dc2387d86491a0cdc95bad (refs/remotes/origi=
n/trunk)
	M	src/library/base/man/Primitive.Rd
	M	src/main/names.c
	M	doc/NEWS.Rd
r58453 =3D 05b55eee9e6bed628873d34261e54c70f87a3736 (refs/remotes/origi=
n/trunk)
	M	doc/NEWS.Rd
	M	src/library/base/man/Primitive.Rd
	M	src/main/names.c
W:svn cherry-pick ignored (/branches/R-2-12-branch:52939,54476,55265) -=
 missing 492 commit(s) (eg df9d875de507ac51932c0ed980392e8262f98b31)
W:svn cherry-pick ignored (/branches/R-2-13-branch:55265,55432) - missi=
ng 231 commit(s) (eg cad052d416d9b8a9dfbfb2ae7bf85c39306c67bb)
W:svn cherry-pick ignored (/trunk:57183,57204-57205,57242,57259,57314,5=
7316,57321,57370,57411,57428,57430,57432,57438,57440,57484,57489-57490,=
57579,57589,57604,57614-57618,57625,57679,57681,57687,57738,57741,57744=
-57745,57747,57752,57758,57761,57763,57765,57767,57769,57771,57790,5779=
3,57803,57812,57814,57816,57826-57827,57836,57840-57841,57844,57846,578=
51,57853,57856,57861-57862,57867,57880,57884,57890,57893,57895,57900,57=
904,57908,57913,57920,57936,57939-57941,57950,57952,57959,57964,57970,5=
7975,57977,57981,57987,58006,58008,58037,58039,58042,58047,58052,58056,=
58058,58066-58067,58082,58084,58089,58094,58098,58100,58107,58126,58129=
,58135,58142,58161,58178,58182,58187,58195,58204,58213,58217,58221,5822=
5,58228,58232,58234,58239,58248,58253,58265,58269,58272,58274,58276,582=
78,58282,58284,58288,58294,58296,58305,58312,58314,58318,58324,58326,58=
328,58332,58334,58340,58346,58348,58353,58355,58357,58359,58361,58373,5=
8378,58381,58386,58388,58392,58395,58397,58405,58412,58415,58429,58435,=
58437,58439,58453) - missing 716 commit(s) (eg e9ccca5db27696ed8faa4427=
ec4110ddf230d141)
r58454 =3D 96d6087a494bb7da6d90f02e8bd36833eaad2067 (refs/remotes/origi=
n/R-2-14-branch)
	M	doc/manual/R-exts.texi
	M	doc/NEWS.Rd
	M	src/library/tools/R/check.R
r58455 =3D 742cbc791fa6760d5dfb4c4ea1e032d32e9e87c9 (refs/remotes/origi=
n/trunk)
----------------------------------8<-----------------------------------

[1] - fbecd99 Update draft release notes to 2.2
