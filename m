From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule 
	working directory in git gui and gitk
Date: Tue, 5 Jan 2010 21:38:01 +0100
Message-ID: <3af572ac1001051238t63e07a25hf9dd77056b79be89@mail.gmail.com>
References: <4B3F6742.6060402@web.de>
	 <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de>
	 <4B421F90.4090402@web.de>
	 <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
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
X-From: git-owner@vger.kernel.org Tue Jan 05 21:38:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSGAX-0003xQ-HI
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 21:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533Ab0AEUiL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2010 15:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755406Ab0AEUiI
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 15:38:08 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:43319 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383Ab0AEUiF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jan 2010 15:38:05 -0500
Received: by pxi4 with SMTP id 4so12393098pxi.33
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 12:38:02 -0800 (PST)
Received: by 10.141.88.10 with SMTP id q10mr755330rvl.129.1262723881975; Tue, 
	05 Jan 2010 12:38:01 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136208>

Hello,

Let me pop here to support Johannes: I agree with every single point
he enumerated. Every. Single. Point.

=46or instance, I'd like to have a 'cmake' repository where I store all
the FindBlah.cmake modules, so that I can share them from every
repository, and not worry about users changing and committing in the
main project instead of the submodule. I can't. Subversion externals
still rule in that regard.

On Mon, Jan 4, 2010 at 11:29 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 4 Jan 2010, Jens Lehmann wrote:
>
>> Am 04.01.2010 10:44, schrieb Johannes Schindelin:
>> > The real problem is that submodules in the current form are not ve=
ry
>> > well designed.
>>
>> IMVHO using the tree sha1 for a submodule seems to be the 'natural' =
way
>> to include another git repo. And it gives the reproducibility i expe=
ct
>> from a scm. Or am i missing something?
>
> You do remember the discussion at the Alles wird Git about the need f=
or
> Subversion external-like behavior, right?
>
>> It looks to me as most shortcomings come from the fact that most git
>> commands tend to ignore submodules (and if they don't, like git gui =
and
>> gitk do now, they e.g. only show certain aspects of their state).
>
> It is not only ignoring. =A0It is not being able to cope with the sta=
te only
> submodules can be in (see below).
>
>> Submodules are in heavy use in our company since last year. Virtuall=
y
>> every patch i submitted for submodules came from that experience and
>> scratched an itch i or one of my colleagues had (and the situation d=
id
>> already improve noticeably by the few things we changed). We are sti=
ll
>> convinced that using submodules was the right decision. But some wor=
k
>> has still to be done to be able to use them easily and to get rid of
>> some pitfalls.
>
> Submodules may be the best way you have in Git for your workflow ATM.
> But that does not mean that the submodule design is in any way
> thought-through.
>
> Just a few shortcomings that do show up in my main project (and to a
> small extent in msysGit, as you are probably aware):
>
> - submodules were designed with a strong emphasis on not being forced=
 to
> =A0check them out. =A0But Git makes it very unconvenient to actually =
check
> =A0submodules out, let alone check them out at clone-time. =A0And it =
is
> =A0outright impossible to _enforce_ a submodule to be checked out.
>
> - among other use cases, submodules are recommended for sharing conte=
nt
> =A0between two different repositories. But it is part of the design t=
hat it
> =A0is _very_ easy to forget to commit, or push the changes in the sub=
module
> =A0that are required for the integrity of the superproject.
>
> - that use case -- sharing content between different repositories -- =
is
> =A0not really supported by submodules, but rather an afterthought. =A0=
This is
> =A0all too obvious when you look at the restriction that the shared c=
ontent
> =A0must be in a single subdirectory.
>
> - submodules would be a perfect way to provide a fast-forward-only me=
dia
> =A0subdirectory that is written to by different people (artists) than=
 to
> =A0the superproject (developers). =A0But there is no mechanism to enf=
orce
> =A0shallow fetches, which means that this use case cannot be handled
> =A0efficiently using Git.
>
> - related are the use cases where it is desired not to have a fixed
> =A0submodule tip committed to the superproject, but always to update =
to the
> =A0current, say, master (like Subversion's externals). =A0This use ca=
se has
> =A0been wished away by the people who implemented submodules in Git. =
=A0But
> =A0reality has this nasty habit of ignoring your wishes, does it not?
>
> - there have been patches supporting rebasing submodules, i.e.
> =A0submodules where a "git submodule update" rebases the current bran=
ch to
> =A0the revision committed to the superproject rather than detaching t=
he
> =A0HEAD, which everybody who ever contributed to a project with submo=
dules
> =A0should agree is a useful thing. But the patches only have been dis=
cussed
> =A0to death, to the point where the discussion's information content =
was
> =A0converging to zero, yet the patches did not make it into Git. =A0(=
=46WIW
> =A0this is one reason why I refuse to write patches to git-submodule.=
sh: I
> =A0refuse to let my time to be wasted like that.)
>
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
>
> - while it might be called clever that the submodules' metadata are s=
tored
> =A0in .gitmodules in the superproject (and are therefore naturally tr=
acked
> =A0with Git), the synchronization with .git/config is performed exact=
ly
> =A0once -- when you initialize the submodule. =A0You are likely to mi=
ss out
> =A0on _every_ change you pulled into the superproject.
>
> All in all, submodules are very clumsy to work with, and you are lite=
rally
> forced to provide scripts in the superproject to actually work with t=
he
> submodules.
>
>> > In ths short run, we can paper over the shortcomings of the submod=
ules
>> > by introducing a command line option "--include-submodules" to
>> > update-refresh, diff-files and diff-index, though.
>>
>> Maybe this is the way to go for now (and hopefully we can turn this
>> option on by default later because we did the right thing ;-).
>
> I do not think that --include-submodules is a good default. =A0It is =
just
> too expensive in terms of I/O even to check the status in a superproj=
ect
> with a lot of submodules.
>
> Besides, as long as there is enough reason to have out-of-Git alterna=
tive
> solutions such as repo, submodules deserve to be 2nd-class citizens.
>
> Ciao,
> Dscho
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
