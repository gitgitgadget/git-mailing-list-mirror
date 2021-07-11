Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B248C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 12:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28F561159
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 12:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhGKMC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 08:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKMC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 08:02:58 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E0BC0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 05:00:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h8so9147555eds.4
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 05:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=RrG/s42nVtA/aE06VeUhAtyvPDineYGzql/fl+fGPqs=;
        b=DuoAStd5s7nko00ANRISqmnhVIoVnQzbyHxV3KnRfWCOcPxKXQQU6C2nW9TMeZtBvg
         t2h1bnxnjW81iPsIUlaRtD9vMTb4oK7bN4TZs2XkGZXdxBElW0ZcwL3bhcCuIAWRTRSZ
         AfOwgx4zM0t9eoscCrxbJ10i2QorLsxZRJ/k3MJl81gC71aNspEwUn2GJgPSI5G7DO05
         WiBDmfVC5QiAVU3Ae44/tAlaT8GsCT2+2i3YBvet5lCCwZt7CQhAaa4YJDkD1p0t3zGQ
         tu2i40hAHW0K6dPITjKIZMZZqDajqfHJ62FuoPBJlc78/8/NL6IXZOhDRx4kI2cx7oYq
         Cteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=RrG/s42nVtA/aE06VeUhAtyvPDineYGzql/fl+fGPqs=;
        b=bi9ayehUfEhIVjQVyFXvY12SgKdNXBOUPCRHJaqXLNeBQ7wlf7xORgV68hZuw0zIKt
         TifmHb/3uh10MdDKZCcacrp/te2ezn+ko+mBt9WquaZx0v6j8qF7IOgdFS5fLuFARVxT
         s5v4tb7yyy7SIbUxmNXSVEyjhIyZoj1caRbwP8xaSs22VkmOPLIpYXL84aAGEtAQdrCv
         qJTBs/jEhGa74FhwBRgCH6EtWaPfbM6XQVLmdUvLXFNtSEIpiT35cxHQWTOHt1JCxAyw
         dSlzpUTHdOuamj7gTdykpszYCMlOav28fy9n09Th7A/wTuIAXwwOqw+kjVYYx8u+bO79
         /hcg==
X-Gm-Message-State: AOAM5313xUMTsxO5B8xCqYITaCOT0uj9T2VCryPHTUzs8hV2uzfzz3/s
        mp8zkZma9B1YR+opm7qm3JGlFOAMXrg2ag==
X-Google-Smtp-Source: ABdhPJybbqzKRJ93rip9Q+LihJvX9Uxx8OKGO4VdCvqY/m3ZoKiYsnp+38HiZI+QySU8kcYy9MQS1g==
X-Received: by 2002:a05:6402:1042:: with SMTP id e2mr51076971edu.144.1626004809314;
        Sun, 11 Jul 2021 05:00:09 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id cq22sm2191111edb.77.2021.07.11.05.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 05:00:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v5 4/6] refs: add failure_errno to refs_read_raw_ref()
 signature
Date:   Sun, 11 Jul 2021 13:59:45 +0200
References: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
 <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
 <ef91f5cee13b1153f597f31451460bba543a63c3.1625684869.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <ef91f5cee13b1153f597f31451460bba543a63c3.1625684869.git.gitgitgadget@gmail.com>
Message-ID: <87fswl3vsn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 07 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This lets us use the explicit errno output parameter in refs_resolve_ref_unsafe.
> [...]
> +const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,

This and the subsequent commit don't compile for me, because this lacks
a prototype that you finally add in 6/6.
