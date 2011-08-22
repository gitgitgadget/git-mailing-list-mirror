From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: [Git 1.7.6.557.gcee4] git stash
Date: Mon, 22 Aug 2011 11:43:25 -0700
Message-ID: <CAE1pOi2OnHpu+kBj8Z47nb7C-MHFpUMAc8ArG3haWpncEDQ-jA@mail.gmail.com>
References: <CAE1pOi1D+J5_fmsdhho1FRAipyO3Ri7GS_wy4fTNtCGbatDaDg@mail.gmail.com>
	<euT1_KmfLWaxwFqOd8u_Zv-flc6Wr9rvg1tf_39P-YMaH8T-tpKl94WG8yCIAmW0AMLjdqnjA3I2uGRQf9YpY513-Io-lue5aNPuVDv8Qp8@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Caldwell <david@porkrind.org>,
	Git Users <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Aug 22 20:43:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvZTA-00042l-B0
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 20:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899Ab1HVSn1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Aug 2011 14:43:27 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61042 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab1HVSn0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2011 14:43:26 -0400
Received: by gya6 with SMTP id 6so3783604gya.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=MZ+w5KJOfZJ+BHn4bt9W8sTROANnXmep54Yf3EdaMMM=;
        b=AcWgpA/ppTaP4JiwkYL08+NxWCQhX88JxtIMBJhOMhZ1XpyBIvQ9vpkhV2Tx7HarIM
         oDY5hQCdbw2ra8DnIUtmUGeUki6mrdh9D9pA37hLFaVW+4s0cJCrIU41GJ20QaS2F3QS
         LOx/853nE2MbOrTLZlLPhT669PQUWo5noz4TU=
Received: by 10.236.9.36 with SMTP id 24mr17009253yhs.17.1314038605062; Mon,
 22 Aug 2011 11:43:25 -0700 (PDT)
Received: by 10.236.207.67 with HTTP; Mon, 22 Aug 2011 11:43:25 -0700 (PDT)
In-Reply-To: <euT1_KmfLWaxwFqOd8u_Zv-flc6Wr9rvg1tf_39P-YMaH8T-tpKl94WG8yCIAmW0AMLjdqnjA3I2uGRQf9YpY513-Io-lue5aNPuVDv8Qp8@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179878>

On 22 August 2011 10:15, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> On 08/22/2011 01:01 AM, Hilco Wijbenga wrote:
>> Hi David,
>>
>> I noticed your very timely change to git stash in the current master
>> branch. I tried it but it doesn't behave as I was expecting/hoping.
>
> It looks like it is actually creating the stash correctly, but it's
> just not deleting the ignored directory.
>
> But, there is a small problem with your command sequence...
>
>> hilco@centaur ~/tmp/repo repo$ git --version
>> git version 1.7.6.557.gcee4
>> hilco@centaur ~/tmp/repo repo$ git init
>> Initialized empty Git repository in /home/hilco/tmp/repo/.git/
>> hilco@centaur ~/tmp/repo repo (master #)$ cat >>.gitignore <<- EOF
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 *.ignore
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ignore-dir/
>>> EOF
>> hilco@centaur ~/tmp/repo repo (master #%)$ mkdir src
>> hilco@centaur ~/tmp/repo repo (master #%)$ touch file.txt src/code.t=
xt
>> hilco@centaur ~/tmp/repo repo (master #%)$ git add -A .
>> hilco@centaur ~/tmp/repo repo (master #)$ git commit -m '1'
>> [master (root-commit) 0fb4106] 1
>> =C2=A01 files changed, 2 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 .gitignore
>> =C2=A0create mode 100644 file.txt
>> =C2=A0create mode 100644 src/code.txt
>> hilco@centaur ~/tmp/repo repo (master)$ touch file-a.ignore src/file=
-b.ignore
>> hilco@centaur ~/tmp/repo repo (master %)$ echo "hello">src/code.txt
>> hilco@centaur ~/tmp/repo repo (master *%)$ mkdir ignore-dir
>> hilco@centaur ~/tmp/repo repo (master *%)$ touch
>> ignore-dir/{file.ignore,file.txt}
>> hilco@centaur ~/tmp/repo repo (master *%)$ git status
>> # On branch master
>> # Changes not staged for commit:
>> # =C2=A0 (use "git add <file>..." to update what will be committed)
>> # =C2=A0 (use "git checkout -- <file>..." to discard changes in work=
ing directory)
>> #
>> # =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 src/code.txt
>> #
>> # Untracked files:
>> # =C2=A0 (use "git add <file>..." to include in what will be committ=
ed)
>> #
>> # =C2=A0 =C2=A0 =C2=A0 file-a.ignore
>> # =C2=A0 =C2=A0 =C2=A0 ignore-dir/
>> # =C2=A0 =C2=A0 =C2=A0 src/file-b.ignore
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^^^^^
> Why are these entries here?

My bad. I had a script that ran the commands but I decided to try run
them on the CL so I copy-pasted them. That changed the tabs to spaces
and ruined .gitignore.

>> no changes added to commit (use "git add" and/or "git commit -a")
>
> if your .gitignore file looks like this:
>
> =C2=A0 $ cat .gitignore
> =C2=A0 *.ignore
> =C2=A0 ignore-dir/
>
> then why are those items showing up under "Untracked files:" in the c=
all
> to git status above? =C2=A0/methinks something is wrong with your .gi=
tignore
> file. =C2=A0It doesn't matter in this case, since --all will cause st=
ash to
> stash the untracked files regardless of whether they are ignored.
>
>> hilco@centaur ~/tmp/repo repo (master *%)$ git stash --no-keep-index=
 --all
>> Saved working directory and index state WIP on master: 0fb4106 1
>> HEAD is now at 0fb4106 1
>> Not removing ignore-dir/
>> hilco@centaur ~/tmp/repo repo (master $%)$ git status
>> # On branch master
>> # Untracked files:
>> # =C2=A0 (use "git add <file>..." to include in what will be committ=
ed)
>> #
>> # =C2=A0 =C2=A0 =C2=A0 ignore-dir/
>> nothing added to commit but untracked files present (use "git add" t=
o track)
>
> Also, in the future it would be nicer if you provided your list of
> commands separately, at the beginning, linked together with &&.
> This makes it easier to copy/paste into my terminal, rather than
> having to extract the commands out from within the body.
> Like this (slightly simplified):
>
> =C2=A0 git --version &&
> =C2=A0 git init &&
> =C2=A0 cat <<-\EOF >.gitignore &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0*.ignore
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ignore-dir/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0EOF
> =C2=A0 mkdir src &&
> =C2=A0 touch file.txt src/code.txt &&
> =C2=A0 git add . &&
> =C2=A0 git commit -m 'initial commit' &&
> =C2=A0 touch file-a.ignore src/file-b.ignore &&
> =C2=A0 echo "hello" >src/code.txt &&
> =C2=A0 mkdir ignore-dir &&
> =C2=A0 touch ignore-dir/{file.ignore,file.txt} &&
> =C2=A0 git status &&
> =C2=A0 git stash --all &&
> =C2=A0 git status || echo 'FAILURE'

Noted. Will do.

>> So it quite explicitly states "Not removing ignore-dir/".
>
> That message is from git-clean, and it is the real problem.
>
>> How do I
>> make sure it also stashes the ignore-dir directory?
>
> It actually did stash the ignore-dir, it just didn't remove it from
> the working directory at the end. =C2=A0Try deleting the ignore-dir b=
y
> hand and then applying the stash, ignore-dir and its content should
> be recreated.
>
> Something like this is probably the appropriate fix:
>
> diff --git a/git-stash.sh b/git-stash.sh
> index f4e6f05..a2d4b4d 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -240,7 +240,7 @@ save_stash () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test "$untrack=
ed" =3D "all" && CLEAN_X_OPTION=3D-x || CLEAN_X_OPTION
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test -n "$u=
ntracked"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0then
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 git clean --force --quiet $CLEAN_X_OPTION
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 git clean --force --quiet -d $CLEAN_X_OPTION
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test "$keep=
_index" =3D "t" && test -n $i_tree
>
> Needs tests.

I just tried it with the extra -d and it all seems to work
beautifully. Should your patch be sent anywhere?
