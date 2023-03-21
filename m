Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F78C77B60
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 21:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCUV6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 17:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjCUV5x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 17:57:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE985980A
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 14:56:57 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54161af1984so166295617b3.3
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 14:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679435816;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d4OWPQ/vSP+M7kycctbEsBhmUpoNm4jOkHS60sZG4oo=;
        b=dYxLaQPS8yeOVYcfQ7ckTJLWhfIoNlXQVcvaQgxN8jXr+ZW9wJDydMr2tKxJlGa8oG
         CQwrrBGxVkiACFVK1vssa7dqwjYbaK0JRHTTkaKIpRn5KpeEfzgv55CEtqqNvOazy0Tc
         FuS0zVouhh/Dl8TjgWi1xUTTiDPYXnkL/z4HkOQ9vxLlENRP8L1y4pUrpmfqR4JdmDcJ
         PHip25zqNTCiMWdAnq86jWck8f+ze+0yTl+POu9TYtMkYF+JBMzJiOBqx+TRRs4o6fjn
         45juoEhumbcLCpaHIcGEEqkNxVbnxL+OSeCJLBC2v+iqwzUoMsZhpsyV1gdfzOusgWd3
         hmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679435816;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4OWPQ/vSP+M7kycctbEsBhmUpoNm4jOkHS60sZG4oo=;
        b=p5vNGqjW9jPH29Z3aVBcNLIBYxSFV9L1LkvuyN+d97i6vwrFoJFENkgNhlmqi34Uqh
         yNpCrIrJHmSHFNpTlFsKe0rUYW8UTDRIPpp/5N58NOFVjVXMTF2X5u1GcxNajDlsxt6Y
         /QhvI46nI9VNwVrt3e/fxrqCyhR1wSQRaMseC64Vhk/E2Dx+X4MvbuUCZVSIdxhSmyiW
         kdy3xO2nYripWr6RDlXAgDr/kccmdDUIdj85gQQCXTgdOF4os502T0MMghAzCcQwHaqF
         pily1YzjXTf/sRi2hG/pDjrbYfoBzNu9QcoelX6LdJzL89bqHwdhsnXtCQ/xCOr7nKX5
         1gYQ==
X-Gm-Message-State: AAQBX9djnkNohU4qXZVmKfvt1J80QiUkpVw52jL9wDH1lmo/2ni8PWgt
        MljqJfclq2b3y1HEX6SecWGBmAKS2JuHeis5TYet
X-Google-Smtp-Source: AKy350bQo0CjIWb3DRZuC0imF9sVI8VErp7/Dj788VH/t0szBFq2HE/4aBhPfTDHkyQ8nXM1wZmCSATy8VN5BBZ+gvZl
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:2807:a6b0:7cba:8634])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:302:b0:a8a:a652:2a69 with
 SMTP id b2-20020a056902030200b00a8aa6522a69mr2179114ybs.10.1679435815828;
 Tue, 21 Mar 2023 14:56:55 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:56:53 -0700
In-Reply-To: <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230321215653.1615083-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 00/16] Header cleanups
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>  * Patch 1: leftover cleanup from en/header-cleanups (now in master) that
>    should have been included in that series
>  * Patches 2-4: cleanups around gettext.h. Without these patches, many
>    gettext inclusions would have to be squashed into later patches and make
>    them harder to review. Also, the implicit dependency on gettext.h was
>    making it much harder to find other dependencies.
>  * Patch 5: move some global var declarations from cache.h into the header
>    associated with where the vars are declared
>  * Patches 6-16: move header declarations from cache.h into a header named
>    the same as the source file containing the actual functions (e.g. move
>    declarations for abspath.c functions from cache.h into abspath.h), and
>    reduce the dependencies on cache.h accordingly.

Thanks for the effort. All the changes look good to me. (As for whether
gettext.h should go into cache.h/git-compat-util.h, I think that
individual files that use it should include it themselves, just as you
have done in this patch set. This means, among other things, that we can
reuse Git code in other projects that do not use gettext.)
 
