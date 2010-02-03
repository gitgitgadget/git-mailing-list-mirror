From: Ron Garret <ron1@flownet.com>
Subject: Re: git-mv redux: there must be something else going on
Date: Wed, 03 Feb 2010 11:23:49 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-5F71CB.11234903022010@news.gmane.org>
References: <ron1-32BD5F.10255403022010@news.gmane.org> <32541b131002031048i26d166d9w3567a60515235c34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 20:24:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nckpp-0001Sa-Mz
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 20:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577Ab0BCTYN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 14:24:13 -0500
Received: from lo.gmane.org ([80.91.229.12]:53311 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756024Ab0BCTYM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 14:24:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nckpe-0001JK-Vt
	for git@vger.kernel.org; Wed, 03 Feb 2010 20:24:11 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 20:24:10 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 20:24:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138865>

In article=20
<32541b131002031048i26d166d9w3567a60515235c34@mail.gmail.com>,
 Avery Pennarun <apenwarr@gmail.com> wrote:

> On Wed, Feb 3, 2010 at 1:25 PM, Ron Garret <ron1@flownet.com> wrote:
> > So something in my understanding of how git works must be wrong. =C2=
=A0Git
> > must be keeping a separate record of file renames somewhere. =C2=A0=
But where?
>=20
> It doesn't.  Your experiment is wrong.
>=20
> > [ron@mickey:~/devel/gittest]$ cat>file2
> > 6
> > 7
> > 8
> > 9
> > 10
> > [ron@mickey:~/devel/gittest]$ git mv file2 file3
> > [ron@mickey:~/devel/gittest]$ git commit -m 'letters->numbers'
> > [master ae3f6d4] letters->numbers
> > =C2=A01 files changed, 0 insertions(+), 0 deletions(-)
> > =C2=A0rename file2 =3D> file3 (100%)
>=20
> Whoops.  You didn't 'git add file2' (before the mv) or 'git add file3=
'
> (after the mv), or use commit -a, so what you've committed is the
> *old* content of file2 under the name file3.  The *new* content of
> file2 is still uncommitted in your work tree under the name file3.
> This is why git can detect the move.  (The 100% is a good clue: it
> means the old and new files are 100% identical.)

Ah.  That explains everything.  Thanks.  (I thought git mv was=20
equivalent to git rm followed by git add.  But it's not.)

> Artificial tests like this are useless anyway.

Yes, I know.  This was not intended to be a real-world example.  I was=20
just trying to understand the heuristics that git uses to track filenam=
e=20
changes, and in particular, how much a file could change before git=20
decided it was a different file.  When I got to zero shared lines=20
between old and new it was clear that I was missing something=20
fundamental :-)

So... how *does* git decide when two blobs are different blobs and when=
=20
they are the same blob with mods?  I asked this question before and was=
=20
pointed to the diffcore docs, but that didn't really clear things up. =20
That just describes all the different ways git can do diffs, not the=20
actual heuristics that git uses to track content.

rg
