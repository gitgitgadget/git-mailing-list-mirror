From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase [-i --exec | -ix] <CMD>...
Date: Mon, 04 Jun 2012 10:42:41 -0700
Message-ID: <7vhaurt1m6.fsf@alter.siamese.dyndns.org>
References: <1338817674-22877-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 04 19:42:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbbIn-0001UW-O8
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 19:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666Ab2FDRmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 13:42:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478Ab2FDRmo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 13:42:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 974D68A6A;
	Mon,  4 Jun 2012 13:42:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tFqfQAZ4VTPY26oHMGB7Zi+1Gp4=; b=fNmt5D
	hKv5Puy5CVME8DikOmcrq+WyyVhS4MHAo0bkg+MURbvjz1/Q+NWdo79EcJLyBQDy
	svS8DdRxJ/xNHG/3KcHzzM56CuD94/gTwgJ/w7t26Uv2zjnQoO+4oJWDiloMjSsP
	P94aCZccs8XlE4X/C2hXWUk4Ef/LqwMMkYp1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YZuUPDxrXZ3uOOEPxMuNruYYC7j1kZei
	AydAnHPBdbalT9w23Kul985ohdE9Djk6EpSeZaEPAeKaYy+ubIykgmHt4A1xrv/E
	m1+FE7Nk3MqvRH0EjTX4YtaGnbsHzyKjbvkVnsevsRtOH0eAGQqAeSdRlBUl5wRw
	QeQMdxZ4UKw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89FF78A68;
	Mon,  4 Jun 2012 13:42:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D47C68A66; Mon,  4 Jun 2012
 13:42:42 -0400 (EDT)
In-Reply-To: <1338817674-22877-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 (Kong Lucien's message of "Mon, 4 Jun 2012 15:47:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AFE96576-AE6C-11E1-B7DD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199160>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 147fa1a..96dbf26 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -210,6 +210,17 @@ rebase.autosquash::
>  
>  OPTIONS
>  -------
> +<cmd>::
> +	Shell command executed between each commit applications. The
> +	--exec option has to be specified.
> ++
> +You may execute several commands between each commit applications.
> +Therefore, you can use one instance of exec:
> +	git rebase -i --exec "cmd1; cmd2; ...".
> +You can also insert several instances of exec, if you wish to
> +only have one command per line for example:
> +	git rebase -i --exec "cmd1" --exec "cmd2" ...
> +

The description of this and exisitng <newbase> look very odd.  The
usual way to describe an option that take a parameter in the OPTIONS
section is to instead do:

	--onto <newbase>::
		Description of what --onto option does and how <newbase>
		is used in what it does.

	--exec <cmd>::
		Description of what --exec option does, and how	<cmd> 
                is used in what it does.

> @@ -336,6 +347,13 @@ link:howto/revert-a-faulty-me
>  	user edit that list before rebasing.  This mode can also be used to
>  	split commits (see SPLITTING COMMITS below).
>  
> +-x::
> +--exec::
> +	Automatically add "exec" followed by <cmd> between each commit
> +	applications (see INTERACTIVE MODE below).
> ++
> +This has to be used along with the `--interactive` option explicitly.
> +

OK.

> @@ -521,6 +539,27 @@ in `$SHELL`, or the default shell if
> ...
> +If the option '-i' is missing, The command will return the usage page
> +of "git rebase". Same if there is no <cmd> specified behind --exec.

OK.

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 0c19b7c..7444160 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -876,6 +876,19 @@ cat >> "$todo" << EOF
>  #
>  EOF
>  
> +if test -n "$cmd"
> +then
> +	OIFS=$IFS
> +	IFS=','
> +	for i in $cmd
> +	do
> +		sed "/^pick .*/aexec $i" "$todo" >tmp
> +		cat tmp >"$todo"
> +	done
> +	rm tmp
> +	IFS=$OIFS
> +fi

Where does this "we split at comma", implying "the user is forbidden
to have a comma in the executed command and its arguments" come
from?

A more conventional way that would be less troublesome in the real
life is to use LF instead in a case like this (and git-rebase.sh
already defines it for exactly a case like this).

I am not sure if that "aexec" is portable outside GNUism, though.
Traditionally the a(ppend) command is spelled like this:

	[1addr]a\
        text

to write one line (cf. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html#tag_20_116_13_03).

Why is "pick" special?  Don't you want to run the commands after
"edit", "reword", "squash", "fixup"?

This should come immediately after autosquash rearranged the insns
in the $todo file, before the help text is appended to it.

> diff --git a/git-rebase.sh b/git-rebase.sh
> index 24a2840..a8b1793 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -76,6 +78,7 @@ If you would prefer to skip this patch, instead run \"git rebase --skip\".
>  To check out the original branch and stop rebasing run \"git rebase --abort\".
>  "
>  unset onto
> +unset cmd
>  strategy=
>  strategy_opts=
>  do_merge=

You copied badness from the existing "unset onto"; I do not think
the rest of the code (and especially the new code you add) treats a
variable that is not set and set to an empty string any different,
and setting it to empty is the right thing to do in such a case.

> @@ -219,6 +222,24 @@ do
>  		onto="$2"
>  		shift
>  		;;
> +	-x)
> +		exec_flag=true

exec_flag is not cleared at the beginning of the script, so if the
command is run without "-x" on the command line, it can have
whatever garbage value that was in the environment.  You know that
$cmd is empty if "-x" was not given, and you can make sure $cmd
becomes non-empty when "-x" is given, so remove use of this variable
and replace any 'test -n "$exec_flag"' with 'test -n "$cmd"'.

> +		test 3 -le "$#" || usage

Why 3?  You only care about the presense of $2 you are about to
read, no?

> +		if orig_head=$(git rev-parse -q --verify "$2") ||
> +		   test `expr substr "$2" 1 1` = -
> +		then
> +			echo "You must specify a command after --exec option\n"
> +			usage
> +		else
> +			if test -n "$cmd"
> +			then
> +				cmd="$2,$cmd"
> +			else
> +				cmd="$2"
> +			fi
> +		fi
> +		shift
> +		;;

Are you telling me that I cannot have a branch named "make"?  Drop
this nonsense, and just write it in a more straightforward way, e.g.

	-x)
		test 2 -le "$#" || usage
                cmd="${cmd:+"$cmd$LF"} $2"
                shift
                ;;
                
>  	-i)
>  		interactive_rebase=explicit
>  		;;
> @@ -304,6 +325,13 @@ do
>  done
>  test $# -gt 2 && usage
>  
> +if test -n "$exec_flag" &&
> +   test -z "$interactive_rebase"
> +then

I think this should be

	if test -n "$cmd" && test "$interactive_rebase" != explicit
        then

> @@ -348,7 +376,6 @@ abort)
>  	exit
>  	;;
>  esac
> -
>  # Make sure no rebase is in progress
>  if test -n "$in_progress"
>  then

Why?
