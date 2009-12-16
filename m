From: Elijah Newren <newren@gmail.com>
Subject: Re: How do I show only log messages for commits on a specific branch?
Date: Wed, 16 Dec 2009 16:59:54 -0700
Message-ID: <51419b2c0912161559x4de94464pe06df2845dbe3b78@mail.gmail.com>
References: <20091216101647.GB27373@bc-bd.org>
	 <51419b2c0912161005n1596d4a1n92ed555c98aee4c6@mail.gmail.com>
	 <20091216232641.GK25474@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bd@bc-bd.org, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Dec 17 01:00:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL3mz-0008E6-Py
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 01:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763400AbZLPX77 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Dec 2009 18:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763403AbZLPX76
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 18:59:58 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:59810 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763400AbZLPX74 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2009 18:59:56 -0500
Received: by pzk1 with SMTP id 1so1078566pzk.33
        for <git@vger.kernel.org>; Wed, 16 Dec 2009 15:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xuivTsg8oFaKdZCPc9o2yD3tQy+1pk+E3EXL58JC2f0=;
        b=XcBy2nY167o2rCyfxiXFvt8jhU37sc2d7OJ2zNMuDoJgWlk0/0lb6LSaWKT48pyPXa
         5nKFpecZBFzSN/4rZ5c1oKTJmmgj6hBv+CqOAbWsp527k6K6btqP/Y6OF61873441khx
         7vGyb9HnPC2SampIA/VC/k+5axSe/Ta/ASwCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x6GYeWKakv/R5rG7QaD+zDsVszfJAOX294dp3aeXVBAx7YCZxp+ymhLdiBpBUl4wKj
         QYDQFmyiFpFYRpu1NcU56WTTmKLOdrHbXDYeFp/HvKR/xZp8ReGl/aR1rKb2QwK2/An+
         KmAiKtUgp8+UOzmh48gkDHNURNuSeE4PUyR1Q=
Received: by 10.114.18.33 with SMTP id 33mr1177698war.51.1261007995121; Wed, 
	16 Dec 2009 15:59:55 -0800 (PST)
In-Reply-To: <20091216232641.GK25474@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135346>

On Wed, Dec 16, 2009 at 4:26 PM, Miklos Vajna <vmiklos@frugalware.org> =
wrote:
> On Wed, Dec 16, 2009 at 11:05:52AM -0700, Elijah Newren <newren@gmail=
=2Ecom> wrote:
>> =C2=A0 git log new@{30.years.ago}..new
>> (You'll get a warning that 'new' hasn't existed for 30 years but it
>> doesn't hurt anything)
>
> That's the same as "git log new", if I'm not mistaken.

Did you try it with a 'new' branch in your repository that started at
the beginning of history rather than at some commit?  "git log new"
and "git log new@{30.years.ago}..new" are not the same for me with
git-1.6.5.5:

$ git init repo
$ cd repo
$ echo content> foo && git add foo && git commit -mone foo
$ echo more content >> foo && git commit -mtwo foo
$ git checkout -b new master~1
$ echo stuff >> foo && git commit -mthree foo
$ git log new@{30.years.ago}..new
warning: Log for 'new' only goes back to Wed, 16 Dec 2009 16:48:02 -070=
0.
commit 7df8bad7cc146875c59ab030da0d25555976e79c
Author: Elijah Newren <newren@gmail.com>
Date:   Wed Dec 16 16:48:07 2009 -0700

    three
$ git log new

commit 7df8bad7cc146875c59ab030da0d25555976e79c
Author: Elijah Newren <newren@gmail.com>
Date:   Wed Dec 16 16:48:07 2009 -0700

    three

commit b86eadcdb152877ade44bebf4b8742884949f29f
Author: Elijah Newren <newren@gmail.com>
Date:   Wed Dec 16 16:47:31 2009 -0700

    one

> What Stefan wants to do is to let git log show the commits which are
> only in the "new" branch, but I don't think there is an out-of-the-bo=
x
> solution for that.

Are you sure?  I'm more inclined to believe he'd like to see all the
commits that have been added to the "new" branch since he created it
(which may be the same as what you say, but not necessarily).  Of
course, neither my assumption or yours match what he actually asked
for (though I think what he asked for isn't possible and is merely an
means to the end he really wants).

Also, I think this does what you asked for (the commits in the "new"
branch but no other branch):
$ git log new $(git for-each-ref --format=3D'%(refname)' 'refs/heads/*'
| grep -v '^refs/heads/new$' | sed -e s/^/^/)
