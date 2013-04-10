From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: add verbose mode for add/update
Date: Wed, 10 Apr 2013 22:00:42 +0200
Message-ID: <5165C4EA.60308@web.de>
References: <1365618262-8024-1-git-send-email-orgads@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 22:00:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ1CO-0002g2-Jr
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936029Ab3DJUAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:00:48 -0400
Received: from mout.web.de ([212.227.15.4]:62768 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934822Ab3DJUAr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:00:47 -0400
Received: from [192.168.178.41] ([79.193.81.26]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MIvXZ-1URx8Z0Nyb-002Kj5; Wed, 10 Apr 2013 22:00:46
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <1365618262-8024-1-git-send-email-orgads@gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:vqixkwT5CWyGqxHSzUBWNScEnqZW8GUuaEWKoVi+ytC
 U5hpsUup8IXl9JkHLeokr9buavFNaIF4GB7OqMmY+PBw0xPfz6
 E6kbNulYhAQb7a4HdjDAWOJxqiRuTXmnzH3lCZsAp8838gDxvA
 816q2h9oDFsyY/98/F6fWkoubdQWJ6ySFMdK02nHE4cnHmFcIy
 IEjpTn8skzdVN2dlOQhpA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220743>

Am 10.04.2013 20:24, schrieb Orgad Shaneh:
> Executes checkout without -q

Nice, looks like you picked the proposal I made last September:
  http://permalink.gmane.org/gmane.comp.version-control.git/204747

The change is looking good, but you still need to document the
new option in Documentation/git-submodule.txt too please.

And the commit message is still too short, as I said in that
other thread:

On Tue, Sep 4, 2012 at 6:28 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Before the "Signed-off-by" is the place where you should have
> explained why this would be a worthwhile change ;-)

And you answered to that with something that would really make
sense as first part of the commit message, because you explain
*why* you do that change:

Am 05.09.2012 13:42, schrieb Orgad and Raizel Shaneh:
> When I run 'git submodule update' I don't expect to be in the dark
> until the submodule/s finishes checkout, this sometimes can take a
> significant amount of time and feedback is expected.

Another paragraph after that should explain *how* you do it.

So what about the following as commit message:
--------------------------------------------------------------
When 'git submodule add/update' is run there is no output during
checkout. This can take a significant amount of time and it would
be nice if user could enable some feedback to see what's going on.

Add the -v/--verbose option to both add and update which suppresses
the -q normally given to checkout so the user sees progress output
from the checkout command.

<Your Signed-off-by goes here>
--------------------------------------------------------------

I'm looking forward to your next iteration.

> ---
>  git-submodule.sh |   24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 79bfaac..f7964ad 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -5,11 +5,11 @@
>  # Copyright (c) 2007 Lars Hjemli
>  
>  dashless=$(basename "$0" | sed -e 's/-/ /')
> -USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
> +USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [-v|--verbose] [--] <repository> [<path>]
>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] init [--] [<path>...]
>     or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
> -   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
> +   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [-v|--verbose] [--] [<path>...]
>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
>     or: $dashless [--quiet] foreach [--recursive] <command>
>     or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
> @@ -309,6 +309,9 @@ cmd_add()
>  			custom_name=$2
>  			shift
>  			;;
> +		-v|--verbose)
> +			VERBOSE=1
> +			;;
>  		--)
>  			shift
>  			break
> @@ -408,11 +411,15 @@ Use -f if you really want to add it." >&2
>  		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" || exit
>  		(
>  			clear_local_git_env
> +			if test -z "$VERBOSE"
> +			then
> +				subquiet=-q
> +			fi
>  			cd "$sm_path" &&
>  			# ash fails to wordsplit ${branch:+-b "$branch"...}
>  			case "$branch" in
> -			'') git checkout -f -q ;;
> -			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
> +			'') git checkout -f $subquiet ;;
> +			?*) git checkout -f $subquiet -B "$branch" "origin/$branch" ;;
>  			esac
>  		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
>  	fi
> @@ -676,6 +683,9 @@ cmd_update()
>  		--checkout)
>  			update="checkout"
>  			;;
> +		-v|--verbose)
> +			VERBOSE=1
> +			;;
>  		--)
>  			shift
>  			break
> @@ -799,7 +809,11 @@ Maybe you want to use 'update --init'?")"
>  				must_die_on_failure=yes
>  				;;
>  			*)
> -				command="git checkout $subforce -q"
> +				if test -z "$VERBOSE"
> +				then
> +					subquiet=-q
> +				fi
> +				command="git checkout $subforce $subquiet"
>  				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$prefix\$sm_path'")"
>  				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': checked out '\$sha1'")"
>  				;;
> 
