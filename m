From: Yann Dirson <ydirson@altern.org>
Subject: Re: stg 0.14.3 breakage on push after moving hunk
Date: Thu, 25 Sep 2008 20:54:14 +0200
Message-ID: <20080925185414.GB17458@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20080924232654.GY4985@nan92-1-81-57-214-146.fbx.proxad.net> <20080925072322.GA27632@diana.vm.bytemark.co.uk> <20080925075732.GA17458@nan92-1-81-57-214-146.fbx.proxad.net> <20080925083747.GC27632@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 20:53:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KivyE-0003Wy-Qi
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 20:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636AbYIYSwh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2008 14:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbYIYSwh
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 14:52:37 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:50340 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754596AbYIYSwf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 14:52:35 -0400
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 6330EB01A6;
	Thu, 25 Sep 2008 20:52:33 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 34D7BB0165;
	Thu, 25 Sep 2008 20:52:33 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 1BB591F0C2; Thu, 25 Sep 2008 20:54:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080925083747.GC27632@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96790>

On Thu, Sep 25, 2008 at 10:37:47AM +0200, Karl Hasselstr=F6m wrote:
> On 2008-09-25 09:57:32 +0200, Yann Dirson wrote:
>=20
> > Thanks, it does fix the exception - I feel a bit ashamed of not
> > having looked at the code myself ;)
>=20
> :-)
>=20
> > Nevertheless, that error was only hiding another more annoying
> > problem:
> >
> > $ ../stgit/stg push
> > Checking for changes in the working directory ... done
> > Pushing patch "factorize" ...
> >   Error: File "t/t4030-diff-rename-factorize.sh" added in both, per=
missions conflict
> >   Error: The merge failed during "push". =20
> >          Use "refresh" after fixing the conflicts or revert the ope=
ration with "push --undo".
> >   stg push: GIT index merging failed (possible conflicts)
> > $ md5sum t/t4030-diff-rename-factorize.sh*
> > cc313acd2824036556128b3e0879dd07  t/t4030-diff-rename-factorize.sh
> > cc313acd2824036556128b3e0879dd07  t/t4030-diff-rename-factorize.sh.=
current
> > cc313acd2824036556128b3e0879dd07  t/t4030-diff-rename-factorize.sh.=
patched
> >
> > AFAICT, adding the same file in 2 branches used not to produce a
> > conflict at all. Is that intended ?
>=20
> "permissions conflict" sounds like it was added with the exec bit in
> one branch, and without in the other. Is that right? And
>   1. Does it work if there's no permissions conflict?

Doh.  Sure, it does work, and as expected.  Some days really deserve to
be spent sleeping :}

>   2. Did it work before if there was a permissions conflict?
>=20
> Just a guess, but it's entirely plausible that this case never worked=
,
> and you're the first to hit it.

I is also entirely plausible that I lacked sleep enough not to read
correctly what was printed, and that the behaviour was indeed correct :=
>

The problem is mostly a limitation of the way stg-fold-files-from works=
,
relying on patchutils which do not know about git extensions to the dif=
f
format.  And since I mostly used it in the past on a git-cvsimport'ed
tree, permissions never bothered me.

Best regards,
--=20
Yann
