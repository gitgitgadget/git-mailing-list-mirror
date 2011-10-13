From: arQon <arqon@gmx.com>
Subject: Re: [CLOSED] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 17:09:11 +0000 (UTC)
Message-ID: <loom.20111013T181801-923@post.gmane.org>
References: <loom.20111013T094053-111@post.gmane.org>  <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>  <20111013145924.2113c142@ashu.dyn.rarus.ru>  <loom.20111013T130924-792@post.gmane.org> <4E96D819.20905@op5.se>  <loom.20111013T144822-277@post.gmane.org> <1318514356.4646.16.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 19:09:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REOmj-0006iw-I8
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 19:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118Ab1JMRJ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Oct 2011 13:09:29 -0400
Received: from lo.gmane.org ([80.91.229.12]:42589 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601Ab1JMRJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 13:09:28 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1REOmc-0006e0-ND
	for git@vger.kernel.org; Thu, 13 Oct 2011 19:09:26 +0200
Received: from 24-180-45-63.dhcp.crcy.nv.charter.com ([24.180.45.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 19:09:25 +0200
Received: from arqon by 24-180-45-63.dhcp.crcy.nv.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 19:09:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.180.45.63 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Ubuntu/10.04 (lucid) Firefox/3.6.23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183498>

Carlos Mart=C3=ADn Nieto <cmn <at> elego.de> writes:
> When you changed branches, git told you that a file had been changed =
in
> the working tree.

That's a very good point, if it was actually documented at all that tha=
t's
what it meant; and / or presented some warning that "BTW, if you edit t=
his
file again now, it'll screw up your whole tree" instead of an innocuous=
 "M";
and didn't appear to contradict what the manpage says about "local
modifications", we could probably have avoided half of this confusion. =
 :P
As it was, when I saw that M suddenly appear after several days of boun=
cing
between branches without it and with everything working, I just thought
"oh great, git's managed to break this tree", because I remembered the =
same
thing from the previous trial run.

That there IS an indication though might just be enough for me to be ab=
le to
deal with it. Realistically, switching branches with uncommitted change=
s
(unless you're doing it because you've ALREADY screwed up and are chang=
ing
the wrong branch) is basically a trainwreck waiting to happen.

git stash appears to be useless for any nontrivial change on the *other=
*
branch, since there's no indication when you return to the stashed bran=
ch
there's a stash sitting around, which is not something you're going to
remember the next morning if fixing the master took the rest of the day=
,
and you're not going to use "stash list" by then either.

But as long as you get the "warning", an alias that does a "commit -am =
'temp
commit to avoid git breaking the tree'" is something I think I can prob=
ably
live with.

Thanks for all the help guys - very much appreciated.
As far as I'm concerned, this topic's done.

(Though if someone can come up with a script / hook / whatever that imp=
roves
the "visibility" of stash, that would be awesome. Or one that makes the
refusal to switch branches consistent).

Looking at the manpage for checkout in the hope that there might be a "=
--safe"
switch, I don't understand why
  "-f  Proceed even if the index *or the working tree* differs from HEA=
D."
even exists, since it proceeds under those conditions anyway.
"--safe" appears to be exactly what the behavior should be if you DON'T
specify -f, except that -f nukes the working tree outright rather than =
just
bleeding it across. Hopefully it'll be clearer after some sleep.  :)
