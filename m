From: Mark Hills <Mark.Hills@framestore.com>
Subject: Re: Clone to an SSH destination
Date: Mon, 3 Sep 2012 14:07:48 +0100 (BST)
Message-ID: <alpine.LFD.2.01.1209031351200.5945@sys880.ldn.framestore.com>
References: <alpine.LFD.2.01.1209031059480.4753@sys880.ldn.framestore.com> <CACBZZX7Pe5gsfpFTihE33a1Exia_4dbMQ9p_Xc_z4Ry=Et9KLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279733332-2093964918-1346677009=:5945"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 15:08:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8WNw-0001gV-Sb
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 15:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756402Ab2ICNIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 09:08:04 -0400
Received: from mx5.framestore.com ([193.203.83.15]:35972 "EHLO
	mx5.framestore.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370Ab2ICNID (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 09:08:03 -0400
Received: from vm-zimbra.ldn.framestore.com ([172.16.73.68] helo=zimbra.framestore.com)
	by mx5.framestore.com with esmtp (Exim 4.72)
	(envelope-from <Mark.Hills@framestore.com>)
	id 1T8WNe-0003PN-2J; Mon, 03 Sep 2012 14:07:59 +0100
Received: from sys880.ldn.framestore.com (sys880.ldn.framestore.com [172.16.84.100])
	by zimbra.framestore.com (Postfix) with ESMTPA id 84DFE1EC0ACD;
	Mon,  3 Sep 2012 14:07:28 +0100 (BST)
In-Reply-To: <CACBZZX7Pe5gsfpFTihE33a1Exia_4dbMQ9p_Xc_z4Ry=Et9KLA@mail.gmail.com>
Content-ID: <alpine.LFD.2.01.1209031359180.5945@sys880.ldn.framestore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204690>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--279733332-2093964918-1346677009=:5945
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-ID: <alpine.LFD.2.01.1209031358001.5945@sys880.ldn.framestore.com>
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Sep 2012, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> On Mon, Sep 3, 2012 at 12:21 PM, Mark Hills <Mark.Hills@framestore.com>=
 wrote:
> > How do I clone a repo _to_ a new repo over SSH? I tried:
> >
> >   cd xx
> >   git clone --bare . gitserver:/scm/xx.git
> >   git clone --bare . ssh://gitserver/scm/xx.git
> >
> > This does not have the expected result, and instead a local path of t=
he
> > given name is created (eg. a 'gitserver:' directory)
> >
> > This seems to be a FAQ, but the only answer I can find (Google) is to
> > login to the server and create the repo, setup a remote and push to i=
t.
>=20
> Basically Git doesn't support this yet, mainly because it could only
> be supported with the ssh or local transports.
>=20
> With anything else it would break, so push can only assume that
> something on the other end can receive data, can update branch
> pointers etc. Not create a brand new repository.
>=20
> You could of course supply your devs with an alias that ssh's to that
> server, does an init if needed, and then does a push.

Yes, a last resort, but do-able of course.

> > This is quite cumbersome; we have a large team of devs who use a simp=
le
> > 'git clone' to an NFS directory, but we wish to retire NFS access.
> >
> > Is there a technical limiation preventing clone-to-ssh, or just somet=
hing
> > waiting to be implemented?
>=20
> But I'm actually more curious about why you need this in the first
> place, there's a bunch of devs where I work as well, but they never
> have the need to create new repos on some NFS drive in this manner.

Without a command-line onto the filesystem (either local or NFS), how do=20
you create a new repository for a new project?

We have a fairly large team on a diverse set of projects. Projects come=20
and go, so it's a burden if the administrator is needed just to create=20
repos.

Likewise, it's a step backwards for the developer to need to login=20
themselves over SSH -- whereas 'git clone' is so easy to NFS.

> What are your devs doing when they do clone their current working=20
> directory to some NFS location, maybe there's a better way to do it.

Most projects start as a small test at some point; eg.

  mkdir xx
  cd xx
  git init
  <write some code>
  git commit
  ...

When a project becomes more official, the developer clones to a central=20
location; eg.

  git clone --bare . /net/git/xx.git

This is the step that is inconvenient if only SSH access is available.

Thanks for your reply,

--=20
Mark
--279733332-2093964918-1346677009=:5945--
