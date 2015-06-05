From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Suggestion: make git checkout safer
Date: Fri, 5 Jun 2015 13:44:50 -0400
Message-ID: <CAPig+cTK4pXgweoGZc1-nj41aYo0bEK6Zrsc9291xQr5v8=p8g@mail.gmail.com>
References: <loom.20150603T104534-909@post.gmane.org>
	<20150603090654.GD32000@peff.net>
	<loom.20150603T110826-777@post.gmane.org>
	<20150603093514.GF32000@peff.net>
	<loom.20150603T114527-151@post.gmane.org>
	<20150603194756.GB29730@vps892.directvps.nl>
	<loom.20150604T124827-124@post.gmane.org>
	<5570B1AC.2060108@web.de>
	<loom.20150605T113129-339@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 19:44:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0vfs-0000Js-DV
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 19:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbbFERow convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2015 13:44:52 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37880 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901AbbFERov convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2015 13:44:51 -0400
Received: by igbsb11 with SMTP id sb11so20062385igb.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 10:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=OWJvn2gZRjFNDTF6qr/gBmj/7pAjEqIl1dNvf9FqGMM=;
        b=Fu7UMIg7IR0965OEmekrH0DhiTyQXRcT4k90WRhKuvwivjF7QFJb2Gem9tIaTpsi+n
         RQYNHR0PtB6dNzV1RyalHzgjsMwdB8BjnKIsmowIVLXKAyPtSY+iF9OtgfR5KGaPHlby
         aIj6HW3lsEaSZEuPrAeomK2Ih9EPNvxxr6juai/xXFnPIudJNr7k1jRmef7ejJ7Z1UDe
         shb/YstBaMz9NbuAgx5ssnoB9iZXTXJq6KREEjRvs85kbq+E2Frhf3cOWk/mHjkb60lv
         YQFxGsmSMamd7TX4z5oLEoVKIVASjOnKreIF/44HWkxY1U9PURqdmPx66tqlkmOIsyzc
         1N7Q==
X-Received: by 10.50.66.174 with SMTP id g14mr17238281igt.7.1433526290658;
 Fri, 05 Jun 2015 10:44:50 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 5 Jun 2015 10:44:50 -0700 (PDT)
In-Reply-To: <loom.20150605T113129-339@post.gmane.org>
X-Google-Sender-Auth: fTQ3gUq2e_a1y6XKNaESqobFk9A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270867>

On Fri, Jun 5, 2015 at 5:32 AM, Ed Avis <eda@waniasset.com> wrote:
> Torsten B=C3=B6gershausen <tboegi <at> web.de> writes:
>>Do you think you can write a patch to improve the documentation ?
>
> Here is my attempt, but it is only a starting point.
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
> index d263a56..ee25354 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -3,7 +3,7 @@ git-checkout(1)
>
>  NAME
>  ----
> -git-checkout - Checkout a branch or paths to the working tree
> +git-checkout - Overwrite working tree files with a given branch

I agree with Duy's suggestion of "switch branches or reset working
tree files" since it explains the high-level purpose of the command,
whereas your wording gives details of the low-level operation without
conveying the high-level purpose.

>  SYNOPSIS
>  --------
> @@ -17,10 +17,11 @@ SYNOPSIS
>
>  DESCRIPTION
>  -----------
> -Updates files in the working tree to match the version in the index
> -or the specified tree.  If no paths are given, 'git checkout' will
> -also update `HEAD` to set the specified branch as the current
> -branch.
> +Updates, creates, or overwrites files in the working tree to match t=
he
> +version in the index or the specified tree.  If no paths are given,
> +'git checkout' will also update `HEAD` to set the specified branch a=
s
> +the current branch, and will keep local changes.

The two changes you made here don't really work together, do they? In
the one case, you changed "Update" to "Update, creates, or
overwrites", and in the second you added "and will keep local changes"
which seems to contradict the "overwrites" bit.

Moreover, as this paragraph is a high-level overview of the modes
enumerated below, it doesn't necessarily make sense to go into such
detail here. For instance, the "git checkout <branch>" case
immediately below this paragraph already says clearly "Local
modifications to the files in the working tree are kept", so repeating
it here seems unnecessary.

> +If paths are given,
> +'git checkout' will unconditionally overwrite local changes.

Likewise, I'm not convinced that it makes sense to add this sentence.
The preceding sentence about updating HEAD applies to all of the
enumerated cases except the "git checkout <pathspec>=E2=80=A6" case, so=
 it
makes sense to have it in the overview paragraph, however, this new
sentence applies only to the one case, so its placement here is
questionable.

>  'git checkout' <branch>::
>         To prepare for working on <branch>, switch to it by updating
> @@ -81,21 +82,24 @@ Omitting <branch> detaches HEAD at the tip of the
> current branch.
>  'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
>
>         When <paths> or `--patch` are given, 'git checkout' does *not=
*
> -       switch branches.  It updates the named paths in the working t=
ree
> -       from the index file or from a named <tree-ish> (most often a
> -       commit).  In this case, the `-b` and `--track` options are
> -       meaningless and giving either of them results in an error.  T=
he
> -       <tree-ish> argument can be used to specify a specific tree-is=
h
> -       (i.e.  commit, tag or tree) to update the index for the given
> -       paths before updating the working tree.
> -+
> -The index may contain unmerged entries because of a previous failed =
merge.
> -By default, if you try to check out such an entry from the index, th=
e
> -checkout operation will fail and nothing will be checked out.
> -Using `-f` will ignore these unmerged entries.  The contents from a
> -specific side of the merge can be checked out of the index by
> -using `--ours` or `--theirs`.  With `-m`, changes made to the workin=
g tree
> -file can be discarded to re-create the original conflicted merge res=
ult.
> +       switch branches.  It overwrites the named paths in the workin=
g
> +       tree from the index file or from a named <tree-ish> (most
> +       often a commit).

Rather than "updates" or "overwrites", how about something like this?

    "It restores the named paths in the working tree
    to a pristine state from the index..."

> +Unlike other modes, local modifications to
> +       the files in the working tree are *not* kept.

This sentence seems utterly redundant with the sentence immediately
preceding it, thus adds noise but no obvious value.

> +        In this case, the `-b` and `--track` options are meaningless
> +       and giving either of them results in an error.  The <tree-ish=
>
> +       argument can be used to specify a specific tree-ish (i.e.
> +       commit, tag or tree) to update the index for the given paths
> +       before updating the working tree.  + The index may contain
> +       unmerged entries because of a previous failed merge.  By
> +       default, if you try to check out such an entry from the index=
,
> +       the checkout operation will fail and nothing will be checked
> +       out.  Using `-f` will ignore these unmerged entries.  The
> +       contents from a specific side of the merge can be checked out
> +       of the index by using `--ours` or `--theirs`.  With `-m`,
> +       changes made to the working tree file can be discarded to
> +       re-create the original conflicted merge result.

A couple issues:

In order for this to format correctly in Asciidoc, it must be
unindented (as in the original), and you must keep the unindented "+"
on the line by itself before the paragraph to tie it to the preceding
paragraph.

You mis-wrapped and combined two formerly separate paragraphs into
one. Notice the "+ The" in the middle of your re-wrapped paragraph.

>  OPTIONS
>  -------
> @@ -110,7 +114,9 @@ OPTIONS
>         local changes.
>  +
>  When checking out paths from the index, do not fail upon unmerged
> -entries; instead, unmerged entries are ignored.
> +entries; instead, unmerged entries are ignored.  (Note that when
> +checking out paths, local changes are thrown away whether or not
> +this flag is given.)

I don't see what value this change adds. The description of "git
checkout <pathspec>=E2=80=A6" already explains that named paths are res=
tored
to a pristine state, so talking about it here may give the false
impression that the reader must be aware that something unusual or
unexpected is going on beyond what was already documented.

>  --ours::
>  --theirs::
> @@ -481,10 +487,10 @@ $ git checkout hello.c            <3>
>  ------------
>  +
>  <1> switch branch
> -<2> take a file out of another commit
> -<3> restore hello.c from the index
> +<2> take a file out of another commit, overwriting any local changes
> +<3> restore hello.c from the index (would overwrite it if it existed=
)

Again, I don't see what value these changes add. These
example-specific notes are intended to explain what is happening in
the example. These new clauses don't do that, thus making them
potentially confusing.

To really convey that local changes will be overwritten, how about
adding a new example which demonstrates it explicitly?

> -If you want to check out _all_ C source files out of the index,
> +If you want to revert _all_ C source files out of the index,
>  you can say

How about?

    If you want to restore _all_ C source files to a
    pristine state from the index, you can say

>  +
>  ------------
> @@ -492,7 +498,7 @@ $ git checkout -- '*.c'
>  ------------
>  +
>  Note the quotes around `*.c`.  The file `hello.c` will also be
> -checked out, even though it is no longer in the working tree,
> +created, even though it is no longer in the working tree,

Again:

    ...`hello.c` will also be restored,...

>  because the file globbing is used to match entries in the index
>  (not in the working tree by the shell).
