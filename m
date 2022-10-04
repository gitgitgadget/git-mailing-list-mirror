Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23394C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 21:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJDVsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 17:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiJDVqz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 17:46:55 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F5E15A23
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 14:44:59 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n9-20020a170902d2c900b001782ad97c7aso10929146plc.8
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 14:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M73JnkcUIklE0jTibr9DBFz1t1jyaXLZ9FmfG/dxjPI=;
        b=pOka4fDfx2UpLTysjGJrF60NYxFh10e/lPmg4nCKZ85FfEcc4EfXB4SROgF9qA0v17
         WHTkuLYTnlY3JnLpZaVQWGwEOC8W5dKFos0yfb7V6lzd7QOHI++1rXtVjstgjXeDt0uY
         c8Z78g8t9Y5CjBlVojtc8iYIptdsXL0u/zn4joZj0fsX9hcdQ0bD80mUkuEOVvEYmBiQ
         KP5ia+3g147KCWxjWRnD72eRslbVq2WcKwvuROovyJYgmaNb6RV/lQFvhdeb9nXLSQZH
         t9j8UoLm4vduKaPsAmPz+la9p7LvffnNNxc0i9chBcw7VSy162npbSA5ZPiWQq5TFdQF
         frMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M73JnkcUIklE0jTibr9DBFz1t1jyaXLZ9FmfG/dxjPI=;
        b=aNh00Kp9BULO2D3bgx/LSXVeEndRXJ2YH2J/kYJs5PDPVoBhRqFaMrja1qoMGr+H8V
         BRTrX3MRosJrAqAHlxks/uZGqVEiORUATKnRJ7PvRwNKQsUuVAatPPAhA4wJaS12oM6O
         d2ZPN5Ivei5q7JbVHY5bF7Rjmop9UeCnbwHxR4Mu0x0vY4EhA4w5AFwdbw1x9Lldtogw
         j+egWVJ3BMklUfLjmjne8JGYzuGNwwsHR61plwsUAza6FnFVvVCpriLLrm9QMkga22nG
         3rzAN0rIEPHelhCgMyd3TwxvGVUPTYq4M04hlXOj2E7wLhHvRQHv3BnP+6dsWy3pqPfZ
         gx5A==
X-Gm-Message-State: ACrzQf15my9+8u0icOnCPhhnMUDN1VFIKP/2DsWzZyxbOTeIu80r/pQd
        8MYosnp8fw2QTRxDCh+F0bxNvoosQ1fN/B1keE/B
X-Google-Smtp-Source: AMsMyM4Nx0XB85kIWy0MqcuswMtxeXWzM0NWZrqbXcjlpQQHCgIXWGuI8RCjH8wu6OlAnLfa+vTanWB8I5UCrRTgxPX0
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:c986:b0:205:f08c:a82b with
 SMTP id w6-20020a17090ac98600b00205f08ca82bmr415054pjt.1.1664919898779; Tue,
 04 Oct 2022 14:44:58 -0700 (PDT)
Date:   Tue,  4 Oct 2022 14:44:54 -0700
In-Reply-To: <46799648b4ce16b0cbacc307443a343994ed064f.1664886861.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221004214455.3383714-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 8/9] bundle-uri: fetch a list of bundles
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> +static int unbundle_all_bundles(struct repository *r,
> +				struct bundle_list *list)
> +{
> +	/*
> +	 * Iterate through all bundles looking for ones that can
> +	 * successfully unbundle. If any succeed, then perhaps another
> +	 * will succeed in the next attempt.
> +	 *
> +	 * Keep in mind that a non-zero result for the loop here means
> +	 * the loop terminated early on a successful unbundling, which
> +	 * signals that we can try again.
> +	 */
> +	while (for_all_bundles_in_list(list, attempt_unbundle, r)) ;
> +
> +	return 0;
> +}

This function always returns 0 regardless of how many successful 
iterations there were: we would need the number to be equal to the 
number of bundles in the list if ALL, and 1 if ANY. 

Which brings up the question...we probably need a test for when the 
unbundling is unsuccessful. 

Other than that, everything looks good, including the removal of one 
patch and the addition of the "bundle-uri: suppress stderr from 
remote-https" patch.
