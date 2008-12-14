From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How to maintain private/secret/confidential branch.
Date: Sun, 14 Dec 2008 16:13:13 +0000 (UTC)
Organization: disorganised!
Message-ID: <gi3bap$asc$1@ger.gmane.org>
References: <c55009e70812140549t6547c1d6jf7780f91b5074e73@mail.gmail.com>
 <20081214145518.GA26380@mail.local.tull.net>
 <c55009e70812140738l8b51adax77cc6e507971554e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 14 17:14:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBtcE-0004vX-Vi
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 17:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340AbYLNQN3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Dec 2008 11:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753290AbYLNQN3
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 11:13:29 -0500
Received: from main.gmane.org ([80.91.229.2]:53811 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753254AbYLNQN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 11:13:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LBtat-0004xY-OJ
	for git@vger.kernel.org; Sun, 14 Dec 2008 16:13:23 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 16:13:23 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 16:13:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103090>

On 2008-12-14, =C5=81ukasz Lew <lukasz.lew@gmail.com> wrote:
> On Sun, Dec 14, 2008 at 15:55, Nick Andrew <nick@nick-andrew.net> wro=
te:
>> If I understand your problem, you could solve it with git cherry-pic=
k
>> and rebase. On priv, make a for-public branch from a pub branch. The=
n
>> cherry-pick the commits you want from your private branch into the
>> for-public branch.
>
> That almost works. Can I somehow split existing commits
> just like in git-add -p?

This is going to sound weird to some seasoned folks, and I'm
hoping to hear better ways of doing this.  But having done
stuff like this, I once wrote it up and here're my notes:

To split just the top commit into multiple commits:
    * start git gui
    * choose "amend last commit" from the commit menu
    * unstage all files (meaning you click on the little
      icons so they move from the left-bottom panel to the
      left-top panel)
    * pick files or hunks in files to stage and commit the
      usual way
    * continue all changes are committed

To split a commit that is *not* the top one:
    * start an interactive rebase that includes that commit
    * mark that commit as "edit" and start the rebase
    * when the rebase pauses, use git gui as described above

To combine a set of commits and split the result in some
other way (meaning you have commits A B P Q C D R E S and you
want to make them A B C D X Y Z where X+Y+Z =3D P+Q+R+S!)
    * start an interactive rebase
    * move lines as appropriate (in the editor) so the
      commits P,Q,R,S are together
    * choose "squash" on the second and subsequent ones and
      start the rebase
    * (dirty trick warning) when the editor for the combined
      commit message pops up, delete ALL the lines and save
    * use git gui as above
    * then continue the rebase

Hope this helps...
