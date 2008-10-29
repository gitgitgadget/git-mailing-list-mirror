From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Do most people feel tracking branches useful?
Date: Wed, 29 Oct 2008 11:03:13 +0100
Message-ID: <20081029100313.GP3612@atjola.homenet>
References: <49082514.9050405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 11:04:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kv7uh-0005H4-Au
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 11:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbYJ2KDS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2008 06:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753306AbYJ2KDR
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 06:03:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:36815 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753094AbYJ2KDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 06:03:16 -0400
Received: (qmail invoked by alias); 29 Oct 2008 10:03:14 -0000
Received: from i577BB586.versanet.de (EHLO atjola.local) [87.123.181.134]
  by mail.gmx.net (mp062) with SMTP; 29 Oct 2008 11:03:14 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18BN3wWqYMBI0lRtBNwDuyMZmf4rQSSSeW/P0+K+I
	zNqaUMhBNAPF2o
Content-Disposition: inline
In-Reply-To: <49082514.9050405@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99356>

On 2008.10.29 16:55:48 +0800, Liu Yubao wrote:
> Hi,
>=20
> I often feel tracking branches are useless to me, because there are r=
emote
> branches and I work on my private branch in most time.
>=20
>    repos
>      |
>      |-- my               (private branch, do my dirty work)
>      |-- master           (tracking branch)
>      |-- origin/master    (remote branch)

Actually, origin/master is the "[remote] tracking branch". master is
just a branch that has config settings for "git pull" defaults. ;-)

"Remote branches" are the actual branches on a remote repository.

> To avoid conflict when execute `git pull` and make the history linear=
, I work
> on branch "my" instead of "master". Here is my work flow:
>=20
> 1) use `git fetch` or `git remote update` to synchronize branch
> "origin/master" with branch "master" in remote repository;
> 2) create a new private branch to polish my commits and rebase it aga=
inst
> "origin/master";
> 3) at last push this new branch to the remote repository or ask the u=
pstream
> developer to fetch it(no `git pull` because we want history as linear
> as possible).

git pull --rebase

> I don't want to bother with the tracking branch "master", it's identi=
cal
> with "origin/master".  Because `git checkout -b xxx <remote_branch>`
> will create a tracking branch "xxx" by default, so my question is:
> do most people feel tracking branches useful?

Tracking branches (origin/* etc.) are very useful :-) And branches that
have "git pull" defaults (what you called "tracking branch") are also
useful.

In your case, you probably want:
git checkout -b my-stuff origin/master
git config branch.my-stuff.rebase true

and then you can do:
git pull

Instead of:
git fetch origin
git rebase origin/master

You can also setup branch.autosetuprebase, to automatically get the
rebase setup, so you can skip the call to "git config" above.

And you can just delete the "master" branch if you don't use it. There'=
s
nothing that forces you to keep any branches around that you don't use.
But that doesn't affect the usefulness of tracking branches or branches
that have "git pull" defaults :-)

> BTW: I feel the terminalogy "remote branch" is confused, because I mu=
st
> synchronize it with `git fetch`. I feel it's better to call it "track=
ing
> branch" // seems will lead to bigger confusion to experienced git use=
rs:-(

See above, that's already the case ;-)

Bj=F6rn
