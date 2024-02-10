Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BFD5B1EB
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707595055; cv=none; b=uQhT51Z5RrzHCswJ2DCHTo9YCJtlLLFf6APN3uXIVsTnLCeNI7cEp43Idl//l0m8QrDuNkN9mGmfxjhsofvati0p3kBXX4I0e81EEBuDtYbyISeI9ydpfJxDYgPgBcuO5VCB2Nw1kx/jssT/rSTJ9Sp7XNRCyE7Qz0gsjrTB8O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707595055; c=relaxed/simple;
	bh=xlQu/iuRCUe6A0Zeukr4yztWJAk7nny7868PrBaoYyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsgPO4mzCVQg57cEUffIVC82USFepV/y8b1lj/aMoZBRvZ/2I6+8gCrBCY/xVNTomU2umfzpfGrZxu9gcWdYV0XMnSPx1+e0hAJ3xDjNSGcg7VnRAbr8GiGfHgtvoJlkPimXhXN1gL8dJ71TUOROBxc+GmM3cs6JKy0mv9ApAN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+Gu/8Sh; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+Gu/8Sh"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0ce2222a6so23823091fa.3
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 11:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707595050; x=1708199850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OEpKNfKmIkM+vpbIrglRBChtFTQHPE2QWy+sAGTTvo=;
        b=m+Gu/8ShOM1+Dn8bbeGiMQH16kN15J2iUbLjpgEGE6hlKJ/MDkn3F0xWeVZb2m6KMU
         IFjpSt+qKaGa/zuk0TVUmi7giKThWWtwgeiUpHNVubyJYxJjy5W37vQZjQ28+pVMSNiM
         nrRQCihW2bKD7c/cgp2HRfAMmS+uriHzB5w6HIM/pou9YNwj46g3RrjLoevMzvALyEYx
         5e3ir+6EAE3JNct8Jcicln15bJh8BuYMLaPO6Zdp1foEWylx2WBdAqCZHNK1dc3NppXz
         KKKAqI4K8miwA9NdRyQyAaeB8z3OgmEohp5eXW1mvcjMiXw+1zpDRKHGEFMs5KTM2iDk
         pETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707595050; x=1708199850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OEpKNfKmIkM+vpbIrglRBChtFTQHPE2QWy+sAGTTvo=;
        b=oQka0zWrvYRmv15xBlG06i/4yjwRPTdmI2ld25o3otGw4fpZDuMGVBcURb2v8ZSaR1
         fOnpILCKvT0qaZxS6C/wZ4ptecksiBSMemQrLzFdmKVdXBCcd6l8HunxE+SsVldr0IAr
         vEnYgqx/nAvmc0Q3hLkVyG5ni24cMc65rI7DDw+5iVcMlXhKkaGosUa5JxRo8puSVDkW
         PyQgPAVdSlhHlK1ccowoTsE9QEH21z+esAItxALoHbATqJici6gVi+Ha2ZzgKOmRiKE+
         ElyUwQGvQZ5SOsV+Cza/2Cf4+xPjfXJrY5Lyq0dwW5ye9lpJcX/cjMrraft/kDvE9C++
         xjHA==
X-Gm-Message-State: AOJu0YwU0kiPttWEjBvO7y+Cog6LAmNQSWIwUtmJtLqL7jgeSFtSkYox
	xBK/NHTgSyX4xHa8eadJxLmLSx1L7iTtRwCNzZx2OlEv9b65zAF1Bgb7jOuPUknLU2HTXScNia8
	XxuCYnfvyzoQjxo1JPBWK/PGPaHfGDOxvz5B5503x
X-Google-Smtp-Source: AGHT+IHUU3iRVCwZlVSs4lF9GneolAG4uR4RqjQP0a8vRnmvGy9B1Ty00kKZFjjzte5XPk9oi6i7VAULDNN/bl90ZOM=
X-Received: by 2002:a2e:a30d:0:b0:2d0:eb23:3b5d with SMTP id
 l13-20020a2ea30d000000b002d0eb233b5dmr902860lje.46.1707595049669; Sat, 10 Feb
 2024 11:57:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7MZG1MeeS5QNPog9oS+MbdKpkDXu61eVOszsC20Q=ik+Ng=g@mail.gmail.com>
 <m05xyw9r92.fsf@epic96565.epic.com> <CAK7MZG29+Cy-7SJnWayro_5GGEe3iZLysQqVaATLz8GLtEtA5A@mail.gmail.com>
 <m0o7co8688.fsf@epic96565.epic.com>
In-Reply-To: <m0o7co8688.fsf@epic96565.epic.com>
From: Vijay Raghavan Aravamudhan <avijayr@gmail.com>
Date: Sun, 11 Feb 2024 01:27:17 +0530
Message-ID: <CAK7MZG1whUj23y5DoqXOjtiB2kFRfT-gi6r1r=GC5HvM5jneNQ@mail.gmail.com>
Subject: Re: git status became very slow after upgrading git
To: Sean Allred <allred.sean@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the quick response!
Here's the data requested:
system credential.helper=3Dosxkeychain
global includeif.gitdir/i:~/.path=3D~/.gitconfig-oss.inc
global advice.detachedhead=3Dtrue
global alias.dangling=3Dfsck --no-reflog
global alias.ec=3Dconfig --global -e
global alias.f=3D!git ls-files | grep -i
global alias.sci=3D!sh -c ' if $(git st | grep -q "have diverged"); then
echo "Diverged branches: aborting"; exit 1; elif ! $(git st | grep -q
"to unstage"); then echo "Nothing to commit: aborting"; else if $(git
st | grep -q "is ahead of"); then echo "Amending existing commit"; git
amq; else echo "Creating new commit"; echo $0; git ci "$0"; fi fi'
global alias.what=3Dshow -s --pretty=3D'tformat:%h (%s, %ad)' --date=3Dshor=
t
global alias.who=3Dshortlog -s --
global alias.whois=3Dlog -i -1 --pretty=3Dformat:'%an <%ae>' --author
global alias.standup=3Dlog --since 1.week.ago --author
global alias.lg=3Dlog --color --graph
--pretty=3Dformat:'%C(yellow)%h%Creset -%C(bold blue)%d%Creset %s
%C(green) %an, %cr%Creset' --abbrev-commit
global alias.lga=3Dlog --color --graph --all
--pretty=3Dformat:'%C(yellow)%h%Creset -%C(bold blue)%d%Creset %s
%C(green) %an, %cr%Creset' --abbrev-commit
global alias.ll=3Dlog --decorate --graph --oneline --abbrev-commit
global alias.mn=3Dmerge --no-commit
global alias.cn=3Dcherry-pick --no-commit
global alias.cr=3Dcherry-pick
global alias.ci=3Dcommit -m
global alias.co=3Dcheckout
global alias.cl=3Dclone
global alias.st=3D!git status --ahead-behind && git submodule summary
global alias.sts=3Dstatus -sb
global alias.b=3Dbranch
global alias.d=3Ddiff
global alias.dc=3Ddiff --staged
global alias.undo=3Dreset --soft HEAD^
global alias.wipe=3D!git add -A && git commit -qm 'WIPE SAVEPOINT if
needed later, can be resurrected using reflog' && git reset HEAD~1
--hard
global alias.amend=3Dcommit --amend --date=3Dnow
global alias.amq=3Damend --no-edit --quiet
global alias.unstage=3Drestore --staged
global alias.large=3D!git ls-tree -r -t -l --full-name HEAD | sort -n -k
4 | tail -n 10
global alias.untrack=3Drm -rf --cached --
global alias.grep=3Dgrep -Ii
global alias.patch=3D!git --no-pager diff --no-color
global alias.track=3Drev-parse --abbrev-ref --symbolic-full-name @{u}
global alias.fo=3D!git fetch --all --tags && git dlb
global alias.repo=3D!basename `git remote get-url origin`
global alias.br=3Dbranch --show-current
global alias.upreb=3D!git branch -u origin/`git br` && git fo && ( git
remote | grep upstream 2>&1 >/dev/null ) && git rebase upstream/`git
br` --no-verify && git fetch upstream --tags && git push --no-verify
&& git push --tags --no-verify && git siu && git dlb
global alias.rpo=3Dremote prune origin
global alias.in=3Dlog --reverse ..@{u} --stat --no-merges
global alias.inp=3Dlog -p --reverse ..@{u} --no-merges
global alias.inc=3D!git diff ..@{u}
global alias.new=3D!sh -c 'git log $1@{1}..$1@{0} $@'
global alias.ghpg-trim=3D!r() { days=3D${1:-19}; echo "Will clean beyond
$days days" && git checkout gh-pages && echo "Size before: $(du -sh
*reports)" && DIRECTORIES=3D$(find *-reports -mindepth 1 -maxdepth 1
-type d); for dir in ${DIRECTORIES}; do SHA_FROM_DIR=3D"$(basename
$dir)"; COMMIT_DATE_IN_MILLIS=3D$(git show -s --format=3D%ct $SHA_FROM_DIR
2> /dev/null || echo 5000000000); COMMIT_DATE_IN_DAYS=3D$(echo
"$COMMIT_DATE_IN_MILLIS / (1000 * 60 * 60 * 24)" | bc -l); ((
${COMMIT_DATE_IN_DAYS%.*} > ${days%.*} )) && git rm -rf $dir; done;
git commit -m "Deleting reports older than $days days" && echo $(git
rev-parse HEAD) > .git/info/grafts && git config
advice.graftFileDeprecated false && FILTER_BRANCH_SQUELCH_WARNING=3D1
git filter-branch -f -- --all; rm -f .git/info/grafts; echo "Size
after: $(du -sh *reports)" done;}; r
global alias.out=3Dlog --reverse @{u}..
global alias.outp=3Dlog -p --reverse @{u}..
global alias.g=3Dgrep --break --heading --line-number
global alias.sf=3Dsubmodule foreach
global alias.rfc=3Dreflog expire --expire=3Dnow
global alias.cc=3D!echo "Size before: $(du -sh .git | cut -f1)"; git
remote prune origin; git repack; git prune-packed; git reflog expire
--all --expire=3D1.week.ago; git maintenance run --task=3Dgc; echo "Size
after: $(du -sh .git | cut -f1)";
global alias.big=3D!git rev-list --objects --all | grep "$(git
verify-pack -v .git/objects/pack/*.idx | sort -k 3 -n | tail -100 |
awk '{print $1}')"
global alias.dlb=3D!git branch -vv | GREP_OPTIONS=3D grep ': gone]' | awk
'{print $1}' | xargs -I {} git branch -D {}
global alias.old=3D!sh -c '[[ "`git log $0/$1 --since 10.days -1 | wc
-l`" -eq 0 ]] && echo "Will need to delete $0/$1"'
global alias.recentb=3D!r() { refbranch=3D$1 count=3D$2; git for-each-ref
--sort=3D-committerdate refs/remotes
--format=3D'%(refname:short)|%(HEAD)%(color:yellow)%(refname:short)|%(color=
:bold
green)%(committerdate:relative)|%(color:blue)%(subject)|%(color:magenta)%(a=
uthorname)%(color:reset)'
--color=3Dalways --count=3D${count:-20} | while read line; do
branch=3D$(echo "$line" | awk 'BEGIN { FS =3D "|" }; { print $1 }' | tr -d
'*'); ahead=3D$(git rev-list --count
"${refbranch:-origin/master}..${branch}"); behind=3D$(git rev-list
--count "${branch}..${refbranch:-origin/master}"); colorline=3D$(echo
"$line" | sed 's/^[^|]*|//'); echo "$ahead|$behind|$colorline" | awk
-F'|' -vOFS=3D'|' '{$5=3Dsubstr($5,1,70)}1' ; done | ( echo
"ahead|behind||branch|lastcommit|message|author\n" && cat) | column
-ts'|';}; r
global alias.oldestb=3D!r() { refbranch=3D$1 count=3D$2; git for-each-ref
--sort=3Dcommitterdate refs/remotes
--format=3D'%(refname:short)|%(HEAD)%(color:yellow)%(refname:short)|%(color=
:bold
green)%(committerdate:relative)|%(color:blue)%(subject)|%(color:magenta)%(a=
uthorname)%(color:reset)'
--color=3Dalways --count=3D${count:-20} | while read line; do
branch=3D$(echo "$line" | awk 'BEGIN { FS =3D "|" }; { print $1 }' | tr -d
'*'); ahead=3D$(git rev-list --count
"${refbranch:-origin/master}..${branch}"); behind=3D$(git rev-list
--count "${branch}..${refbranch:-origin/master}"); colorline=3D$(echo
"$line" | sed 's/^[^|]*|//'); echo "$ahead|$behind|$colorline" | awk
-F'|' -vOFS=3D'|' '{$5=3Dsubstr($5,1,70)}1' ; done | ( echo
"ahead|behind||branch|lastcommit|message|author\n" && cat) | column
-ts'|';}; r
global alias.lc=3D!git branch -r --sort=3D-committerdate
--format=3D"%(color:magenta)%(committerdate:relative)%(color:reset)
%(color:bold cyan)%(refname:short)%(color:reset) %(contents:subject)
%(color:bold blue) <%(authorname)> %(color:reset)"
global alias.lc2=3D!git branch -r --sort=3D-committerdate | egrep -v
'HEAD|master|main' | while read b; do git log --since 4.days --color
--format=3D"%ci _%C(magenta)%cr %C(bold cyan)$b%Creset %s %C(bold
blue)<%an>%Creset" $b | head -n 1; done | sort -r | cut -d_ -f2-
global alias.se=3D!git rev-list --all | xargs git grep -F
global alias.siu=3D!git submodule update --init --recursive --remote
--rebase --force
global alias.pushsub=3Dsf git push
global alias.pullsub=3Dsf git pull
global alias.dcolor=3Ddiff --color-words
global branch.autosetupmerge=3Dtrue
global branch.autosetuprebase=3Dalways
global branch.sort=3Dcommitterdate
global checkout.defaultremote=3Dorigin
global checkout.workers=3D0
global color.diff.meta=3Dyellow
global color.diff.frag=3Dmagenta bold
global color.diff.func=3D146 bold
global color.diff.commit=3Dyellow bold
global color.diff.old=3Dred bold
global color.diff.new=3Dgreen bold
global color.diff.whitespace=3Dred reverse
global core.pager=3Ddiff-so-fancy | less --tabs=3D2 -RFX
global core.editor=3Dcodium --wait
global core.autocrlf=3Dinput
global core.excludesfile=3D~/.gitignore_global
global core.commentchar=3D*
global core.whitespace=3Dfix
global diff.compactionheuristic=3Dtrue
global diff.renames=3Dtrue
global diff.renamelimit=3D1000
global diff.colormoved=3Ddefault
global diff.submodule=3Ddiff
global diff-so-fancy.markemptylines=3Dfalse
global fetch.prune=3Dtrue
global fetch.prunetags=3Dtrue
global fetch.parallel=3D0
global fetch.showforcedupdates=3Dtrue
global filter.lfs.required=3Dtrue
global filter.lfs.clean=3Dgit-lfs clean -- %f
global filter.lfs.smudge=3Dgit-lfs smudge -- %f
global filter.lfs.process=3Dgit-lfs filter-process
global gc.auto=3D2000
global gc.pruneexpire=3Dnow
global gc.worktreepruneexpire=3D1.weeks.ago
global gc.reflogexpire=3D2.weeks.ago
global gc.reflogexpireunreachable=3D2.weeks.ago
global gc.rerereresolved=3D1.weeks.ago
global grep.column=3Dtrue
global grep.extendedregexp=3Dtrue
global grep.linenumber=3Dtrue
global grep.fullname=3Dtrue
global gui.pruneduringfetch=3Dtrue
global gui.matchtrackingbranch=3Dtrue
global gui.warndetachedcommit=3Dtrue
global gui.tabsize=3D2
global help.autocorrect=3D1
global interactive.difffilter=3Ddiff-so-fancy --patch
global merge.defaulttoupstream=3Dtrue
global merge.ff=3Donly
global merge.renamelimit=3D15000
global merge.autostash=3Dtrue
global pack.threads=3D0
global pack.writereverseindex=3Dtrue
global pager.diff=3Ddiff-so-fancy | less --tabs=3D2 -RFX
global pull.rebase=3Dtrue
global pull.autostash=3Dtrue
global push.default=3Dupstream
global push.followtags=3Dtrue
global push.recursesubmodules=3Dcheck
global rebase.autosquash=3Dtrue
global rebase.autostash=3Dtrue
global rebase.missingcommitscheck=3Derror
global rebase.abbreviatecommands=3Dtrue
global rerere.enabled=3Dtrue
global rerere.autoupdate=3Dtrue
global stash.untracked=3Dtrue
global stash.showincludeuntracked=3Dtrue
global stash.showpatch=3Dtrue
global status.showstash=3Dtrue
global submodule.fetchjobs=3D0
global tag.sort=3Dversion:refname
global transfer.fsckobjects=3Dfalse
global http.postbuffer=3D786432000
global user.useconfigonly=3Dtrue
global add.interactive.usebuiltin=3Dfalse
global init.defaultbranch=3Dmaster
local core.repositoryformatversion=3D0
local core.filemode=3Dtrue
local core.bare=3Dfalse
local core.logallrefupdates=3Dtrue
local core.ignorecase=3Dtrue
local core.precomposeunicode=3Dtrue
local core.hookspath=3D.husky
local remote.origin.url=3Dgit@github.com:vraravam/ferdium-app
local remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin/*
local branch.develop.remote=3Dorigin
local branch.develop.rebase=3Dtrue
local branch.develop.merge=3Drefs/heads/develop
local remote.upstream.url=3Dgit@github.com:ferdium/ferdium-app
local remote.upstream.fetch=3D+refs/heads/*:refs/remotes/upstream/*
local submodule.recipes.active=3Dtrue
local submodule.recipes.url=3Dhttps://github.com/ferdium/ferdium-recipes.gi=
t
local branch.nightly.remote=3Dorigin
local branch.nightly.rebase=3Dtrue
local branch.nightly.merge=3Drefs/heads/nightly
local branch.release.remote=3Dorigin
local branch.release.rebase=3Dtrue
local branch.release.merge=3Drefs/heads/release
local gui.wmstate=3Dnormal
local gui.geometry=3D1381x921+5+48 201 203

On Sun, Feb 11, 2024 at 1:03=E2=80=AFAM Sean Allred <allred.sean@gmail.com>=
 wrote:
>
>
> Vijay Raghavan Aravamudhan <avijayr@gmail.com> writes:
>
> > Thanks for responding. I have run the command that you gave on an open
> > source repo so that its easy for you to replicate. The remote url is:
> > https://github.com/vraravam/ferdium-app
> >
> > The output is:
> >
> >         [[ I took the liberty of cleaning this up; ]]
> >         [[ let's hope formatting is preserved now. ]]
> >
> > ferdium-app.git:develop$ GIT_TRACE=3D1 GIT_TRACE_SETUP=3D1 GIT_TRACE_PE=
RFORMANCE=3D1 git status
> > 00:08:15.548976 trace.c:314             setup: git_dir: .git
> > 00:08:15.550590 trace.c:315             setup: git_common_dir: .git
> > 00:08:15.550600 trace.c:316             setup: worktree: /Users/vijay/d=
ev/oss/ferdium
> > 00:08:15.550604 trace.c:317             setup: cwd: /Users/vijay/dev/os=
s/ferdium
> > 00:08:15.550611 trace.c:318             setup: prefix: (null)
> > 00:08:15.550707 chdir-notify.c:70       setup: chdir from '/Users/vijay=
/dev/oss/ferdium' to '/Users/vijay/dev/oss/ferdium'
> > 00:08:15.550723 git.c:463               trace: built-in: git status
> > 00:08:15.552184 read-cache.c:2386       performance: 0.000183000 s: rea=
d cache .git/index
> > 00:08:15.555964 read-cache.c:1629       performance: 0.003696000 s: ref=
resh index
> > 00:08:15.556442 diff-lib.c:273          performance: 0.000132000 s:  di=
ff-files
> > 00:08:15.558558 unpack-trees.c:2004     performance: 0.000019000 s: tra=
verse_trees
> > 00:08:15.558801 unpack-trees.c:438      performance: 0.000003000 s: che=
ck_updates
> > 00:08:15.558813 unpack-trees.c:2096     performance: 0.000394000 s: unp=
ack_trees
> > 00:08:15.558819 diff-lib.c:638          performance: 0.000524000 s:  di=
ff-index
> > 00:08:15.559166 name-hash.c:613         performance: 0.000148000 s: ini=
tialize name hash
> > On branch develop
> > Your branch is up to date with 'origin/develop'.
> >
> > 00:08:15.567249 run-command.c:657       trace: run_command: GIT_INDEX_F=
ILE=3D.git/index git submodule summary --cached --for-status --summary-limi=
t -1 HEAD
> > 00:08:15.833334 git.c:749               trace: exec: git-submodule summ=
ary --cached --for-status --summary-limit -1 HEAD
> > 00:08:15.834114 run-command.c:657       trace: run_command: git-submodu=
le summary --cached --for-status --summary-limit -1 HEAD
> > 00:08:16.880778 trace.c:414             performance: 0.000013000 s: git=
 command: git --exec-path
> > 00:08:18.216639 git.c:463               trace: built-in: git rev-parse =
--git-dir
> > 00:08:18.218740 trace.c:414             performance: 0.002132000 s: git=
 command: git rev-parse --git-dir
> > 00:08:18.489025 git.c:463               trace: built-in: git rev-parse =
--git-path objects
> > 00:08:18.490677 trace.c:414             performance: 0.001675000 s: git=
 command: git rev-parse --git-path objects
> > 00:08:19.031080 git.c:463               trace: built-in: git rev-parse =
--show-prefix
> > 00:08:19.032882 trace.c:414             performance: 0.001827000 s: git=
 command: git rev-parse --show-prefix
> > 00:08:19.296074 git.c:463               trace: built-in: git rev-parse =
--show-toplevel
> > 00:08:19.297559 trace.c:414             performance: 0.001504000 s: git=
 command: git rev-parse --show-toplevel
> > 00:08:19.830285 trace.c:314             setup: git_dir: .git
> > 00:08:19.830972 trace.c:315             setup: git_common_dir: .git
> > 00:08:19.830981 trace.c:316             setup: worktree: /Users/vijay/d=
ev/oss/ferdium
> > 00:08:19.830984 trace.c:317             setup: cwd: /Users/vijay/dev/os=
s/ferdium
> > 00:08:19.830990 trace.c:318             setup: prefix: (null)
> > 00:08:19.830994 git.c:463               trace: built-in: git submodule-=
-helper summary --cached --for-status -n -1 -- HEAD
> > 00:08:19.834629 read-cache.c:2386       performance: 0.000164000 s: rea=
d cache .git/index
> > 00:08:19.834914 unpack-trees.c:2004     performance: 0.000024000 s: tra=
verse_trees
> > 00:08:19.834932 unpack-trees.c:438      performance: 0.000003000 s: che=
ck_updates
> > 00:08:19.834940 unpack-trees.c:2096     performance: 0.000157000 s: unp=
ack_trees
> > 00:08:19.834958 diff-lib.c:638          performance: 0.000307000 s:  di=
ff-index
> > 00:08:19.834975 trace.c:414             performance: 0.005922000 s: git=
 command: git submodule--helper summary --cached --for-status -n -1 -- HEAD
> > 00:08:19.836137 trace.c:414             performance: 4.003693000 s: git=
 command: /opt/homebrew/opt/git/libexec/git-core/git submodule summary --ca=
ched --for-status --summary-limit -1 HEAD
> > 00:08:19.836842 run-command.c:657       trace: run_command: GIT_INDEX_F=
ILE=3D.git/index git submodule summary --files --for-status --summary-limit=
 -1
> > 00:08:20.106802 git.c:749               trace: exec: git-submodule summ=
ary --files --for-status --summary-limit -1
> > 00:08:20.107638 run-command.c:657       trace: run_command: git-submodu=
le summary --files --for-status --summary-limit -1
> > 00:08:21.162243 trace.c:414             performance: 0.000006000 s: git=
 command: git --exec-path
> > 00:08:22.496146 git.c:463               trace: built-in: git rev-parse =
--git-dir
> > 00:08:22.497722 trace.c:414             performance: 0.001589000 s: git=
 command: git rev-parse --git-dir
> > 00:08:22.764795 git.c:463               trace: built-in: git rev-parse =
--git-path objects
> > 00:08:22.766763 trace.c:414             performance: 0.001991000 s: git=
 command: git rev-parse --git-path objects
> > 00:08:23.304626 git.c:463               trace: built-in: git rev-parse =
--show-prefix
> > 00:08:23.306436 trace.c:414             performance: 0.001833000 s: git=
 command: git rev-parse --show-prefix
> > 00:08:23.575506 git.c:463               trace: built-in: git rev-parse =
--show-toplevel
> > 00:08:23.577138 trace.c:414             performance: 0.001656000 s: git=
 command: git rev-parse --show-toplevel
> > 00:08:24.111335 trace.c:314             setup: git_dir: .git
> > 00:08:24.112123 trace.c:315             setup: git_common_dir: .git
> > 00:08:24.112138 trace.c:316             setup: worktree: /Users/vijay/d=
ev/oss/ferdium
> > 00:08:24.112142 trace.c:317             setup: cwd: /Users/vijay/dev/os=
s/ferdium
> > 00:08:24.112149 trace.c:318             setup: prefix: (null)
> > 00:08:24.112154 git.c:463               trace: built-in: git submodule-=
-helper summary --files --for-status -n -1 --
> > 00:08:24.113679 read-cache.c:2386       performance: 0.000216000 s: rea=
d cache .git/index
> > 00:08:24.117811 diff-lib.c:273          performance: 0.004115000 s:  di=
ff-files
> > 00:08:24.117838 trace.c:414             performance: 0.007389000 s: git=
 command: git submodule--helper summary --files --for-status -n -1 --
> > 00:08:24.118895 trace.c:414             performance: 4.013083000 s: git=
 command: /opt/homebrew/opt/git/libexec/git-core/git submodule summary --fi=
les --for-status --summary-limit -1
> > nothing to commit, working tree clean
> > 00:08:24.119646 trace.c:414             performance: 8.571954000 s: git=
 command: git status
> >
> > Hope this helps. Also, I noticed that the same repo, same versions of
> > all tools, etc - this issue only occurs on my M2 mac, but works
> > without any slowness on the intel mac.
>
> Thanks, that info does help. It at least narrows it down to these two
> subprocesses:
>
>     git submodule--helper summary --cached --for-status -n -1 -- HEAD
>     git submodule--helper summary --files --for-status -n -1 --
>
> Unfortunately, I'm still not able to reproduce on my M2 (even with that
> config set globally), so I wonder if there's something else at play.
> I've probably reached the end of my usefulness (since the problem does
> appear to be specific to submodules and cmd_submodule__helper seems to
> be lacking documentation), but you might consider replying with your
> output of
>
>     git config --list --show-scope
>
> after stripping any private information, of course.
>
> I'll provide my info down below in the hopes that it's useful for
> comparison by someone who knows more about this subsystem. It's worth
> noting that I'm running the same submodule--helper command and it's
> completing in a reasonable timeframe for me.
>
> Configuration:
>
>     ferdium-app.git:develop$ git --no-pager config --list --show-scope
>     system      credential.helper=3Dosxkeychain
>     system      filter.lfs.clean=3Dgit-lfs clean -- %f
>     system      filter.lfs.smudge=3Dgit-lfs smudge -- %f
>     system      filter.lfs.process=3Dgit-lfs filter-process
>     system      filter.lfs.required=3Dtrue
>     global      user.signingkey=3D/Users/sallred/.ssh/id_ed25519.pub
>     global      pull.rebase=3Dtrue
>     global      push.default=3Dcurrent
>     global      core.editor=3Dmg
>     global      core.excludesfile=3D/Users/sallred/.gitignore
>     global      core.fsmonitor=3Dtrue
>     global      core.whitespace=3Dtrailing-space
>     global      init.defaultbranch=3Dmain
>     global      remote.pushdefault=3Dorigin
>     global      branch.autosetupmerge=3Dtrue
>     global      rerere.enabled=3Dtrue
>     global      gpg.format=3Dssh
>     global      maintenance.repo=3D/Users/sallred/a
>     global      maintenance.repo=3D/Users/sallred/b
>     global      maintenance.repo=3D/Users/sallred/c
>     global      maintenance.repo=3D/Users/sallred/d
>     global      commit.gpgsign=3Dtrue
>     global      diff.wserrorhighlight=3Dold,new
>     global      gpg.ssh.allowedsignersfile=3D/Users/sallred/.ssh/allowed_=
signers
>     global      remote.origin.fetch=3D+refs/notes/*:refs/notes/*
>     global      status.submodulesummary=3Dtrue
>     local       core.repositoryformatversion=3D0
>     local       core.filemode=3Dtrue
>     local       core.bare=3Dfalse
>     local       core.logallrefupdates=3Dtrue
>     local       core.ignorecase=3Dtrue
>     local       core.precomposeunicode=3Dtrue
>     local       remote.origin.url=3Dgit@github.com:vraravam/ferdium-app
>     local       remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin/*
>     local       branch.develop.remote=3Dorigin
>     local       branch.develop.merge=3Drefs/heads/develop
>
> Performance data:
>
>     ferdium-app.git:develop$ GIT_TRACE=3D1 GIT_TRACE_SETUP=3D1 GIT_TRACE_=
PERFORMANCE=3D1 git status
>     13:29:32.879597 trace.c:314             setup: git_dir: .git
>     13:29:32.880020 trace.c:315             setup: git_common_dir: .git
>     13:29:32.880026 trace.c:316             setup: worktree: /Users/sallr=
ed/tmp/ferdium-app
>     13:29:32.880029 trace.c:317             setup: cwd: /Users/sallred/tm=
p/ferdium-app
>     13:29:32.880033 trace.c:318             setup: prefix: (null)
>     13:29:32.880071 chdir-notify.c:70       setup: chdir from '/Users/sal=
lred/tmp/ferdium-app' to '/Users/sallred/tmp/ferdium-app'
>     13:29:32.880078 git.c:463               trace: built-in: git status
>     13:29:32.880606 read-cache.c:2386       performance: 0.000118000 s:  =
read cache .git/index
>     13:29:32.904888 read-cache.c:1629       performance: 0.000082000 s:  =
refresh index
>     13:29:32.905983 diff-lib.c:273          performance: 0.000287000 s:  =
diff-files
>     13:29:32.907393 unpack-trees.c:2004     performance: 0.000014000 s:  =
  traverse_trees
>     13:29:32.907403 unpack-trees.c:438      performance: 0.000002000 s:  =
  check_updates
>     13:29:32.907407 unpack-trees.c:2096     performance: 0.000109000 s:  =
 unpack_trees
>     13:29:32.907410 diff-lib.c:638          performance: 0.000163000 s:  =
diff-index
>     13:29:32.907681 name-hash.c:613         performance: 0.000107000 s:  =
initialize name hash
>     13:29:32.922245 run-command.c:657       trace: run_command: GIT_INDEX=
_FILE=3D.git/index git submodule summary --cached --for-status --summary-li=
mit -1 HEAD
>     On branch develop
>     Your branch is up to date with 'origin/develop'.
>
>     13:29:32.928117 git.c:749               trace: exec: git-submodule su=
mmary --cached --for-status --summary-limit -1 HEAD
>     13:29:32.928715 run-command.c:657       trace: run_command: git-submo=
dule summary --cached --for-status --summary-limit -1 HEAD
>     13:29:32.941067 trace.c:414             performance: 0.000002000 s: g=
it command: git --exec-path
>     13:29:32.961582 git.c:463               trace: built-in: git rev-pars=
e --git-dir
>     13:29:32.962376 trace.c:414             performance: 0.000802000 s: g=
it command: git rev-parse --git-dir
>     13:29:32.966772 git.c:463               trace: built-in: git rev-pars=
e --git-path objects
>     13:29:32.967437 trace.c:414             performance: 0.000673000 s: g=
it command: git rev-parse --git-path objects
>     13:29:32.976243 git.c:463               trace: built-in: git rev-pars=
e --show-prefix
>     13:29:32.976902 trace.c:414             performance: 0.000667000 s: g=
it command: git rev-parse --show-prefix
>     13:29:32.981157 git.c:463               trace: built-in: git rev-pars=
e --show-toplevel
>     13:29:32.981835 trace.c:414             performance: 0.000690000 s: g=
it command: git rev-parse --show-toplevel
>     13:29:32.989790 trace.c:314             setup: git_dir: .git
>     13:29:32.990234 trace.c:315             setup: git_common_dir: .git
>     13:29:32.990238 trace.c:316             setup: worktree: /Users/sallr=
ed/tmp/ferdium-app
>     13:29:32.990242 trace.c:317             setup: cwd: /Users/sallred/tm=
p/ferdium-app
>     13:29:32.990245 trace.c:318             setup: prefix: (null)
>     13:29:32.990246 git.c:463               trace: built-in: git submodul=
e--helper summary --cached --for-status -n -1 -- HEAD
>     13:29:32.991301 read-cache.c:2386       performance: 0.000062000 s:  =
read cache .git/index
>     13:29:33.002570 unpack-trees.c:2004     performance: 0.000009000 s:  =
  traverse_trees
>     13:29:33.002577 unpack-trees.c:438      performance: 0.000001000 s:  =
  check_updates
>     13:29:33.002580 unpack-trees.c:2096     performance: 0.000074000 s:  =
 unpack_trees
>     13:29:33.002585 diff-lib.c:638          performance: 0.000117000 s:  =
diff-index
>     13:29:33.002591 trace.c:414             performance: 0.013037000 s: g=
it command: git submodule--helper summary --cached --for-status -n -1 -- HE=
AD
>     13:29:33.003099 trace.c:414             performance: 0.075293000 s: g=
it command: /opt/homebrew/opt/git/libexec/git-core/git submodule summary --=
cached --for-status --summary-limit -1 HEAD
>     13:29:33.003446 run-command.c:657       trace: run_command: GIT_INDEX=
_FILE=3D.git/index git submodule summary --files --for-status --summary-lim=
it -1
>     13:29:33.007530 git.c:749               trace: exec: git-submodule su=
mmary --files --for-status --summary-limit -1
>     13:29:33.007926 run-command.c:657       trace: run_command: git-submo=
dule summary --files --for-status --summary-limit -1
>     13:29:33.017316 trace.c:414             performance: 0.000002000 s: g=
it command: git --exec-path
>     13:29:33.036544 git.c:463               trace: built-in: git rev-pars=
e --git-dir
>     13:29:33.037494 trace.c:414             performance: 0.000959000 s: g=
it command: git rev-parse --git-dir
>     13:29:33.041936 git.c:463               trace: built-in: git rev-pars=
e --git-path objects
>     13:29:33.042731 trace.c:414             performance: 0.000803000 s: g=
it command: git rev-parse --git-path objects
>     13:29:33.051651 git.c:463               trace: built-in: git rev-pars=
e --show-prefix
>     13:29:33.052320 trace.c:414             performance: 0.000678000 s: g=
it command: git rev-parse --show-prefix
>     13:29:33.056260 git.c:463               trace: built-in: git rev-pars=
e --show-toplevel
>     13:29:33.057043 trace.c:414             performance: 0.000793000 s: g=
it command: git rev-parse --show-toplevel
>     13:29:33.064488 trace.c:314             setup: git_dir: .git
>     13:29:33.064860 trace.c:315             setup: git_common_dir: .git
>     13:29:33.064862 trace.c:316             setup: worktree: /Users/sallr=
ed/tmp/ferdium-app
>     13:29:33.064863 trace.c:317             setup: cwd: /Users/sallred/tm=
p/ferdium-app
>     13:29:33.064866 trace.c:318             setup: prefix: (null)
>     13:29:33.064867 git.c:463               trace: built-in: git submodul=
e--helper summary --files --for-status -n -1 --
>     13:29:33.065421 read-cache.c:2386       performance: 0.000085000 s:  =
read cache .git/index
>     13:29:33.079310 diff-lib.c:273          performance: 0.000026000 s:  =
diff-files
>     13:29:33.079330 trace.c:414             performance: 0.015094000 s: g=
it command: git submodule--helper summary --files --for-status -n -1 --
>     13:29:33.079947 trace.c:414             performance: 0.072649000 s: g=
it command: /opt/homebrew/opt/git/libexec/git-core/git submodule summary --=
files --for-status --summary-limit -1
>     13:29:33.080290 trace.c:414             performance: 0.201218000 s: g=
it command: git status
>     nothing to commit, working tree clean
>
> --
> Sean Allred



--=20
You can visit my Github Profile to get to know what I work on outside
of my day job
