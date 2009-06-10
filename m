From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: EasyGit Integration
Date: Wed, 10 Jun 2009 14:13:49 +0200
Message-ID: <20090610121349.GA27679@atjola.homenet>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com> <32541b130906091252i6c96c44buc148bb525d7cde14@mail.gmail.com> <20090609203747.GB13781@atjola.homenet> <32541b130906091342s7dd6064fud2205bee8af95aab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 14:14:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEMgz-0005hq-IH
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 14:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757172AbZFJMNv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 08:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755967AbZFJMNu
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 08:13:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:54851 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753662AbZFJMNu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 08:13:50 -0400
Received: (qmail invoked by alias); 10 Jun 2009 12:13:50 -0000
Received: from i59F575EB.versanet.de (EHLO atjola.local) [89.245.117.235]
  by mail.gmx.net (mp053) with SMTP; 10 Jun 2009 14:13:50 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19J79049UdJ68QBbwuhByBVXParlkwJ0ewfLxXIpa
	xRVlw4I8II+SNF
Content-Disposition: inline
In-Reply-To: <32541b130906091342s7dd6064fud2205bee8af95aab@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121273>

On 2009.06.09 16:42:33 -0400, Avery Pennarun wrote:
> 2009/6/9 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> > On 2009.06.09 15:52:46 -0400, Avery Pennarun wrote:
> >> To be honest, I'm not convinced svn's use of the word "revert" is
> >> really right, though. =A0Git's isn't *really* right either, since =
it
> >> actually makes a new commit, it doesn't remove the old one like it
> >> sounds like it does. =A0Maybe 'reverse' would be a better name for=
 what
> >> git does, and we should just introduce another word for what svn d=
oes.
> >> =A0(With CVS, you just deleted the file and then did a checkout/up=
date
> >> on it again, which made sense to me. =A0That works in git too.)
> >>
> >> Crazy idea: we could actually make 'git revert' do both: given a
> >> commit, it applies the reverse as it does now. =A0Given filenames,=
 it
> >> simply brings them back to HEAD. =A0But maybe that's too crazy.
> >
> > Doesn't seem that crazy to me. But maybe a bit problematic if you w=
ant
> > to support both, "git checkout -- ." and "git checkout HEAD -- .". =
And
> > adding DWIMmery there seems dangerous, as in:
> >
> > git revert =3D=3D git checkout -- .
> >
> > git revert HEAD =3D=3D
> > =A0no uncommitted changes =3D revert commit HEAD
> > =A0uncommitted changes =3D revert to HEAD
>=20
> Well, that's what I meant by "crazy" :)

OK, thinking about it, I really dislike the idea of "revert --since",
as that is IMHO better thought of as "get the old version back", and fo=
r
"get something out of the repo" we have checkout. That would leave us
with "revert changes from a commit" and "revert uncommitted/unstaged
changes". For that "limited" thing, I could live with:

git revert <commit> # As is
git revert --unstaged # git checkout --=20
git revert --uncommitted # git checkout HEAD -- / git rm --cached

IOW: Mode of operation is chosen by a flag, which has a meaning that is
somewhat similar to --cached for diff/rm, it chooses what to use as the
source for the operation. And as at least "revert --uncommitted" isn't
100% the same as "checkout HEAD --", I think the overlap that we'd have
with a small subset of the checkout functionality might be ok.

Bj=F6rn
