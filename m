Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F07C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 22:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242692AbiCXWWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 18:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355341AbiCXWWw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 18:22:52 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92389BA30E
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 15:21:19 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id n17-20020a17090ac69100b001c77ebd900fso3478918pjt.8
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 15:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=DbhsEiLT/r0x+toR6xSjS6j9Q26uV/iWMYlrNdbPojU=;
        b=FXkxJpsCx27jvpDBG/noqAYclyeihwUI6gyWDsEem0qgNLc2TuSxIXctMy3NgR3V4V
         Bb2JT0FgL4p3UfLGWxHzaTqYapqxJW5eCN+pReOZcccbNg+WSzCaHPJNIXcytdbBYcVm
         JbfrmpL0QdW1E0iKg3Kz4J3bnHaGbe+8/1doqKAKoXk7XzVq5GwAWEZsCDAqbB65tmuU
         0NtXx0tbsdh/Vu3Pu4CLfdzCva5ZHhyWypvY/rzOAwKkjRGqAFqbt1F7HfOVKHLkt8eZ
         5sVBPydAnz8Pc9koM2Ruxz++sqd5bCurf2FYU1HclAJwI/neNmAf+1Q9cy14WtGp/wX+
         PHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=DbhsEiLT/r0x+toR6xSjS6j9Q26uV/iWMYlrNdbPojU=;
        b=k8Kid3Hb+MpH6z0t86PI0pDeDGBTND6y2RPWkwN0yRbwJQcFR2kQstO3p9Y8CwCGWJ
         9IawBOv3KnL4TpBLfXm5HjETPbJX6EU02rCTIr7A8neldr9wHysAFSKbAHcgKC77bQC8
         YlXgO79MNiCOtEvAnwEqOQLQMZRoJmTvRyb4yzzHm1un4pdxKqI3FIKfKO340AF4CiVN
         B5m07CRsTRZBZ/BkD9PDSMZ6GIX8VTdYyzI1u6MA2XnbM2weJ0XhdVrHUTTaa4bMvEQX
         nh7y/Ilkl2uRim2mZ4vB+B+EVabT+r3odcP7Dbbu/KeKZaYDAcOGgAh5dRf/t5gyhjrY
         rj+g==
X-Gm-Message-State: AOAM531M2KiAF4S5Yo+d04LPyez1ULqzaI/6fMJ6x1DNipiStLPDLKVL
        eypvk0zWBvt5jfA5MmIjytf0Wv/In/0vfc7TNWeS
X-Google-Smtp-Source: ABdhPJzQXGsHPfcci74Afk7on5sqeq7WVr53GhipHEgaZ4nQLO2mDeF0IUxucNi60Cht32AmMY5QJ5ADIGLIs+W/UtOQ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:f646:b0:151:d5b1:cbb4 with
 SMTP id m6-20020a170902f64600b00151d5b1cbb4mr8224690plg.150.1648160478406;
 Thu, 24 Mar 2022 15:21:18 -0700 (PDT)
Date:   Thu, 24 Mar 2022 15:21:15 -0700
In-Reply-To: <a4656826-aecb-d752-7ce7-2ce7a37c7b00@github.com>
Message-Id: <20220324222115.1327778-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: Re: [PATCH] commit-reach: do not parse and iterate minima
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:
> On 3/23/2022 5:08 PM, Jonathan Tan wrote:
> >  test_expect_success 'fetch --update-shallow' '
> > +	git init a-submodule &&
> > +	test_commit -C a-submodule foo &&
> 
> You add a submodule here so you can trigger the bug in this test, but...
> 
> >  test_expect_success 'fetch --update-shallow into a repo with submodules' '
> > -	git init a-submodule &&
> > -	test_commit -C a-submodule foo &&
> 
> This test was already named to be specific to submodules. The test names
> could probably use an update to describe what's really the difference
> between the two tests.
> 
> Is there a reason we couldn't trigger the failure only in this second
> test, allowing us to still test --update-shallow when submodules are NOT
> present?
> 
> Thanks,
> -Stolee

I tried but somehow couldn't figure out the correct server and client
state to trigger this. If I can't think of anything else, I might just
"cp -r" both repos before the "fetch --update-shallow" and that might do
the trick.
