Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A579C433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 02:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF0720786
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 02:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAcf8LwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgH1CQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 22:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH1CQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 22:16:16 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D11C061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 19:16:16 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id j3so2031409otk.13
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 19:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDFPAQpC400s9pzppdUIzCp4yhV3Q2UOoZGXot80ahA=;
        b=iAcf8LwGWTNIsCMqXPwPqZIPj/Wdw5ReqUczW0jdqLbgK8H23D15XjQF88tmZ5Ft/K
         bwLghEg8/KaiVezVSq9TFbgQ0+v1flVFGqdj9qX/+Z7wuCZWRwU6wrMIb7h1PjmkaXKN
         fJP3QM7vwPN8I2Szv1nODJnmRdLUfmCJ0dqjBvgIaJPFjwY6U7HLSabEaAIoGDDy0fcB
         NnUSLKBz2wzr8wfoOBpyI9O3ZVNi/k+jJBvlq1AQtElahcjWDRKUR26DAwLNESPOx77a
         I7DW8k0IZbPCwUAgzCfmDZrNaoyXCrG4eL7F9VaMtfDU8tz0uAQjP9fC8Dk7GBo4LvFX
         eKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDFPAQpC400s9pzppdUIzCp4yhV3Q2UOoZGXot80ahA=;
        b=IQ2wPGANlansoB8ltBy8S8M9e1cvIO7/mFQ/dSfJlYbUglKp6pc+bCaazrnw5vwr5F
         USgqSGnCAm9MEaDcyigI/08zCaWI8j8EAkRsdBhNE0QMyQKCqB3GoXB2gqoviv3JrFPe
         LFb8aTxJQVc2kMYrkQyFNFlf8L8nToT0bpvKN0Np7E7IRxSr8t7rTVQ2R2I4r8WkPE7/
         Fx3Yvf19YjkAnd9VaRJxIYj/jt2q3pahdp1WXE8Z6G8fko0Ko4MY6H6sASElDIE6Mz5G
         Kou7LrtZQ4uxomoKkPrb7nQE/CRekbFkXMyqbWDW0k6wzmtJuc3ustZELVS7ADGGuNyt
         wpHQ==
X-Gm-Message-State: AOAM5313CfQBONkHUG+Ca4joX3mvFODvVUbTrzkXL0lrc7LlRFHoTAFJ
        MMiGrtIfpc+LUTLzX+rv4t/1GNM6vmNrXQvF+NE=
X-Google-Smtp-Source: ABdhPJyi9cA3OFgLoQrajgHXMMabF5MXxRVBgHenV1TaLhdg8Bwlh52LJPldPJOqCwDufW1d5AWad+Gcww7VswI4IzE=
X-Received: by 2002:a9d:3d89:: with SMTP id l9mr6335955otc.316.1598580974422;
 Thu, 27 Aug 2020 19:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 27 Aug 2020 19:16:03 -0700
Message-ID: <CABPp-BHCVWWFDL2kpWymNuX_t4anX2Xw-xiTK8N+MdrBoopERg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2020, #07; Thu, 27)
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 2:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * mt/grep-sparse-checkout (2020-06-12) 6 commits
>  - config: add setting to ignore sparsity patterns in some cmds
>  - grep: honor sparse checkout patterns
>  - config: correctly read worktree configs in submodules
>  - t/helper/test-config: facilitate addition of new cli options
>  - t/helper/test-config: return exit codes consistently
>  - doc: grep: unify info on configuration variables
>
>  "git grep" has been tweaked to be limited to the sparse checkout
>  paths.
>
>  Review needed on 4/6; otherwise looking sane.
>  cf. <CABPp-BGdEyEeajYZj_rdxp=MyEQdszuyjVTax=hhYj3fOtRQUQ@mail.gmail.com>

Kinda disappointed to see this stalled out; especially after so much
work put into it.  This spawned lots of other side discussions and a
topic or two outside this series as well.  I really like the overall
result we came up with out of this series and would like to see it
land.  If we can't get more reviewers, maybe we just merge it down
anyway?  But, in an attempt to prod some review...

Jonathan: I pinged you in chat about this series some time ago and you
said you'd take a look and comment.  I can't find a reference
anywhere, but maybe you talked with Matheus in IRC somewhere?  Do you
recall?

Matheus: Do you have any outstanding items for this series or is it
good as far as you know?
