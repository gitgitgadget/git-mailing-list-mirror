Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B194CC74A5B
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 19:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjCOTKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 15:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjCOTKF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 15:10:05 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B6574FF
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 12:10:00 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so3258983pjb.0
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 12:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678907399;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5LWAlQsc52+/bzrJNjOjeEGP9NUqARMrCAoE/cdaEw=;
        b=J4CCDVSmFQ+jAfuwBHPgJItwWW+X3IzgQGuqluagvqGuPdmKlgB6K5uuEObKfvYnmp
         BYNPvyT3wrwMUaUO4cHBKGm6WiHIJiPPo9cD7peD6yM0RnyJ4k1OzrsKYIYA75YF7zH0
         l6ERji4YdiXqoWvlSvqZUXKOPs7PRWyKE2WzDKx+TjMpRX6xAigvFVuef1MEi/DuseP2
         xnkM9BI8QVvnqDzmDgnWAyR++D9CzovLr/AFHcabYB9VI2IyCtfkLsKb3pVniMI0sCsq
         j6A3lMqBggqVgOmNipoEU443jKM6E7RwZaFT/MjSlh0MgPAK7H0s5p2ZBEH4JHqZGJe1
         uT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678907399;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V5LWAlQsc52+/bzrJNjOjeEGP9NUqARMrCAoE/cdaEw=;
        b=FEf9TG8HXKZuRJDhYdiT/q0rdJpChMRCTDp197scxp6A22oXCaIfrl/ICu2WpfORc5
         5tQexXuPj89AbOjcr0YoPxYtguHAJKvA1rAGHmSezIwC+Nm54GjuzWlVKSchcPQRYY0R
         18diqhT7yLjFNEPB/gtsF5R4vWYy1dDiJHNpjRCciHQtf+mSzmL0VfSxGizaftS4h038
         1i/P/kklRo/dd8i08DWXdXXh7gDebgiMd9Gt4tglyF9xKyb62rmJbGNX2q6h1lpuA1VR
         DtCZQxrBKt+jAzAKYM5zx9fNBvSsbtxnBUbT0T5zOtW+dsadkdIcChuoPArwlM+G9iRI
         +pMg==
X-Gm-Message-State: AO0yUKW8t2T709JUlYwJshYarjYpW52Qmvk6pvlhEhlmSO66zdyeewbq
        zpU0sHm3YLVXel/hrtEFLXywJS6wbjw=
X-Google-Smtp-Source: AK7set909cGuqNfwU/AcWfdSUMqmkVLU09rYO8jVcv4p9K+292cnQVFRBOFMbBI3sBqsQVmyiFAcDg==
X-Received: by 2002:a17:90a:1c6:b0:23d:3698:8ed3 with SMTP id 6-20020a17090a01c600b0023d36988ed3mr839546pjd.22.1678907399556;
        Wed, 15 Mar 2023 12:09:59 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id iy18-20020a170903131200b001a045f45d49sm3938906plb.281.2023.03.15.12.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:09:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH v16] git: change variable types to match what is
 assigned to them
References: <pull.1399.v15.git.git.1673204590945.gitgitgadget@gmail.com>
        <pull.1399.v16.git.git.1678886439331.gitgitgadget@gmail.com>
Date:   Wed, 15 Mar 2023 12:09:58 -0700
In-Reply-To: <pull.1399.v16.git.git.1678886439331.gitgitgadget@gmail.com>
        (Rose via GitGitGadget's message of "Wed, 15 Mar 2023 13:20:38 +0000")
Message-ID: <xmqq3565q1a1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Rose via GitGitGadget" <gitgitgadget@gmail.com> writes:

>       @@ add-interactive.c: static ssize_t find_unique(const char *string, struct prefix_item_list *list)
>      @@ advice.c: void advise_if_enabled(enum advice_type type, const char *advice, ...)
>        
>        	if (!strcmp(var, "color.advice")) {
>        		advice_use_color = git_config_colorbool(var, value);
>      +@@ advice.c: int git_default_advice_config(const char *var, const char *value)
>      + 
>      + void list_config_advices(struct string_list *list, const char *prefix)
>      + {
>      +-	int i;
>      ++	size_t i;
>      + 
>      + 	for (i = 0; i < ARRAY_SIZE(advice_setting); i++)
>      + 		list_config_item(list, prefix, advice_setting[i].key);

Here, the advice_setting[] is not an attacker controlled array with
an unbound size.  It is a known static array the program prepares.
Converting it to use size_t as an index is a totally pointless
churn.

Some of the changes in this patch may have merit, but seeing a
change like this as the first change in the iteration makes me lose
interest in reading this huge message that weighs more than 7000
lines.  If you are looking for "for (x = 0;" where x is declared of
any type other than size_t and blindly converting them, please stop.
