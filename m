Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFB8C6FA99
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 22:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjCGW5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjCGW5X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 17:57:23 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA9AB6926
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 14:54:32 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id a23-20020a62bd17000000b0058db55a8d7aso8015152pff.21
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 14:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678229617;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPNS6OIZX9bHjZts+oYgLeWE3Xci8RY/ooRZUIuB+30=;
        b=NwfKnXBsu/rEjYoMO5jZULuXbS20TwR2srrOkkOKJq+LycDQgAMl1utfu+igZZUpRu
         n8pKLOcSaeOT6bBtNNFvK4ThNiL0jfrZEujVe/tgvoYzkXBd3a7NYmh6NtCCnn9nj/Qj
         A/gdKqqDffTBVZuyEWycDucWcefTYk5nm2+pSYBkuuAWmxJmW54maqR/hav+ldG8/1UJ
         x3Y4s3M612f35LzXeTesBlF+/PesV07SjV0RxzMXywnfZBOMTsi7z0KfVl4uLszDjNKs
         2lZVotdpbMEOr0tOCHhYuur77tsYMq1TR3cha7sj99jg6EaG0emOWW8mNlaK6qDklbLO
         Wpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678229617;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uPNS6OIZX9bHjZts+oYgLeWE3Xci8RY/ooRZUIuB+30=;
        b=wiSOt6FqTvHg/r11pqpILBeGXjF4Q0FYhtiEp3Drh6i3YKtSooFIZ4bbIGshkHJ3xo
         1HK0jsxHMCfBRVf6l60E/qBfhzUi8ZOqOUSlp3mm8iLI2HpJxLUYOd/tqxHfybuD7Fb6
         VZDXZMj30M2tSeFIrehr2MXr/5hMPFkL4u6QEpVJlgOsGXpWRX1SHgaXtK5iAXHHMKeP
         S7RUGicmbm33T2jlR++1l0GWZzliQSNpT4khqZeU3CMwN9mnIXfVpJGJSriQYaO4DLLY
         bw1xz9cbtVp0o+WOEvAbXzmks7I4McUTy71obLKL/JTecHFbgHjj2ygtSAmPyyIgG2E6
         +m6A==
X-Gm-Message-State: AO0yUKWBFDeWxJW44I2jKzRc6N+Xv6TQMPljp8QWd5lQebQy+sR0fAEK
        zVJs5612mkmAGA4/s0VIkVZkpzeGyCXNLQ==
X-Google-Smtp-Source: AK7set/FmoJT1MY1VD4HPfeKufevEVu9Im9oePHy3jzDqs9BJ1/+1UpH+0uIzcY9h778M9C5wYATRFe3QBkWtg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:bc02:0:b0:4fb:d6b9:abea with SMTP id
 q2-20020a63bc02000000b004fbd6b9abeamr5600938pge.5.1678229616856; Tue, 07 Mar
 2023 14:53:36 -0800 (PST)
Date:   Tue, 07 Mar 2023 14:53:27 -0800
In-Reply-To: <xmqqbkl4xsj2.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
 <230307.86wn3szrzu.gmgdl@evledraar.gmail.com> <kl6lfsagifpc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqbkl4xsj2.fsf@gitster.g>
Message-ID: <kl6lcz5ki36g.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 0/6] [RFC] config.c: use struct for config reading state
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If you include "populate from system-wide, per-user, and repository
> specific configuration files" as part of the API being libified,
> your configsets cannot avoid being tied to a repository.  But I do
> not think the reader needs to be in the repository.
>
> [...]
>
> Isn't the use of the reader object purely transitory while you
> populate the keys and values in a configset from a single file?  At
> the layer to read and populate a configset from a single "source"
> file, you still do not need repository.
>
> [...]
> Only when you say "I have a 'repo' instance and I want to read the
> config variables from appropriate places", you call such a "read and
> populate configset from a single source" helper three or four times
> to populate repo->config.  Once a configset is populated, it or its
> contents do not depend on the reader instance to function, so I do
> not see how it benefits to have the reader in the repository object.

Yes, exactly. Having a config_set on the repository makes sense, but I
don't see a good reason to have the reader on the repository.

If =C3=86var sends his series soon, it would be fruitful to see how that
series interacts with this one :)
