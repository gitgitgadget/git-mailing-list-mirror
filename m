From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 19/19] pull: remove redirection to git-pull.sh
Date: Wed, 3 Jun 2015 10:49:54 -0700
Message-ID: <CAGZ79kaR_MFgbo6F9=1s9h5OtXSDu6526iKT_hVcUCq9vpf8-A@mail.gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-20-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 19:50:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Cng-00023Y-Ih
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 19:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755802AbbFCRt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 13:49:57 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:32923 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbbFCRtz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 13:49:55 -0400
Received: by qkhg32 with SMTP id g32so9969583qkh.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+JCVM89r9KOamnZgvl+aj48AhE4kIAJzbK8CUNpn51k=;
        b=k+wNblefitKfvkW6XBsALkreE2SIzG0qL3RTQrrW6A2XDqZTGbAg1/E5yJ5VSA8Tif
         W9EmBQICGeW79KRlswLFsALM5Mwtab97E7YOyBJbCO3uu5JdDI29qGXksYSpOjBNZO4g
         5FAfkAa5dZ7OfVmVmpMFHQu5YLSX9Ezhj8TbRomOL2D6bqtbtXMIqDMop305ghzBB8jo
         /Kjx+UHhsrLm1/TYUBLuhCI5PFYL6VXvWl24sEh0dG+DCVGuXadPOAqGL66PbUp6Jw8f
         Zg+NqD/t+XZIh9CfghK7pXnxsY5FRz9DMTyCODCAT3jgsA6qUQWWWsX1dy5tIdZa4AR8
         Z+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+JCVM89r9KOamnZgvl+aj48AhE4kIAJzbK8CUNpn51k=;
        b=EithpIGx3Sa8fi7u9++TLowo0FXG+hTvYoXBgf8hpXKVpGh4VrAJGJvVwoPSGb7RMV
         IE6b5KzYAICZfebr+CKrs6xqSnHWX/dVEidJHoCQAIVfnFOKR2jC7ADbANQNv/Q1zy3G
         W+TzqXVGWluWeAXVQvYcdWp5Ylp9JgmjAjS+xrcyamfDze3jIsy2B57sBeSlmUVX0XCs
         C+wizKlxM9QHd7GVEyaAZ1nU1CDmp+oPqnc3wIeHe5GqSIXBKT3qts/ploTleUgYq46W
         LUcrK79CNvCXrj+iJ2T8H6NeiMiuwoM6+MRwW9c/Kca/p1wWHBLytigNgzLpCQ80jPRg
         Mmpw==
X-Gm-Message-State: ALoCoQmTx8jn3MW8X/L7dx2dzIsIJKJ2X8GosQN/868dlu7Wlv5M67J3aeCt5td/GNd4GGNmlUAK
X-Received: by 10.140.132.17 with SMTP id 17mr39555422qhe.36.1433353794636;
 Wed, 03 Jun 2015 10:49:54 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 3 Jun 2015 10:49:54 -0700 (PDT)
In-Reply-To: <1433314143-4478-20-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270711>

On Tue, Jun 2, 2015 at 11:49 PM, Paul Tan <pyokagan@gmail.com> wrote:
> At the beginning of the rewrite of git-pull.sh to C, we introduced a
> redirection to git-pull.sh if the environment variable
> _GIT_USE_BUILTIN_PULL was not defined in order to not break test scripts
> that relied on a functional git-pull.
>
> Now that all of git-pull's functionality has been re-implemented in
> builtin/pull.c, remove this redirection, and retire the old git-pull.sh
> into contrib/examples/.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>

The whole series was a pleasant read.

Thanks,
Stefan

> ---
>  Makefile                                    | 1 -
>  builtin/pull.c                              | 7 -------
>  git-pull.sh => contrib/examples/git-pull.sh | 0
>  3 files changed, 8 deletions(-)
>  rename git-pull.sh => contrib/examples/git-pull.sh (100%)
>
> diff --git a/Makefile b/Makefile
> index 2057a9d..67cef1c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -474,7 +474,6 @@ SCRIPT_SH += git-merge-octopus.sh
>  SCRIPT_SH += git-merge-one-file.sh
>  SCRIPT_SH += git-merge-resolve.sh
>  SCRIPT_SH += git-mergetool.sh
> -SCRIPT_SH += git-pull.sh
>  SCRIPT_SH += git-quiltimport.sh
>  SCRIPT_SH += git-rebase.sh
>  SCRIPT_SH += git-remote-testgit.sh
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 4e1ab5b..dad49cf 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -805,13 +805,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>         unsigned char orig_head[GIT_SHA1_RAWSZ], curr_head[GIT_SHA1_RAWSZ];
>         unsigned char rebase_fork_point[GIT_SHA1_RAWSZ];
>
> -       if (!getenv("_GIT_USE_BUILTIN_PULL")) {
> -               const char *path = mkpath("%s/git-pull", git_exec_path());
> -
> -               if (sane_execvp(path, (char**) argv) < 0)
> -                       die_errno("could not exec %s", path);
> -       }
> -
>         if (!getenv("GIT_REFLOG_ACTION"))
>                 set_reflog_message(argc, argv);
>
> diff --git a/git-pull.sh b/contrib/examples/git-pull.sh
> similarity index 100%
> rename from git-pull.sh
> rename to contrib/examples/git-pull.sh
> --
> 2.1.4
>
