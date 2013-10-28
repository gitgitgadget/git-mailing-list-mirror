From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [ANNOUNCE] git-fc, a friendly fork of Git
Date: Mon, 28 Oct 2013 03:20:57 -0600
Message-ID: <CAMP44s2_bcXT36rwhge4texy7eEUn1h7-efGriK9Be9E_V39Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 28 10:21:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vaj0W-00074v-Ac
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 10:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755914Ab3J1JVC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Oct 2013 05:21:02 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:63863 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873Ab3J1JU7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Oct 2013 05:20:59 -0400
Received: by mail-la0-f53.google.com with SMTP id eo20so4898062lab.40
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 02:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=0K1XfnzvmaGgKkXlcjUQYvuJ3JvSuxO+1P6GuYVXURM=;
        b=zf3SZU0uwTUKoZO6ZBHo/JKJ0821MOBmqyGdDT0dK817nKL+9Bccs3eKR3tKBFDEDK
         01r53tXFptpqvdIrct/LhFyT29f0Pyj0i3J5cE2nV0xD4zR0/peJwG54alymRoawMKN4
         DO8srTXgMDmRFMFtbVVCU3JoM0/BacWAekAZsyqaxtlv5Pxgm6JI85SdOKE+xTw17c0G
         NyRezsMSDpf8VZAw/0c5tsxJHKSBHJkfMjGbVIZPTGWD2Elt3COJRTCATACLotdrzbrO
         gRAxyaaWyg6hRTL/GMacFvC9lfyy8aqh/F/Vg4PTaR+Oa2/CxplMjWp53eRaj110Knjw
         sH8A==
X-Received: by 10.152.202.167 with SMTP id kj7mr422300lac.43.1382952057136;
 Mon, 28 Oct 2013 02:20:57 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Mon, 28 Oct 2013 02:20:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236826>

Hi,

Why a fork? Well, the short answer is; my patches are not being applied=
=2E

What is git-fc? It is a friendly fork, and by that I mean that it's a
fork that won't deviate from the mainline, it is more like a branch.
This branch will move forward close to Git's mainline, and it could be
merged at any point in time, if the maintainer wished to do so.

git-fc doesn't include experimental code, or half-assed features, so
you can expect the same level of stability as Git's mainline. Also, it
doesn't remove any feature, or do any backwards incompatible changes,
so you can replace git with git-fc and you wouldn't notice the
difference. The delta comes in the extra features, that is all.

What do you get if you use git-fc?

=3D=3D=3D @ shortcut =3D=3D=3D

Many people have suggested a shortcut for the
non-particularly-intuitive "HEAD", but none of these suggestions
seemed very appealing, or feasible.

Because Git already has an ref@op revision syntax, where if you remove
the ref, HEAD is implied, I thought @ could be thought as HEAD.

This change was welcome and accepted by the Git mainline, and it even
was on track for v1.8.4 but it was dropped last minute because of some
issues that are fixed now, and you probably will see it in v1.8.5. But
why wait? :)

=3D=3D=3D Nice 'branch -v' =3D=3D=3D

If you have configured the upstream tracking branch for your branches
(I wrote a blog post about them), when you do 'git branch -v' you see
something like this:

  fc/branch/fast      177dcad [ahead 2] branch: reorganize verbose opti=
ons
  fc/stage            abb6ad5 [ahead 14] completion: update 'git reset'=
 ...
  fc/transport/improv eb4d3c7 [ahead 10] transport-helper: don't update=
 ...

While that provides useful information, it doesn't show the upstream
tracking branch, just says "ahead 2" but "ahead 2" compared to what?

If you do 'git branch -vv', then you see the answer:

  fc/branch/fast      177dcad [master: ahead 2] branch: reorganize ...
  fc/stage            abb6ad5 [master: ahead 14] completion: update ...
  fc/transport/improv eb4d3c7 [master: ahead 10] transport-helper: don'=
t ...

Unfortunately both options take a lot of time (relative to most Git
commands which are instantaneous), because computing the "ahead 2"
takes a lot of time. So I decided to switch things around, so 'git
branch -v' gives you:

  fc/branch/fast      177dcad [master] branch: reorganize verbose optio=
ns
  fc/stage            abb6ad5 [master] completion: update 'git reset' n=
ew ...
  fc/transport/improv eb4d3c7 [master] transport-helper: don't update r=
efs ...

And it does so instantaneously.

=3D=3D=3D Default aliases =3D=3D=3D

Many (if not all) version control system tools have shortcuts for
their most common operations; hg ci, svn co, cvs st. But not Git. You
can configure your own aliases manually, but you might have some
trouble if you use somebody else's machine.

Adding default aliases is trivial, it helps everyone, and it doesn't
hurt anyone, yet the patch to do so was rejected.

=46or now, there are only four aliases, but more can be added later if
they are requested.

  co =3D checkout
  ci =3D commit
  rb =3D rebase
  st =3D status

If you have already these aliases, or mapped to something else, your
aliases would take precedence over the default ones, so you won't have
any problems.

=3D=3D=3D Streamlined remote helpers =3D=3D=3D

I have spent a lot of time working on git-remote-hg and
git-remote-bzr, and although they are relatively new, they have proven
to be quite stable and solid, yet they are only part of the "contrib"
area side by side with much simpler and way less solid scripts.

In order these in Git mainline you might need a bit of tinkering, and
it's not straight-forward to package them for distributions.

With git-fc they are installed by default, and in the right way,
making things easier for distributions.

=3D=3D=3D Improvements to the transport helper =3D=3D=3D

The two way bridges between Git and Mercurial/Bazaar already work
quite well, but they lack some features, specifically you cannot do
--force, or --dry-run, or use an old:new refspec. If you are not
familiar with the old:new refspec; you can do 'git push
master:my-master', which would push your 'master' branch, as if it was
named 'my-master' in the remote repository.

This is extremely useful if you are really serious about using Git as
a transparent client to access a Mercurial repository.

=3D=3D=3D New core.mode configuration =3D=3D=3D

Git is already preparing users for the v2.0 release which would bring
minor backward compatibility breakage, but some people would rather
get rid of the warnings which are going to stay probably for many
releases more and just move to the new behavior already.

Testing Git v2.0 behavior today would not only help git-fc, but also
the Git mainline, and you can do that by setting core.mode =3D next, so
if you do this and provide feedback about any issues, that would be
greatly appreciated. Unfortunately you cannot test the v2.0 behavior
in Git mainline because they rejected the patches, but you can in
git-fc.

Please note that the v2.0 behavior might change in the future, before
v2.0 is released, so if you enable this mode you need to be aware of
that. Chances are you are not going to notice any difference anyway.

In addition to the "next" (v2.0) mode, there's the "progress" mode.
This mode enables "next" plus other configurations that have been
proposed to change by default in v2.0, but hasn't yet been agreed.

In particular, you get these:

  merge.defaulttoupstream =3D true
  branch.autosetupmerge =3D always
  mergetool.prompt =3D false

There might be more in the future, and suggestions are welcome.

It is recommended that you setup this mode for git-fc:

  git config --global core.mode progress

=3D=3D=3D Non-ff pulls rejected by default =3D=3D=3D

Even in the Git project everybody has agreed this is the way to go in
order to avoid the typical Git newbie making the mistake of doing a
merge, when perhaps (s)he wanted to do git reset, or git rebase. With
this change git complains that that a non-fast-forward branch is being
pulled, so the user has to decide what to do.

The user would have to do either `git pull --merge` or `git pull
--rebase`, the former being what Git mainline currently does.

The user can of course choose the old behavior, which is easy to config=
ure:

  git config --global pull.mode merge

=3D=3D=3D Official staging area =3D=3D=3D

Everybody already uses the term "staging area" already, and Git
developers also agreed it the best term to what is officially referred
to as "the index". So git-fc has new options for all commands that
modify the staging area (e.g. git grep --staged, git rm --staged), and
also adds a new git stage command that makes it easier to work with
the staging area.

  'git stage' [options] [--] [<paths>...]
  'git stage add' [options] [--] [<paths>...]
  'git stage reset' [-q|--patch] [--] [<paths>...]
  'git stage diff' [options] [<commit>] [--] [<paths>...]
  'git stage rm' [options] [--] [<paths>...]
  'git stage apply' [options] [--] [<paths>...]
  'git stage edit'

Without any command, git stage adds files to the stage, same as git
add, same as in Git mainline.

=3D=3D=3D New fetch.default configuration =3D=3D=3D

When you have configured the upstream tracking branch for all your
branches, you will probably have tracking branches that point to a
local branch, for example feature-a pointing to master, in which case
you would get something like:

  % git fetch
  From .
   * branch            master     -> FETCH_HEAD

Which makes absolutely no sense, since the '.' repository is not even
documented, and FETCH_HEAD is a marginally known concept. In this case
git fetch is basically doing nothing from the user=E2=80=99s point of v=
iew.

So the user can configure `fetch.default =3D simple` to get a simple
sensible default; `git fetch` will always use origin by default, which
is not ideal for everyone, but it's better than the current
alternative.

If you use the "progress" mode, this option is also enabled.

=3D=3D=3D Publish tracking branch =3D=3D=3D

Git mainline doesn't have the greatest support for triangular
workflows, a good solution for that is to introduce a second
"upstream" tracking branch which is for the reverse; the branch you
normally push to.

Say you clone a repository (libgit2) in GitHub, then create a branch
(feature-a) and push it to your personal repository, you would want to
track two branches (origin/master), and (mine/feature-a), but Git
mainline only provides support for a single upstream tracking branch.

If you setup your upstream tracking branch to origin/master, then you
can just do git rebase without arguments and git will pick the right
branch (origin/master) to rebase to. However, git push by default will
also try to push to origin/master, which is not what you want. Plus
git branch -v will show how ahead/behind your branch is compared to
origin/master, not mine/feature-a.

If you set up your upstream to mine/feature-a, then git push will
work, but git rebase won=E2=80=99t.

With this option, git rebase uses the upstream branch, and git push
uses the publish branch.

Setting the publish tracking branch is easy:

  git push --set-publish mine feature-a

Or:

  git branch --set-publish mine/feature-a

And `git branch -v` will show it as well:

  fc/branch/fast      177dcad [master, gh/fc/branch/fast] branch:
reorganize verbose options
  fc/stage            abb6ad5 [master, gh/fc/stage] completion: update
'git reset' new stage options
  fc/transport/improv eb4d3c7 [master, gh/fc/transport/improv]
transport-helper: don't update refs in dry-run

=3D=3D=3D Support for Ruby =3D=3D=3D

By far the most complex and interesting feature, but unfortunately
also the one that is not yet 100% complete.

There is partial optional support for Ruby. Git already has tooling so
any language can use it=E2=80=99s plumbing and achieve plenty of tasks:

  IO.popen(%w[git for-each-ref]) do |io|
    io.each do |line|
      sha1, kind, name =3D line.split()
      # stuff
    end
  end

However, this a) requires a process fork, and b) requires I/O
communication to get the desired data. While this is not a big deal on
many systems, it is in Windows systems where forks are slow, and many
Git core programs don=E2=80=99t work as well as they do in Linux.

Git has a goal to replace all the core scripts with native C versions,
but it=E2=80=99s a goal only in name that is not actually pursued. In
addition, that still leaves out any third party tools since Git
doesn=E2=80=99t provide a shared libgit library, which is why an indepe=
ndent
libgit2 was needed in the first place.

Ruby bindings solve these problems:

  for_each_ref() do |name, sha1, flags|
    # stuff
  end

The command `git ruby` can use this script by providing the bindings
for many Git=E2=80=99s internal C functions (though not all), which mak=
es it
easier to write Ruby programs that take full advantage of Git without
any need of forks, or I/O communication.

=3D=3D For more information =3D=3D

The code is in Github[1], the home page is in Google code[2], and the
mailing list in Google groups (git-fc@googlegroups.com). All comments
and patches are welcome.

You can find future comments and releases in my blog [3].

Enjoy ;)

[1] https://github.com/felipec/git
[2] https://code.google.com/p/git-fc/
[3] http://felipec.wordpress.com/tag/git-fc/

--=20
=46elipe Contreras
