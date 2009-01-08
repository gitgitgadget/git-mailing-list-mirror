From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
Subject: Re: Git (svn) merge - but ignore certain commits?
Date: Thu, 08 Jan 2009 20:17:16 +0100
Message-ID: <4966513C.1010707@sneakemail.com>
References: <49562749.9060705@sneakemail.com>	 <eaa105840812271617n74406517x3335a05d224f5e0@mail.gmail.com>	 <49663CA2.90102@sneakemail.com> <eaa105840901081029h220e06e4m1a1af693e908751e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Peter Harris git-at-peter.is-a-geek.org |Lists|" 
	<xtslkck8t30t@sneakemail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 20:45:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL0P9-0007Wk-Ba
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 20:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762329AbZAHTRW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jan 2009 14:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761229AbZAHTRV
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 14:17:21 -0500
Received: from smtp27.orange.fr ([80.12.242.96]:15770 "EHLO smtp27.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760858AbZAHTRU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 14:17:20 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2718.orange.fr (SMTP Server) with ESMTP id 023DE1C000A5;
	Thu,  8 Jan 2009 20:17:18 +0100 (CET)
Received: from [192.168.1.39] (ANice-157-1-29-28.w90-28.abo.wanadoo.fr [90.28.172.28])
	by mwinf2718.orange.fr (SMTP Server) with ESMTP id 98D491C00087;
	Thu,  8 Jan 2009 20:17:17 +0100 (CET)
X-ME-UUID: 20090108191717626.98D491C00087@mwinf2718.orange.fr
User-Agent: Thunderbird 2.0.0.18 (X11/20081125)
In-Reply-To: <eaa105840901081029h220e06e4m1a1af693e908751e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104954>

Peter Harris git-at-peter.is-a-geek.org |Lists| wrote:
> Well, the real problem is that it *isn't* a repeated merge. Subversio=
n
> rebased your trunk on you, so you...
>=20
>> I ended up using git cherry-pick, and diff and patch / git diff and =
git
>> apply.
>=20
> ...wind up needing to do this.
>=20
> Don't rebase trunk (which implies ditching subversion,
> (un)fortunately), and repeated merges should Just Work. See, for
> example, the git repository itself, where the master branch is
> repeatedly merged into next.

Ah, yes. I understand. Thanks for making it more clear to me. There are=
=20
two different problems at play here:

1) git svn doesn't help with the fact that svn can't handle the repeate=
d=20
merge problem (just noise here)

2) The git-only repeated-merge problem still exists, if I want a commit=
=20
on the branch, but *do not* want it merged back to "master". This I=20
still don't see a solution for. E.g.:

---A---B---C---D--+ "master"
     \--E---F---G-/  "branch"

Here I want F and G merged back to "master", but *not* E (which is a=20
quick-and-dirty but safe version of B). That still seems not to be=20
possible. What I did was:

---A---B---C---D--+- "master"
    |             /
    |\--F---G----+    "devbranch"
    |             \
     \--E----------+-   "branch"

(So F and G got merged from "devbranch" to both "master" and "branch",=20
but E stayed on "branch" only)

I could do that because the system worked somewhat without E and I was=20
able to develop/test F and G without E. But I'd still be out of luck if=
=20
I needed to work on "branch". There seems to me to be no way in the=20
first two-branch scenario to do repeated merges from "branch" to=20
"master" if I need to avoid that E gets merged back to "master".

But thanks, Peter, for helping me understand. "git svn" and the fact=20
that E happened to be a revert where just noise and had nothing to do=20
with the core problem (2). That still has no solution, or am I missing=20
something?

Peter
--=20
Peter Valdemar M=F8rch
http://www.morch.com
