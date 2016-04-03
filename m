From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/7] t5520: factor out common code
Date: Sun, 3 Apr 2016 16:03:20 -0400
Message-ID: <CAPig+cSofS_ozEY2N1k4fjgubq-J=3k870UMvx0-j55LPaMoRg@mail.gmail.com>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
	<1459619912-5445-5-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 22:05:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amoH3-0001gd-Cn
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 22:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbcDCUDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 16:03:22 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:34809 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbcDCUDV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 16:03:21 -0400
Received: by mail-ig0-f195.google.com with SMTP id qu10so2878642igc.1
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 13:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=5W6S+ZdgpCa4ZwatqaTbG7+9wpcLYzgDZLERwlZiJ/I=;
        b=bhn/rb0JVIxgSnSh+gKomUfptlo6o9eKffM/gnBtxvyfEzS2luN+llNdoX03AoIfe3
         h7ur0rY+pqdZP568lAm7twRKH1XBlAWfzTPKQ5tr8YIL7NN+q2sYktGKkYUhi91gPzrN
         V0oLDq8/Zl08oFqNRWV2BlRalnE/fNTnTeF0jsAcV+1jLMXeJlLPbACkie1V7/cfgDq8
         w1Sdoy8evz2Sovi0kt4vZ8Xk5tVgJmlRcDVRcepxsKfu2gXfaevY/OH9gL/ZpJeHmURY
         x42CbHmqJ9yKuxENbt89Rm8EkCXeeMjIgCXwnkaeSnXuPimJooHgb7uttTKctTfRkLYu
         Ksrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=5W6S+ZdgpCa4ZwatqaTbG7+9wpcLYzgDZLERwlZiJ/I=;
        b=jbago/uxzJSUAy8IMawTdYAf6/TIrzRiigdkQI9zxGzlzSwS9a6Xaggw6E+ifqyH+3
         kTHWs9VDcE9Ngx31nyb+qsJ9lz+c2MhRfHi8NPw9feuIPSURUTtpwkKBACWsrDf8y6Pe
         a43zKvRyh/JBv/aEYrPyhBsvHSDC4MPTU3XS4g/KbMumVib819ztrCyuh5oXpYToNV5p
         Qw0S1kN4Py+iXWB4C5MVmUCYVWf/MMxVW5rZzGVhMoSvRioKy91oIkQnZDosSjehLJoB
         BF3cJfYYZxYb6FltW7/d1q+acNWveyIYDntftyQOdrlIo708G/HwadMsQI7ueQ7PLyXc
         sXYg==
X-Gm-Message-State: AD7BkJJsOvUKNN6CdGqg9JdsbbMM0hEtMMzFItQb0PXuGOvRhkC3kKKWoSvT8x3DdJelXG3fPBdWiESJ+QWfdA==
X-Received: by 10.50.138.69 with SMTP id qo5mr7990926igb.17.1459713800944;
 Sun, 03 Apr 2016 13:03:20 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Sun, 3 Apr 2016 13:03:20 -0700 (PDT)
In-Reply-To: <1459619912-5445-5-git-send-email-mehul.jain2029@gmail.com>
X-Google-Sender-Auth: k3Rn0BNX-pqmOvJXXRjdiilukcc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290650>

On Sat, Apr 2, 2016 at 1:58 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> t5520: factor out common code

To distinguish this title from that of patch 5/7, you could say:

    t5520: factor out common "successful autostash" code

> Four tests contains repetitive lines of code.
>
> Factor out common code into test_pull_autostash() and then call it in
> these tests.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> @@ -9,6 +9,16 @@ modify () {
> +test_pull_autostash () {
> +       git reset --hard before-rebase &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       git pull $@ . copy &&

Nit: This could just as well be $* rather than $@.

> +       test_cmp_rev HEAD^ copy &&
> +       test "$(cat new_file)" = dirty &&
> +       test "$(cat file)" = "modified again"
> +}
> @@ -247,46 +257,22 @@ test_expect_success '--rebase fails with multiple branches' '
>
>  test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
>         test_config rebase.autostash true &&
> -       git reset --hard before-rebase &&
> -       echo dirty >new_file &&
> -       git add new_file &&
> -       git pull --rebase . copy &&
> -       test_cmp_rev HEAD^ copy &&
> -       test "$(cat new_file)" = dirty &&
> -       test "$(cat file)" = "modified again"
> +       test_pull_autostash --rebase
>  '
>
>  test_expect_success 'pull --rebase --autostash & rebase.autostash=true' '
>         test_config rebase.autostash true &&
> -       git reset --hard before-rebase &&
> -       echo dirty >new_file &&
> -       git add new_file &&
> -       git pull --rebase --autostash . copy &&
> -       test_cmp_rev HEAD^ copy &&
> -       test "$(cat new_file)" = dirty &&
> -       test "$(cat file)" = "modified again"
> +       test_pull_autostash --rebase --autostash
>  '
>
>  test_expect_success 'pull --rebase --autostash & rebase.autostash=false' '
>         test_config rebase.autostash false &&
> -       git reset --hard before-rebase &&
> -       echo dirty >new_file &&
> -       git add new_file &&
> -       git pull --rebase --autostash . copy &&
> -       test_cmp_rev HEAD^ copy &&
> -       test "$(cat new_file)" = dirty &&
> -       test "$(cat file)" = "modified again"
> +       test_pull_autostash --rebase --autostash
>  '
>
> -test_expect_success 'pull --rebase: --autostash & rebase.autostash unset' '
> +test_expect_success 'pull --rebase --autostash & rebase.autostash unset' '
>         test_unconfig rebase.autostash &&
> -       git reset --hard before-rebase &&
> -       echo dirty >new_file &&
> -       git add new_file &&
> -       git pull --rebase --autostash . copy &&
> -       test_cmp_rev HEAD^ copy &&
> -       test "$(cat new_file)" = dirty &&
> -       test "$(cat file)" = "modified again"
> +       test_pull_autostash --rebase --autostash
>  '
>
>  test_expect_success 'pull --rebase --no-autostash & rebase.autostash=true' '
> --
> 2.7.1.340.g69eb491.dirty
