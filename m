Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E95D1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 19:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbeFATH6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 15:07:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32908 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbeFATH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 15:07:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so6386283wma.0
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PliAO4vE7AbZ378fVR/mtiJG84Llz2M1k5g33LBLiNI=;
        b=McXSjYAj+xIfwWptYsj6ypevhI+NKXau8ZVikpoOMbXm3O0/ZllRnu00xK6nCtRY6M
         22hdMMO7x0R2SpkrZxtOmpiBZVIHteMLRNKaLAh/VJ32WY3gsStuKZkEM32aihMLj9sE
         6N2D5OKPo1JyYHKPT2FFkzp75mIgLQEophoSNAFjQtTH8OoOCuptT1Cpna6NWDkGImWg
         16AY+7U7FWGB0aMDULFfkPmK5eB+O/beoPqtyDZSTZ3+c3WrGyPazY91XGcWpUl9Ap92
         EcyvyYIDKzMre4m9WjKKiweVtgpiGasU9XUrr+QrHgfrtNbXxEk/aSbQNpX4+DAiaQQt
         Xvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PliAO4vE7AbZ378fVR/mtiJG84Llz2M1k5g33LBLiNI=;
        b=k9RMIvxstYiNK+5Z5ktUaFJ1jbZ6AZK+XU2QNYr2pZ0tQKu8P4NFnvNbEHVz/hjqfF
         F7CsFOcdsZZMbIrvhhRdrYSEce6vm/8hdH7Wx43OoagVJDDjdlS20XI3rM74iR9gFitb
         Hrj69tSzklDoF2BTUCah9APyqO6Ednz/HD9mB2eVmuGnqBI7otkquFh2Xtrqsb9qzeIq
         AQJX5q0p71hCO5tq4DzS4ihFVOe/hMzudn4akGXLGxPqZEIJUX04eLRnDmIj0IWllbUu
         6Drd1BfzT/quBIgHetJPQl4S146YtgvsIjzjv5LUNG2Z4dnDChQwHrh0sl18RgGURDtV
         Uxrg==
X-Gm-Message-State: ALKqPwfG0vRl5M8PYJ0OEvge7iqWnjrawSIpohwRBtjs0L74Q7akz99c
        6ku9aiZSyi14gJHuVNsQTKLCUetT/weh/m+CKzU=
X-Google-Smtp-Source: ADUXVKLX1LHrXSZEqzbn4Cu68qwASdlTtTxQXQCZXTPpkqy1WSLcTE7P2Cwki+6DzhXf+HFVU4YXkBpo8EoS7SKTXbI=
X-Received: by 2002:a50:c089:: with SMTP id k9-v6mr13409022edf.303.1527880076453;
 Fri, 01 Jun 2018 12:07:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:ea87:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 12:07:35 -0700 (PDT)
In-Reply-To: <20180601174644.13055-1-phillip.wood@talktalk.net>
References: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
 <20180601174644.13055-1-phillip.wood@talktalk.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 1 Jun 2018 12:07:35 -0700
Message-ID: <CA+P7+xokjMcbbrH2iCt5SWMxgsstA+VXHOQgx4debd7Oou-RRA@mail.gmail.com>
Subject: Re: [PATCH] add -p: fix counting empty context lines in edited patches
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Martin Agren <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Oliver Joseph Ash <oliverjash@gmail.com>,
        Mahmoud Al-Qudsi <mqudsi@neosmart.net>,
        Jeff Felchner <jfelchner1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 1, 2018 at 10:46 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> recount_edited_hunk() introduced in commit 2b8ea7f3c7 ("add -p:
> calculate offset delta for edited patches", 2018-03-05) required all
> context lines to start with a space, empty lines are not counted. This
> was intended to avoid any recounting problems if the user had
> introduced empty lines at the end when editing the patch. However this
> introduced a regression into 'git add -p' as it seems it is common for
> editors to strip the trailing whitespace from empty context lines when
> patches are edited thereby introducing empty lines that should be
> counted. 'git apply' knows how to deal with such empty lines and POSIX
> states that whether or not there is an space on an empty context line
> is implementation defined [1].
>
> Fix the regression by counting lines consist solely of a newline as
> well as lines starting with a space as context lines and add a test to
> prevent future regressions.
>
> [1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html
>
> Reported-by: Mahmoud Al-Qudsi <mqudsi@neosmart.net>
> Reported-by: Oliver Joseph Ash <oliverjash@gmail.com>
> Reported-by: Jeff Felchner <jfelchner1@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> My apologies to everyone who was affected by this regression.
>

Ahhh I suspect this is why my edited code in add -p was sometimes
failing to apply!

Thanks,
Jake

>  git-add--interactive.perl  |  2 +-
>  t/t3701-add-interactive.sh | 43 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index ab022ec073..bb6f249f03 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1047,7 +1047,7 @@ sub recount_edited_hunk {
>                         $o_cnt++;
>                 } elsif ($mode eq '+') {
>                         $n_cnt++;
> -               } elsif ($mode eq ' ') {
> +               } elsif ($mode eq ' ' or $_ eq "\n") {
>                         $o_cnt++;
>                         $n_cnt++;
>                 }
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index e5c66f7500..f1bb879ea4 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -175,6 +175,49 @@ test_expect_success 'real edit works' '
>         diff_cmp expected output
>  '
>
> +test_expect_success 'setup file' '
> +       test_write_lines a "" b "" c >file &&
> +       git add file &&
> +       test_write_lines a "" d "" c >file
> +'
> +
> +test_expect_success 'setup patch' '
> +       SP=" " &&
> +       NULL="" &&
> +       cat >patch <<-EOF
> +       @@ -1,4 +1,4 @@
> +        a
> +       $NULL
> +       -b
> +       +f
> +       $SP
> +       c
> +       EOF
> +'
> +
> +test_expect_success 'setup expected' '
> +       cat >expected <<-EOF
> +       diff --git a/file b/file
> +       index b5dd6c9..f910ae9 100644
> +       --- a/file
> +       +++ b/file
> +       @@ -1,5 +1,5 @@
> +        a
> +       $SP
> +       -f
> +       +d
> +       $SP
> +        c
> +       EOF
> +'
> +
> +test_expect_success 'edit can strip spaces from empty context lines' '
> +       test_write_lines e n q | git add -p 2>error &&
> +       test_must_be_empty error &&
> +       git diff >output &&
> +       diff_cmp expected output
> +'
> +
>  test_expect_success 'skip files similarly as commit -a' '
>         git reset &&
>         echo file >.gitignore &&
> --
> 2.17.0
>
