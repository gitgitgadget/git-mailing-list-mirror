Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96C4C77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 16:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjFAQWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 12:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjFAQWo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 12:22:44 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4B4138
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 09:22:43 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-64d285fc7ecso1097112b3a.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685636563; x=1688228563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+D/6aomJ4XpgeqPSbgMStqgONZn+JiWaqx7b3Z33Abo=;
        b=6I0XtL/CTf3SsVPDn1uvNCZ2v9y8LkQ7O7dX7HbMGdmO31v44+Jgon1u2gJ192L0bS
         unZDqHP25agQmu8hCzvl/s+bcKgTZKltyVithxHgH58LvYT9PZoUorcam3je/CK8ik6H
         HlugrMYbBK1VWbX85LigTYWvWqh1/pa0wCIhfoolTBfMO3XsUQ7qjK0h7kMnirWMb1Wa
         X7uYzNPet+eQEyLUeCVRypM0+Crbf0Dk40G/dkkuEvZAo4i29+ArYQ4yhtxR4mLa1lw6
         sP/oc7xVQUl+yfCFURRKUInwLzxL57KhXRvQNDUIr8PsL3ZrHygVw9aitbHRUNaCYU6L
         SYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685636563; x=1688228563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+D/6aomJ4XpgeqPSbgMStqgONZn+JiWaqx7b3Z33Abo=;
        b=KBV7z7k9ghzKZ2RDm7hb8vrm+TDe7yIuzQlHh/BrD0gTnn7GcJCrPEyippFuBCoFa9
         nIL51TSqQzSTLWvbRJzklhOX98b4ThMLy17dTN/IL5/BUq7yyoTs6X5cdhiI7eRdrraO
         YyNPOPeRFsvpkdf8MFjvIDqtMF3576rQPor6+hOklSvTkJag88aS+3b7TEean8mLDKi4
         I/Hc1r3Ru2QKhmAYnBC77jOSI6dd7SwPpR1CjjOho30CI2W7K5EY/YOw4YCCLqjTl4VK
         rBlr9GP6N6j4oGNzvlzSrdKXBESxjyWnvViEt4ngon7RNmHb458vqJaLTMNANb3+F7iv
         QAcg==
X-Gm-Message-State: AC+VfDyXvh4nQbrsOWQrvC9g5Avyxg2lJnNtcj3pMbuLUiCrGcAazsRa
        Zc3+ZR3Cq33Nkmj5tZtYMwHAa/UKsNgmFg==
X-Google-Smtp-Source: ACHHUZ7oJo8eh6cUPUhZfVluyQ8vB/YfQ+674NJcuWfG7A5QGR2BVdT0xxyOR2/3FYTk7Wv/BWxaEJoIYf9xSQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:b8a:b0:643:b756:d39e with SMTP
 id g10-20020a056a000b8a00b00643b756d39emr3617507pfj.6.1685636563343; Thu, 01
 Jun 2023 09:22:43 -0700 (PDT)
Date:   Thu, 01 Jun 2023 09:22:41 -0700
In-Reply-To: <6faf1b17-a1ca-0c22-2e43-aee121c4e36a@gmail.com>
Mime-Version: 1.0
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
 <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com> <6834e37066e7877646fc7c37aa79704d14381251.1685472133.git.gitgitgadget@gmail.com>
 <6faf1b17-a1ca-0c22-2e43-aee121c4e36a@gmail.com>
Message-ID: <kl6l4jnr17am.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 03/14] (RFC-only) config: add kvi arg to config_fn_t
From:   Glen Choo <chooglen@google.com>
To:     phillip.wood@dunelm.org.uk,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason" 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>   - is it worth making struct key_value_info opaque and provide getters
>     for the fields so we can change the implementation in the future
>     without having to modify every user. We could rename it
>     config_context or something generic like that if we think it might
>     grow in scope in the future.

Yes! I planned to do the key_value_info -> config_context conversion
when I send the first non-RFC version for this exact reason.

>   - (probably impractical) could we stuff the key and value into struct
>     key_value_info so config_fn_t becomes
>     fn(const struct key_value_info, void *data)
>     that would get rid of all the UNUSED annotations but would mean even
>     more churn.

Some of my colleagues also suggested this off-list. I think it is
impractical for this series because I don't think anyone could
reasonably review with all of the added churn. At least its current
form, the churn is mostly concentrated in the signatures, but performing
^this change would make the bodies quite churny too.

After this series, I think it becomes somewhat feasible with coccinelle.
My .cocci files were difficult to craft because we couldn't rely on the
signature of config_fn_t alone to tell us if the function is actually
used as config_fn_t, but after this series, we can just use the
signature since config_fn_t has a struct key_value_info param.

>     The advantage is that one could add functions like
>     kvi_bool_or_int(kvi, &is_bool) and get good error messages because
>     all the config parsing functions would all have access to location
>     information.

Interesting, I hadn't considered this possibility. This seems like a
pretty good abstraction to me, though I worry about the feasibility
since this is yet again more churn.
