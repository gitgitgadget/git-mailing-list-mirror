Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D1551F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 20:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbeFAUEB (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 16:04:01 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35565 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeFAUEA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 16:04:00 -0400
Received: by mail-qt0-f196.google.com with SMTP id s9-v6so4129919qtg.2
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 13:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nkBHDChcvvHNNkR66C/Y0z4x7bXyco5aac/NXwiJsOY=;
        b=kHDSfOH4nWGmtc2ffwqwxKG7k8YFbQ9oVIMQX6BmIs45MOqCEhTMZgy26vK36WHeYj
         SukOyw2movCvM2GVCioIA/JAJr8Ok0s6WSLBPlMfFKzxAE0epeQRYWB1Y3il473H6zz3
         b/gB5FPw3L+N4a3w0tYu9r9yHGsM+1Cx5JsAUVkufeQl28Ke4eigO09kXGBKWqsFfe4Z
         3TaV63/ADmkbE75vASKs+SJbRkr1Ll4aa6a72ranuJMJjVomgjT3padE+wZPdXkE/6rY
         ExSOaRIPtFTaEoETigsDSs4lVOZ+kwqbc5wqW42QLYjIOcmkWOi30tB8F1PmTDCDfsVZ
         r1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=nkBHDChcvvHNNkR66C/Y0z4x7bXyco5aac/NXwiJsOY=;
        b=tazSHo4eAcz5DSlulC9FZmdZtH8thuMkQ5EdAZOyWgcEknd6fl9rmCiQ4XKeEVIb86
         w0rvLmhmnSJzAQfQtK7yGcnSsruXZU/rvcr7RBX0T88UhwrYu6uZAYLOIDfu3HRXr76u
         dMQNmDkus22Qfy2HEW4ooThrXMJSrEqX0RWWVF9NYgxf2yWGlj76KIIFAhxQWd+byNSd
         TUt6PD4DVpbHM3AXdIVUiz40VqvyAbAMKuPo52Ptw+SJWbwq84EWDJ8HCzyEOH2jpWkf
         ep7jrtyOzucXqTmJfxGMJ/RMJbUkG8aDZ/6v2AvQb3a8A4sG7QAjYESIg/imv0dAVXJ/
         pqkg==
X-Gm-Message-State: APt69E23S2RhtC9XGsAp7SvpjVNLLfBi8IlzyRwzu8I/lwNWBPh2g0Fu
        xfozj/uWf3e6NdJo7QmqJV4KLxUBzXhzg48G1/A=
X-Google-Smtp-Source: ADUXVKJwnUSNyhYN6BlbF0Jwb8hCOcjQ6rv9y1lSsGhJCnM7iPylpLbcCKU9mHkJbSvzLZ5Ku/RQiJ2fjWb1w3W41sY=
X-Received: by 2002:aed:362a:: with SMTP id e39-v6mr12330459qtb.25.1527883439880;
 Fri, 01 Jun 2018 13:03:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 13:03:59 -0700 (PDT)
In-Reply-To: <20180601174644.13055-1-phillip.wood@talktalk.net>
References: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
 <20180601174644.13055-1-phillip.wood@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Jun 2018 16:03:59 -0400
X-Google-Sender-Auth: cAICzEbyGDB3HoKvl6eTAD3pAMM
Message-ID: <CAPig+cSSj2ETXfk8FYUc+=tE6bfoRuqF5Ld4kOgE4+DDpfL+BA@mail.gmail.com>
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

On Fri, Jun 1, 2018 at 1:46 PM, Phillip Wood <phillip.wood@talktalk.net> wrote:
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

s/consist/&ing/
--or--
s/consist/that &/

> well as lines starting with a space as context lines and add a test to
> prevent future regressions.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  git-add--interactive.perl  |  2 +-
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> @@ -1047,7 +1047,7 @@ sub recount_edited_hunk {
> -               } elsif ($mode eq ' ') {
> +               } elsif ($mode eq ' ' or $_ eq "\n") {

Based upon a very cursory read of parts of git-add-interactive.perl,
do I understand correctly that we don't have to worry about $_ ever
being "\r\n" on Windows?

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> @@ -175,6 +175,49 @@ test_expect_success 'real edit works' '
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
> +       [...]
> +       EOF
> +'
> +
> +test_expect_success 'setup expected' '
> +       cat >expected <<-EOF
> +       [...]
> +       EOF
> +'
> +
> +test_expect_success 'edit can strip spaces from empty context lines' '
> +       test_write_lines e n q | git add -p 2>error &&
> +       test_must_be_empty error &&
> +       git diff >output &&
> +       diff_cmp expected output
> +'

I would have expected all the setup work to be contained directly in
the sole test which needs it rather than spread over three tests (two
of which are composed of a single command). Not a big deal, and not
worth a re-roll.
