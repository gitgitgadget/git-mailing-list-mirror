Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E11BC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 16:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E26F6611CC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 16:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhFRQIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 12:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhFRQIC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 12:08:02 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13043C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 09:05:53 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id s17so2300777oij.11
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 09:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=QMVSPOsrks1S27MTxQgZ2UvHmMpW4mMAqVMI7DJ7Jjk=;
        b=IrF79JxeoyCE1TnfF5smb6ypfQTDVjej0515IJ6RsWom4a0PWc/QfMjVFlIGESLFat
         I4QMbYmFtI1Pj2sdNx47VBAKq3pohfico8OZMnGUMiHEnnw5H5ipkyUXUnBR/qxNoZJm
         IxvCXszOi0iygAIKTOxt880DOska3N6lVrfWHfgIyz2YYHnxsBp00HOVwMHpEyDL76j5
         tKPifguGLbsTLcwp3vGxzHMKn8aRpYDekfoMedlHw0J63tDRQekukbvWr9Wds2PgKixA
         Ye3e6RBo7l45fUdghy5e0ycQo6u7AbcfJLPHwCycaST3nemNSUtETAno3P2qAJY5DObp
         yfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=QMVSPOsrks1S27MTxQgZ2UvHmMpW4mMAqVMI7DJ7Jjk=;
        b=PPrFzbUqpBXC/Y6obLYskc1VuiPs6YpSSYmzM/31z5APw/fOzpSFPvxZOmZW6JUNgz
         LIcy4hGMyBnRiJqv/SQKukAtyMu6hbODI/IUABBgXIALq1K/MCmlhqi811FYCUbByRlq
         cu8AeCbbLPep4xN+NhaKlv4KxJgGMby7Bwlby3mUQKftJOyZMsluBHlqrVKgSWQFL6eb
         bzbW8o2Pxhzj71U3GEM1XWyzqt3arfIOUR4JZpW1/Vr5cXBA+abtG0Cv8aXpTeCG/I6f
         SgscLFOmI8cQCGu8S9M9S1mkSoCbGnfhgdnmE958+ZqHAtq6FmkVX14MF29Hp1j44Kb1
         Smvw==
X-Gm-Message-State: AOAM530Yk+U9UkPz+QjGH3e54OYm0XNFjs3KKtoENvf9Fk/RCQTAjjEE
        hKm8KzH18SGQEvfpo/7ULes=
X-Google-Smtp-Source: ABdhPJyHSP1KxFWJbujoVzwHb8bkHRGHpBiwNq+IJiC3SlLOj56shJY6BYr9NoLLo862ssS6WHhQjA==
X-Received: by 2002:aca:1809:: with SMTP id h9mr4354165oih.4.1624032352513;
        Fri, 18 Jun 2021 09:05:52 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id f2sm1880590ooj.22.2021.06.18.09.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 09:05:52 -0700 (PDT)
Date:   Fri, 18 Jun 2021 11:05:45 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <60ccc459c5dd8_5eaa22086e@natae.notmuch>
In-Reply-To: <35417819-3b25-e346-436a-a2090a8f8c43@gmail.com>
References: <60cc1749b1c4d_5d12520825@natae.notmuch>
 <35417819-3b25-e346-436a-a2090a8f8c43@gmail.com>
Subject: Re: Only 27% of reviewed-by tags are explicit, and much more
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> On 18/06/21 10.47, Felipe Contreras wrote:
> > I think it's fair to say our Documentation/SubmittingPatches needs to be
> > updated.
> 
> With what new procedure? After any reviews?

Something like this:

. `Reviewed-by:`, means the reviewer is completely satisfied with the
  patch after a detailed analysis. Unlike other tags, it's recommended
  that the reviewers themselves offer it.

It is recommended, not a must.

-- 
Felipe Contreras
