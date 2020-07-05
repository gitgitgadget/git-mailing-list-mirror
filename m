Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6407FC433E0
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 14:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3727D206CB
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 14:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Enp1CNIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgGFOiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:38:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:55967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbgGFOiD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 10:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594046276;
        bh=1OPBMF6jlswBuftco4R9H49ejXAj8mIdISDhleAurJ8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Enp1CNIrBQ/9/IBSXtkKaLHwAef8rehV/4WhPIGUY/h6TSUxfRcfj2P3zuFbO8jjs
         qCW1kkSL9m5aXarbbqgv9taYPgntvVDVOaOOYrNeq+tLYc5KWZEV8swTTGRRyK210r
         oB3u/E8Ytuhx0PVT+k6Guxq2908JHlYAZRulZiQ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.26.78] ([89.1.213.199]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wq3-1ku9hV0eHh-012K80; Mon, 06
 Jul 2020 16:37:56 +0200
Date:   Sun, 5 Jul 2020 04:15:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Trygve Aaberge <trygveaa@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Wait for child on signal death for aliases to
 builtins
In-Reply-To: <20200704221839.421997-1-trygveaa@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007050410100.50@tvgsbejvaqbjf.bet>
References: <20200704221839.421997-1-trygveaa@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xII5gfRxhOijreZB85+Cc+WXn9plTdDay+uaESJLv6kSFJ17lFN
 /xlOWx98HTLm8NiEPhf1mZK8Z8BK/KPs0sJ00d8F/5Me2dW6k/0PCCXZ443VCdN17rM11IQ
 VN3boYSVV3y7VEHS/Z66ANHY+QAXj9lE3emYJgpw7lwQ0SYadkalFoSL04GC9S9Isn6NifS
 vl89OVjlB0+wJTgi08hQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:20ub3gBH1Vs=:GIhukCM/7IUKC+RtJ5HQTL
 xD1NE27nKMJWXtw3Pbq9wNjX4NTfjqWkh8nhtjkKI8QxIWLns41nQvdxYW6vLoFGmUqPU4lUh
 m7nBOtz63NaP8IACWcQPXmGjv5fy8eD9+RqJ49AoxCeopo8M5mL1vFlTHFlzz8TQFoU8sWgqR
 l17PD5Rp/N9YdrG6FiwwHfBW9hSt+udkKEq1PYHkh1gyVFOeBQ0xiYDQG8iVdLbFG5Srumzzn
 KcF2WShXspzOW1mDx6AnBHlYmvbAZ74ysdxGsL1NcpYXlMfkO9CWPMMsQYiyNbaUAPM/zeOA1
 FLiQPJ2sqJzh38oRW4t9z2IXNJXl33JpY6XCCNsoAoFf3CygcP6SWbpRaNkWRucAkHBE20UxJ
 dniMdq4wot1prkC/mGALRSuVeSssKUD2B7KelYa+4nRjJ6ttf7gPRPstT29DiTfbdK0mORFzb
 zsylje0fg915COrsyKBxAIvdAqjfUfesZ5ivujSg/0G+XvAg1qovwQjm9J+WMhJG6rGYzXP+e
 6BlgWG1E5Px9o11X3gsVPHu4aZ4jCqFskXAsm+OJ5RE2CfkkYfwXbihQEh184JDUS8q4tBx/n
 VQWtBjB1yiih1wgmBV6sJmJdCYnAr2VCYjZJs7lsfJ25f00RgkdLQxKhdffGGYyQIKL6WTYTs
 c7Sb3KX1lCFKXoXFureyQxGQ2DVtxDqk3I5DKo+SvMHhO18CIxoPd/mmLHtqV9vxjkK5RdYeF
 KhS+iV9+A0vBnE3wiMp9fuLidt8VJD0T2OadHbj3zIG4bW30A/77lsgl2xHWUyj4WV39JqSKF
 gQM0NsI422roNs3T2BTYnJ+06D6SGkQKDYRd9krSS1Ljn6WvwprUYsfUglZmQB14C+ypCcnSl
 zfWalll43HqDISiItBqy8RzWbUftvQZWTkCmV+h+GRnItGmnw8ywei76UepKhUIQuEpj9eSuI
 J9upAOAhwcKxvXv1voxVFJuNGv16RXsA9iLzQHMx/W8Es1u+N8N39Ylg2ebO2xmfSpLNAVZX4
 TbLHZGDwfGei9l8YKNxLBeMKCVx4wQ2Gt/JOXwmc5EL0so/GJKUUV53b5YcbswdsYPCr2qEnE
 UBxPLsi9kvZot24LX6tzN7B4ecAKPsej9Ihh/oLlNj2LVRWiskJBOcE47cn4ykgnUtsB9qe3H
 a10mQOyhCChjfM5+wvXNHiotFIJ8e5i7NaktFO+neiwSST94hzy+QJQ7WXONqYdF+f0Mt67Ik
 l7tnElTZB1QdWZ1K35CCQm5UCaC3uC9buSFOKZw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 5 Jul 2020, trygveaa@gmail.com wrote:

> From: Trygve Aaberge <trygveaa@gmail.com>
>
> When you hit ^C all the processes in the tree receives it. When a git
> command uses a pager, git ignores this and waits until the pager quits.
> However, when using an alias there is an additional process in the tree
> which didn't ignore the signal. That caused it to exit which in turn
> caused the pager to exit. This fixes that for aliases to builtins.
>
> This was originally fixed in 46df6906f3 (see that for a more in
> explanation), but broke by a regression in b914084007.

Thank you for those references. I did try to make sure that b914084007
would not regress on anything, but apparently I failed to verify the final
form. Since all it did was to remove `#if 0`...`#endif` guards, it was
unfortunately quite easy for this regression to slip in.

IIRC the original code inside those guards was modeled closely after
`execv_dashed_external()`, but it does not really look very much like it
anymore now, does it? (And it looks as if 2b296c93d49
(execv_dashed_external: use child_process struct, 2017-01-06) was
responsible for that.)

In any case, thank you for the patch, it looks good to me!

Ciao,
Dscho

>
> Signed-off-by: Trygve Aaberge <trygveaa@gmail.com>
> ---
>  git.c         | 2 +-
>  run-command.c | 1 +
>  run-command.h | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/git.c b/git.c
> index a2d337eed7..c8336773e3 100644
> --- a/git.c
> +++ b/git.c
> @@ -767,7 +767,7 @@ static int run_argv(int *argcp, const char ***argv)
>  			 * OK to return. Otherwise, we just pass along the status code.
>  			 */
>  			i =3D run_command_v_opt_tr2(args.argv, RUN_SILENT_EXEC_FAILURE |
> -						  RUN_CLEAN_ON_EXIT, "git_alias");
> +						  RUN_CLEAN_ON_EXIT | RUN_WAIT_AFTER_CLEAN, "git_alias");
>  			if (i >=3D 0 || errno !=3D ENOENT)
>  				exit(i);
>  			die("could not execute builtin %s", **argv);
> diff --git a/run-command.c b/run-command.c
> index 9b3a57d1e3..a735e380a9 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1039,6 +1039,7 @@ int run_command_v_opt_cd_env_tr2(const char **argv=
, int opt, const char *dir,
>  	cmd.silent_exec_failure =3D opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
>  	cmd.use_shell =3D opt & RUN_USING_SHELL ? 1 : 0;
>  	cmd.clean_on_exit =3D opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
> +	cmd.wait_after_clean =3D opt & RUN_WAIT_AFTER_CLEAN ? 1 : 0;
>  	cmd.dir =3D dir;
>  	cmd.env =3D env;
>  	cmd.trace2_child_class =3D tr2_class;
> diff --git a/run-command.h b/run-command.h
> index 191dfcdafe..ef3071a565 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -229,6 +229,7 @@ int run_auto_gc(int quiet);
>  #define RUN_SILENT_EXEC_FAILURE 8
>  #define RUN_USING_SHELL 16
>  #define RUN_CLEAN_ON_EXIT 32
> +#define RUN_WAIT_AFTER_CLEAN 64
>
>  /**
>   * Convenience functions that encapsulate a sequence of
> --
> 2.27.0
>
>
