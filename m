From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule 
	working directory in git gui and gitk
Date: Mon, 4 Jan 2010 17:53:32 -0500
Message-ID: <32541b131001041453l25409c41y3aadf749b1308f01@mail.gmail.com>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> 
	<4B421F90.4090402@web.de> <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 04 23:53:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRvoD-00049Y-Nz
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 23:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649Ab0ADWxy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jan 2010 17:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753606Ab0ADWxx
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 17:53:53 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:41500 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab0ADWxx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jan 2010 17:53:53 -0500
Received: by gxk3 with SMTP id 3so3197926gxk.1
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 14:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wrtVuBAjzNdpbcoYFlt2T45x+YZrUYEuQS0kfZZxuTw=;
        b=Iwwx7zLqArXzCPn+6y1d12xCnIVGktjRu/WF2TydRrgs2uhTb6Wq4eUhz7Zamhu+Eq
         dNoC6VPL1bwh/uOGYgiP7/K3pgPCS0Q9XKdnBIb0FIks9qQbWALZ/760kp35fiqK3qgu
         4JvMO84aKCGasKHJEosvRdfFh56MbKmtyudcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Ti7HvvY4/kSD92MqgdgfKBNW+izpcy8b6FJN4Rz3isHDvx7ewecdVIVOC8dDcL/Sln
         fqtw0AbWk7vx/ZlV9vyso/gHsEMEhThwnyW3AHqS5Ljmy2eNB8JzDzf2ihTWdaJ6HHrY
         nLlj0k6C68mF0prSZ4dUxXjM+3Ns5F68l47mc=
Received: by 10.150.29.33 with SMTP id c33mr35922120ybc.292.1262645632123; 
	Mon, 04 Jan 2010 14:53:52 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136148>

On Mon, Jan 4, 2010 at 5:29 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Mon, 4 Jan 2010, Jens Lehmann wrote:
>> IMVHO using the tree sha1 for a submodule seems to be the 'natural' =
way
>> to include another git repo. And it gives the reproducibility i expe=
ct
>> from a scm. Or am i missing something?
>
> You do remember the discussion at the Alles wird Git about the need f=
or
> Subversion external-like behavior, right?

I'm not sure why this is such an issue.  Basically, non-version-locked
submodules are about the easiest thing in the world; that's why CVS
and SVN supported them first.  (SVN later added version-locking like
git has.)

All you need is a .gitignore entry and a trivial script that checks
out the external.  If you want to be fancy, this operation could be
part of git, but it's such a totally different case (and an easy one,
no less) that I think it ought to be treated totally seperately.

> - among other use cases, submodules are recommended for sharing conte=
nt
> =A0between two different repositories. But it is part of the design t=
hat it
> =A0is _very_ easy to forget to commit, or push the changes in the sub=
module
> =A0that are required for the integrity of the superproject.
[...]
> - working directories with GIT_DIRs are a very different beast from s=
ingle
> =A0files. =A0That alone leads to a _lot_ of problems. =A0The original=
 design of
> =A0Git had only a couple of states for named content (AKA files): cle=
an,
> =A0added, removed, modified. =A0The states that are possible with sub=
modules
> =A0are for the most part not handled _at all_ by most Git commands (a=
nd it
> =A0is sometimes very hard to decide what would be the best way to han=
dle
> =A0those states, either). =A0Just think of a submodule at a different
> =A0revision than committed in the superproject, with uncommitted chan=
ges,
> =A0ignored and unignored files, a few custom hooks, a bit of addition=
al
> =A0metadata in the .git/config, and just for fun, a few temporary fil=
es in
> =A0.git/ which are used by the hooks.


I think this is primarily because checked-out submodules currently
have their own .git directories (with their own config, index, etc).
If they were considered *part* of the subproject's repo checkout, and
updated upon switching branches, etc, this whole class of problems
would go away.

> - that use case -- sharing content between different repositories -- =
is
> =A0not really supported by submodules, but rather an afterthought. =A0=
This is
> =A0all too obvious when you look at the restriction that the shared c=
ontent
> =A0must be in a single subdirectory.

I haven't found the subdir requirement to be much of an issue, at
least on Unix where I can simply work around it using symlinks from
the superproject into the subproject.  It's obviously more gross on
Windows, but I've worked around it there too.  This one isn't a daily
aggravation for me, though maybe it is for others.  And any cure I can
think of sounds rather worse than the disease.

> - submodules would be a perfect way to provide a fast-forward-only me=
dia
> =A0subdirectory that is written to by different people (artists) than=
 to
> =A0the superproject (developers). =A0But there is no mechanism to enf=
orce
> =A0shallow fetches, which means that this use case cannot be handled
> =A0efficiently using Git.

I doubt you want to "enforce" shallow fetches.  And if you just want
to "allow" shallow fetches, or default to shallow fetches, I'd think
it would be pretty easy to add.  This hasn't been important to me
either.  (It seems to be not too important to git users in general, or
git's support *in general* for shallow repositories would be more
featureful.)

> - while it might be called clever that the submodules' metadata are s=
tored
> =A0in .gitmodules in the superproject (and are therefore naturally tr=
acked
> =A0with Git), the synchronization with .git/config is performed exact=
ly
> =A0once -- when you initialize the submodule. =A0You are likely to mi=
ss out
> =A0on _every_ change you pulled into the superproject.

This could be fixed too, though I gave up on git-submodule before I
bothered to fix it myself.

The correct solution here is simply to not ever copy the settings from
=2Egitmodules into .git/config.  Instead, git-submodule should read
=2Egitmodules as defaults, and then override those defaults with
anything in .git/config.  99% of users will probably not need to ever
put any of their settings in .git/config, and so this problem
disappears.

> All in all, submodules are very clumsy to work with, and you are lite=
rally
> forced to provide scripts in the superproject to actually work with t=
he
> submodules.

Agreed; I do this in every project which uses git-submodule.  (And
from doing so, I learned that the value-added of git-submodule is
nearly zero.  My script does most of the work, and it could just as
easily check out the submodule as a git repo too.  I could even choose
to version-lock or not version-lock the checked-out submodule: just
hardcode the commitid into my script!)

> I do not think that --include-submodules is a good default. =A0It is =
just
> too expensive in terms of I/O even to check the status in a superproj=
ect
> with a lot of submodules.

I've thought about this a lot, and I think having a special case for
submodules here is the wrong line of thinking.  A big project
*without* submodules has this same problem.  The "real" solution is to
just make status checks faster.

(This is actually possible to do: in the extreme case, you just have a
daemon running with inotify or the Windows equivalent.  TortoiseSvn
reputedly does something like this.  I've thought of writing such a
daemon myself to just twiddle --assume-{un,}changed flags at the right
times, particularly since status checks in Windows are so ridiculously
slow.  But I got frustrated when it was *still* slow even after
setting --assume-unchanged on all the files in the index.  git still
scans directories to detect *unknown* files, and there seems to be no
way to turn it off or, moreover, to provide the list of unknown files
from some other source.)

Have fun,

Avery
