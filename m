From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/7] i18n: rebase: mark strings for translation
Date: Tue, 24 Jul 2012 13:01:38 -0500
Message-ID: <20120724180138.GF2939@burratino>
References: <cover.1343112786.git.worldhello.net@gmail.com>
 <b263c2bcc5dd6d611a1e3a4f6a87042d4cdb50aa.1343112786.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 20:02:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StjQn-0002cH-NG
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 20:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354Ab2GXSBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 14:01:49 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43627 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932290Ab2GXSBn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 14:01:43 -0400
Received: by yhmm54 with SMTP id m54so6961798yhm.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/1RGFS7rwyuGIH0yDw1eSISdDqZglTtrvDqNVZiuviM=;
        b=J5fMEzi/D5hOxhy5/2UY1NEM6mMebUD5c91LewK68AbRoGc/xO+1cgVGQFUL3dFb0y
         eRtiGLVvxBnWxtXUK3U5AvGbpw6rbSG611g7VRUa2XOcbbIcCDgeV3Y/QbyIXpl9UPD3
         w7YGwjR48KA7O58uz6V+hADkrr/d8JcH1WY76DT6QXpO6H0ylaiEkK1SpnpMme5FOf9B
         NA7vWk//FVyhHkdRxfQjFgyoTlgXyufzCdfmK4Hqn0sTep6DHkN/+6iicDLmtdBWFUfG
         kKOz9h6FJsgIXY9epvG0eYc1fMPXrqnvl1LGjonDCxtAmOMfbzdjdDdN8nkGeJfJjZhi
         YKiw==
Received: by 10.43.70.71 with SMTP id yf7mr17033336icb.14.1343152902663;
        Tue, 24 Jul 2012 11:01:42 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id s4sm2548035igb.1.2012.07.24.11.01.41
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 11:01:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b263c2bcc5dd6d611a1e3a4f6a87042d4cdb50aa.1343112786.git.worldhello.net@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202048>

Hi,

Jiang Xin wrote:

> Mark strings in git-rebase.sh for translation.

Thanks.

[...]
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -65,6 +65,7 @@ abort!             abort and check out the original branch
>  skip!              skip current patch and continue
>  "
>  . git-sh-setup
> +. git-sh-i18n
>  set_reflog_action rebase
>  require_work_tree_exists
>  cd_to_toplevel
> @@ -72,11 +73,11 @@ cd_to_toplevel
>  LF='
>  '
>  ok_to_skip_pre_rebase=
> -resolvemsg="
> -When you have resolved this problem run \"git rebase --continue\".
> -If you would prefer to skip this patch, instead run \"git rebase --skip\".
> -To check out the original branch and stop rebasing run \"git rebase --abort\".
> -"
> +resolvemsg=$(gettext '
> +When you have resolved this problem run "git rebase --continue".
> +If you would prefer to skip this patch, instead run "git rebase --skip".
> +To check out the original branch and stop rebasing run "git rebase --abort".
> +')

Functional change: command substitution strips off the trailing newline.
Intentional?

Probably it would make sense to do

	resolvemsg="
	$(gettext 'When you have resolved this problem, run "git rebase --continue".
	If you prefer to skip this patch, run "git rebase --skip" instead.
	To check out the original branch and stop rebasing, run "git rebase --abort".')
	"

anyway, so the translators could have fewer newlines at the edges to
fuss about.

[...]
>  	git diff-files --quiet --ignore-submodules || {
> -		echo "You must edit all merge conflicts and then"
> -		echo "mark them as resolved using git add"
> +		echo "$(gettext "You must edit all merge conflicts and then
> +mark them as resolved using git add")"
>  		exit 1

Nice.

[...]
> @@ -367,15 +368,16 @@ esac
>  # Make sure no rebase is in progress
>  if test -n "$in_progress"
>  then
> -	die '
> -It seems that there is already a '"${state_dir##*/}"' directory, and
> +	state_dir_base=${state_dir##*/}
> +	die "$(eval_gettext "
> +It seems that there is already a \$state_dir_base directory, and
>  I wonder if you are in the middle of another rebase.  If that is the
>  case, please try
>  	git rebase (--continue | --abort | --skip)
>  If that is not the case, please
> -	rm -fr '"$state_dir"'
> +	rm -fr \"\$state_dir\"
>  and run me again.  I am stopping in case you still have something
> -valuable there.'
> +valuable there.")"

Maybe, to allow changing the commands without having to update
translations:

	state_dir_base=...
	cmd_live_rebase='git rebase (--continue | --abort | --skip)'
	cmd_clear_stale_rebase="rm -fr \"$state_dir\""
	die "
	$(eval_gettext 'It seems that there is already a $state_dir_base directory, and
	I wonder if you ware in the middle of another rebase.  If that is the
	case, please try
		$cmd_live_rebase
	If that is not the case, please
		$cmd_clear_stale_rebase
	and run me again.  I am stopping in case you still have something
	valuable there.')"

[...]
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -68,24 +68,24 @@ test_expect_success 'rebase against master' '

Thanks for updating tests!  The expected output you had to change all
seems to be intended for humans, which is a good sign.

[...]
> --- a/t/t3406-rebase-message.sh
> +++ b/t/t3406-rebase-message.sh
> @@ -64,7 +64,7 @@ test_expect_success 'rebase -n overrides config rebase.stat config' '
>  
>  test_expect_success 'rebase --onto outputs the invalid ref' '
>  	test_must_fail git rebase --onto invalid-ref HEAD HEAD 2>err &&
> -	grep "invalid-ref" err
> +	test_i18ngrep "invalid-ref" err
>  '

This is probably part of a message intended for humans, but the test
does not say.  What is the full message being checked?

Hope that helps,
Jonathan
