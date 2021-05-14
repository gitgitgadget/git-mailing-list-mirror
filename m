Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287F5C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 07:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047C861354
	for <git@archiver.kernel.org>; Fri, 14 May 2021 07:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhENHEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 03:04:06 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:37542 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhENHEF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 03:04:05 -0400
Received: by mail-ed1-f54.google.com with SMTP id f1so11350391edt.4
        for <git@vger.kernel.org>; Fri, 14 May 2021 00:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWtt7ev5m4jEnc4pV7jFsdUC9z7I+v7YaPdyrYGz1NU=;
        b=C+J5H14bfzih0IstgosPXmNr1sHDJkHrGLmyoOzH/vNh2Iev4FyRq5z5as3QKNU448
         Hdj0fVC9pksEZ24YAiplpPKaCLSYIX5B4PeQpRGSYlY2hPhYiBLXf2oeq1MhbfGSERGh
         s6PoxP6ChMmxvI9Tkr02a5SiKtUrwU5gs83i2E3KMQwM2/Li/0kjRk//+4T1o0MQby1l
         gws4uPl4Tff1/P/qsbnJ/PJTr9zRMmzlmkH6/meBH7vceltoeVtwfknXLGHHprZh9Tzk
         okcsYCKucNmf0gGzsLqa46/S5Zvf6YCiOhPa5+myUbQ0db1KVGH07sDfQgRPcoH2OtNg
         EGxA==
X-Gm-Message-State: AOAM530QqhkjFWUA1vM/gUKrt6MgZKrbjLnWHhY2Cnt/NKjfWR9uI9/e
        81Lv3ASTJ2ga+MbriOPshkSYRo69rX8yizdfXx2H/Okz
X-Google-Smtp-Source: ABdhPJwaTxZ/5c9NJu5HYojCreD6kkSzkLfF8OUoKXa45wuhduxPxVuOSd4QxlQwxVE69jleHqxj2WrUVMyZ1rDPNlc=
X-Received: by 2002:a05:6402:347:: with SMTP id r7mr15943767edw.163.1620975773777;
 Fri, 14 May 2021 00:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210514065508.247044-1-firminmartin24@gmail.com>
In-Reply-To: <20210514065508.247044-1-firminmartin24@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 14 May 2021 03:02:42 -0400
Message-ID: <CAPig+cRrVN0cqoRFA90XYSsDcJ-PZxLMNfFCye4pUXz47AhpYw@mail.gmail.com>
Subject: Re: [PATCH 1/2] t/README: document test_config
To:     Firmin Martin <firminmartin24@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 14, 2021 at 2:55 AM Firmin Martin <firminmartin24@gmail.com> wrote:
> test_config is used over one thousand times in the test suite, yet not
> documented. Give it a place in the "Test harness library" section.
>
> Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
> ---
> diff --git a/t/README b/t/README
> @@ -1046,6 +1046,21 @@ library for your script to use.
> + - test_config <config-option> [<value>]
> +
> +   Set the configuration option <config-option> to <value>, and unset it at the
> +   end of the current test. For a similar purpose, test_config_global for
> +   global configuration is also available. Note, however, that test_config_*
> +   should not be used under a subshell.

"should" is perhaps too weak of a word. test_config() will not
function correctly at all (just as test_when_finished() will not
function correctly) within a subshell. So, perhaps say "must not be
used in a subshell."
