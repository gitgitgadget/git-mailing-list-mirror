Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D25C7EE23
	for <git@archiver.kernel.org>; Tue,  9 May 2023 22:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbjEIWao (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 18:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjEIWan (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 18:30:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962A326A5
        for <git@vger.kernel.org>; Tue,  9 May 2023 15:30:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b99ef860a40so11899881276.3
        for <git@vger.kernel.org>; Tue, 09 May 2023 15:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683671441; x=1686263441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ukGbfWlrD6UQiWkZefJDqFDguyP+deMwyhL02tNBHlE=;
        b=3wSS2676kFmdwvppMA7YwULufNg8eaS6jEEuOUpRguYxstqcCMLCuCIVsvroa2jQFa
         Yvi8M0RazumjxNipizn18TvULEhAvd87KYZ0uJyJYcR4cbIXs80QdInS0uskQiGDG/Wb
         a/1CCQ7LYtFWPcEIgqYWZL4QwA9d5/uamftN3vzLCkfg/fV2edcUQjF7r3azJgZkU7/e
         LrTdWeJ4aheH2+l+P6eMt5ZVjD7dXiLpgx44tsnqlUYzoOL/ehgI2TKbwkZL2ZBrfQHD
         wgQm0hLXLG7cKk+lD+qp4cozeIE8LwZOOtodWnmATgEeVck8QB04lHSjJM8AxUluKDYs
         oP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683671441; x=1686263441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukGbfWlrD6UQiWkZefJDqFDguyP+deMwyhL02tNBHlE=;
        b=Tr3yo+RbvQHWzqT/2tvm+ss2u0wIYMwW3LgkaVbP4w9laTu2IOQ44LAxou4yGUbG7J
         amVKNua0soYGfsSk8nZBrNH4uHNaO8LWcgnEI6jXYIpn53PQPevR95FUd0L27CEYD7Qc
         xlZwepwixgTMTKvw+XqNKoEfVSYZL4TJta08l5ubrrMk24ZfRavgAwQvWNGQtrLwEws0
         jF1z8jLjIf5GPf/Sh0BY6oilOGwvyg6UgcnTOy3UTI4hZC+ErpYlg21fRYNkGuyG+9Tz
         R4gXQtx+5Xp94blCeAiuuopM3ImmBURRFN+cYGBG7xnI//FDxBa1G8OuggKQertxUrPU
         HONw==
X-Gm-Message-State: AC+VfDyXDlnqTGIBiip97x04Efz5/Hf1ieOUWvO+N3t/b6w9Vvjj3xnM
        2VWxbUie76XYCzwEjVwAwIt+T0C0tnyvHQ==
X-Google-Smtp-Source: ACHHUZ5NjI871Ni3TMZqleWVNazl0Zb8rnBTS4qzAxOCNBWCnSYsaSOrhqq6fIsyUfY3l5QctPvesw32F3/2ZA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:5b84:0:b0:ba2:da66:3d37 with SMTP id
 p126-20020a255b84000000b00ba2da663d37mr3364140ybb.10.1683671440896; Tue, 09
 May 2023 15:30:40 -0700 (PDT)
Date:   Tue, 09 May 2023 15:30:33 -0700
In-Reply-To: <826b8b7bc0d7d6a76f6fd19d8f4a8460af61e9cf.1683636885.git.ps@pks.im>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <cover.1683636885.git.ps@pks.im> <826b8b7bc0d7d6a76f6fd19d8f4a8460af61e9cf.1683636885.git.ps@pks.im>
Message-ID: <kl6l1qjp16k6.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 6/8] fetch: move display format parsing into main function
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> with the `fetch.output` config key set. We're thus going to introduce a
> new `--output-format` switch for git-fetch(1) so that the output format
> can be configured more directly.

This is stale as of v3, since isn't named --output-format any more. Let
me see if there are other instances of this.

(I should have caught this earlier; I only saw it because Junio quoted
it in a reply of his.)
