Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B03C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 21:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCUVZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 17:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjCUVZl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 17:25:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89FE5708F
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 14:25:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso21575107pjb.3
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 14:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679433940;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xY5uzKOGJeqrd5X5BolONErZ0LSwCSdYEdpGQrLYPhU=;
        b=eY0AnPrVZTqhcuMIazk3iuhgXOMIAmjI8RwrpSv8m63o9FGsGJil78KtGjMjE3kxkg
         1xRRru6VHbziXrAlKQwvQr6aDgsTMb/dQ6W7pE44y/aLj0rPCHlmWmXhxCGWgWcgxFbv
         lm7/uLB3gdELJX69jWnkrXVuqRDvtJPtK8aXZ4UMK+Sv63QsghNi4LYdtzQhelyu5TDY
         3grxu2DHELVzah9eJjaBhjGC/ruWunLpw1LuqSSD3F4/Dt5W1pZki9Mxsk090KHHzQ4W
         btfOz8D4aBvoMX96DwuR9x2M+JDxA89/i12ozYV/QRr+pXSj29XdX68PpGHHI7dyj5E1
         os3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679433940;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xY5uzKOGJeqrd5X5BolONErZ0LSwCSdYEdpGQrLYPhU=;
        b=IA7+SMkOk7NSFLMfnZBMJf1voNeQxt0dU4wq8xPPfAX65XV1NWNe2zwUA22UazRtAO
         PwXZi358ZAed4xGb3DW0qRUDFCcHDpKOdje110wpGHdKoD8I4Ic1RE+J6R2ygxyVDct0
         KD2YK9evkHsGTXsX6avbu6IVtwNsTQoZ8UkC//FIDM2Cqm96ZIM9Dhdg8xkB+xXp+9xk
         mqTG50ppvhyP8nAaV69aAffedRMbJwcztys2bDMeXeYuCFVb+fDibXtZCDch73VjjqCK
         3SeSxocvuAu4npxz7ApSMq1JmYV+iwkszsWaBDvUZY/vHTa0jv4rqiZvPFhFvcsm54F3
         9YcQ==
X-Gm-Message-State: AO0yUKXGX7RMX37p9bh7KFxDQjT4JQpujBkxy+C25cqbC6Qi1EmCdffx
        y/B5PLsu/BJR+aI3PJYUtDs=
X-Google-Smtp-Source: AK7set/AwjFss9I+nYihwio+s46ftJ1SttUS7/a8CkfLs5i7ttCvi43U+lelplwHRCkSEk6aO59sNA==
X-Received: by 2002:a05:6a20:9a:b0:da:62c2:6402 with SMTP id 26-20020a056a20009a00b000da62c26402mr2633341pzg.30.1679433940116;
        Tue, 21 Mar 2023 14:25:40 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id j23-20020aa78dd7000000b0058bf2ae9694sm8726209pfr.156.2023.03.21.14.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 14:25:39 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: [PATCH v6 1/2] t1092: add tests for `git diff-files`
References: <20230310050021.123769-1-cheskaqiqi@gmail.com>
        <20230320205241.105476-1-cheskaqiqi@gmail.com>
        <20230320205241.105476-2-cheskaqiqi@gmail.com>
        <d940fe05-de86-5069-1d77-f4c7d0d368b6@github.com>
Date:   Tue, 21 Mar 2023 14:25:39 -0700
In-Reply-To: <d940fe05-de86-5069-1d77-f4c7d0d368b6@github.com> (Victoria Dye's
        message of "Tue, 21 Mar 2023 14:21:46 -0700")
Message-ID: <xmqq1qlhhk4s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> The strange thing is, once I fixed the 'mkdir' issue in my local copy of
> these patches, these 'test_all_match diff-files' calls succeeded. It turns
> out that 'git diff-files' in the 'full-checkout', like in 'sparse-checkout',
> reports a difference in 'folder1/a' that doesn't actually exist. So the bug
> isn't in sparse-checkout as I initially assumed [1], but rather in
> diff-files itself.

Is that a bug, or just a common "ah, you forgot to refresh the index"?
