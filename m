Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72B1C433ED
	for <git@archiver.kernel.org>; Sat, 15 May 2021 20:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1EB061185
	for <git@archiver.kernel.org>; Sat, 15 May 2021 20:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhEOUHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 16:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhEOUHu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 16:07:50 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8CEC061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 13:06:36 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id j75so2823574oih.10
        for <git@vger.kernel.org>; Sat, 15 May 2021 13:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=12rl6VR7IEqDdPTbiKGK5/SBURu+6/XRyNrtMVkXRlM=;
        b=Ss++B+taXdUxxZHnnpkMnf91nqmSuGzM/+2M3SVrN61JGEO3Hw8D3y6Aur418tJD3u
         6YsjLI7/RIFPM+vOsYmYc/5mngCk8gnFtXSwdSagVkfcBN6k2/Emh1ibDIauoTeEbP2m
         CejijM84pwZTaevPd86xSYt6G7ynIhvLADVbAVACK2P/lrdRPnI1ufzrrGPxpgQynCfW
         LjDThm+PjcE1SDa8QpkzA4l+ntmaX4+Eq9qjEEYoO5mDXNJwY2wzVjJMmsR3iqR4Sb6o
         D0brGphFvqRAAdGZyHWEwlGo9X6xaOghzWusoP/1VO6ifLmcbHXaHq9S2mb5PQcZYP7N
         dDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=12rl6VR7IEqDdPTbiKGK5/SBURu+6/XRyNrtMVkXRlM=;
        b=P7V5Q4QTnLI+Z9sIMeDWLllUzS1ywss3kpFwFiPNlJCit8laiPIqaJlgetu54Y7JXy
         p12Twq5hi8s9qmuSsTn2sl3jZdqCkv4IiPE+z3Q4dVyHJSrojZLVMAg/t5hCY0SOP20t
         omRBvOw8nR/TuMvaoLx1AYBkzoqmP2QXjXNs0Rmt3VNLuyCrtSVBwahBGzw4BMlQu1Lb
         nVJ51bF32SjQSVJro4Ymb340iitBsTua7g6FjfJvHy1UxWPOZihADIu9c0w4pk43hakA
         ERkgUSNuoUEIpcdxA9/hddG9LNNGZibI/g6b6vgG9qkC8Gy8n3CTS6Du8V7KCtZo1tuW
         V4Mg==
X-Gm-Message-State: AOAM533ZLNI0mYDYgeG6vHmeV7kJmnfQqXBzLNriOwUBPh4Ugq0L2BSB
        AiBrSn4Tpu27d45k3o17hUE=
X-Google-Smtp-Source: ABdhPJx5G5jPJsZlJexRbRMdaaUk9IPcvlkm0fpmV19FPv8f0ESpTg9Kisa8UrlUGL0KP1NEXpENqg==
X-Received: by 2002:aca:dc07:: with SMTP id t7mr10769906oig.164.1621109195261;
        Sat, 15 May 2021 13:06:35 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id c95sm2083264otb.80.2021.05.15.13.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 13:06:34 -0700 (PDT)
Date:   Sat, 15 May 2021 15:06:33 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Allan Ford <allan.ford17@gmail.com>, git@vger.kernel.org
Message-ID: <60a029c9280c0_eacf52088d@natae.notmuch>
In-Reply-To: <CAL-6oQo3KDrrw+DiQsJJR_2tMjrLY3xu5ARJz0SJJ-naQqo8Rw@mail.gmail.com>
References: <CAL-6oQo3KDrrw+DiQsJJR_2tMjrLY3xu5ARJz0SJJ-naQqo8Rw@mail.gmail.com>
Subject: RE: Git Gui - Searching for in Google
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allan Ford wrote:
> What do you think ?
> Can we add a picture of Git Gui interface to either
> https://git-scm.com/downloads or https://git-scm.com/downloads/guis ?

+1

I don't use git-gui, and I don't see much value in shipping such
probably not widely used interface to the main deliverables, but it's
already there, so we should add it to git-scm.com.

-- 
Felipe Contreras
