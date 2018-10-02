Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 123A01F453
	for <e@80x24.org>; Tue,  2 Oct 2018 23:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725754AbeJCGcP (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 02:32:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42977 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeJCGcO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 02:32:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id n2-v6so3649590edo.9
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 16:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EPbctQUTl94xU/Od3wgLPWy8Tju19SKqJiG2WLKi3A0=;
        b=XLnDvxekTXYL8YGkB6EKKPUfuygw3v5hRS9S+pvZFca8j83YMNLnejy9gKKPEAoES/
         zrQGC//2vMCQWthdyD0Tn0wbRnvFCk2Tu5skwiCgX6XAbDfpwE+gLfaWhIK1eTTOhaSn
         95gU8JtaUOD47RVGZxKGWJUV/McTdJeEfQfWhhI6V1zGUqJLoRFX/FAcBCZZ6gQbUnlb
         DaUpu+WDr8ujaYPrvy4qiYef3xfxGs2KeuAwbbVLpiTGkC9HUlq0gaRvZLB/IAdKiPhz
         HjXi639MEIDIBtP2xq7sj6YcvPTZ4iwobrTHROp4OPtB3ufKJEX/Q/coMDzoCyA6ATed
         l+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPbctQUTl94xU/Od3wgLPWy8Tju19SKqJiG2WLKi3A0=;
        b=ONbJNOb/5LLsltf+6CXbewlMFj5Q7jofdWU2Wd8JBBPcUbNcbrm6n3a72HqI79+Dk7
         t84Zty8RULNblII4tdL3Q0dDy+vc5S3cxymyyFTKywsP8vLtFcZuNChk643cYknjMTx+
         gvzS/cPYAMm6G60wifVduvXXbAY0dcV1xdfQSyS3WhCyoEvRQUQq83sx16zpTwZ2MVth
         99wK8Pp8J3uAsCwsueCHp73xtS6WFCeqaNimEVmiygrGxjaARZr5KXGYs7g8evn8TafZ
         0IT2c4u1Bk87636guce++CSUOr9einUe/jTJvKLjg9uqMdCARK8FdYSyc634qtC/Z1CV
         Zglg==
X-Gm-Message-State: ABuFfoh40PYihtM5f6RvZVrCOsNqFPv9M4G57nAR7jEKQLSpaAug2LFJ
        1a6TEPzLRCPGteOQhCfLF9S4zzWMprdGZR6VD9A=
X-Google-Smtp-Source: ACcGV60hAFA2frPKkEIqjD0lKS/P1F3IlvNjzEvkZ2enkgz3mQUcGt8cw26D2Uf69QrcwDsz3KHZLmhgn/EKo5htEAU=
X-Received: by 2002:a50:93c5:: with SMTP id o63-v6mr26722647eda.154.1538523982838;
 Tue, 02 Oct 2018 16:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181002211921.GA3322@sigill.intra.peff.net>
In-Reply-To: <20181002211921.GA3322@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 2 Oct 2018 16:46:11 -0700
Message-ID: <CA+P7+xp6B4K-bHnSV1npL-1pV30jENFyPKDmCmzEuRZKFK=jQg@mail.gmail.com>
Subject: Re: [PATCH] more oideq/hasheq conversions
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 2, 2018 at 2:19 PM Jeff King <peff@peff.net> wrote:
>
> We added faster equality-comparison functions for hashes in
> 14438c4497 (introduce hasheq() and oideq(), 2018-08-28). A
> few topics were in-flight at the time, and can now be
> converted. This covers all spots found by "make coccicheck"
> in master (the coccicheck results were tweaked by hand for
> style).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Jake: I was surprised that this was not a "patch 2" on top of your
> earlier coccicheck patch. Apologies if you were planning to send it out.
>

Nope, I hadn't gotten around to this yet, thanks!

The conversions also look good to me :)

Regards,
Jake
