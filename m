Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB51CC433E9
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 09:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A95664FDD
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 09:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhCLJOq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 04:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbhCLJOe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 04:14:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A90BC061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 01:14:34 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mm21so51893767ejb.12
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 01:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=JjoyVwlhrAdEbxRIHaPwcaXKzp7UzAGXMVa8w2gIs5c=;
        b=Om7hiIssrN6VCSMisaa7bmoHmiAjXzESnSlnEPOVyI963F+wphp39lO62nINSYqzQt
         /xhtnHQ5IwpXD5ZjSxlgc7SA8WLSScJeQ7nGjojuCoch+9qO04noBRGS+ntkMbJ2KpRn
         2D9j49+JMIhMBOfzYdxRMLakCyioaXL9zpgBWeBS9OCQ4KsyOKn9rpAcnjoSn5mFlF7H
         1ZchTTl5YCYb41gXhUH1CkFxEUchI+7E87ioetadU7ONe8Y/6BYJdQPdgLGE1mf+GDms
         Fe2ZgBdg2knataHRoySzJLwni35h46lipynMQRUbFMUbAxZnDwd7BwvA77HCpMVlfsC0
         MvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=JjoyVwlhrAdEbxRIHaPwcaXKzp7UzAGXMVa8w2gIs5c=;
        b=Ee9D0oqixjR2DPP1Gc08YQwUOTaafq5wdnN0P6f9fdsaEqlDn5iVcL4YKyjhkjwk6o
         L0TRyLqb59BOkbHOhjHt9kCoboMcNKsTEBQqJS+srQwGXmqbmT02aU8XEqSfdHe2iRyp
         oglhAzkfxVcVmFIYf/6SFX/LCf/u4tKGBkSaJYUZWj+M0ZE96Pi8Ae7QFvCZLdHQdcEQ
         N+00Ug+l1oMjrqVoQ6uUB3lHl4mwYpg3iEx5xpO9gegRLzoRT+h+/+IqieUAmDVhxs2F
         2SnzfBhGh2TpqZPx7sguxJGQnHbwJhiY2mA7hVeea6VQGWXD/ogon7+4WhZYN2IgPPdu
         5fXg==
X-Gm-Message-State: AOAM530GpoL0uUxgfrNcdhHrYAombAhm8etCN9PSOcn9GSMLK1QnQXDt
        FazZW2CLhw3lVTJ1ptXO27k=
X-Google-Smtp-Source: ABdhPJyotto4O3CzmTqXdziviCrjsxCOLO3FAC3IqExuWj+QrMOYWLL7FTQcfFkFdyKYcEKZGKsLNw==
X-Received: by 2002:a17:906:b2d6:: with SMTP id cf22mr7412102ejb.321.1615540472200;
        Fri, 12 Mar 2021 01:14:32 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v15sm2573139edw.28.2021.03.12.01.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:14:31 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 32/37] post-update: use hook.h library
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-33-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210311021037.3001235-33-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 10:14:31 +0100
Message-ID: <871rckhgy0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 11 2021, Emily Shaffer wrote:

> By using run_hooks() instead of run_hook_le(), 'post-update' hooks can
> be specified in the config as well as the hookdir.

Looking ahead in the series no tests for this, seems like a good thing
to have some at least trivial tests for each hook and their config
invocation.
