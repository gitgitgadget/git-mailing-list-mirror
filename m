From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 5/7] t5520: test --rebase with multiple branches
Date: Mon, 4 May 2015 10:09:37 -0700
Message-ID: <CAGZ79kbSMbhW2FLK05CaQjJjSTqEurB8iyeEBgyA1wbWJ4g2vw@mail.gmail.com>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
	<1430581035-29464-6-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 19:09:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpJsF-0001i7-Gs
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 19:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbbEDRJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 13:09:39 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34813 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbbEDRJh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 13:09:37 -0400
Received: by iedfl3 with SMTP id fl3so152604645ied.1
        for <git@vger.kernel.org>; Mon, 04 May 2015 10:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8v4N3MfhzcIi84+rmv4LdQXCmVaPSE8L5/WEJiIQ5v4=;
        b=WcfPAVUAeGibQE2928uSwdxw1B3WEhrC+jfjKVgwqiUSjfv71qmA94eKi+AdsH8oWo
         ltyDZfR6LBYDa+wo1X+VwVfxKV3LZ5gSqEesKD4naQvKGhHbBpPc/9XP7y2MW0UVx+lk
         7EHQ9HhdvfImZ0c8jZtD/Yqjg3PACKZctoZ5Mj+IdtfglTMS0gXCJc1+73E5irIHp3eo
         JrgzU/Wd6gMBopfaS0VRhN44ejjI8Q2LhFeG04Hmilj/takVTGuN0NDKrTH01SNHN5oS
         FeSQPz6lsgA3nFYF6CFe4d9xXOzr8zKSdgNvRmLbN7cBFhCjwyrvw66/BkuIE6Ole51q
         fQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8v4N3MfhzcIi84+rmv4LdQXCmVaPSE8L5/WEJiIQ5v4=;
        b=W2sbUUYOLWxPe5mLzgnHozGPzyTvpvrsrkCf8GKjvbkYKSIvlT6LiFRfFdNsgPRT8x
         IOBJcTlsZkohNBJ6BBs4o6xM9Fig0hoDcuh8UH4Wf802ftwHLuZRfPpl9BDPXwanS566
         2WQtt4tVE3u5KMy7dviweTFRPWxQTqLd1Eb1WFOzby2ogS2V9Bx0tJ0Jh2P1NDbr7Vfv
         JhppItjnsQGFk0TwJHUl1xChv0pW95JnnFr+RTdXiE82IhSikCczvrigQVEyOkQmaFtl
         PxR5o4Fary1EDm8CTEa8x1IhN9e3/RLSEFqA34qHw/+xqkN8PtH1h49uIpzCNIj3DiSe
         /9MA==
X-Gm-Message-State: ALoCoQmyBt87g1tSIrLzMeH/mNsmsRgORxU7j/WrtU5CzrhDJCR4sh9qwU3WdNOIQR+GGOKD847g
X-Received: by 10.107.170.135 with SMTP id g7mr29671956ioj.2.1430759377233;
 Mon, 04 May 2015 10:09:37 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 4 May 2015 10:09:37 -0700 (PDT)
In-Reply-To: <1430581035-29464-6-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268331>

On Sat, May 2, 2015 at 8:37 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Since rebasing on top of multiple upstream branches does not make sense,
> since commit 51b2ead0 ("disallow providing multiple upstream branches
> to rebase, pull --rebase"), git-pull explicitly disallowed specifying
> multiple branches in the rebase case.
>
> Implement tests to ensure that git-pull fails and prints out the
> user-friendly error message in such a case.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  t/t5520-pull.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 25d519d..17c63ff 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -223,6 +223,14 @@ test_expect_success '--rebase' '
>         test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
>         test new = $(git show HEAD:file2)
>  '
> +
> +test_expect_success '--rebase fails with multiple branches' '
> +       git reset --hard before-rebase &&
> +       test_must_fail git pull --rebase . copy master 2>out &&
> +       test_when_finished "rm -f out" &&

I think it would make sense to switch the previous 2 lines, because the
test_when_finished should also be run if the test actually fails.
The actual tested part may segfault, which would interrupt the && chain
from reaching the test_when_finished line. And here, the line to test
is meant to be the "git pull --rebase" line, so we'd assume it may be
stopping there due to failures in the tested program.

If you grep through the code base, you'll find lots of test_when_finished
commands as the very first command (or the earliest spot where it makes
sense).

> +       test_i18ngrep "Cannot rebase onto multiple branches" out
> +'
> +
>  test_expect_success 'pull.rebase' '
>         git reset --hard before-rebase &&
>         test_config pull.rebase true &&
> --
> 2.1.4
>
