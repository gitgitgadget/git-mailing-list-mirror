From: Paul Drews <paul.drews@intel.com>
Subject: Re: rebase not honoring core.worktree pointing elsewhere
Date: Wed, 3 Nov 2010 15:41:06 +0000 (UTC)
Message-ID: <loom.20101103T162424-483@post.gmane.org>
References: <loom.20101101T182113-378@post.gmane.org> <AANLkTi=ejRcnz+83zc2Z-6etUGMsBSw1FFUY0JNFRFGB@mail.gmail.com> <loom.20101102T165800-486@post.gmane.org> <AANLkTi=T5kHfgNOpOtCDCoq7epEgwUrVayaUCbf35dSU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 16:41:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDfSy-0006uJ-GT
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 16:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213Ab0KCPlY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 11:41:24 -0400
Received: from lo.gmane.org ([80.91.229.12]:56132 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755779Ab0KCPlX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 11:41:23 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PDfSh-0006ie-QP
	for git@vger.kernel.org; Wed, 03 Nov 2010 16:41:19 +0100
Received: from jfdmzpr04-ext.jf.intel.com ([134.134.139.73])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 16:41:19 +0100
Received: from paul.drews by jfdmzpr04-ext.jf.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 16:41:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 134.134.137.73 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.3) Gecko/20100403 Fedora/3.6.3-4.fc13 Firefox/3.6.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160602>

Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:

> > (implementation dependent) Having the ".git" dir inside the worktre=
e be a
> > symbolic link to a dir somewhere outside the work tree. =C2=A0Keeps=
 the actual
> > ".git"
> > contents safe from deletion. =C2=A0Works so far, but this is Tamper=
ing With The
> > Implementation in a way that is likely to fail down the road somewh=
ere,
> > e.g., if an internal script does cd to the GIT_DIR, then cd relativ=
e to
> > that to try to get back into somewhere else in the work tree.
>=20
> Another one: create a .git file with this line and put it in worktree=
's
> topdir
>=20
> gitdir: /path/to/real/git.dir
>=20
> See gitrepository-layout.txt.

Ooh!  That would be my favorite, since it's a documented legal usage.
Unfortunately, although the rebase scenario works that way a local
"git clone" doesn't work:

# git clone /abs/path/to/proj
Cloning into proj...
fatal: failed to open '/abs/path/to/proj/objects': No such file or dire=
ctory
# git clone /abs/path/to/proj/
Cloning into proj...
fatal: failed to open '/abs/path/to/proj//objects': No such file or dir=
ectory
# git --version
git version 1.7.3.GIT

weird
