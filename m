Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2179C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37CB20882
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7JKRwoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762860AbgJYD31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762849AbgJYD31 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:29:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA329C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:29:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n6so8281023wrm.13
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2kcjgPb1Zfi9s/aTlH5yfS8pOqpUDV2jaYfjYbETRNs=;
        b=O7JKRwoA79AxVnYKHKIwtKXfE8kWb+SWP0jmWIGnOIrhxQVexqHkkAdfUWZ6jjEx4b
         SG/tX2frIO1mymaOhzra3LAjoeRfc8lvvGSwleQg5CUab6ZZqfSAgyJc0Wnz3P5h7udN
         S2vg0bzCsOZVV4GHQ3kABf/Os67I4DLM5DZWZsGrcpgW9pfW2zM/QxhVZHVllts5WpPj
         k8nBpruY4x7Uh2Di1tGST/K30yxWIpNpLk8/RWqwugbAqsQdQVUB7YZIjo/nvkEK+h7j
         GyVCbBjVAogNYjF9NPBQP1dKplsagPmRBJ7ygEvVAWbeHV+2VbgAjRm2PzS6SWMkrvrf
         h7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2kcjgPb1Zfi9s/aTlH5yfS8pOqpUDV2jaYfjYbETRNs=;
        b=fnnY6jGNMB9gRvKHXM7S0dPHK48q+JNxuld/BkGclzV63TbrciJpA3Tec89da4zYHf
         3adzMNapwFvGLXZ7CiBB8k+9gdjl/6GnXb2PxB37wczOZXM8GFqsMew/wnrN6sP1WTN+
         jZvxwuCWHHS21YRVt61y5WxdlinLk20EfaDY4nKHrdcEG8jQo3ZmUMR/zOLr/+o4jAF/
         TflsSwiHVgNdyjqMdABtPZ3fwea0/4FWbs4t5kd7SAHKspmnEorUya5MMPPWTASQvWjt
         Tu9W0Cv0b+RUWYQCWSwxjSarQ1/HRJDTfXbBdXRTKR1qGKU9nClAu4xuWZcEbeBYj1t2
         wXuw==
X-Gm-Message-State: AOAM530ml7pMcSX7OBztB/q9fkQz5m1Z6La2pFuIaQf8261t5OgonurQ
        HerW+ZlpbKE298F13y+QuUOgnY9lSw4sTnf7ngk=
X-Google-Smtp-Source: ABdhPJxNFLzAh12XE9Mhnj9yAz1KZ0eaOkuDtHHtrWjjbA7DpJ3uYIGkUE3Nla0Nxyss5SBwXSVs2lAOUBA6KnBM8QU=
X-Received: by 2002:adf:ff8e:: with SMTP id j14mr11150928wrr.255.1603596565443;
 Sat, 24 Oct 2020 20:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.814.git.git.1593687080695.gitgitgadget@gmail.com>
 <xmqqr1to8dv9.fsf@gitster.c.googlers.com> <abc4ab95-ed65-1d6b-e964-73734c08cda9@haller-berlin.de>
In-Reply-To: <abc4ab95-ed65-1d6b-e964-73734c08cda9@haller-berlin.de>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 24 Oct 2020 22:29:14 -0500
Message-ID: <CAMP44s3=CUmx_7DCExK7L4trZvQTxO67Qk20eexsP3su-3RyKQ@mail.gmail.com>
Subject: Re: [PATCH] Fix zsh installation instructions
To:     Stefan Haller <lists@haller-berlin.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexey via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>, Alexey <lesha.ogonkov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 12:39 PM Stefan Haller <lists@haller-berlin.de> wrote:

> Yes, the change is sane. The wrong file extension (.zsh vs. .bash) was a
> documentation bug that I had noticed myself, but forgot to submit a
> patch for.

Yes, a patch was wrongly applied that changed it from .sh to .zsh.

> The other hunk (adding compinit) is not so important to me; I suppose it
> was not in the original version because most zsh users already have this
> in their .zshrc anyway. But it's not wrong, and doesn't hurt to have
> here, I guess.

If you don't have compinit, then how is the '_git' script being loaded
in the first place?

-- 
Felipe Contreras
