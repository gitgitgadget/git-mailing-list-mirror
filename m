From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] Added recurse command to git submodule
Date: Tue, 8 Jan 2008 12:57:12 +0600
Message-ID: <7bfdc29a0801072257m14fa739el618c932fb38b61fe@mail.gmail.com>
References: <7bfdc29a0801071914s207be500veae8e507d7d9d29@mail.gmail.com>
	 <7v3at8yiq4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 07:57:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC8P8-0001vw-Ip
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 07:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339AbYAHG5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 01:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755266AbYAHG5P
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 01:57:15 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:36376 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170AbYAHG5O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 01:57:14 -0500
Received: by fk-out-0910.google.com with SMTP id z23so8957164fkz.5
        for <git@vger.kernel.org>; Mon, 07 Jan 2008 22:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fdgJ8fgxwYpUNgP4uTODeubR8gZdVXgvJLqUPPqtay8=;
        b=DcBnvN9ZVODTWNpgmaOC/eSoJJEMQmWUksvySuVnF5jbe1aJkKUosfGihnrbWk+s7iP0+uFT/k1QfahlYdyyAINH0QrY934WR5/IUF+c4lHytTaz9QtxAi+dAi8eXwgdJyY4hxJzjjeiemKsXGAUQ6ASCYq4L1AZBWeKhkl4E8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jZi2Y0qd4/kf1fjYLv+CkbYmi9kIGO+B/YosGceoVHhF/jX/NnoYFz7LkE3iDX5jdAb6AdljuoxDur/gfl6bDL9sbi+z4d2yKwTqTOljJ4x9v8fPb8elaV2u3jxxQrs8aXSvBbUJ6n1yZZcsKW75TaNxU7uBnZY8+aNkRhf9xKs=
Received: by 10.78.138.14 with SMTP id l14mr20672944hud.23.1199775432095;
        Mon, 07 Jan 2008 22:57:12 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Mon, 7 Jan 2008 22:57:12 -0800 (PST)
In-Reply-To: <7v3at8yiq4.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69843>

Hi Junio,

Thanks for the comments.
FIrstly, yes I did not mean for inclusion right now, but rather for
comment. I am already working with the branched out versions of the
files.
Secondly, I should apologize for messing the patches, as I read the
SubmittingPatches actually after sending out the patches. From next
time, I will try to follow the document strictly.
Sorry for mixing camel case, being a Java developer I always tend to
use them, but will fix them right now :). Will be also changing the
comments. I will also change the for loop to as you suggested.
Thanks a lot for the chdir solution. I actually did not that it could
be done; that saves a lot of effort. Will surely change it
accordingly.
I was actually not planning to introduce git submodule init
--recursive or git submodule update --recursive; but I will also
introduce it. Just wanted to clarify that only git submodule init will
behave as it used to earlier and there is no recursion involved.

>
> > +                             arg="\"$arg\""
> > +                     fi
> > +                     command_arguments="$command_arguments $arg"
> > +             done
> > +             if [ $recurse_verbose -eq 1 ]; then
> > +                     echo GIT Command git-$git_command with arguments\($#\) "$command_arguments"
> > +             fi
> > +             main_command="git-$git_command $command_arguments"
> > +             eval $main_command
>
> This feels like a sloppy quoting, although I haven't looked at
> the code very deeply.  Does it work when $arg has funny letters
> like backslash, double-quote and or backquote?

it does work if $arg has double-quote (commit -m "commit message"), I
will also test with the other 2 characters you mentioned.

I just wanted to confirm that I will submit the patch for commands of
submodule by today. I do agree with having --recursive option with all
the commands, but, IMHO, as it is particularly useful for submodules
only it also makes sense if it is a separate command for submodule.

At first I will make the command change and send the patch today and
then make the other patches and send them over.

Thank you once again for the hints.

Imran

On Jan 8, 2008 11:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Imran M Yousuf" <imyousuf@gmail.com> writes:
>
> > Following is the diff with git-submdoule version 1.5.3.7. I also
> > attached the diff and the modified file in the attachment.
>
> Please do not do this when the submission is for real (I think
> you did not mean this for inclusion but for comment so it is Ok
> this time around), as such a message cannot be processed with
> our automated tools but need to be applied by hand.
>
> Just send a non whitespace-corrupted, plain text patch.  A
> corrupt text patch followed by an attachment is the worst of
> both worlds.
>
> > @@ -251,6 +252,78 @@ modules_list()
> >       done
> >  }
> >
> > +# Simply checks whether the submodule is initialized
> > +# or not. If not initialized it does so.
> > +initializeSubModule() {
> > +     if [ ! -d "$1"/.git ]; then
> > +             if [ $recurse_verbose -eq 1 ]; then
> > +                     echo Initializing and updating "$1"
> > +             fi
> > +             git-submodule init "$1"; git-submodule update "$1"
> > +     fi
> > +}
>
> The comment above sounds quite wrong, isn't it?  It is not just
> "simply check" but actively makes sure it is initialized.
>
> Do we use CamelCase in our shell script?
>
> Making -r to always recurse _fully_ feels quite wrong.  It is
> one thing to allow "git submodule init --recursive" to recurse
> fully and initialize everything, but it is another thing to
> force full instantiation of submodules that the user _chose_ not
> to check out, when the user has checkout of some but not all
> submodules and asks "git submodule update --recursive".
>
> > +# This actually traverses the module; checks
> > +# whether the module is initialized or not.
> > +# if not initialized, then done so and then the
> > +# intended command is evaluated. Then it
> > +# recursively goes into it modules.
> > +traverseModule() {
> > +     current_dir=`pwd`
> > +     dir_path="$current_dir:$dir_path"
> > +     initializeSubModule "$1"
> > +        cd "$1"
> > +     if [ $recurse_verbose -eq 1 ]; then
> > +             echo Working in mod $1 @ `pwd` with $2
> > +     fi
>
> Always quote variable references unless you mean you want field
> splitting.  Even when you know $1 and $2 do not have IFS
> characters, to make it easier to readers.
>
> > +        eval "$2"
> > +     if [ -f .gitmodules ]; then
> > +                for mod_path in `grep "path =" .gitmodules | awk
> > '{print $3}'`; do
> > +                        traverseModule "$mod_path" "$2"
> > +                done
> > +        fi
> > +     old_dir=$(echo $dir_path | cut -d':' -f1-1)
> > +     length_old_dir=`expr "$old_dir" : '.*'`
> > +     cd $old_dir
> > +     index=$(echo "$length_old_dir+2" | bc)
> > +     dir_path=`echo $dir_path $index | awk '{print substr($1, $2)}'`
>
> This dir_path separated with ":" and shuffling the $cwd with
> chdir'ing around makes me say "Yuck".  Is it essential that
> these operation in the submodule happen in the same process?
> IOW, wouldn't it be enough to do something like:
>
>
>         initialize_submodule "$1"
>         (
>                 cd "$1"
>                 if test -n "$recursive_verbose"
>                 then
>                         echo "Working in module $1 with $2"
>                 fi
>                 eval "$2"
>                 if test -f .gitmodules
>                 then
>                         for p in `sed -n -e 's/^path = //p' .gitmodules`
>                         do
>                                 traverse_module "$p" "$2"
>                         done
>                 fi
>         )
>
> > +}
> > +
> > +# Propagates or recurses over all the submodules at any
> > +# depth with any git command, e.g. git-clone, git-status,
> > +# git-commit etc., with the arguments supplied exactly as
> > +# it would have been supplied to the command otherwise.
> > +# This actually starts the recursive propagation
> > +propagate() {
> > +     project_home=`pwd`
> > +     echo Project Home: $project_home
> > +     if [ -d $project_home/.git/ ]; then
> > +             git_command=$1
> > +             shift
> > +             command_arguments=""
> > +             for arg in "$@"; do
>
> That 'in "$@"' is distracting.
>
>         for arg
>         do
>                 ...
>
> is enough.
>
> > +                     if [ `expr index "$arg" ' '` -gt 0 ]; then
>
> Do we ever use `expr index` anywhere else?  I thought we fixed
> that non-portability.
>
> > +                             arg="\"$arg\""
> > +                     fi
> > +                     command_arguments="$command_arguments $arg"
> > +             done
> > +             if [ $recurse_verbose -eq 1 ]; then
> > +                     echo GIT Command git-$git_command with arguments\($#\) "$command_arguments"
> > +             fi
> > +             main_command="git-$git_command $command_arguments"
> > +             eval $main_command
>
> This feels like a sloppy quoting, although I haven't looked at
> the code very deeply.  Does it work when $arg has funny letters
> like backslash, double-quote and or backquote?
>
> > @@ -286,6 +359,17 @@ do
> >       -*)
> >               usage
> >               ;;
> > +     recurse)
> > +             recurse=1
> > +             case "$2" in
> > +                     -v)
> > +                             recurse_verbose=1
> > +                             shift
> > +                             ;;
> > +             esac
> > +             shift
> > +             break
> > +             ;;
>
> I was ahead of myself earlier but I think it makes more sense to
> pretend (at the command line syntax level) that --recursive is
> an option to other commands.
>
> > @@ -303,17 +387,21 @@ case "$add,$branch" in
> >       ;;
> >  esac
> >
> > -case "$add,$init,$update,$status,$cached" in
> > -1,,,,)
> > +
> > +case "$add,$init,$update,$recurse,$status,$cached" in
> > +1,,,,,)
> >       module_add "$@"
> >       ;;
> > -,1,,,)
> > +,1,,,,)
> >       modules_init "$@"
> >       ;;
> > -,,1,,)
> > +,,1,,,)
> >       modules_update "$@"
> >       ;;
> > -,,,*,*)
> > +,,,1,,)
> > +     propagate "$@"
> > +     ;;
> > +,,,,*,*)
> >       modules_list "$@"
> >       ;;
> >  *)
>
> I've always hated this part of the script.  How about a bit of
> clean-up patch first before adding $recurse or anything else, to
> introduce command variable and do:
>
>         case "$command" in
>         add)
>                 module_add "$@"
>                 ;;
>         init)
>                 module_init "$@"
>                 ;;
>                 ...
>         *)
>                 modules_list "$@"
>                 ;;
>         esac
>
> or even just a single:
>
>         "module_$command" "$@"
>
>
>



-- 
Imran M Yousuf
