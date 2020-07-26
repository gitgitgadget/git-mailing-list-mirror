Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB663C433E1
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 22:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2A92065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 22:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGZWkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 18:40:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36332 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgGZWkX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 18:40:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id 88so13010786wrh.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 15:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKXEkMVufQ9sj9UxpnDo03vacaAJncFsch7iFayzabo=;
        b=UP8w5l0DYqBwrXGVnBLZOW41Cz6b427W4SHTKKudkBEET+tbcyB53vlXeR8TWJ1Nef
         Fw5QqR4Wza1M1bmgk/6qXl2GzAQ/UP2l5FPwiMyoJ46EiOyeu1nk2pM9jdHOzE1Gd0/F
         xYt/QI7h2hflbyGeQUBiphX2OSEeX0XNYfmPUh3Ko6GmghRt5tTISmxYu5oQO+ii2Ioq
         6VGyK2g2BaENAOSS9EmBSSyDUVbDZdj3T9DNfgCCM2GlXmivcamLL3tHWdnnc2TxOs+a
         vyFwOuQVV2CkjvgtjXRIF3LKeQzqUPqBnQrbhjetigTJQLhNWfXewm2P3oVfMFJY/1wF
         x1ww==
X-Gm-Message-State: AOAM531SK2CkFKEgE1V0N42mX+B9OULNdIoSvcBfTNmTCOYrejiRviyk
        5ZOrHG8kbh3ibzTMTDO62fVdC4yx+NRLLfG8yO3IwalX
X-Google-Smtp-Source: ABdhPJwAQlDsCIDHLvosIf7MU6SgTsiJPqbk5hELC64gTqbsCpI6VLcSDqkZ76bEYObLPo6yrkDsfF7/vF2/NI2mqhc=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr18882190wrs.226.1595803221985;
 Sun, 26 Jul 2020 15:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200726195424.626969-1-sandals@crustytoothpaste.net> <20200726195424.626969-12-sandals@crustytoothpaste.net>
In-Reply-To: <20200726195424.626969-12-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Jul 2020 18:40:11 -0400
Message-ID: <CAPig+cRU_6pMiPxW6sJd5E9_EuwXEroavL4uXScsuS-v4T__iQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/39] t7063: make hash size independent
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 26, 2020 at 3:55 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Use test_oid instead of hard-coding a fixed size all-zeros object ID.

This patch is doing more than replacing all-zero OID's. Perhaps say instead:

    Use test_oid instead of hard-coding SHA-1-specific OID's.

or something.

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
> @@ -695,6 +705,7 @@ test_expect_success 'using --untracked-cache does not fail when core.untrackedCa
>  test_expect_success 'setting core.untrackedCache to keep' '
> +       touch ../expect-from-test-dump &&

This change seems unrelated to all other changes in this patch.
