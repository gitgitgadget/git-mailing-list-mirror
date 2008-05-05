From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] git-submodule.sh: Add recurse subcommand with basic options
Date: Mon, 5 May 2008 15:08:12 +0600
Message-ID: <7bfdc29a0805050208s1a460638ib6327453b18b2ec3@mail.gmail.com>
References: <1209977051-25896-1-git-send-email-imyousuf@gmail.com>
	 <1209977051-25896-2-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 11:09:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jswgw-0004KQ-Co
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 11:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390AbYEEJIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 05:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755386AbYEEJIO
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 05:08:14 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:49767 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755379AbYEEJIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 05:08:13 -0400
Received: by fk-out-0910.google.com with SMTP id 18so586802fkq.5
        for <git@vger.kernel.org>; Mon, 05 May 2008 02:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ftmOTyoMDPq2lUgRd5FZrMloAx4BVT8led7BZ1OPal8=;
        b=fgwXh94K7e5WmWFt10dW723KUf44g4O2Dxmg4X2W44+G8gwqVdXWURN0Ge7dXToPdhKWiw2dJyjRlN/6cZi/GyIgI60MQ0Mb4vjXhx8LNWATwL+1f83o8zJwj7RPurPoJXn/Q/U0R18zBQrHYhWdw2E9vCiwg7KlmxM/SF/DxMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dd4phSyZzAWetPkZcaY55Yy169ALa3IxoVy7dsr6Aa15bxEKJROJesAl2jVYvVij5Cyz5ykJOXAPLwx7uN0xzvasOjpGKXvaCFEMkDkOQRDzGDLCAWqlFrYzHbBsQALwav5YQYeiLTK70z72RVJgTS7Zhvjpr94qrcqFKN4GDSw=
Received: by 10.78.158.6 with SMTP id g6mr1551646hue.20.1209978492259;
        Mon, 05 May 2008 02:08:12 -0700 (PDT)
Received: by 10.78.75.8 with HTTP; Mon, 5 May 2008 02:08:12 -0700 (PDT)
In-Reply-To: <1209977051-25896-2-git-send-email-imyousuf@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81255>

Sorry for the inconvenience, but please ignore this patch as it was
not generated with -n and version number :(.

- best regards,

Imran


On Mon, May 5, 2008 at 2:44 PM,  <imyousuf@gmail.com> wrote:
> From: Imran M Yousuf <imyousuf@smartitengineering.com>
>
>  The purpose of the recurse command in the git submodule is to recurse
>  a command in its submodule. For example if one wants to do a diff on its
>  project with submodules at once, one can simply do
>         git-submodule recurse diff HEAD
>  and would see the diff for all the modules it contains.
>
>  The recurse commands behavior can be customized with several arguments
>  that it accepts. The synopsis for the recurse command is:
>
>         git-submodule recurse [-q|--quiet] [-e|--exit-after-error]
>         [-d|--depth <recursion depth>] [-b|--breadth-first]
>         <git command> [<arguments> ...]
>
>  There are commands that can fail for a certain submodule but succeed for
>  others; if one wants to stop execution once the top level module's execution
>  fails, one can specify [-e|--exit-after-error]. It will ensure that once
>  execution of git <command> fails in the top level module it will not recurse
>  into its submodules.
>
>  If the project has submodule hierarchy upto n depth and we want to restrict
>  recursion to (n-p) depth; we can use the [-d|--depth <recursion depth>] option.
>  Value has to be greater than 0 and command will at least recurse into the first
>  depth. If depth is specified to p than all depths <= p will be recursed over.
>
>  While discussion on the recurse command one thing which was put forward
>  in several occassions is that there might be scenario where a command should be
>  executed over the child module before the parent module.
>
>         For such scenario [-b|--breadth-first] option can be used; one use case
>  in particular presented as an example is git commit; where almost everybody
>  mentioned that they prefer to commit the child module before the parent and
>  default will enable just that.
>
>         E.g. p -> a, b, c, e; a ->d is a module structure. If the following command is
>  used,
>
>         git submodule recurse commit -a
>
>  it will execute git commit -a in the following sequence - d, a, b, c, e, p.
>
>         Now if one want to instead go in a breadth first manner then one can
>  specify -b option. E.g. if the above command is -
>
>         git submodule recurse -b commit -a
>
>  it will execute git commit -a in the following sequence - p, a, d, b, c, e.
>
>  Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
>  ---
>   git-submodule.sh |  132 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 files changed, 130 insertions(+), 2 deletions(-)
>
>  diff --git a/git-submodule.sh b/git-submodule.sh
>  index a5ee2e5..8161d51 100755
>  --- a/git-submodule.sh
>  +++ b/git-submodule.sh
>  @@ -11,7 +11,8 @@ Use $0 -h for more details"
>   LONG_USAGE="$0 add [-q|--quiet] [-b|--branch branch] <repository> [<path>]
>   $0 [status] [-q|--quiet] [-c|--cached] [--] [<path>...]
>   $0 init|update [-q|--quiet] [--] [<path>...]
>  -$0 summary [--cached] [-n|--summary-limit <n>] [<commit>]"
>  +$0 summary [--cached] [-n|--summary-limit <n>] [<commit>]
>  +$0 recurse [-q|--quiet] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-b|--breadth-first] <git command> [<args> ...]"
>   OPTIONS_SPEC=
>   . git-sh-setup
>   require_work_tree
>  @@ -20,6 +21,10 @@ command=
>   branch=
>   quiet=
>   cached=
>  +depth=0
>  +current_depth=0
>  +depth_first=1
>  +on_error=
>
>   #
>   # print stuff on stdout unless -q was specified
>  @@ -580,6 +585,129 @@ cmd_status()
>         done
>   }
>
>  +# Check whether the submodule is initialized or not
>  +initialize_sub_module()
>  +{
>  +       if test ! -d "$1"/.git
>  +       then
>  +               say "Submodule $1 is not initialized and skipped"
>  +               return 1
>  +       # Returns true if submodule is already initialized
>  +       elif test -d "$1"/.git
>  +       then
>  +               return 0
>  +       fi
>  +}
>  +
>  +# This function simply checks whether the depth is traverseable in terms of
>  +# depth and if so then it sequentially traverses its submodules
>  +traverse_submodules()
>  +{
>  +       # If current depth is the range specified than it will continue
>  +       # else return with success
>  +       if test "$depth" -gt 0 &&
>  +               test "$current_depth" -ge "$depth"
>  +       then
>  +               return 0;
>  +       fi
>  +       # If submodules exists than it will traverse over them
>  +       if test -f .gitmodules
>  +       then
>  +               # Incrementing the depth for the next level of submodules
>  +               current_depth=$(($current_depth + 1))
>  +                for mod_path in `sed -n -e 's/path = //p' .gitmodules`; do
>  +                        traverse_module "$mod_path" "$@"
>  +                done
>  +               # Decremented the depth to bring it back to the depth of
>  +               # the current submodule
>  +               current_depth=$(($current_depth - 1))
>  +       fi
>  +}
>  +
>  +# This actually traverses a submodule; checks whether the its initialized
>  +# or not, does nothing if not initialized.
>  +traverse_module()
>  +{
>  +       # Will work in the submodule if and only if its initialized
>  +       initialize_sub_module "$1" &&
>  +       (
>  +               submod_path="$1"
>  +               shift
>  +               cd "$submod_path"
>  +               # If depth-first is specified in that case submodules are
>  +               # are traversed before executing the command on this submodule
>  +               test -n "$depth_first" && traverse_submodules "$@"
>  +               # pwd is mentioned in order to enable the ser to distinguish
>  +               # between same name modules, e.g. a/lib and b/lib.
>  +               say "git submodule recurse $submod_path $*"
>  +               git "$@"
>  +               # if exit on error is specifed than script will exit if any
>  +               # command fails. As there is no transaction there will be
>  +               # no rollback either
>  +               # TODO - If possible facilitate transaction
>  +               if test "$?" -ne 0 && test -n "$on_error"
>  +               then
>  +                       die "FAILED: git submodule $submod_path $*"
>  +               fi
>  +               # If depth-first is not specified in that case submodules are
>  +               # are traversed after executing the command on this submodule
>  +               test -z "$depth_first" && traverse_submodules "$@"
>  +       )
>  +}
>  +
>  +# Propagates or recurses over all the submodules at any depth with any
>  +# git command, e.g. git-clone, git-status, git-commit etc., with the
>  +# arguments supplied exactly as it would have been supplied to the command
>  +# otherwise. This actually starts the recursive propagation.
>  +cmd_recurse() {
>  +       while :
>  +       do
>  +               case "$1" in
>  +               -q|--quiet)
>  +                       quiet=1
>  +                       ;;
>  +               -d|--depth)
>  +                       shift
>  +                       if test -z "$1"
>  +                       then
>  +                               echo "No <recursion depth> specified"
>  +                               usage
>  +                       # Arithmatic operation will give an error if depth is not number
>  +                       # thus chose to check intergerness with regular expression.
>  +                       # $1 is underquoted becuase the expr is in quotation
>  +                       elif test "$(expr $1 : '[1-9][0-9]*')" -eq "$(expr $1 : '.*')"
>  +                       then
>  +                               depth="$1"
>  +                       else
>  +                               echo "<recursion depth> not an integer"
>  +                               usage
>  +                       fi
>  +                       ;;
>  +               -b|--breadth-first)
>  +                       depth_first=
>  +                       ;;
>  +               -e|--exit-after-error)
>  +                       on_error=1
>  +                       ;;
>  +               -*)
>  +                       usage
>  +                       ;;
>  +               *)
>  +                       break
>  +                       ;;
>  +               esac
>  +               shift
>  +       done
>  +       test "$#" -le 0 && die "No git command specified"
>  +       project_home="$(pwd)"
>  +       if test -d "$project_home"/.git/
>  +       then
>  +               traverse_module . "$@"
>  +       else
>  +               die "$project_home not a git repo thus exiting"
>  +       fi
>  +}
>  +
>   # This loop parses the command line arguments to find the
>   # subcommand name to dispatch.  Parsing of the subcommand specific
>   # options are primarily done by the subcommand implementations.
>  @@ -589,7 +717,7 @@ cmd_status()
>   while test $# != 0 && test -z "$command"
>   do
>         case "$1" in
>  -       add | init | update | status | summary)
>  +       add | init | update | status | summary |recurse)
>                 command=$1
>                 ;;
>         -q|--quiet)
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
