Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91033C46467
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 09:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjAOJb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 04:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjAOJby (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 04:31:54 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408BD9017
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 01:31:53 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d3so27510515plr.10
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 01:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jCpSUyPZon0jJryJHgKKZC6I/Xk2csGAP4ufEwIJpbU=;
        b=AFHK6cd0lLflBqigiCPXZhjHwCtIVLlUYLt56Kck4L/FcQ69mxDIiCTztWrFszAPOZ
         22i2C1+MXAHFTtEB3YWaTmBBbGgtN81rMiZhFLP2lEQ/oBNq50C+Lls91tZMmJ6CXdB2
         zn7s6BgHNeiMZo/BHNDqCqySTb0zP2xoxFEEJDllHtFLNQjqb8ZjmulMsaOXRSr/5JPN
         t3jQPWaA6ZQUjyt0Zdy0Vj7IFuWlVIaHn4Us9GpJLUu+3Skdl5YRdtt2MEYrum0jVv60
         PI1W5kFStEsm/8IMYP1iTvL7nOmX4k5WJlJq2MK3pBMYY3DhaaVhYi9e4kpHEXYMxmAo
         JlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCpSUyPZon0jJryJHgKKZC6I/Xk2csGAP4ufEwIJpbU=;
        b=4DEWCh0skOoTbhknZ9/3pkrxsqUuIFOqW8odArDvpXeISPAYIr86WSzmnOWu1VmEyI
         miZfRv3U/wB9sjkMKrNQBOTogy76FaNm4X93PP+YU9q5XRD9QdQP1zX4T8fq2v56is3y
         jLaS7BqGW7SZt9PAwCEKbdwMm+v6z5KFgW1sN05DFvxuuZMb0LOv3bK+zKMJ+QzavXTE
         NiralRrcv+BsfQHJRdyHPi8eMQCcRn1MS/HBpRNkh5Vl3j2BsXrYNJQeqoOU3gtx083F
         r8wWkD0B+MjLnBb7ZGaJhostlTj0W0Y2BKS6L9O67KRpbqoCDYcJ26BZ5Ri/3DEh+Fqk
         /wvQ==
X-Gm-Message-State: AFqh2kpeiAnoApeGmwLskcEzv4jeQP1lRe8d9waoOXW2bW4DhewPeMP4
        Nq5gPqY9HA2EMLYKEnwcf9Y=
X-Google-Smtp-Source: AMrXdXuPc0g2BJRSgLsdbglftwsgydv0J4eCd2zt1OhV4yHXLyfcQTsB5ed8GR+PSq/vjDvUAhfe5A==
X-Received: by 2002:a17:90b:181:b0:225:d697:41ea with SMTP id t1-20020a17090b018100b00225d69741eamr18391467pjs.23.1673775111985;
        Sun, 15 Jan 2023 01:31:51 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h12-20020a17090a648c00b0022941908b80sm2319917pjj.47.2023.01.15.01.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 01:31:51 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Jacob Keller <jacob.keller@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v5 0/4] Optionally skip hashing index on write
References: <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
        <pull.1439.v5.git.1673022717.gitgitgadget@gmail.com>
Date:   Sun, 15 Jan 2023 01:31:51 -0800
Message-ID: <xmqq358cgn3s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Writing the index is a critical action that takes place in multiple Git
> commands. The recent performance improvements available with the sparse
> index show how often the I/O costs around the index can affect different Git
> commands, although reading the index takes place more often than a write.

https://github.com/git/git/actions/runs/3922482355/jobs/6705454550#step:4:2006

shows that all other platforms passed but osx-gcc failed one of the
tests this series added.  Could it be that there is something racy
about the test (1006.6 if I am not mistaken)?

