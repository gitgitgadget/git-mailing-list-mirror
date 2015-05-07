From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 12/12] t5520: check reflog action in fast-forward merge
Date: Thu, 7 May 2015 09:39:23 -0700
Message-ID: <CAGZ79kaUCp=8JKSspqetzEGFMF7FVvCvFwO9v+A_XtiEd_V=fw@mail.gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-13-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 18:39:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqOpr-0005wc-UI
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 18:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbbEGQj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 12:39:26 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34547 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbEGQjY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 12:39:24 -0400
Received: by iget9 with SMTP id t9so14900520ige.1
        for <git@vger.kernel.org>; Thu, 07 May 2015 09:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=197/Ku8MBx5vBIGoj9EA5s0coyMFP0kwWgQy2I++bTc=;
        b=iRsEDe72zy0A1F1OY/yN8+WVY6CNDHOvMJfCcI5wQhkCr/4bcMsHSd2Q0b/hjto870
         CPNFqofmPdymA3bx5YuHSgVTe/Br7Gu3dav6nt4ejyqycmZaZpNga11N9TngqOndGxk9
         LVPSZjVBe4OEr3O3gNdfCwcTIR8CxhkQr92rjwMeqbmiFm/dgalIN+8CqpMA7OdaiLiB
         qua8RplCcYWLSJesYK9frnDge7cIvLk8zVsBw0HEuRuRHo5WliqlWCeIIryA1q7P0C66
         nsrJOMr8vTRsstS4dGbxICpsKUJPJpX6QORKxP0BIpswriiyyGz6u4YzwUGej6V3kIpd
         q+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=197/Ku8MBx5vBIGoj9EA5s0coyMFP0kwWgQy2I++bTc=;
        b=Rf/fdtbaJKQnnw5xhv1e+h+JJSThLL9vi4+tEGB9sJaiyMbQz4uaJ5ow6yhU/+IDLp
         3nfsir6zhHLuGlgDvcb1cwayQb+xA0GOrOm76LmUgghIcq8KJghcSfAuydn08xjAcpa9
         bbiBH444k1SAyERVJn3wYUSyRaIoIXK+wpy/d2JfwPIygcA+AgXWAPSv9x1FjtxGB8kC
         imowXNIL2g4eByZusJF+bOEXZjfbioR9ZDVHUHTUsPkOFlogkCdy2IytWGmH6cEUf3Db
         8aV5qj3qQwtGEpfFoyKM4yzAG2sX3iL/faCNzmVRM/y7f1FrJu6R/sfLP8/LBjQzzY+u
         Vw3g==
X-Gm-Message-State: ALoCoQkMpyQnV00cPlKUkvmCCrinBbm0qYC+V4of17IUabUZMXZxI+Z7bkPJE7BFqAFSuhsCZmtd
X-Received: by 10.42.188.19 with SMTP id cy19mr4717266icb.92.1431016764059;
 Thu, 07 May 2015 09:39:24 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Thu, 7 May 2015 09:39:23 -0700 (PDT)
In-Reply-To: <1430988248-18285-13-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268547>

On Thu, May 7, 2015 at 1:44 AM, Paul Tan <pyokagan@gmail.com> wrote:
> When testing a fast-forward merge with git-pull, check to see if the
> reflog action is "pull" with the arguments passed to git-pull.
>
> While we are in the vicinity, remove the empty line as well.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>
> Notes:
>     * Added this test to the patch series.
>
>  t/t5520-pull.sh | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index b93b735..6045491 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -86,7 +86,6 @@ test_expect_success 'pulling into void must not create an octopus' '
>  '
>
>  test_expect_success 'test . as a remote' '
> -
>         git branch copy master &&
>         git config branch.copy.remote . &&
>         git config branch.copy.merge refs/heads/master &&
> @@ -95,7 +94,11 @@ test_expect_success 'test . as a remote' '
>         git checkout copy &&
>         test `cat file` = file &&
>         git pull &&
> -       test `cat file` = updated
> +       test `cat file` = updated &&

same as in patch 1

> +       git reflog -1 >reflog.actual &&
> +       sed "s/$_x05[0-9a-f]*/OBJID/g" reflog.actual >reflog.fuzzy &&
> +       echo "OBJID HEAD@{0}: pull: Fast-forward" >reflog.expected &&
> +       test_cmp reflog.expected reflog.fuzzy
>  '
>
>  test_expect_success 'the default remote . should not break explicit pull' '
> @@ -106,7 +109,11 @@ test_expect_success 'the default remote . should not break explicit pull' '
>         git reset --hard HEAD^ &&
>         test `cat file` = file &&
>         git pull . second &&
> -       test `cat file` = modified
> +       test `cat file` = modified &&
> +       git reflog -1 >reflog.actual &&
> +       sed "s/$_x05[0-9a-f]*/OBJID/g" reflog.actual >reflog.fuzzy &&
> +       echo "OBJID HEAD@{0}: pull . second: Fast-forward" >reflog.expected &&
> +       test_cmp reflog.expected reflog.fuzzy
>  '
>
>  test_expect_success 'fail if wildcard spec does not match any refs' '
> --
> 2.1.4
>


The series looks good to me apart from the minor nits.

Thanks,
Stefan
