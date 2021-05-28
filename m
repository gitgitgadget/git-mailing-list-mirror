Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58609C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 252246127C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhE1U7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 16:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhE1U7V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 16:59:21 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C7BC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:57:44 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id s19so5528681oic.7
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r1BHvxj8oW22LzrZcaw9WU5bOvTU/fpnuzser1DVvp0=;
        b=dSclK51Goz7BI1Eumam2S79qaQG1s3CG5f8DUFPHGtO2l1KRQ+hIh+1HeoSf5DdWiW
         4Jf9MD1zVnt1jG2+YOem2ilkS1iITLMGTJR81Bp2HW5TFFWrK7AG9ZMiSoWaGjOMjbe5
         gcN4PtjYDowWFs13g+/leYLx0IGCO6R0hNiRw5Fx+tm3hqFbWY6F9peAZ4rGGkqyKxW6
         XTU/kh+6Up5iz84gx9QPsETxnskXlj2SJQn9/QyzcSbZXBwQZ3aW7TBnWKuJU47Wkx3/
         DY629zYsncboLadQaAsQ9qkXAFE1BZy637dqfJPv7QCRZX6mMHWpl9tbn9lNL90skIoS
         Doag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1BHvxj8oW22LzrZcaw9WU5bOvTU/fpnuzser1DVvp0=;
        b=Wa257erAFcYFd5zFIGPplPTtsIcyQMLYwKgc2jeDYVMmz/dr0NBqbqJrZzlDu4GSiV
         bk5YEktA2ccyYCM1KN4EyhAF6Qs1Buo+7Ayb5R4z6cs34zUommFuvtLGnEKmANXGumaP
         8+lrxvG34q0oUkRTRpD3SySw81RrLuM3fc4wu6BYd75dzg/GT8ruQr6KgnR6rnABswsr
         iu2mT5aZ8iyPYmHkGB8Julhm9hP4I7PPZbcwApnMqN1NEOoQvYGFGFzw+VQ45Nv7qXcR
         Lx7GbOSjJ4+5stRPPoe1LlC2Th1ovVl17A4LRQHZzF8VZi8/UKqV3vML1M4ZT3iphg3V
         /rQA==
X-Gm-Message-State: AOAM532WEW8iqo0V5Ab8HYbad0uL4LXimgfm94PEbfk2PEDi6X1fMqYe
        TrBbwZn8AqZA/iKxFq9FO8XJ7GBcErUKej5SqnU=
X-Google-Smtp-Source: ABdhPJxlG8LyX+1bxN/2IpK13A1M0sIf3TqlcLcx3renbYXnZImO1yrxK60asWWYs9K6pPuwIhnxL1pdn/SYdoQHDPQ=
X-Received: by 2002:aca:30cd:: with SMTP id w196mr10108019oiw.167.1622235464245;
 Fri, 28 May 2021 13:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210528201014.2175179-1-felipe.contreras@gmail.com> <20210528201014.2175179-5-felipe.contreras@gmail.com>
In-Reply-To: <20210528201014.2175179-5-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 May 2021 13:57:33 -0700
Message-ID: <CABPp-BG=496bZ78ToKK0vwmmtWDDC4qbCZfXbL+odzecy8U7vw@mail.gmail.com>
Subject: Re: [PATCH 04/11] push: simplify setup_push_simple()
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 28, 2021 at 1:10 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> branch->refname can never be different from branch->merge[0]->src.

This statement isn't true without additional qualifications.  Perhaps
extend your commit message with "...since the 'Additional safety'
check dies if they differ." or some other wording that qualifies why
it's true at the point of the code in question.


> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/push.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 9c807ed707..73fe083682 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -225,14 +225,10 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
>
>  static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
>  {
> -       const char *dst;
> -
>         if (!branch)
>                 die(_(message_detached_head_die), remote->name);
>
> -       if (triangular) {
> -               dst = branch->refname;
> -       } else {
> +       if (!triangular) {
>                 if (!branch->merge_nr || !branch->merge || !branch->remote_name)
>                         die(_("The current branch %s has no upstream branch.\n"
>                             "To push the current branch and set the remote as upstream, use\n"
> @@ -248,10 +244,8 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
>                 /* Additional safety */
>                 if (strcmp(branch->refname, branch->merge[0]->src))
>                         die_push_simple(branch, remote);
> -
> -               dst = branch->merge[0]->src;
>         }
> -       refspec_appendf(&rs, "%s:%s", branch->refname, dst);
> +       refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
>  }
>
>  static int is_workflow_triangular(struct remote *remote)
> --
> 2.32.0.rc0

Simple transformation allowed by the "Additional safety" check; makes sense.
