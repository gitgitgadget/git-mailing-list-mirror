Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A67C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 13:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiHINQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiHINQs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 09:16:48 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3ACBE3
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 06:16:47 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z145so9503342iof.9
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 06:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=KbJAe3BTalYdq1/KQ7NtM+mzlVrFPt7CmV0IrjRTf3c=;
        b=Vg/06h/y0TpZ5QzziLbQoJX2gzImRXJXOScJ7EmecoXiSGGv1WZVRRobfqhvOC1xrY
         PwHEatprphQzp4q1hVNH4Lx8B3SxgzS9t9NQv1RKKXxXqdtu0fElr/LcbhOSdgOVI5+1
         TuLr3jubdol1z7Ldm5rBOI2qTvFXBOVOQoIz2FmASibUZFUPgFpCc++1e04ndrZGbuaC
         NI300A0kxBfhJSXuRMYnO/V9aTObgNkiYy2ijqOZdUfpXUhwMJ6QBhbXDRXT62mCRMLR
         RkW0fjPbaoWpDJMOAYaRQoBS4lh87JNjs+u81025SNxsO0C3nuWzqJ2OLembo9lq4eqz
         Fktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=KbJAe3BTalYdq1/KQ7NtM+mzlVrFPt7CmV0IrjRTf3c=;
        b=GGLHCHmO9+L56lb5rCGF1w72qAUaeD0cQzgCiAnpGF4hvGr0vte9Io7fHOIM8YSf0v
         cGnOIUZlvC2SLYR7cGHjsruxIbya7QeVfBiQU/3Y5c5xXo2j+LmQUGCnJdaC7Y9qXQ/H
         ECm4tWwk9S+ByhDF1QSFiuZGmZwzBMwLGGGm+C9uYNPjaFvR6jTpC4sUe6C3m48cF3FH
         FvWDWEM+84e1/ZQ0tjaodHLfD1fr3SDBs/GNZBVmNWpLc6Wc8uoE4Fnzk0GiULUPwF4Y
         U/6qFhilJJftuLbYYXVgbKUVT2MDOBCT3b4UZhtA2LHoFGl+h+6gnTDy/mJQR2O3ju5i
         LvXQ==
X-Gm-Message-State: ACgBeo184+wLzHn7kKU2e/psXhk1TzFzZ5qXU4N5XJkA5nlew1LG0zau
        P46ytKxXVnFVH6ombBBckLe6
X-Google-Smtp-Source: AA6agR41kVxpCSpY+o51e0Q5MP5n/aNDJA6wRe9IpzDvq/LIfNGVjND4Y7nq5873hRBYbUgqYXa/0Q==
X-Received: by 2002:a05:6638:ed1:b0:342:dfd2:6278 with SMTP id q17-20020a0566380ed100b00342dfd26278mr5763319jas.316.1660051007077;
        Tue, 09 Aug 2022 06:16:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:14e1:3e6e:802:8594? ([2600:1700:e72:80a0:14e1:3e6e:802:8594])
        by smtp.gmail.com with ESMTPSA id m4-20020a0566022ac400b0067c47eb46desm1088059iov.47.2022.08.09.06.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 06:16:46 -0700 (PDT)
Message-ID: <d8a20d85-ab00-cb03-765b-e1d080de422b@github.com>
Date:   Tue, 9 Aug 2022 09:16:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: ds/* (was What's cooking in git.git (Aug 2022, #03; Mon, 8))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqv8r2qoi4.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqv8r2qoi4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/8/2022 7:55 PM, Junio C Hamano wrote:
> * ds/bundle-uri-clone (2022-08-02) 5 commits
>  - clone: --bundle-uri cannot be combined with --depth
>  - bundle-uri: add support for http(s):// and file://
>  - clone: add --bundle-uri option
>  - bundle-uri: create basic file-copy logic
>  - remote-curl: add 'get' capability
> 
>  Implement "git clone --bundle-uri".
> 
>  Expecting a reroll.
>  cf. <9afd5eb2-44a0-6342-6006-5dbdefba9947@github.com>
>  source: <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>

I just sent v3 [1], including the updates to the protocol parsing.

[1] https://lore.kernel.org/git/pull.1300.v3.git.1660050703.gitgitgadget@gmail.com

> * ds/bundle-uri-more (2022-07-25) 2 commits
>  - bundle-uri: add example bundle organization
>  - docs: document bundle URI standard
> 
>  The "bundle URI" topic.
> 
>  Needs review.
>  source: <pull.1248.v3.git.1658757188.gitgitgadget@gmail.com>

I just sent v4 [2], including minor rewords of things. Now that this was
reviewed by Josh, Matthew, and yourself, do you still feel that more
review is required?

[2] https://lore.kernel.org/git/pull.1248.v4.git.1660050761.gitgitgadget@gmail.com

> * ds/decorate-filter-tweak (2022-08-05) 11 commits
>  - fetch: use ref_namespaces during prefetch
>  - maintenance: stop writing log.excludeDecoration
>  - log: create log.initialDecorationSet=all
>  - log: add --clear-decorations option
>  - log: add default decoration filter
>  - log-tree: use ref_namespaces instead of if/else-if
>  - refs: use ref_namespaces for replace refs base
>  - refs: add array of ref namespaces
>  - t4207: test coloring of grafted decorations
>  - t4207: modernize test
>  - refs: allow "HEAD" as decoration filter
> 
>  The namespaces used by "log --decorate" from "refs/" hierarchy by
>  default has been tightened.
> 
>  Will merge to 'next'?
>  source: <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>

I think review has stabilized on this series.

Thanks,
-Stolee
