From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Removing a commit from a local branch
Date: Sun, 11 Jan 2009 23:52:20 +0100
Message-ID: <20090111225220.GB15533@atjola.homenet>
References: <a038bef50901111441w21959397tc41922656a25027c@mail.gmail.com> <a038bef50901111442y16695664y4fed7cdd9d8af27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 23:53:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM9Bm-0005x8-Fc
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 23:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbZAKWwZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jan 2009 17:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbZAKWwZ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 17:52:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:33647 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750893AbZAKWwY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 17:52:24 -0500
Received: (qmail invoked by alias); 11 Jan 2009 22:52:21 -0000
Received: from i577BBA7A.versanet.de (EHLO atjola.local) [87.123.186.122]
  by mail.gmx.net (mp046) with SMTP; 11 Jan 2009 23:52:21 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+X3ehICEaX6TSTUj5kuPKq7umJpV75cHxvMQ47PE
	l4yUTEtmArN8iq
Content-Disposition: inline
In-Reply-To: <a038bef50901111442y16695664y4fed7cdd9d8af27@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105247>

On 2009.01.12 11:42:24 +1300, Chris Packham wrote:
> Hi List,
>=20
> I'm part of a development team using git. We use a maintainer model
> where developers send patches/pull requests to a maintainer who
> applies the patches to a local branch, decides if they're good or not
> and pushes the good patches to the public repository.
>=20
> What I want to do is script the removal of a bad patch so that the
> maintainer identifies a patch in his local branch, sends an email to
> the author telling them why their patch is being rejected then remove=
s
> the commit for that patch. Using git log a script can extract the
> author email address, hash and headline of each commit. Based on that
> information scripting the email is easy enough. Now I come to using
> git rebase to remove the bad commit based on its hash which leads me
> to my question - How do I refer to a commit based on the hash of its
> parent?
>=20
> Consider the following example. The maintainer has the following bran=
ch locally
>=20
>   todeliver: A-B-C-D
>=20
> He is happy with commits A, C and D but wants to reject B. Ideally I
> want to be able to say
>   git rebase --onto <parent of B> <child of B> todelvier

You don't want <child of B> there, just B.

git rebase --onto <onto> <upstream> <branch>

Rebases the commits from the range <upstream>..<branch>, and that
_excludes_ the commit (referenced by) <upstream>.

So:
git rebase --onto B^ B todeliver

Works on: B..todeliver =3D=3D todeliver --not B
And that range contains commits C and D.

Bj=F6rn
