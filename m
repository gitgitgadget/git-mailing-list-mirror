Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5CBECAAD3
	for <git@archiver.kernel.org>; Sat, 10 Sep 2022 16:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIJQkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Sep 2022 12:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiIJQko (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2022 12:40:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3B54B0DB
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 09:40:42 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x1so4595300plv.5
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 09:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=B54sUt/95+OrUF/MN3W8hOA0iRXswmreknvUG6KT/iA=;
        b=Cm53ca0a1jZYP/dvzDNWN6renKvUOSk+QLdgOSNDe7hMlD6KMVsRpTVJxjQhm10SsA
         CQu3PcZDM9j8ZEPoA/SenEqgZfXcDgKmfNcVvxBXNceEPEkXMYeiAX8r9gyDZiW/ZCcz
         zL1GXCvuwOH2z8Zq0lHETmluNQTqNa4c9qwYwxF6Wy2kVkUuHZxW1RL1PrCPqMHQ/wOq
         ktiWUvHSE95IYYgbMwrJ5AhpzLuZYs6bPXe0rgvaz8X5JYqd6GX1UW1f76sMxkxW3BCy
         WsfjyzXU0D+9QJQEb3H1ArttkUzpLrqQ+dFwSxoCTyihIxfzhUXGc2rsY7gRnGmfW5q1
         YDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=B54sUt/95+OrUF/MN3W8hOA0iRXswmreknvUG6KT/iA=;
        b=khq9Ap5iOeBQrqhPFwemz1xZFBtwHeEj2KgoWU7weGN+YebeNGij2QuOmc9a7w4t4+
         Bc3Ca0qZvFh+DYkWjvMuK7VqGyArSuwwuU/zag6NiMPBWRkaaNrusUS0A1Lkhp3oFUL6
         +ckBjeKMEGdwWAN0TfXeMye+Kl0B8ZyzXPK9QiZb236V/QOqKKUcMjiE6tx/avl4AOFm
         oLfjZEr9IZZBoYJbgLgk9/FJe9qDnZQZ/PaevQSwavB9QN/qgrTRcazoo3E1pEocZbCq
         T+FX+H3H7KM4IH55wQyMZLV2HJmVNS4JzNc+MI5TvyBZ5rrQa4g7sBwfsVzGZ4Gjtkmf
         yJPg==
X-Gm-Message-State: ACgBeo2N5aUJyfhh2S2m3UGTnTC/mga2oEGDsCUftYoyYSo3QH5HKJho
        PKF8AP4bhaAefz7uyHtMDfc=
X-Google-Smtp-Source: AA6agR6lcszJHPnmzr1sZD74fIMQFHEu5C8u0h1Hly3S2DFMszG+kcTHG8YuZy8YiWfxlQHGhFlIYw==
X-Received: by 2002:a17:90a:8548:b0:202:65b9:4bc0 with SMTP id a8-20020a17090a854800b0020265b94bc0mr15279874pjw.41.1662828041877;
        Sat, 10 Sep 2022 09:40:41 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id nh12-20020a17090b364c00b002006428f01esm2215967pjb.55.2022.09.10.09.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 09:40:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: en/remerge-diff-fixes
References: <xmqq5yhwi1vw.fsf@gitster.g>
        <CABPp-BG3jqJXjAWaZPZr6nO=U2oBRae-cHajc8-zbkpehURzrg@mail.gmail.com>
Date:   Sat, 10 Sep 2022 09:40:41 -0700
In-Reply-To: <CABPp-BG3jqJXjAWaZPZr6nO=U2oBRae-cHajc8-zbkpehURzrg@mail.gmail.com>
        (Elijah Newren's message of "Fri, 9 Sep 2022 18:26:27 -0700")
Message-ID: <xmqq1qsji3na.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> * en/remerge-diff-fixes (2022-09-02) 3 commits
>> ...
>>  Will probably need to rebase to make it mergeable to 'maint'.
>
> Is this last sentence stale?

Yes indeed. Thanks for noticing.
