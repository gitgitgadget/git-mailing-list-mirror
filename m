Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29892C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 20:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB272206D5
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 20:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tp/NfFzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgFHUIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgFHUII (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 16:08:08 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1BBC08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 13:08:08 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id k22so15763566qtm.6
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 13:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84zkr4KmOVefougIj5aIKKUNq0NZnELjbAzjO0mp9VA=;
        b=tp/NfFzUmois+Qry0Yu6bZn462btP6EzoVkMicBsOTlRb8G8GGis44MesukvO+AJnU
         U+urnDFryRHKIjzk7rHtgKAB29OrUp1i5nEcrGZ/BMfH+Cgm9APtdM+wl+eKR9BeKzHz
         z8PwoO0IAjJ1WoqrsNQtMCqiBI9inJ3JotBgub6ZJRfZ73DXJQoy5k/EH6Yz0JtSFSbu
         n7k5jgDoE3ZxXSOULsWIA3xm2OmbCG5HZ9/n0Fsr3RyKCWhG8ptuHtZH8ukkw41SVmhq
         g86b/f4QOLeTQYIcd+TGSBZ0TBpSECQSnsnSWKm5yOBME81cQUHAVD4Js889dNoLGSXE
         IYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84zkr4KmOVefougIj5aIKKUNq0NZnELjbAzjO0mp9VA=;
        b=MXz1IXiWRlLIsAdIACUUr6IiFeaU6qcZx5/2L0QAxe53gCIZlFi3iolAIMYvNK4Isg
         mM1CW+Zcxtj+lk8K1imzMZeauXgdJPUVSlMN+Qrb9HfBX3qR/6VhZF1xC+v4AQGpsZfa
         XH0+YSHQ5fmlgRGeAjtw67XI3z+FsuZOTQv3LN25SHQaSudwZUSinrdKpaXr2+W1H/B0
         ZKX3N9dANu1xhYt1FkfmaF9bULMolVKPEtUStQG/Pry+9x5G0EdH43joLtRYoC+7sBwg
         eUdJV9FWaFAHEnGx7Bsl9748H98KU1HFzmpUayNzMf5wf4zODPX3leHoCxwoNVhBPYGT
         eagw==
X-Gm-Message-State: AOAM533hkW/C5m22e0cJrsDBDhGgDX8tV65vU2tdjoiVr57ckYatTok5
        uSzFxalpch7i9/xBT8bQK5kWFLBpmnQZ9HYTr/SuCQ==
X-Google-Smtp-Source: ABdhPJyGBKte7frbXJs6SmjYnKnb2XfexqxxZSQDfbxciz7WxD/F09yqSAaFq0EWYtigFil49C1xJmq4kj8XeJ3CR78=
X-Received: by 2002:ac8:1bd2:: with SMTP id m18mr25410604qtk.64.1591646887336;
 Mon, 08 Jun 2020 13:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
 <pull.614.v3.git.1590759624.gitgitgadget@gmail.com> <f19794fdbc09cc3c57392dc522920f7b01691d88.1590759624.git.gitgitgadget@gmail.com>
 <xmqqwo4uy20z.fsf@gitster.c.googlers.com> <CAKiG+9Ue1fqrzqHduZY4Pnsh4q+Thqq618JymkonmVhGewmM1g@mail.gmail.com>
In-Reply-To: <CAKiG+9Ue1fqrzqHduZY4Pnsh4q+Thqq618JymkonmVhGewmM1g@mail.gmail.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Tue, 9 Jun 2020 01:37:56 +0530
Message-ID: <CAKiG+9VcAx2xRFzrqQpXFc+sVuRZ2ydoVYTpCtWpi9z2Oa0fCw@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] cmake: generate the shell/perl/python scripts and
 templates, translations
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I have done the suggested changes namely:
1) Format code inside check_c_source_compiles/runs
2) Moved the changelog of the patch series from the commit messages to
the cover letter
3) parse for SCRIPT_LIB
4) glob templates and po files
5) add logic as to where the template file should be built.

Any other changes I should do before I a new version of the patch series?

Thank You,
Sibi Siddharthan
