Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087D3C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67746117A
	for <git@archiver.kernel.org>; Tue, 18 May 2021 15:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350428AbhERPxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 11:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbhERPxd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 11:53:33 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B2AC061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 08:52:15 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id v5so12156027ljg.12
        for <git@vger.kernel.org>; Tue, 18 May 2021 08:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uQMyWBpVICt9rPT+0qtG94R1qinifkMxqRdM6M8p0Ek=;
        b=VtwttCsgxg70pEByD9zRahANbXxnep81FfWK8a3teJEYzi+pPZaJorD7Vqt027zyL6
         DUEdhUpkvn4tz8TPbPVzmqgSKVolm51zfKVMxeH75gjGMOxSB1Dw3rBFFG1iAnbN/rBJ
         bauEYWWI554dbpZrUDwR/Ju0LKXbgZWz5ROCwqdjTXXRmvpXpMtTHEwuKN1HB9k2DDQU
         dBXn54l7ZLj6u3XWwNff1UAimX78FPRQ6sq44/c6dY+Qt0DjE6hgU1MdJAGqNEK9wasm
         3myyRToRfiy9KWRGOZyI1Xlvui7v8w9TFpEXsU9mCuX4vP4gEs6ozQFOHnfyRXpqz4VW
         7nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=uQMyWBpVICt9rPT+0qtG94R1qinifkMxqRdM6M8p0Ek=;
        b=Ri03hA4qEK68YgZst3fgcjJEEzJ/nenPA8zTYciCnXI82p+NnlSole2yNQWprh8sCh
         t5IGg6NJ2NdlS11iMRbLbrqf80zCqV4wAHGu65boW1bH+Ovy9m3Q0R10hylbUAaU1s3B
         VnNo39sJpBz6LOM9WqSd0rEK7jbcpt5qERgpXLcDl106jFllPOE1bFjnifjW/ogTp9fX
         4vtxNSHiZrvWXoUk1YIVG1BgiaBqMaojsYX6iQkcf44aKqknUwpBT1xQM650LJrbeVhF
         nugv4Ez6EFkkXrZd1W3SSRN62X/j8I1CO0MOzB9VpbSs2antS9p8D/pru+Ww6xQCCs33
         ulxQ==
X-Gm-Message-State: AOAM530xY+TqAoOxKr7J+uR27512+TvcF6N5E8kx4EsEOsXFqOgX9H2y
        fGFB2Qhj2WWmm+aWcSd+yQ//7VyuYdE=
X-Google-Smtp-Source: ABdhPJx7xwUUDRSJLdEU4G4JceK6Jyuweub4Sc9NjLzd9wIFOLKjT8qc5RY0TddEzto4gjv5yuqQSg==
X-Received: by 2002:a2e:6c1a:: with SMTP id h26mr4695053ljc.478.1621353133702;
        Tue, 18 May 2021 08:52:13 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h13sm3262411lji.102.2021.05.18.08.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 08:52:13 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1 0/9] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210517155818.32224-1-sorganov@gmail.com>
        <xmqqr1i42kje.fsf@gitster.g>
Date:   Tue, 18 May 2021 18:52:12 +0300
In-Reply-To: <xmqqr1i42kje.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        18 May 2021 23:17:41 +0900")
Message-ID: <87bl989h03.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Sergey Organov (9):
>>   t4013: test that "-m" alone has no effect in "git log"
>>   t4013: test "git -m --raw"
>>   t4013: test "git -m --stat"
>
> These two are mistitled (s/git -m/git log -m/).  Not a big deal as I
> could "rebase -i" locally if there is no other changes needed, but
> if you are going to have a reroll for other reasons, please correct
> them.

I'll correct and re-roll, please don't bother rebasing.

>
>>   stash list: stop passing "-m" to "git list"
>
> s/git list/git log/, I would think.

Yep, and the description itself is as buggy.

Thanks,

-- Sergey Organov

[...]

