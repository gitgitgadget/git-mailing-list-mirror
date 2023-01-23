Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1304C05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 21:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjAWVIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 16:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjAWVIh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 16:08:37 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A2526A2
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 13:08:37 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v23so12749988plo.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 13:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHgkHnCgyOEJlhCGsQ1JDyA6IhWhePSh0t4TeOT/QVM=;
        b=bEKaERLy6eJOnIBljVu3DRhMwsyyG9VUUKItFgEwsFQYLYTZAbPwBiCf5G6LVkYg0k
         YYJQMbho2cOSAy434bIraSMXCwrpgfwfIsJkVfj5SECv0MYR9gBtb+DD0VEm5ngkQKqF
         YwQvZzprlgJ5BVvwLTYALv+KJRBlRpEG+C59uBa+28mOc3mc3sQZARQGrHEg+RADIii9
         O24TB2sN6T8XGCOgFm5qOrx+d6BgO/cll1Jb+J0akbVEE85aG3KobNDgQTOBU2RO274f
         gZpQdxhzIj4CY1ptzucwqxxgKjfuEd685sQ6HdDX5AKKmpOmQOktPQRrigVuyAag3e/1
         vAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jHgkHnCgyOEJlhCGsQ1JDyA6IhWhePSh0t4TeOT/QVM=;
        b=pm9BlpRUZUrCBTS9m3s+4ypYzCXy8m4/ppKnA1DDlNov8Qb3v48aRR6F1beHIvMhgr
         buHmqwMyIxXjzzgVib7zgY3MA7FX12oN/JJl1ZSKh0YxoDx6kFAHgVOs0MmTU9kiXKH9
         UGOT2ch6/yzJS9qDw0c7ddaefrtZoHP+nLWovnUsKvpf7MaTAPd6Tte1gSBddEtpRf2G
         a35VZeSKZx8iT2oJLhRVq6/iCDd1Vqu4iR5cWBQDzoSPToMLYzz76OuvAdgcNvO5szdP
         Mb4A+CkU4EqepBlw3+UvowSU/uN2BA3DG4lyVUfd3XVejAevg0D0wVkuJtTzO5N4v6Lm
         XiQA==
X-Gm-Message-State: AFqh2koGpTiJsZGlcqw2aC9boqEBF2l0Liurhk8ZLQAxLRVxafheHiGY
        XiBBGUuOii0QQlAhW3TNqSg=
X-Google-Smtp-Source: AMrXdXsBD4cmEEF9suu+BKNHMay3vG6gGPDRUiPqCsa3scRLV0K13XltnmeubhKpkriiWuqPKHj00w==
X-Received: by 2002:a17:902:cf08:b0:192:c125:ac2f with SMTP id i8-20020a170902cf0800b00192c125ac2fmr29386541plg.8.1674508116619;
        Mon, 23 Jan 2023 13:08:36 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a23-20020a1709027d9700b00187033cac81sm141308plm.145.2023.01.23.13.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:08:36 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com
Subject: Re: [PATCH v2 01/10] bundle: optionally skip reachability walk
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <b3828725bc8f8887b9b4777a0e3d84224a427f31.1674487310.git.gitgitgadget@gmail.com>
        <xmqqsfg1m8l6.fsf@gitster.g>
        <eae85534-89c9-6eff-69d5-7d4b2be85fb6@github.com>
Date:   Mon, 23 Jan 2023 13:08:35 -0800
In-Reply-To: <eae85534-89c9-6eff-69d5-7d4b2be85fb6@github.com> (Derrick
        Stolee's message of "Mon, 23 Jan 2023 13:24:26 -0500")
Message-ID: <xmqqedrlm018.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> Do we do the same as we unpack from a fetch?

We should.

We only consider tips of refs and objects that are reachable from
them to be "present", and there may be random objects that float in
the object store without any guarantee that no the objects that
ought to be reachable from them are missing from the object store,
but they do not play part in the common ancestor discovery.

And then after we unpack, we ensure that the proposed updates to
refs made by the fetch operation will not corrupt the repository.
This can be guaranteed by making sure that objects to be placed at
the updated tip can all reach some existing tips of refs.  We trust
refs before the operation (in this case, 'git fetch') begins.  We
ensure that refs after the operation can be trusted before updating
them.  Where "trust" here means "objects pointed at by them are
connected.

