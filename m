Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1DBC433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 08:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A15923BA7
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 08:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgLIISQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 03:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgLIISQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 03:18:16 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24853C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 00:17:36 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cw27so576814edb.5
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 00:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:user-agent:date:message-id:mime-version;
        bh=i58MUca+eBMvrcg6MKwO+gZLeX1qINp7hFGqm7kJQuY=;
        b=cuhpV6PtIT6LXruKhsAWgJ0MZAIKAWlpa4ksjj73eHrGbUevXXpsNavhakUxYgcu4V
         bRMV0meAJOZxp/A1c8U820Vs3cNDshoXJ44If46QAoqIqu2SAJADRMvwvfw1ee/P02qD
         C3GMZ6jHQnrzh9ggYYslpmhBpxuIqfLqm6tVPNzhaxNRq/eCqAiUNm56ecYvewsrTAMM
         kaH9cXJ0cUSWoSWagYJciNPSoLxYZB98OECwA4fApC9YkYPwzl5m03AZu9T61SkUqAc3
         3fOLY1kfbFWIHW7fTVhw1jHFn8v5GxijpHANsG6XKTt/p8TUxIpk4mEGexzATGYYpabZ
         2WSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:user-agent:date:message-id
         :mime-version;
        bh=i58MUca+eBMvrcg6MKwO+gZLeX1qINp7hFGqm7kJQuY=;
        b=o+KrltmDZPFC4CPTFFRJ4nBLsJDoP8IiIzNtu9p94x7GyZGdCZb2gGQjHAtp7sjPVB
         cLt+7qWP5P7e2tjno84h4Un8XQQniMreixLmEEu+ZGASSzIchOPqY4wgjeCq75JrF3/z
         zIxCdrGeMcQmL84pzTC+vljmwykPsGWruMmaG1zjS1qrRLLcQXTBuGmRc60GlX9e3TJi
         mNq+HKTNr1QlKHUlMHWByJ1R2EpzrtmFlYhEXM4QSl2ltJ/9FFTnv03nBfanatK6oUA+
         xe8VGhKyLPDcachE56FTJqShwwAvFMocb05HFvgEbd/JFJK151+rHDGSEHzsw+V07w8s
         e25Q==
X-Gm-Message-State: AOAM533MXTvwQ259KRapaAilFRGVjpVOSo3Xif2RZahhNQFJd1PWN4k8
        E9QrFzrr/SoW0yUwAY86pwGxjcq5bz4=
X-Google-Smtp-Source: ABdhPJxyRg9InC+uTCJd20k8Lnpc9j/Wi4NNcKL2NacR8r+voKKThAmTYjA5AqLPoY/zreavvRN6eQ==
X-Received: by 2002:aa7:cd84:: with SMTP id x4mr903931edv.192.1607501854732;
        Wed, 09 Dec 2020 00:17:34 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id d9sm772327edk.86.2020.12.09.00.17.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 00:17:33 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Subject: RFC: Modernizing the contept of plumbing v.s. porcelain
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
Date:   Wed, 09 Dec 2020 09:17:33 +0100
Message-ID: <878sa7xujm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A lot of external guides and people's mental models of /usr/bin/git as a
scriptable client reference the concept of plumbing & porcelain. Just
one such example [1] prompted me to write this E-Mail.

I've wondered if we shouldn't be updating this concept to reflect the
reality on the ground in the git command ecosystem.

I.e. if you look at "git help git"'s list of plumbing v.s. porcelain it
makes no mention or distinction between those commands & functionalities
that are truly transitory "porcelain". E.g. the specific error message a
command might return, and those that are effectively plumbing. E.g. some
"git config" functionality, "git init", the pretty formats in "git log"
etc.

I'm not quite sure what I'm proposing if anything, just putting out
feelers to see if others think this documentary status quo has drifted
from reality.

One potential change would be to mostly/entirely remove the
"porcelain/ancillary/plumbing" distinction in "git help git" (except
maybe e.g. "hash-object") and instead make a mention of the status of
the command at the top of its own manpage, which could then also
(e.g. in the case of "git log") document the API reliability of its
various sub-features.

1. https://gitlab.com/gitlab-org/gitaly/-/blob/afc90e3c2/doc/serverside_git_usage.md#L11-17
