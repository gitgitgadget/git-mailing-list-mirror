Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765ABC46CA1
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 15:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjIRPqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjIRPq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 11:46:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F61010D7
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 08:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695051666; x=1695656466; i=johannes.schindelin@gmx.de;
 bh=lgTeFaKnLG0kdcQIgSvDgFkQUHwEfXzhi3m1JGLU3hU=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=c34Vf9F78t7tqKP2+5bSRAwS0JNIBmYelyQ4wPkqX3c9wKF/n8MussbWty4DTp82VruyC7Z8VxY
 P1wYqThafSS+UAKY9OP+gmLsd5+G0IX7EzOrNiySTzT9GR+Cdb5Z2vm4+PA3q2FWwTK/7DJs7gR3e
 ZScm5aocgQQveEZrRBqBZuE/Emz+71ZpNzcpr4/yprcjLwERvF8656UTJNKygaKoGD6P0vRH3URJW
 MzS2Se/fovDfl43Y6xoKBg6L/JlXU9PidcM4qxkJ8G62/bUs325dxri68tuzd3xprCdmxOhGCL+Wx
 9ot56Kvwq+GHfoN8PDnd04UCBKge2LZCx2NA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.206]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmULx-1rQdWN1QTx-00iTMm; Mon, 18
 Sep 2023 17:27:46 +0200
Date:   Mon, 18 Sep 2023 17:27:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Mark Levedahl <mlevedahl@gmail.com>
cc:     gitster@pobox.com, me@yadavpratyush.com, git@vger.kernel.org
Subject: Re: [PATCH] git-gui - use git-hook, honor core.hooksPath
In-Reply-To: <20230917192431.101775-1-mlevedahl@gmail.com>
Message-ID: <a6998d64-32a7-80b6-f75c-d983ac6130dd@gmx.de>
References: <fa876f80-02dc-2c04-0db3-bf3f6269b427@gmail.com> <20230917192431.101775-1-mlevedahl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2KKKxbDBc/v8tB+Xw/1+UJoZQD9PnBvpQ+q/wGiBxcwknyliNgG
 bLcMCF3U2g7tY+8z9kxXpTUXUi2CGNT7my4LS2ks08NcHeux7qKSgRXdCZN8fSJuAVd8dxM
 jbYy3PfgWFWKKUNr4VHK9x4GL4Vp0O2rNkBmPmScch4ht1361iT+ClH/49dJtY02sgmpNC9
 YyVW+IzvBF+V+sOeixGLQ==
UI-OutboundReport: notjunk:1;M01:P0:O6R2XOsN//U=;611N9VL4sDElou5/ohOp5DBn8h7
 DwMPHH0I4e2sUCgU4++p65huZtzL2TwUCJNwuyaMQ23N8SDl1kdMijdUrAAqphM2Tk3Y+Gvnj
 SfluP1Mqpo9C4N+LGpcBDp76nn0F3sCekFpXG2sIWiOO7caSwYmeKCoYEn3qVK520USorxUml
 Lh6mtKcPylISle3s+bnygjnBZ6FJe33B1mTDznIScJgFpGEhrXHWx39Ghh7vCb2GZv65q5tJh
 FjEUC+AD3OoLo1fZDIvQ06xXGD82QT3vXC8yrs6ea1Yn14kl0nQ0+yeyiIFVfRWRoivZ5jvbQ
 NEYEYFH7gZaiR3+PjJdXQHLo19rGXHJqw4q0BYXEBK6/NcsB7+1apnT/a/gwsLmTg+qdGegUb
 RmKTnoAxt19Jw0IIu1k9eoPEP15xs9UW06m8yI5HG8EFbWsKB2X//wBAswmxMlxhEG4RBG9Gi
 sgZVH0Ml81TU44+BPALiakNakseeXi5Xw96zDQ4Fnj4nixmxo98d5iUM0CFnJ82raI0jfDila
 ozXWO3VAiFG7c0y6+KXYA07gqpGQUb5gP/Pr538hJkIuyGX+a+TbnVu/D1qfW0Uc+nkq+++y8
 iBi1ynEGoSB/lwaD1sJg94bFMlkF9eHqM+8hz6UvLe8fgRKIBuMvlSHPp8kOGv2TMm2QyLdRV
 I3+lu5hWAXAQ5JdQPBPh63FGCKyE1ssllO3RASyB5fZZE/tvls7xXHftueBKWyovB3rZndYt3
 QbIe23O7Nym9UmT5XPHTWSHUUvxxZ4t/m7mBz/Sv5d9zWdye5LXjQX2qZPDZmrp+5jkFpnvui
 +eK2gsdkl4+vJYGepM+coudyOuvlGpMizAwB9V2Zvd5eWnLqVhnDv+x0ZxGv9CmK8vwI6zHzL
 9j+88yqTWiVHL/Zjh/SI/IMd4Y2g17ei3a2+BxO+IujIzwz3UHdM52UR5+XdkkR+EkF25Np4d
 /9uC+PA8vACIMcohuFOMvJYEuGI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mark,

On Sun, 17 Sep 2023, Mark Levedahl wrote:

> git-gui currently runs some hooks directly using its own code written
> before 2010, long predating git v2.9 that added the core.hooksPath
> configuration to override the assumed location at $GIT_DIR/hooks.  Thus,
> git-gui looks for and runs hooks including prepare-commit-msg,
> commit-msg, pre-commit, post-commit, and post-checkout from
> $GIT_DIR/hooks, regardless of configuration. Commands (e.g., git-merge)
> that git-gui invokes directly do honor core.hooksPath, meaning the
> overall behaviour is inconsistent.
>
> Furthermore, since v2.36 git exposes its hook exection machinery via
> git-hook run, eliminating the need for others to maintain code
> duplicating that functionality.  Using git-hook will both fix git-gui's
> current issues on hook configuration and (presumably) reduce the
> maintenance burden going forward. So, teach git-gui to use git-hook.
>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 27 ++-------------------------
>  1 file changed, 2 insertions(+), 25 deletions(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 8603437..3e5907a 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -661,31 +661,8 @@ proc git_write {args} {
>  }
>
>  proc githook_read {hook_name args} {
> -	set pchook [gitdir hooks $hook_name]
> -	lappend args 2>@1
> -
> -	# On Windows [file executable] might lie so we need to ask
> -	# the shell if the hook is executable.  Yes that's annoying.
> -	#
> -	if {[is_Windows]} {
> -		upvar #0 _sh interp
> -		if {![info exists interp]} {
> -			set interp [_which sh]
> -		}
> -		if {$interp eq {}} {
> -			error "hook execution requires sh (not in PATH)"
> -		}
> -
> -		set scr {if test -x "$1";then exec "$@";fi}
> -		set sh_c [list $interp -c $scr $interp $pchook]
> -		return [_open_stdout_stderr [concat $sh_c $args]]
> -	}
> -
> -	if {[file executable $pchook]} {
> -		return [_open_stdout_stderr [concat [list $pchook] $args]]
> -	}
> -
> -	return {}
> +	set cmd [concat git hook run --ignore-missing $hook_name -- $args 2>@1=
]
> +	return [_open_stdout_stderr $cmd]

This looks so much nicer than the original code.

Thank you,
Johannes

>  }
>
>  proc kill_file_process {fd} {
> --
> 2.41.0.99.19
>
>
