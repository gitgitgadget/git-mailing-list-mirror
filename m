From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] git-submodule.sh: Add Custom argument input support to git submodule recurse subcommand
Date: Mon, 5 May 2008 15:07:56 +0600
Message-ID: <7bfdc29a0805050207i7978043u6084cf328be4bec4@mail.gmail.com>
References: <1209977051-25896-1-git-send-email-imyousuf@gmail.com>
	 <1209977051-25896-2-git-send-email-imyousuf@gmail.com>
	 <1209977051-25896-3-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 11:08:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jswgh-0004FO-He
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 11:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366AbYEEJH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 05:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755296AbYEEJH7
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 05:07:59 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:49767 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755062AbYEEJH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 05:07:58 -0400
Received: by fk-out-0910.google.com with SMTP id 18so586802fkq.5
        for <git@vger.kernel.org>; Mon, 05 May 2008 02:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uCnKZB0mwc1UJ76Moir6JAHaaUdLtvIGqf3mZYyJrc0=;
        b=MVu2HUcVIZBgTwLmezVOViSt36EKKbbj/J2lErcx6hRabkl9gRWsMc1SKWOXk+oWyvD62aHRqSKy/psXco20+oRr7zWHLxF+UJRc+spsDVhkjRscNjgKmmEptmx4OUpBQwkYXl6tXxr0TFc7rZPRN0v+seqEWDexbMPMkLrMgBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gzMu+G6yrhrw6LyH6DK1tXJY9K/HgxDCOBSR3zapPFfw0Z3jABnGU+cnCrK/SopNbYcdJc9mRjR4cI6XGGeiFScxowbfUJFXPIsw2qmUrLsbJleGJ3O8MSdGZcsjNBIfC5PJuM+Xu5yA47pASo2XqtjmQyCixg/jyHUM1K6i/ao=
Received: by 10.78.137.14 with SMTP id k14mr1557928hud.9.1209978476174;
        Mon, 05 May 2008 02:07:56 -0700 (PDT)
Received: by 10.78.75.8 with HTTP; Mon, 5 May 2008 02:07:56 -0700 (PDT)
In-Reply-To: <1209977051-25896-3-git-send-email-imyousuf@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81254>

Sorry for the inconvenience, but please ignore this patch as it was
not generated with -n and version number :(.

- best regards,

Imran


On Mon, May 5, 2008 at 2:44 PM,  <imyousuf@gmail.com> wrote:
> From: Imran M Yousuf <imyousuf@smartitengineering.com>
>
>  There is a scenario which has been put forward several times in
>  discussion over the recurse subcommand and it is that commands chould have
>  different arguments for different modules.
>
>  For example, one module could want to checkout 'master', while another might want
>  to checkout 'work'. The [-a|--customized-argument] argument provides platform
>  just for that. Consider the following command and its followup for further info:
>
>         git submodule recurse -a checkout
>
>         Submodule b is not initialized and skipped
>         git submodule recurse a checkout
>         Please provide an argument: master
>         Press y to provide another arg...
>         git checkout master
>         Already on branch "master"
>         Submodule d is not initialized and skipped
>         git submodule recurse . checkout
>         Please provide an argument: master
>         Press y to provide another arg...
>         git checkout master
>         Already on branch "master"
>
>  This command would also come in handy for diffs and other commands.
>
>  Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
>  ---
>   git-submodule.sh |   53 +++++++++++++++++++++++++++++++++++++++++++++++++----
>   1 files changed, 49 insertions(+), 4 deletions(-)
>
>  diff --git a/git-submodule.sh b/git-submodule.sh
>  index 8161d51..314652d 100755
>  --- a/git-submodule.sh
>  +++ b/git-submodule.sh
>  @@ -12,7 +12,7 @@ LONG_USAGE="$0 add [-q|--quiet] [-b|--branch branch] <repository> [<path>]
>   $0 [status] [-q|--quiet] [-c|--cached] [--] [<path>...]
>   $0 init|update [-q|--quiet] [--] [<path>...]
>   $0 summary [--cached] [-n|--summary-limit <n>] [<commit>]
>  -$0 recurse [-q|--quiet] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-b|--breadth-first] <git command> [<args> ...]"
>  +$0 recurse [-q|--quiet] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-b|--breadth-first] [-a|--customized-argument] <git command> [<args> ...]"
>   OPTIONS_SPEC=
>   . git-sh-setup
>   require_work_tree
>  @@ -25,6 +25,8 @@ depth=0
>   current_depth=0
>   depth_first=1
>   on_error=
>  +use_custom_args=
>  +custom_args=
>
>   #
>   # print stuff on stdout unless -q was specified
>  @@ -585,6 +587,40 @@ cmd_status()
>         done
>   }
>
>  +# Take arguments from user to pass as custom arguments and execute the command
>  +exec_with_custom_args()
>  +{
>  +       input=
>  +       arg_index=0
>  +       eval_str="set "
>  +       while test $# -gt 0
>  +       do
>  +               arg_index=$(($arg_index + 1))
>  +               var='$'"$arg_index"
>  +               input="$1"
>  +               eval_str="$eval_str $var \"$input\""
>  +               shift
>  +       done
>  +       while :
>  +       do
>  +               arg_index=$(($arg_index + 1))
>  +               printf "Please provide an argument: "
>  +               read input
>  +               var='$'"$arg_index"
>  +               eval_str="$eval_str $var \"$input\""
>  +               printf "Press y to provide another arg... "
>  +               read keypress
>  +               if test "$keypress" != "y" &&
>  +                       test "$keypress" != "Y"
>  +               then
>  +                       break
>  +               fi
>  +       done
>  +       eval $eval_str
>  +       say "$*"
>  +       "$@"
>  +}
>  +
>   # Check whether the submodule is initialized or not
>   initialize_sub_module()
>   {
>  @@ -637,10 +673,16 @@ traverse_module()
>                 # If depth-first is specified in that case submodules are
>                 # are traversed before executing the command on this submodule
>                 test -n "$depth_first" && traverse_submodules "$@"
>  -               # pwd is mentioned in order to enable the ser to distinguish
>  -               # between same name modules, e.g. a/lib and b/lib.
>                 say "git submodule recurse $submod_path $*"
>  -               git "$@"
>  +               if test -n "$use_custom_args"
>  +               then
>  +                       # Execute the commands after taking the arguments
>  +                       # Please note that one input is for one argument
>  +                       # only.
>  +                       exec_with_custom_args git "$@"
>  +               else
>  +                       git "$@"
>  +               fi
>                 # if exit on error is specifed than script will exit if any
>                 # command fails. As there is no transaction there will be
>                 # no rollback either
>  @@ -689,6 +731,9 @@ cmd_recurse() {
>                 -e|--exit-after-error)
>                         on_error=1
>                         ;;
>  +               -a|--customized-argument)
>  +                       use_custom_args=1
>  +                       ;;
>                 -*)
>                         usage
>                         ;;
>  --
>  1.5.4.2
>
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
