Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA0BC4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 10:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiLSKyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 05:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiLSKyr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 05:54:47 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8205643D
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:54:46 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z92so12311147ede.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r2ZpvQEJo3K/ooe91RthdUcOFIqzqcjBIjQ3OR9Rwsk=;
        b=Syc/O00HtGBlP2vtfyhNCnHEaPiNwWnFkQLUFYtnu2J36tVfM4hkyb7xnIL5P4F8gF
         OPC0h1fFwI4LIJqwZyLzSw5kqRuNGmZYy7cqoTnlKDsAvfZcTXIddTQTLql9PqfJN4tT
         PFeycJOJpjkq1U1J+ZEcwU0U5VY8v8K9hr7adWJtUY4cLD+1syQlbinRMCNtIbtwxPLQ
         6g8UYRKvzvWJZxE4pJWxz3V/lqHeGEYahEzOp+uynFfvPNykl60U7eX+/cYmKAgLlVH7
         7XMBUSseg05i2v6XDBAr50FUWUOVgaPywD5M8HuzLhs3w3gIgJzr++T4QMCh6tQfyLgA
         Ktbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2ZpvQEJo3K/ooe91RthdUcOFIqzqcjBIjQ3OR9Rwsk=;
        b=KWdUeCvfO/8cnjS5ePo0cwp/ViCO9bRzCDy26+e5fbqWEOnvDHCAyPV9hTmmanMQ3d
         +0B1BCLM/bfLuaA7K0tWwRxB9E22eP/T8iGmmrTN64L505WiTMObzef8zOQAZErznoD+
         6EPwUclfK8g0BFOGJeNAw2ArfGJQUD24ofzzJ77y+T8nEoGitDcLGgKsY1RCaS7CTzJ1
         AuNn5kv0vdpkDh2GVEVPFCsek/v/ooEFvaivu0upShQfGKT4CygSryQ0HK0GROLDbX7x
         UWtLNeM6Pgc+2l+2045bC+aQfCu8O5kguu1p3xmqrs8yHOqPlsPHrcYlD3fZObD5Eug2
         1RXg==
X-Gm-Message-State: AFqh2krkujQ49yYTy5K2F061+XZcuCHvjaTg5yiK5v8DkCuIF+7PbZuP
        h4k8sR2l3N0Nl+YWn5i4RwY=
X-Google-Smtp-Source: AMrXdXsFtY4AoTo7TDUK6Fs7+dfcRPHzmrNiNstx4fp/OQQoQ3o7enmcy+ZGrORyVLPTpL9asIXh7A==
X-Received: by 2002:aa7:d38b:0:b0:473:280e:1959 with SMTP id x11-20020aa7d38b000000b00473280e1959mr14485539edq.16.1671447285420;
        Mon, 19 Dec 2022 02:54:45 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id a9-20020a17090682c900b007c09d37eac7sm4179103ejy.216.2022.12.19.02.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:54:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7DnA-006Xgo-1e;
        Mon, 19 Dec 2022 11:54:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: ds/omit-trailing-hash-in-index (was: What's cooking in git.git (Dec
 2022, #06; Sun, 18))
Date:   Mon, 19 Dec 2022 11:49:30 +0100
References: <xmqqh6xtw4uw.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqh6xtw4uw.fsf@gitster.g>
Message-ID: <221219.86y1r3zmrv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 18 2022, Junio C Hamano wrote:

> * ds/omit-trailing-hash-in-index (2022-12-17) 4 commits
>  - features: feature.manyFiles implies fast index writes
>  - test-lib-functions: add helper for trailing hash
>  - read-cache: add index.skipHash config option
>  - hashfile: allow skipping the hash function
>
>  Introduce an optional configuration to allow the trailing hash that
>  protects the index file from bit flipping.
>
>  Will merge to 'next'?
>  source: <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>

I've been following this closely & reviewing it. I think the end-state
is probably good, but noted in [1] that the intermediate progression
equates bad config with "true", so:

	git -c index.skipHash=blahblah status

Enables it, fixing that is trivial, and probably worth a re-roll.

The "probably" above is then because the patches seemingly try to make
this compatible with different config for submodules, but there's no
tests for submodule interaction, so that may or may not work.

Normally we could just trust the "struct repository *" parameter we get,
but in this case it's "istate->repo", which (as I showed in the v3
feedback[2]) is sometimes NULL.

Perhaps that NULL is benign, and perhaps it's a symptom that would
result in a bug exposed by this topic bug. I don't know, but think that
before this lands we really should have tests to tease out those
interactions.

1. https://lore.kernel.org/git/221216.86sfhf1gbc.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/221215.865yec3b1j.gmgdl@evledraar.gmail.com/
