Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A49C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37E66101D
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhGPTRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 15:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhGPTRr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 15:17:47 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823ACC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 12:14:51 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so10922205otp.8
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=fhtavKP+VIVJaVrdq+gsHQoRMvX78+submhBuHgmNAc=;
        b=PXU5/PV5yI/ysckTgWbEC7WHmI0N/KThNMUA58kp5m8JRTzP+UIRae1Zgxhb/jT1mM
         GQjOMDTH5lrXtFwaTV+LR0dILKxDKMlltVRJEB+gHPz6z5w+VhXUMnvUT9IFnLLmLMx0
         m/qixoeJb3HrFP42b6X2pjsmDxi6H7dkXS3h2qqQqHLXdYdGaXb7Js41EHE56rHDYh2q
         favPuAlzp7hO3BwZ2NelLbK8NhYdndKSRgzuUqBEdzftC+CKUuLjjtAvSqcrWaqcx0ds
         98A9ggDImTxnbKhUUglPqVA0e/GH600s/Ny69rw2eh9viwYnK4EfwtEs/T8QWqZ8eLqR
         Ta4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=fhtavKP+VIVJaVrdq+gsHQoRMvX78+submhBuHgmNAc=;
        b=G89RE16PQPbfjrYlbdnBpQDLisUTKHlZNrb9IK4ifjRrQAP/LuBigOrESpJ1Xb9Q6l
         QBWhMKAPbKbYNLQEznTovKecYvvjG9ymS7uXIP+cJFsnYIKQ5TiIMuSZ9lonQ73egWD3
         YzMGarCQKA8ay6x4pO2DtuYgHYJt0EWXQAFrgl+n0oImCdQvEgrHiBIKXWo61deMiCir
         vOkZzwtAda4hjfYZRfKR8p83afr0gKp3nE4a6bhCVZ/bwuxdqK5eQMzPd8HLsPxRMhHL
         vsqXGRZMcIgygDc2AaxqA31q5Uu4yrm1NzXNs8qvPZ6YQ15r96DKsEBc7SxPWy+j0iKH
         z4/Q==
X-Gm-Message-State: AOAM531bV2104ioKwB8ZC9bPi41gDNA74ODTeX7J9WmLEG32s/v/Qy7F
        q3RPmd/AsTa7ch0Qcdho03M=
X-Google-Smtp-Source: ABdhPJzJOLRN7BMAb3FzW414eZuF7G+TKiWv8cCwWRgPOY9ZlOb3N2DEtzSJi5FDGQvUxQGAaW1zcA==
X-Received: by 2002:a9d:6a0c:: with SMTP id g12mr9632856otn.220.1626462890845;
        Fri, 16 Jul 2021 12:14:50 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id a137sm1653793oib.0.2021.07.16.12.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 12:14:50 -0700 (PDT)
Date:   Fri, 16 Jul 2021 14:14:48 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Message-ID: <60f1daa896f69_330208b1@natae.notmuch>
Subject: When are you going to stop ignoring pull.mode?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> It may be a worthy goal, but I cannot implement correct behavior if I
> cannot determine what correct behavior is.
> 
> You've only specified how to handle a subset of the valid combinations
> in each of your emails, and from those individually or even
> collectively I cannot deduce rules for handling the others.  Reading
> the dozen+ recent messages in the various recent threads, I think I've
> figured out your opinion in all but two cases, but I have no idea your
> intent on those two (I would have thought --rebase override there too,
> but you excluded that), and I'm rather uncertain I've correctly
> understood you for the other ones (I really hope gmail doesn't
> whitespace damage the following table):
> 
>    pull.ff  pull.rebase  commandline            action
>      *          *        --ff-only --rebase     fast-forward only[1]
>      *          *        --rebase --no-ff       rebase[1]
>      *          *        --rebase --ff          rebase[1]
>      *          *        --ff-only --no-rebase  fast-forward only
>      *          *        --no-rebase --no-ff    merge --no-ff
>      *          *        --no-rebase --ff       merge --ff
> 
>     <unset>     *        --no-rebase            merge --ff
>     only        *        --no-rebase            merge --ff[2]
>     false       *        --no-rebase            merge --no-ff
>     true        *        --no-rebase            merge --ff
> 
>     <unset>     *        --rebase               rebase
>     only        *        --rebase               rebase[2]
>     false       *        --rebase               ?[2]
>     true        *        --rebase               ?[2]
> 
>      *          *        --ff-only              fast-forward only[1]
> 
>      *       <unset>     --no-ff                merge --no-ff
>      *        false      --no-ff                merge --no-ff
>      *       !false      --no-ff                rebase (ignore --no-ff)[2][3]
> 
>      *       <unset>     --ff                   merge --ff
>      *        false      --ff                   merge --ff
>      *       !false      --ff                   rebase (ignore --ff)[2][3]
> 
> [1] https://lore.kernel.org/git/xmqq7dhrtrc2.fsf@gitster.g/
>     https://lore.kernel.org/git/c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com/
> [2] https://lore.kernel.org/git/xmqqpmvn5ukj.fsf@gitster.g/
> [3] https://lore.kernel.org/git/xmqq8s2b489p.fsf@gitster.g/
> 
> It appears you, Phillip, and I all had different opinions about
> correct behavior and in a few cases though the documentation clearly
> implied what we thought.  So, I'd have to say the documentation is
> rather unclear as well.  However, even if the above table is filled
> out, it may be complicated enough that I'm at a bit of a loss about
> how to update the documentation to explain it short of including the
> table in the documentation.

Yeah, now you are starting to see the problem.

How many more failed attempts do you need to go through before accepting
that the approach you thought was feasible is in fact not feasible?

The solution is simple and self-documenting:

  pull.mode={fast-forward,merge,rebase}

-- 
Felipe Contreras
