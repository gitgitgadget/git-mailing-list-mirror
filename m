From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH v2] contrib: added git-diffall
Date: Thu, 23 Feb 2012 11:07:17 -0500
Message-ID: <CAFouetiSpsZGtLt2tG4ou-H18zigNx5xWQH4cy8GrL1eDxbjJw@mail.gmail.com>
References: <1329948749-5908-1-git-send-email-tim.henigan@gmail.com>
	<7vipiy8m5q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, davvid@gmail.com, stefano.lattarini@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 17:07:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0bCY-0001hZ-Kr
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 17:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401Ab2BWQHT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 11:07:19 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61008 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab2BWQHS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2012 11:07:18 -0500
Received: by yenm8 with SMTP id m8so655513yen.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 08:07:17 -0800 (PST)
Received-SPF: pass (google.com: domain of tim.henigan@gmail.com designates 10.50.100.202 as permitted sender) client-ip=10.50.100.202;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tim.henigan@gmail.com designates 10.50.100.202 as permitted sender) smtp.mail=tim.henigan@gmail.com; dkim=pass header.i=tim.henigan@gmail.com
Received: from mr.google.com ([10.50.100.202])
        by 10.50.100.202 with SMTP id fa10mr2325119igb.10.1330013237794 (num_hops = 1);
        Thu, 23 Feb 2012 08:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=e3NrjVoLceMjVqePhyTwiyqe9Akp+ej0SfX8RIrW4mc=;
        b=blNuuUxipygrcLNqfrRWgatPaM7Q2anjaPPp39rY+DgwLduMfYTttIWwcf/KC0AMGG
         3jkmaJJAcqPcvlNrNemr9E4WKd5/Ibh3Ic9qcvbCVYM3VbBtytfjIhqjXuv5B4RCcm0V
         ayVKhWR3FwVBIR7j/BQ8fNqnqWnNpFRoF7b8E=
Received: by 10.50.100.202 with SMTP id fa10mr1956619igb.10.1330013237579;
 Thu, 23 Feb 2012 08:07:17 -0800 (PST)
Received: by 10.42.220.136 with HTTP; Thu, 23 Feb 2012 08:07:17 -0800 (PST)
In-Reply-To: <7vipiy8m5q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191378>

On Wed, Feb 22, 2012 at 6:48 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
> We encourage our log messages to describe the problem first and then
> present solution to the problem, so I would update the above perhaps =
like
> this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0The 'git difftool' command lets the user t=
o use an external tool
> =C2=A0 =C2=A0 =C2=A0 =C2=A0to view diffs, but it runs the tool for on=
e file at the time. This
> =C2=A0 =C2=A0 =C2=A0 =C2=A0makes it tedious to review a change that s=
pans multiple files.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0The "git-diffall" script instead prepares =
temporary directories
> =C2=A0 =C2=A0 =C2=A0 =C2=A0with preimage and postimage files, and lau=
nches a single instance
> =C2=A0 =C2=A0 =C2=A0 =C2=A0of an external diff tool to view the diffe=
rences in them.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0diff.tool or merge.tool configuration vari=
able is used to specify
> =C2=A0 =C2=A0 =C2=A0 =C2=A0what external tool is used.

Understood.  I will update in v3.


> I am wondering if reusing "diff.tool" or "merge.tool" is a good idea,
> though.
>
> I guess that it is OK to assume that any external tool that can compa=
re
> two directories MUST be able to compare two individual files, and if =
that
> is true, it is perfectly fine to reuse the configuration. =C2=A0But i=
f an
> external tool "frobdiff" that can compare two directories cannot comp=
are
> two individual files, it will make it impossible for the user to run =
"git
> difftool" if diff.tool is set to "frobdiff" to use with "diffall".
>
> Another thing that comes to my mind is if a user has an external tool=
 that
> can use "diffall", is there ever a situation where the user chooses t=
o use
> "difftool" instead, to go files one by one. =C2=A0I cannot offhand im=
agine any.

It was my assumption that any tool that supports directory diff also
supports individual file diff.  It seems like a strict subset of
directory diff case.


> Perhaps a longer term integration plan may be to lift the logic from =
this
>
=2E..snip...
>
> But that is all two steps in the future.

I hope that this feature finds it way into the existing core commands.
 This script is intended to be a conversation starter that is also
immediately useful as a separate command.  Would it be better to begin
the long-term discussion now and skip adding this to contrib?


>> +# mktemp is not available on all platforms (missing from msysgit)
>> +# Use a hard-coded tmp dir if it is not available
>> +tmp=3D"$(mktemp -d -t tmp.XXXXXX 2>/dev/null)" || {
>> + =C2=A0 =C2=A0 tmp=3D/tmp/git-diffall-tmp
>> +}
>
> It would not withstand malicious attacks, but doing
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp=3D/tmp/git-diffall-tmp.$$
>
> would at least protect you from accidental name crashes better in the
> fallback codepath.

This makes sense.  I will add a unique portion to the name of the tmp d=
ir in v3.


>> +trap 'rm -rf "$tmp" 2>/dev/null' EXIT
>
> Do you need to suppress errors, especially when you are running "rm -=
rf"
> with the 'f' option?

On msysgit, I found that "rm -rf $tmp" consistently fails due with a
permission error.  I don't understand why the script that created the
tmp dir is not allowed to delete it.  I am still looking into it, but
so far it appears to be an idiosyncrasy of msysgit.


>> +left=3D
>> +right=3D
>> +paths=3D
>> +path_sep=3D
>> +compare_staged=3D
>> +common_ancestor=3D
>> +left_dir=3D
>> +right_dir=3D
>> +diff_tool=3D
>> +copy_back=3D
>
> You can write multiple assignment on a line to save vertical space if=
 you
> want to, and the initialization sequence like this is a good place to=
 do
> so.

My personal preference is to keep them on separate lines.  However if
the compressed style is preferred, I will change it.


>> + =C2=A0 =C2=A0 -x|--e|--ex|--ext|--extc|--extcm|--extcmd)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diff_tool=3D$2
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shift
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;
>
> What if your command line ends with -x without $2?

Currently it results in a shift error with no useful message to the
user.  I will add something for this in v3.


> Don't you want to match "-t/--tool" that "difftool" already uses?

Are you suggesting that I a) change "-x/--extcmd" to "-t/--tool" or
that b) I add support for the "difftool -t/--tool" option?

If "a", I was reusing the "difftool --extcmd" option which has the
same behavior.  If "b", I will look into it.


>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # could be commit, commi=
t range or path limiter
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case "$1" in
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *...*)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 left=3D${1%...*}
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 right=3D${1#*...}
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 common_ancestor=3D1
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ;;
>
> Strictly speaking, that is not just a common_ancestor but is a merge_=
base,
> which is a common ancestor none of whose children is a common ancesto=
r.

Understood.  I will change the name to "merge_base" in v3.


>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *..*)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 left=3D${1%..*}
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 right=3D${1#*..}
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ;;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if test -n "$path_sep"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 paths=3D"$paths$1 "
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 elif test -z "$left"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 left=3D$1
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 elif test -z "$right"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 right=3D$1
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 paths=3D"$paths$1 "
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 fi
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ;;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 esac
>
> Hrm, so "diffall HEAD~2 Documentation/" is not the way to compare the
> contents of the Documentation/ directory between the named commit and
> the working tree, like "diff HEAD~2 Documentation/" does.
>
> That is not a show-stopper (a double-dash is an easy workaround), but
> it is worth pointing out.

So I would need something to determine if a string represents a
commit/tag/branch or a path?.  I presume it would need to handle the
corner case where a branch/tag and path have the same name.  Is there
anything like this in the mergetool lib scripts today?


>> + =C2=A0 =C2=A0 then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git diff --name-only "$l=
eft"..."$right" -- $paths > "$tmp/filelist"
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git diff --name-only "$l=
eft" "$right" -- $paths > "$tmp/filelist"
>> + =C2=A0 =C2=A0 fi
>
> And this will not work with pathspec that have $IFS characters. =C2=A0=
If we
> really wanted to we could do that by properly quoting "$1" when you b=
uild
> $paths and then use eval when you run "git diff" here (look for 'sq' =
and
> 'eval' in existing scripts, e.g. "git-am.sh", if you are interested).
>
> Also you may want to write filelist using -z format to protect yourse=
lf
> from paths that contain LF, but that would require the loop "while re=
ad
> name" to be rewritten.

I just discovered that the script fails to handle files that have
spaces in their name, so some further work is needed.


>> +# Exit immediately if there are no diffs
>> +if test ! -s "$tmp/filelist"
>> +then
>> + =C2=A0 =C2=A0 exit 0
>> +fi
>
> Ok, you have trap set already so $tmp will disappear with this exit ;=
-)

I'll try not to be such a slow learner in the future...but no guarantee=
s.


>> +if test -n "$copy_back" && test "$right_dir" !=3D "working_tree"
>> +then
>> + =C2=A0 =C2=A0 echo "--copy-back is only valid when diff includes t=
he working tree."
>> + =C2=A0 =C2=A0 exit 1
>> +fi
>
> I actually wondered why $right_dir needs to be populated with a copy =
in
> the first place (if you do not copy but give the working tree itself =
to
> the external tool, you do not even have to copy back).
>
> I know the answer to the question, namely, "because the external tool
> thinks files that are not in $left_dir are added files", but if you c=
an
> find a way to tell the external tool to ignore new files (similar to =
how
> "diff -r" without -N works), running the tool with temporary left_dir=
 and
> the true workdir as right_dir would be a lot cleaner solution to the
> problem.

I'll note this as "for future consideration".  I spent some time
trying this is the original implementation, but could not find a
workable solution in the time I had available.


>> + =C2=A0 =C2=A0 while read name
>> + =C2=A0 =C2=A0 do
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ls_list=3D$(git ls-tree =
$right $name)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if test -n "$ls_list"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mkdir -p "$tmp/$right_dir/$(dirname "$name")"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 git show "$right":"$name" > "$tmp/$right_dir/$name" || true
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi
>> + =C2=A0 =C2=A0 done < "$tmp/filelist"
>
> "while read -r name" might make this slightly more robust; even thoug=
h
> this loses leading and trailing whitespaces in filenames, we probably
> can get away without worrying about them.
>
>> +else
>> + =C2=A0 =C2=A0 # Mac users have gnutar rather than tar
>> + =C2=A0 =C2=A0 (tar --ignore-failed-read -c -T "$tmp/filelist" | (c=
d "$tmp/$right_dir" && tar -x)) || {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutar --ignore-failed-r=
ead -c -T "$tmp/filelist" | (cd "$tmp/$right_dir" && gnutar -x)
>> + =C2=A0 =C2=A0 }
>
> What is this "--ignore-failed-read" about? =C2=A0Not reporting unread=
able as an
> error smells really bad.

If a file was added or deleted between the two commits being compared,
tar would fail because a file was missing from "$tmp/filelist".  The
"--ignore-failed-read" prevents tar from halting the script in this
case.


> If you require GNUism in your tar usage, this should be made configur=
able
> so that people can use alternative names (some systems come with "tar=
"
> that is POSIX and "gtar" that is GNU).

Is there an example showing how this could be configurable?  The
problem is that the "--ignore-failed-read" was not supported in all
flavors of tar.


>> +# Copy files back to the working dir, if requested
>> +if test -n "$copy_back" && test "$right_dir" =3D "working_tree"
>> +then
>> + =C2=A0 =C2=A0 cd "$start_dir"
>> + =C2=A0 =C2=A0 git_top_dir=3D$(git rev-parse --show-toplevel)
>> + =C2=A0 =C2=A0 find "$tmp/$right_dir" -type f |
>> + =C2=A0 =C2=A0 while read file
>> + =C2=A0 =C2=A0 do
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cp "$file" "$git_top_dir=
/${file#$tmp/$right_dir/}"
>> + =C2=A0 =C2=A0 done
>> +fi
>
> This will copy new files created in $right_dir. =C2=A0Is that intende=
d?

hmmm...that was not intended.  If would be odd for the user to create
new files in this tmp directory, but if the diff tool automatically
generates any files then this could result in unwanted files.
