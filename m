Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01501C77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 16:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbjDTQLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 12:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjDTQLU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 12:11:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8136A4C37
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 09:11:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63d4595d60fso8193673b3a.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 09:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682007066; x=1684599066;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXlkSUz4slv/NwsRQKyWLRjAsEUrDAKFkshnViKKSbk=;
        b=dt/12/sLj4qzZlxU/1HhLDitTHqcbjJV2DW5wBt8XNFxYvrSOOuwqjW1VNSuIS7I/V
         NHt76WvxDPIy+uO29DJWPwye3N4Dzez4nGCto+flPinB656eOcdwakJpBiZF/Ue+06G/
         LiQPZX2xdwaQKb895Y9O2Tchsv40Tx61bC65Ur91Uur1eyctEkGmMNe/0BXkZ7xoEk/e
         DM3N+9EgSdNHDFTa28PWoKysEhzblhYhq5SbIbX8C14fdvwvpx4Bc5SybHeME81CMtCy
         fYMs+DstgXuM0NgKP1H8hSc3ToEtELYtsV2XpG3zQKp7ps0jZjcCA4uF5SmoDqsHr0oV
         02OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682007066; x=1684599066;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TXlkSUz4slv/NwsRQKyWLRjAsEUrDAKFkshnViKKSbk=;
        b=GIupMBpn3IQabCqneDrUZH44SPB1Yyl707sLopPpkWSwUSVgPJre/MQOrUo2aEgdjg
         FgkQIYwWYyLIfXisZGKSJhJSXYfFixzulSXiTJi3TzXDw/H6zbUt3seeyE/DaO9rBEhO
         YzsCX83kbsDtFjnnm0dVKTX1V/5tuMHuVf6UkVpuNxkofdD1xzoSmvWei14ZvvUTLU+j
         kd1myTXrXUAnK2sxvTGgH0+SEzFFGC8KuDPFWUb6b9QkwllrsomjvQOKL1D3+brlGvoX
         ysvrs0cqTx8jpBiA7rNTbH06SWoWtUIdSsD4rCFzDg1JY1EDUaoyY7EyLwEfHX2gMIWU
         JoGA==
X-Gm-Message-State: AAQBX9c5UC7+t2lCF+Qk+p78T+pxwFX/EN8qis/kMa3sXeb32UpCFtxh
        9hi9wcma6KeGvUQgYeqjKdmwDDnank0=
X-Google-Smtp-Source: AKy350a+pySHbJWjfXkDeMi9/bfzc5D6nvZ5MY+/bxZ2HH3azBMZ2lrZDatWXNhdH8aFG+9jUolf1A==
X-Received: by 2002:a17:90b:1906:b0:23d:54e8:3bb7 with SMTP id mp6-20020a17090b190600b0023d54e83bb7mr2245512pjb.17.1682007065517;
        Thu, 20 Apr 2023 09:11:05 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id s91-20020a17090a2f6400b0023cfa3f7c9fsm1387501pjd.10.2023.04.20.09.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:11:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] merge-ort: fix calling merge_finalize() with no
 intermediate merge
References: <pull.1518.git.1681974847078.gitgitgadget@gmail.com>
Date:   Thu, 20 Apr 2023 09:11:04 -0700
In-Reply-To: <pull.1518.git.1681974847078.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Thu, 20 Apr 2023 07:14:06
        +0000")
Message-ID: <xmqqedoe4jqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> If some code sets up the data structures for a merge, but then never
> actually performs one before calling merge_finalize(), then
> merge_finalize() wouldn't notice that result->priv was NULL and
> return early, resulting in following that NULL pointer and getting
> a segfault.  There is currently no code in the git codebase that does
> this, but this issue was found during testing of some proposed patches
> that had the following structure:
>
>     struct merge_options merge_opt;
>     struct merge_result result;
>
>     init_merge_options(&merge_opt, the_repository);
>     memset(&result, 0, sizeof(result));
>
>     <do N merges, for some value of N>
>
>     merge_finalize(&merge_opt, &result);
>
> where some flags could cause the code to have N=0, i.e. doing no merges.
> Add a check for result->priv being NULL and return early to avoid a
> segfault in these kinds of cases.
>
> While at it, ensure the FREE_AND_NULL() in the function does something
> useful with the nulling aspect, namely sets result->priv to NULL rather
> than a mere temporary.

Clearly written.  The FREE_AND_NULL() bit is a bit embarrassing
slip-up for everybody who reviewed and applied the initial patch
X-<.

And we need to undo the attribute direction change in merge_start()
even if we didn't perform any, so the early return cannot be done
before that.  So everything makes sense as a fix to the reported
problem.

> Reported-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     merge-ort: fix calling merge_finalize() with no intermediate merge
>     
>     See
>     https://lore.kernel.org/git/CABPp-BHCdjOutYqdMO1NbYKNA0BgkXRgwUEKK=MX0kXM-5G_DQ@mail.gmail.com/
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1518%2Fnewren%2Ffix-merge-finalize-with-no-merge-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1518/newren/fix-merge-finalize-with-no-merge-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1518
>
>  merge-ort.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 5bf64354d16..cba3662e497 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -4718,14 +4718,14 @@ void merge_switch_to_result(struct merge_options *opt,
>  void merge_finalize(struct merge_options *opt,
>  		    struct merge_result *result)
>  {
> -	struct merge_options_internal *opti = result->priv;
> -
>  	if (opt->renormalize)
>  		git_attr_set_direction(GIT_ATTR_CHECKIN);
>  	assert(opt->priv == NULL);
>  
> -	clear_or_reinit_internal_opts(opti, 0);
> -	FREE_AND_NULL(opti);
> +	if (!result->priv)
> +		return;
> +	clear_or_reinit_internal_opts(result->priv, 0);
> +	FREE_AND_NULL(result->priv);
>  }
>  
>  /*** Function Grouping: helper functions for merge_incore_*() ***/
>
> base-commit: 667fcf4e15379790f0b609d6a83d578e69f20301
