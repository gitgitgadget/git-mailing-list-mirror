From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 14:59:24 +0400
Message-ID: <20111013145924.2113c142@ashu.dyn.rarus.ru>
References: <loom.20111013T094053-111@post.gmane.org>
	<CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: arQon <arqon@gmx.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 12:59:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REJ0w-000559-P0
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 12:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab1JMK7c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Oct 2011 06:59:32 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33561 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277Ab1JMK7a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2011 06:59:30 -0400
Received: by wwf22 with SMTP id 22so1546644wwf.1
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 03:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=YyfORn0bus+AddWRk7NQoUq1d729PqFXAZU4Q6VdS1g=;
        b=Fic+Go24ojxATjEVKnw/08TCleX2z20pp3a3NOmP3xQABdbcYfSijjqJQc0vRTt4Er
         46Ofqjuo4qC10y+SpWMSdaEV9VdSydBh/u3Gl+gh3tJWqwy9Eh4x+uQwD02FOBvZJxNa
         nawW7lDicOloDTGpsAHVAoIj/lpv2Y/2tTKqE=
Received: by 10.227.23.194 with SMTP id s2mr1048426wbb.99.1318503568885;
        Thu, 13 Oct 2011 03:59:28 -0700 (PDT)
Received: from ashu.dyn.rarus.ru (mail.rarus.ru. [213.247.194.83])
        by mx.google.com with ESMTPS id es10sm5298346wbb.4.2011.10.13.03.59.26
        (version=SSLv3 cipher=OTHER);
        Thu, 13 Oct 2011 03:59:27 -0700 (PDT)
In-Reply-To: <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183469>

> On Thu, Oct 13, 2011 at 7:40 PM, arQon <arqon@gmx.com> wrote:
> > $ git co master
> > M =C2=A0 =C2=A0 =C2=A0 code/renderer/tr_font.cpp
> > Switched to branch 'master'
> > Your branch is ahead of 'origin/master' by 3 commits.
>=20
> ...
>=20
> > At this point, reverting the master with "checkout --" also wipes
> > out the changes on the other branch. It's like the merge symlinked
> > the two branches rather than, well, merging them.
>=20
> It does show you that there are changes in the working tree and you
> could have switched back with "git co -", done whatever you want with
> your changes then switched to master again.
>=20
> > A couple of days ago it DID complain
> > when I tried to switch with uncommitted files still present, so it
> > was working properly then. I have no idea what's made it happy to
> > ignore them now: nothing's changed that I know of.
>=20
> git tries to keep all changes on working tree you have. If you have
> changes in file A and the new branch changes in file B, fine. If the
> new branch also changes in file A too, it'll complain because
> otherwise it may overwrite your changes. What it actual does is "Two
> way merge", there is a table in "git read-tree" man page that
> describes exactly how it is done, what cases would fail...
>=20
> I see it as more choices. As I said above, it does tell you there are
> changes and you could do something. You could make alias "co" that
> check for worktree/index cleanliness before calling checkout.
> Something like this maybe (I have not tested it)
>=20
> git config alias.co '!git update-index --refresh && git diff-files
> --quiet && git diff-index --cached --quiet HEAD && git checkout "$@"'
>=20
> A config key to enforce this may be nice. I don't know, I have never
> had problems with current behavior.

I agree with the explanation and I like current behavior, as well.

2arQon:
Your expectations is based on SVN experience but as ex-SVN-user, too, I
can (and I want to) say: Git is more flexible and powerful tool then SV=
N
is. Take is power and change your expectations, and your life will
become better )))
