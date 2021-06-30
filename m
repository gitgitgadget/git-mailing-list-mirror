Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA50C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 16:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEEC261474
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 16:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhF3RC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 13:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhF3RCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 13:02:25 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAFDC061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 09:59:55 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id g5so6075083ybu.10
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=PrIaO6X+AtPdqsKV0u+KvUxNqN36idwD8/i8Z7GVGAE=;
        b=j+Mvk9hpQW13E5oV10xP7BJNZfD4fJlwpTbVAIbdD2vrGJaW9XZm3KAd7wtMQ8xcgP
         Cro5Rct/gYX3zn0/eKYigCyhoTBX+W3c1pVxcRxH1rFDs5y9Nm5SmjhFUdqEbtsxXbBl
         MRMchPuTReqx2yXt7UxS2C2u9paVSRbtbKQWqWaOzlIZ8Vy1+oQlD474h1dzbHjkFsHq
         b1/7XVxq1aMDI05AqloInOt0dADMjvwRD7MQIrXTNhQeXT3xHv3jdme3oGzbMlVj527X
         ilhW0tBBdKmyEeiz/5IBT72YFtAxDJjpm6YNR6Oxpla5i0h/nYb+WOb4Ck1K3el65Blw
         itNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=PrIaO6X+AtPdqsKV0u+KvUxNqN36idwD8/i8Z7GVGAE=;
        b=aBkBScBRPotNl6atwb0xpn83agk2BeatEgBZAjfvHvdn5KHh2hNYTQHeAHN5MtbW12
         FHqHu2EUj8wPpNephStX+F+3ONPVmOH26jOPk98pV4Yny9IYIeNB4LgT9a8vqBFKelHz
         dmyuZgOaBV9egtUF9vyvvdIjio5AEMGejHx5iJj+yz5Ojldyck1kH97trzdH8NHGyUD1
         Dihg6jp2sAyXuRbTjq6C1TthO0Msf1VHzyh1CodGlSmsDv/ThfIxXXrUy3HLkjIGR22E
         87ncanbd71btdiw12lN6tzXt9q8+f5wRWH+3wNTfE+xFm3U+i1hourHgJ5CoT26m0OQX
         hK8w==
X-Gm-Message-State: AOAM530yRMSV2CtH5uDuUdVe1uU/hyd+ykVQQABZACLOMfsA6EU9p5tr
        w4XLXY2hwvaoYkTOjfE+vQZ+RVzNvqA0NrvQvpu80NulnVzTcg==
X-Google-Smtp-Source: ABdhPJxnczicU94Ew9WLa9YPONOB8ZOBmLLNI4Gd4lCvZLH70WM6NZ+3gGwdaqieoXJFu6A3470ZiQVCBmjA8X5yW7A=
X-Received: by 2002:a25:f446:: with SMTP id p6mr49256997ybe.288.1625072394307;
 Wed, 30 Jun 2021 09:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <CACPiFCLtj5QF6_Goc5UYh9KHWgkrKtjApL-cCH04S5gdTFyk7Q@mail.gmail.com>
In-Reply-To: <CACPiFCLtj5QF6_Goc5UYh9KHWgkrKtjApL-cCH04S5gdTFyk7Q@mail.gmail.com>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Wed, 30 Jun 2021 12:59:43 -0400
Message-ID: <CACPiFCLXxwaWOuR6sy8H4hCG-H0ZFvVYma7COfDq3zxoUt=VtA@mail.gmail.com>
Subject: git log exclude pathspec from file - supported? plans?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git Gang!

long time no see! I'm doing some complex git repo spelunking and
pushing the boundaries of the pathspec magic for excludes.

Is there a reasonable way to provide a (potentially large) set of
excludes? something like

     git log --exclude-pathspec-file paths-to-exclude.txt .

Has there been discussion / patches / plans related to this? I may
have some cycles (hopefully!)

cheers,


m
-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
