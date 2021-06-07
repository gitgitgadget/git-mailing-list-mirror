Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CBAC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 21:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1782B610A2
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 21:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhFGVq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 17:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhFGVq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 17:46:27 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFA3C061574
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 14:44:20 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w127so19520990oig.12
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=HVPevmsSHpSuoIm4hGD/xNE7s1gM6jj4E1HZJw8o59M=;
        b=W2K44oF9+6NMfuf/HjFBdm562505+PBICPSSCPwdz60flb9sY1o9XwPoQzimcmuIGM
         5U/IZc6dSQ6siE0oPfKrGvRSU5GjSK+Z7CGVh9PlRcAPLzFPbYvwaWa6ZAkKkDXKyARV
         6zRhIz+SwvoQtmnDRGUhZKXiRhxaCxP7nDAy2knWkdxHtfg30Wf5+ddGKNdc1k9g4KCY
         dM8ATMygfSudLdCCUVqXciBLhwmDtSR4nLdwd/zd4doRyK/R4S27zRNwwqQqSSX83JsN
         Ip6qZX/VObksmgJMRG+KbVfWmuXPJ303Y1cBsVDSjWtsEwF95dFgApSO4MsbOg0Ox0FE
         zwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=HVPevmsSHpSuoIm4hGD/xNE7s1gM6jj4E1HZJw8o59M=;
        b=dUg3K4hbsCkEz68dsljp3VXueyEEoT1oTxfcVsTfiIte+wswBYgywW0z7/2to4n5Ee
         fejhDyfuwNs5/aBmnbv4GY0jDxJdEW/PMAwOvwcCnySb/jcKKHRca9ycNRE3TuXTzGEB
         nKxVeUuCtlq/Okht7umNJcJogdSX+nlNhLsIsHw0dxjSnk5HWtwc8ye/qZ+eCCWNYFl3
         Kc1tdIdxH9uRKWydR4stRtF6LMg+e4ES5mp5GscyCIavW/qAcsLeDnciqm5b8SZqurBS
         RoPrD9XJUA7p1bsCQSm4qhmzg5k3CP3XLGf8iA9dDI8l0UankjZuG78lLUScbWVJmvTG
         BMgQ==
X-Gm-Message-State: AOAM5318wiaJvlDxPeZenG6z1dHW6zjBPTvnZsvNbqHkA4OENxNOoASr
        90MBBIRwxYlTDJbv3wHF0Q0=
X-Google-Smtp-Source: ABdhPJzPiUVgYmHcC4DxJIzMgyDDOVi3eRRgtq8OuHAHfoAQcdRusB/FJIM5hAcvb1SC1X4/S0zCNQ==
X-Received: by 2002:aca:2215:: with SMTP id b21mr811290oic.94.1623102260298;
        Mon, 07 Jun 2021 14:44:20 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p5sm2501986oip.35.2021.06.07.14.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 14:44:19 -0700 (PDT)
Date:   Mon, 07 Jun 2021 16:44:18 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60be93327f1db_db80d208d1@natae.notmuch>
In-Reply-To: <xmqqwnr5ts55.fsf@gitster.g>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <b36e3f99716bf3976fc886df684c300e17566c79.1623085069.git.gitgitgadget@gmail.com>
 <xmqqwnr5ts55.fsf@gitster.g>
Subject: Re: [PATCH 2/4] *: use singular they in comments
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > @@ -1178,7 +1178,7 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
> >  	/*
> >  	 * We could verify this signature and either omit the tag when
> >  	 * it does not validate, but the integrator may not have the
> > -	 * public key of the signer of the tag he is merging, while a
> > +	 * public key of the signer of the tag they are merging, while a
> >  	 * later auditor may have it while auditing, so let's not run
> >  	 * verify-signed-buffer here for now...
> >  	 *
> 
> This is not wrong per-se, but "the tag being merged" is something I
> would have written, as naive non-native English speakers would find
> it disturbing and ungrammatical that "the integrator" singular is
> matched with "singular" they, which goes opposite from what they
> were taught in their foreign language classes [*1*].

It's not just non-native English speakers. According to linguists the
singular "they" only makes sense when the antecedent is plural (comes
from a pool of people), in this case "the integrator" is semantically
singular.

58% of the Usage Panel of the American Heritage Dictionary would
disagree with this usage [1].

> Perhaps offer a passive voice as a weaker alternative to the
> singular they in the guidelines patch?

Yes, "of the tag being merged" does read correctly to me, unlike the
version above.

Cheers.

[1] https://ahdictionary.tumblr.com/post/147597257733/updated-usage-note-they

-- 
Felipe Contreras
