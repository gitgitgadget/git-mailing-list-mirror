Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB9FC4320A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7F7611C9
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbhHXPzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238423AbhHXPzG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 11:55:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FBCC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 08:54:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id dm15so7407657edb.10
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=YoJzAU+9HQT06dSJt/CLQfNXf5GvMm/NOP1AKisyKps=;
        b=jbhY8vBZnW1TvRAIeymcENtwulH+ZC6vKIp7KEanc3wYAh+0U/sBPzZGq9y9OXv65/
         uuzo4cLDKB4slxwqDgnqv8AswqBnCWm6uYhy2XsvqWPaP4dysF16KHKuWQWSP850QyM0
         FBwz/XO2otteqF2o8QOhaTBSmr8MmGaJ+dTB9sGULD7aHts460snS1Z2GnX5QPobe7Fs
         O3tT+gc2SGTUv7xLFT2sdGp8IknNGXVYklSzzbh+IQVHCS2NoNcgeouM4gjMqtmAjSAV
         EKXAIPk+JJWtS/6wqemPy0OwCBMTYS1g/7Y/U2wn7Ys2xUUyb/+pxjPlQ2TRmUjLgBr6
         Lh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=YoJzAU+9HQT06dSJt/CLQfNXf5GvMm/NOP1AKisyKps=;
        b=lKch+BfImVa92mEpxI1MguN4/JlYGSzsgUfHkQiN4RrahO3iqJgnMJSMuOvQnn/InD
         F2NSFiXQ0oYwX59jCNHaxAoXUXuyF6sxCtp1Bxr4KFgq+UATsQC1vl3JQ9HbwBP6J/kO
         tjagTraxLRMiNCVyR3iIuMOJTShfKqqnTShQlAyBlBDrvTXLkT+bpJJkUcPUfzt0yF9L
         oU5ywYYmPHPWGS/aUywDEVaSm4EDoY59MyO/p4tFYxlQP3anFTOj5X6aJ+GWMV57bFH1
         HUKTyM+TCzYeRaN7yIWM96j3uQyFSAbSao61B4IpByhMt9Zz5t5h+TmPo0gheKaWgSMD
         tNig==
X-Gm-Message-State: AOAM532a1SuiZ+FLdmfGglYRox00XTaKamzwMIBke4do5KmBBmZbUHbB
        Y7y6mM6TwP8mMlddyDKW0YBu2ORN8l85GA==
X-Google-Smtp-Source: ABdhPJx0xxs96jAtYTp4lzxnLFDZydSKCfinBGVHxsCOXhbI4UdEa70tjfnx51n80kuaRH1tK7empw==
X-Received: by 2002:a05:6402:b47:: with SMTP id bx7mr12713117edb.319.1629820460496;
        Tue, 24 Aug 2021 08:54:20 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b18sm3411449ejl.90.2021.08.24.08.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 08:54:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/6] hook: introduce "git hook list"
Date:   Tue, 24 Aug 2021 17:53:48 +0200
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-4-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210819033450.3382652-4-emilyshaffer@google.com>
Message-ID: <87r1eiet3o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 18 2021, Emily Shaffer wrote:

> +	head = hook_list(hookname);

This doesn't compile, as hook_list() is added in a later
commit. Something something earlier suggestion of "git rebase -i --exec
'make test'" :)
