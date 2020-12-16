Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6408CC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2029522D75
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgLPAcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgLPAcN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 19:32:13 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5459C0613D6
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 16:31:32 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id iq13so518939pjb.3
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 16:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pb/kG4gDxxDk3yUbIGjCq4uI0hg8dFXe/6cFijJsI5k=;
        b=aKiDoUkr/EfUv26t4tMbTkzuLLQJ1PY1LZSWnc4b9PhpwFNnspsW17bInYJdflavpj
         5US4dCoFGPAf/zuH1XMyqRFx+XVgwjkLbvTTFElR0v4i/yCDBqkotmxH5rCmw9+Ksvxd
         HqzYSdazUxWWbve6DYp4dOww3m6HjIlfITOYW7KRpZzdcKS1F1olliqOLHAoF7nuKHHX
         rbLJHAB1m5jsnJEfcETBvikBdAsv5JdHNkYBSOGzrWiGEasnO5qDy94wd4l5qaF8G+uO
         f/76XkJo/VqxOQjNUhM/oZIIz++/9TGBZK02fnL7MBD0HtekuNmTAX2FtvOHtCFeKM15
         enSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Pb/kG4gDxxDk3yUbIGjCq4uI0hg8dFXe/6cFijJsI5k=;
        b=SwiRsLbpcjyKV3ad/C/940juJqNd2opLn03IqYjXae+iXjNvQKHjd63gzJaLBptX3H
         mAsrmppZ4XD+jCpKNox0PChK+dJvp0riOz6oLWbYjcD7quz0lWgBek7VZ0siSfcxKhL4
         lJ6HpXOREXZhnGeb5Gerh6tN9Op+LpxO+s4jEf9ql7F/irtiJy4dsDcGbYpx4/d1WrLF
         0cRzrQWgjDc1GqOr5dPYlMCTJUBnWX4aiD64FXoc/K/GYOh1eBbN98tqxZV27IuxotRa
         Br4m+Z8kdmuM43WTZNEunoyTtJx/MfDPfgBnWa/XuDgJPX0dD4suHkKlnUOFsMAD8t6A
         i/Rw==
X-Gm-Message-State: AOAM5328gjx3UGCJAkOzpCY7Pyuypeyw2QqDhF9zupM3KaJdcUVNb2yd
        mhR79cd8XVMDpmwGRhdEHmCLAQ==
X-Google-Smtp-Source: ABdhPJyFsZ5cKjA4YJirGtLx2agU8FC547uY1uDcaM9APpgRkaM1h3Q0V7yueTX2b42I7SMcfoA08Q==
X-Received: by 2002:a17:902:d907:b029:db:cb2b:8bcc with SMTP id c7-20020a170902d907b02900dbcb2b8bccmr29783699plz.9.1608078692223;
        Tue, 15 Dec 2020 16:31:32 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id u24sm43954pjx.56.2020.12.15.16.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 16:31:31 -0800 (PST)
Date:   Tue, 15 Dec 2020 16:31:26 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit: use config-based hooks (config-based hooks part
 II)
Message-ID: <20201216003126.GQ36751@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20201014232517.3068298-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014232517.3068298-1-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.10.14 16:25, Emily Shaffer wrote:
> As part of the adoption of config-based hooks, teach run_commit_hook()
> to call hook.h instead of run-command.h. This covers 'pre-commit',
> 'commit-msg', and 'prepare-commit-msg'. Additionally, ask the hook
> library - not run-command - whether any hooks will be run, as it's
> possible hooks may exist in the config but not the hookdir.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---

Apart from the minor issues I noted on patches 8 & 10, this looks good
to me.

Reviewed-by: Josh Steadmon <steadmon@google.com>
