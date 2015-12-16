From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] push: Fully test --recurse-submodules on command line
 overrides config
Date: Wed, 16 Dec 2015 12:48:56 -0800
Message-ID: <CAGZ79kb3XCkabxUq6Sh-aLa=a6kzRZtR6WG+wTk1SQY9_Mehog@mail.gmail.com>
References: <20151203131006.GA5119@mcrowe.com>
	<1449148235-29569-1-git-send-email-mac@mcrowe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Mike Crowe <mac@mcrowe.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 21:49:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9J0Q-0000N4-0O
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 21:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbbLPUs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 15:48:58 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35655 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbbLPUs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 15:48:57 -0500
Received: by mail-ig0-f175.google.com with SMTP id to4so83385635igc.0
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 12:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EBbBQOqIW27a6NRnC//yk1nm9MS3RUiP4qutW5C4x+0=;
        b=iLw4X38rCHEfYulRpQJAlCK/xYzfN6djf2MbVEnZpMqmuL8Gc8FPZPN1cxklr6AHX6
         Zlk0BYlGlQC89KXucVxSj1ruo7rKOV2pLm5tdAgpUL9UmFFCOxAFujXmt7RC2bM12arE
         5jjInj8Awo4fQHqrkUk/5x/pRT2yWsRfIfB4lFGRSQydIyD5II+gvTUpWdL87SbhlWtw
         89PMosvq3fUOLAnwD7J0nz+Zo2yxfSwBzogpty8ncCeBfU3syGiVPDHwlS7ZOdM5vMI2
         lW7qDGSS5tCeTukx4yxwSTE1lhq2As6gM79bKHTJ+k+W2H3z4xyVubaiDVmQes8619hb
         ESSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EBbBQOqIW27a6NRnC//yk1nm9MS3RUiP4qutW5C4x+0=;
        b=gKIYUnMAANHP4MSWTy3Q/knyPoJnv69T4MjfY+2+c49Cbgj1k6Bxsrb0o9NrTo0h09
         l81XWSEhFsW4RHMaMBOd0938GfX8VjGboSGiBawCgYR/jOfIOhy5klM+EWUNyigMKHs6
         ThX7YmWHJHuhdueMlCMCzLXiOTS63e8zbcRT4VCkflyZBnv3k3rBkfn6M2j0eN1x6Aip
         bSmHSrRALGdn2lcKdR9U64lHNj1OHMvRYh/VhHoSPPkUL/p1WLakhjjLXcjLogLTNIOB
         6SAe8gL8ROhwxulK0lcucQe0yFOL+Ddp40uXgUVEoTsXCLbfkFyIo7tqyJd3MlKZ+MyZ
         APjg==
X-Gm-Message-State: ALoCoQkdoMZYlIsqU1MoUnedYIUoyzcMhP2aVvE7vsvDgeKioNcCZyeX/WGuSGp8G3hzToZiQmAEleEsQfnx3VkxPFmoJ71nGXEu00yzL3M1cHS0Q5kcF4o=
X-Received: by 10.107.168.203 with SMTP id e72mr3447617ioj.96.1450298936664;
 Wed, 16 Dec 2015 12:48:56 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Wed, 16 Dec 2015 12:48:56 -0800 (PST)
In-Reply-To: <1449148235-29569-1-git-send-email-mac@mcrowe.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282588>

On Thu, Dec 3, 2015 at 5:10 AM, Mike Crowe <mac@mcrowe.com> wrote:
> t5531 only checked that the push.recurseSubmodules config option was
> overridden by passing --recurse-submodules=check on the command line.
> Add new tests for overriding with --recurse-submodules=no,
> --no-recurse-submodules and --recurse-submodules=push too.
>
> Also correct minor typo in test commit message.
>
> Signed-off-by: Mike Crowe <mac@mcrowe.com>

This looks good to me.

Thanks,
Stefan


> ---
>  t/t5531-deep-submodule-push.sh | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
> index 9fda7b0..721be32 100755
> --- a/t/t5531-deep-submodule-push.sh
> +++ b/t/t5531-deep-submodule-push.sh
> @@ -126,24 +126,48 @@ test_expect_success 'push succeeds if submodule commit not on remote but using o
>         )
>  '
>
> -test_expect_success 'push fails if submodule commit not on remote using check from cmdline overriding config' '
> +test_expect_success 'push recurse-submodules on command line overrides config' '
>         (
>                 cd work/gar/bage &&
>                 >recurse-check-on-command-line-overriding-config &&
>                 git add recurse-check-on-command-line-overriding-config &&
> -               git commit -m "Recurse on command-line overridiing config junk"
> +               git commit -m "Recurse on command-line overriding config junk"
>         ) &&
>         (
>                 cd work &&
>                 git add gar/bage &&
>                 git commit -m "Recurse on command-line overriding config for gar/bage" &&
> +
> +               # Ensure that we can override on-demand in the config
> +               # to just check submodules
>                 test_must_fail git -c push.recurseSubmodules=on-demand push --recurse-submodules=check ../pub.git master &&
>                 # Check that the supermodule commit did not get there
>                 git fetch ../pub.git &&
>                 git diff --quiet FETCH_HEAD master^ &&
>                 # Check that the submodule commit did not get there
> -               cd gar/bage &&
> -               git diff --quiet origin/master master^
> +               (cd gar/bage && git diff --quiet origin/master master^) &&
> +
> +               # Ensure that we can override check in the config to
> +               # disable submodule recursion entirely
> +               (cd gar/bage && git diff --quiet origin/master master^) &&
> +               git -c push.recurseSubmodules=on-demand push --recurse-submodules=no ../pub.git master &&
> +               git fetch ../pub.git &&
> +               git diff --quiet FETCH_HEAD master &&
> +               (cd gar/bage && git diff --quiet origin/master master^) &&
> +
> +               # Ensure that we can override check in the config to
> +               # disable submodule recursion entirely (alternative form)
> +               git -c push.recurseSubmodules=on-demand push --no-recurse-submodules ../pub.git master &&
> +               git fetch ../pub.git &&
> +               git diff --quiet FETCH_HEAD master &&
> +               (cd gar/bage && git diff --quiet origin/master master^) &&
> +
> +               # Ensure that we can override check in the config to
> +               # push the submodule too
> +               git -c push.recurseSubmodules=check push --recurse-submodules=on-demand ../pub.git master &&
> +               git fetch ../pub.git &&
> +               git diff --quiet FETCH_HEAD master &&
> +               (cd gar/bage && git diff --quiet origin/master master)
>         )
>  '
>
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
