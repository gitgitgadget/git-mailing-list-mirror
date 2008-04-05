From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git repository size vs. subversion repository size
Date: Sat, 5 Apr 2008 04:34:37 +0200
Message-ID: <20080405023437.GA8861@atjola.homenet>
References: <1086fb5f0804041502s7ab12202y3b0ec3640425eff@mail.gmail.com> <20080404221728.GA30728@atjola.homenet> <1086fb5f0804041927m5aba1912sc71a19b8f8221e06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sean Brown <seanmichaelbrown@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 05 04:35:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhyFg-0007T6-0t
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 04:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbYDECej convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Apr 2008 22:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbYDECej
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 22:34:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:34984 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751087AbYDECej (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 22:34:39 -0400
Received: (qmail invoked by alias); 05 Apr 2008 02:34:36 -0000
Received: from i577BB809.versanet.de (EHLO atjola.local) [87.123.184.9]
  by mail.gmx.net (mp013) with SMTP; 05 Apr 2008 04:34:36 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX184+wdmS0s4x4+H4+eXxMKMLDWZ4xAn7zexqxlDdf
	JqK4uzyxncLDXV
Content-Disposition: inline
In-Reply-To: <1086fb5f0804041927m5aba1912sc71a19b8f8221e06@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78832>

On 2008.04.04 22:27:12 -0400, Sean Brown wrote:
> On Fri, Apr 4, 2008 at 6:17 PM, Bj=F6rn Steinbrink <B.Steinbrink@gmx.=
de> wrote:
> > On 2008.04.04 18:02:56 -0400, Sean Brown wrote:
> >  > Last night I decided to see what storage size differences I migh=
t see
> >  > between an svn repo and a git one.  So I imported a highly used
> >  > subversion repository into git and was shocked to see how huge t=
he git
> >  > version was.  I used a repo that has a lot of branches and tagge=
d
> >  > releases just to make sure importing into git would in fact keep=
 all
> >  > of the history.  It did keep the history, but the total disk usa=
ge was
> >  > very different:
> >  >
> >  > $subversionbox # du -hs ./my_sample_website/
> >  > 67M   ./my_sample_website
> >  >
> >  > $localhost # du -hs ./git-samplesite/
> >  > 3.6GB ./git-samplesite/
> >
> >  How much of that is in the .git/svn directory? The contents of tha=
t
> >  directory are used to map git commits to svn revision and git vers=
ions
> >  before 1.5.4 had a quite space consuming file format for that. The=
 new
> >  format is a lot better. If you want to switch completely, you can =
even
> >  just delete the .git/svn directory, as that's only required as lon=
g as
> >  you want to interact with the corresponding svn repository.
> >
> >  And finally, you might want to repack to repository once after the
> >  initial import, to get a smaller repo. Something like:
> >  git repack -a -d -f --window=3D100 --depth=3D100
> >
>=20
> The svn folder (in the.git directory) was only about 4.2 MB.  After
> running the repack (and then after that git gc as mentioned by anothe=
r
> in this thread), it's still about 3.5 GB.
>=20
> git-samplesite (master)]$ du -hs ./*
> 2.1G	./branches
> 1.4G	./tags
>  66M	./trunk

Uhm, you forgot to use -s when doing the clone. That would have created
real git branches instead of the directories... What you are counting i=
s
the size of the checked out, uncompressed files of _all_ branches and
_all_ tags (and trunk). The repo size of basically what "du -sh .git"
would give.

Bj=F6rn
