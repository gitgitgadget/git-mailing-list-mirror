Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF37C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 18:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC8C261130
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 18:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbhJMSQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhJMSQL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 14:16:11 -0400
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CB4C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 11:14:08 -0700 (PDT)
Received: by mail-oi1-x249.google.com with SMTP id m189-20020aca58c6000000b0027381ff1c37so2105485oib.22
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 11:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+mx+JtSvmtb3kDxBBy+4kv3irOzKOS8NR1lGGKMhCwk=;
        b=k9Oo5tLojB4hoxBu04smScQ+85N60e7w7ipsq+i7M+5QRuo5k3i5mtT7czt6g4r49A
         wYz/0e9jW3bms2cr6Y+7XJee5X8spkLsGU3jOwFPUF+dqAofpGt8jRBSlIuYykKA+8oa
         +8txQREpegPqwLighR0qLTHfI+F2ZNK8eFjQVimsBeY722oOC7ZWi83+zg5fAXJbXa44
         uxm+m1t3bNGVhixIEpbud2nLXIjtgAa/V7PaaglyaLN9yiI8DFgYVGhDlseZgVtw0SEY
         A8e6JdZLQP6iQNXf7m3kgKZbjBcmzwC2bob9W9ZVXnfyohjbzU0he1bDW8U0e0L1ezbB
         kCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+mx+JtSvmtb3kDxBBy+4kv3irOzKOS8NR1lGGKMhCwk=;
        b=7pfhYPwqIJ1FWQyp3ZP4orM5I+axsxBherw+OX6bS9SjsTFYH4FtAzyLsIu8dd5u+0
         bBl3bJ1h4bu7NChNzVy9qe2Y6z8p3DSnxGza+UiZde13ILFA+zRMJwA86MaB9/eJUBVC
         qI5pSIZkecH7qhT+SLZCO11h6z2MM1HviJnGtGJ4dsS3Ise76JCPwJ+8hbPdM9r+AeIk
         ab4V1V2eJkUOhCSxNqInWUBZuLMGS64NTpED5KaNZlINJOZuQBVPuheOVbidp8l/mnem
         ilBGsXyK+T2Ab00hs7EkJYV1gmvUBGvVnXEQn4XovPaIRrQy6PEcRI2qnAJ1psriXnmD
         dfZA==
X-Gm-Message-State: AOAM532XteWHdUH9ogew68cwH5IVDMN+6jAs8rn7ulnqyXGOgudMFuOH
        e0DWUgVLchI2+RkiTq2bgh7gvPU6UUFKAjcDQH2y
X-Google-Smtp-Source: ABdhPJwk0RuDI1DE0hEM3pmaOW5TTWazXzySMClFa8q+Iz+o4b9j1+o6pfkBtMaheV1IDHCEQURIfk3D8GHumyXRBIvZ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1147:: with SMTP id
 p7mr1079509ybu.107.1634148837276; Wed, 13 Oct 2021 11:13:57 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:13:53 -0700
In-Reply-To: <xmqqk0igj1vf.fsf@gitster.g>
Message-Id: <20211013181353.83505-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqk0igj1vf.fsf@gitster.g>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: Re: [RFC PATCH 1/2] config: make git_config_include() static
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > ...and avoid the forward declaration?
> >
> > I've seen that in a few places, making the diff smaller here doesn't
> > seem worth it v.s. maintaining the definition in two places.
> 
> Sounds good.  If we are moving things around anyway, it is probably
> a good time to do that, too ;-)

OK, I'll do this.
