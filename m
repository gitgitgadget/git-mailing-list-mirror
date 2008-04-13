From: Jan Hudec <bulb@ucw.cz>
Subject: Re: git repository size vs. subversion repository size
Date: Sun, 13 Apr 2008 11:57:08 +0200
Message-ID: <20080413095708.GA16649@efreet.light.src>
References: <1086fb5f0804041502s7ab12202y3b0ec3640425eff@mail.gmail.com> <20080404221728.GA30728@atjola.homenet> <1086fb5f0804041927m5aba1912sc71a19b8f8221e06@mail.gmail.com> <20080405023437.GA8861@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean Brown <seanmichaelbrown@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 13 11:58:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkyyH-00051c-Gu
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 11:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbYDMJ5R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 05:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754814AbYDMJ5R
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 05:57:17 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:53645 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753750AbYDMJ5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 05:57:16 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id E8E0957435;
	Sun, 13 Apr 2008 11:57:14 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id b-YOAZJ1m4oT; Sun, 13 Apr 2008 11:57:11 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 1F3BF57468;
	Sun, 13 Apr 2008 11:57:11 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1JkyxQ-0006Rw-Rw; Sun, 13 Apr 2008 11:57:08 +0200
Content-Disposition: inline
In-Reply-To: <20080405023437.GA8861@atjola.homenet>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79403>

On Sat, Apr 05, 2008 at 04:34:37 +0200, Bj=C3=B6rn Steinbrink wrote:
> On 2008.04.04 22:27:12 -0400, Sean Brown wrote:
> > On Fri, Apr 4, 2008 at 6:17 PM, Bj=C3=B6rn Steinbrink <B.Steinbrink=
@gmx.de> wrote:
> > > On 2008.04.04 18:02:56 -0400, Sean Brown wrote:
> > >  > Last night I decided to see what storage size differences I mi=
ght see
> > >  > between an svn repo and a git one.  So I imported a highly use=
d
> > >  > subversion repository into git and was shocked to see how huge=
 the git
> > >  > version was.  I used a repo that has a lot of branches and tag=
ged
> > >  > releases just to make sure importing into git would in fact ke=
ep all
> > >  > of the history.  It did keep the history, but the total disk u=
sage was
> > >  > very different:
> > >  >
> > >  > $subversionbox # du -hs ./my_sample_website/
> > >  > 67M   ./my_sample_website
> > >  >
> > >  > $localhost # du -hs ./git-samplesite/
> > >  > 3.6GB ./git-samplesite/
> > >
> > >  How much of that is in the .git/svn directory? The contents of t=
hat
> > >  directory are used to map git commits to svn revision and git ve=
rsions
> > >  before 1.5.4 had a quite space consuming file format for that. T=
he new
> > >  format is a lot better. If you want to switch completely, you ca=
n even
> > >  just delete the .git/svn directory, as that's only required as l=
ong as
> > >  you want to interact with the corresponding svn repository.
> > >
> > >  And finally, you might want to repack to repository once after t=
he
> > >  initial import, to get a smaller repo. Something like:
> > >  git repack -a -d -f --window=3D100 --depth=3D100
> > >
> >=20
> > The svn folder (in the.git directory) was only about 4.2 MB.  After
> > running the repack (and then after that git gc as mentioned by anot=
her
> > in this thread), it's still about 3.5 GB.
> >=20
> > git-samplesite (master)]$ du -hs ./*
> > 2.1G	./branches
> > 1.4G	./tags
> >  66M	./trunk
>=20
> Uhm, you forgot to use -s when doing the clone. That would have creat=
ed

No, not the clone, but the git svn init.

> real git branches instead of the directories... What you are counting=
 is
> the size of the checked out, uncompressed files of _all_ branches and
> _all_ tags (and trunk). The repo size of basically what "du -sh .git"
> would give.
>=20
> Bj=C3=B6rn
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
