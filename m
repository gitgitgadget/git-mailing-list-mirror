Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B0CC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 21:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574D6611CA
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 21:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFKVLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 17:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhFKVK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 17:10:58 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BE0C061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 14:08:46 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id d19so3120678oic.7
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 14:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=YOyQfGLgWiIMvtrN5uRZwy86qS20xTHryGrHWkbflyg=;
        b=TB1+q8KCrjWQi/EEjvI3Ubt/+h8ZhElfCqC9qyJ924SdJgR744QcDnWL9AanLMewvF
         rW3aTmW+iFqGq69VVtNY5w8wPlIA6bbB7ibZDkikWiXealx+WNPJ0nNAIAf08Eu7LrUi
         sYIXCp37X05IQY6YaK+GdfEitBI8rzEG0OAZPnZZIhdGGajulgwdBIi12Gp7MBkKyot7
         FpP+wWMAZL2aGJlCo5jkXrLMp9LX8XiqDGYLvD9tP0HySBpJ57qyb9KrAXXPTHOV2vcG
         cqybjN5aa6GJXrcy4/BpxA7CrG1Z9CMGt3MRiK0xzfnKlP+2BViXbDkisIyYYbpg9izj
         CAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=YOyQfGLgWiIMvtrN5uRZwy86qS20xTHryGrHWkbflyg=;
        b=Wd+qDfCicHyC4D21jFzlqnMtTTMbQnae3yAo+oTYTyUSPJX0bkgNs8p4ZnuXlXHoDP
         N/GwcygCCmr/9vJOjuBqOriTJIV18NJqgJqeuaf/T7wWZvAoRrtDu/gXCypJUfCV2I4d
         RlaPyzAXrktZYt/begcAUARAvcnP2DUZlmsO8eh2a6Gk8vaHG8kX9rJ9wqwBm/aYmFRG
         O0hs/EcnQRFNA3nnvfsvZ2K/iVnzSTDWhPUys06RC50lNAYRWPG+I6GrXQ8DUs7blTgw
         YsUCgphNBnKUdg1RH7Oro6tvwFTY33Zs6c250sS0J1PBbPdDt9Etn3NMAkfGny4DuYsg
         yMOg==
X-Gm-Message-State: AOAM5311ZcZEOAyuBl6wfKSZOHkvtjBs+X54KrAeReDxcCb1MdCQgXUG
        G7W+RSE7PZ/XQ+Wp65B/WWk=
X-Google-Smtp-Source: ABdhPJzZgFFT57S+snQwlT2T3yHtRrYbft+Ug8Jt0A0XrllvvQk/avX6YbYxLXc7AUDDPR8nkq7VmQ==
X-Received: by 2002:aca:4d46:: with SMTP id a67mr3656977oib.52.1623445725971;
        Fri, 11 Jun 2021 14:08:45 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 16sm1421929oie.33.2021.06.11.14.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 14:08:45 -0700 (PDT)
Date:   Fri, 11 Jun 2021 16:08:44 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Timothy Madden <terminatorul@gmail.com>, git@vger.kernel.org
Message-ID: <60c3d0dc6a663_8d0f208e2@natae.notmuch>
In-Reply-To: <8d3f8cf4-24ec-1271-ccd3-70db24f53523@gmail.com>
References: <8d3f8cf4-24ec-1271-ccd3-70db24f53523@gmail.com>
Subject: RE: Wrong tabs in terminal output for git diff
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Timothy Madden wrote:
> Is it possible please to fix diff output as well, when used in the 
> terminal (interactive mode) ?
> 
> (I can include screenshots but I am not sure what the mailing list 
> policy is about that)

You can upload screenshots to an online service:
https://snipboard.io/

-- 
Felipe Contreras
