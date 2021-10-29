Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3A3C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 17:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71AC3610A0
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 17:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhJ2Rdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 13:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhJ2Rdn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 13:33:43 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9FBC061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 10:31:14 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id y9-20020a17090a2b4900b001a41086b3e0so3965525pjc.8
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T8BCv4JHtJeJH87PkS6fGRZIkUUTj+55rJlb5lwH044=;
        b=o7PfqHjJJSHybUJcbrHOntxzcetI7yXpP9ULPZGu6t2nFmhebu2ALpl17QJvjPrf3H
         Fs6AQSxxE2/RUw8ak9ZiHdYHwfYU/sMcYTxlsSRlxhiOOhkd6pe9uUbwzLMZ/D5UjEGO
         n0a4CuL2oxMF9ESBO+etkJzqVkmKA459plOrR1k4Ag61NFyud2/Hmz7iOR1FkLQ5fPN3
         wBIKGKmwaJRXPqdTnqP4aGcSMO8Pox9Skl/2fp9nTWKP/4MPn1FeIKT3v5w5f7IzlxJx
         nZcbNicG760JaI1FbbJdE9HOOdmmiRzBQd051rdlFfoYFe9My6MExX5uWSFDQVGsme46
         uU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T8BCv4JHtJeJH87PkS6fGRZIkUUTj+55rJlb5lwH044=;
        b=hbXUfvKqJ8mrkbp6BdDwAn3B1K4iOsMQXaVrH6uT38l8Vup5YwxdjvHXn8apnVBpPt
         hZG5V68RelCcfzYJV090lD9dKCVSodbjylSod8ZfOzMp88qvLVpYWUDxKUu7WZezXlQ+
         EaSPy+64KaJ0cRHbXhDZ4BbwiIvLu9R4hij/lclXnDWgyxrqFD5uxsge6qxQ9+QII3jz
         YpLYQ0A4MadMx0bb322PhdwnQ4ARpCISqzXQUE8GXzms2Kn7gIhYG/0lBkhgKYxFftGN
         S712WWGlDT3GA8VgplnkC+mHq6wyNIFZMnnutkIMvA8/O8I4Ge9MXz5s72joxf/A1QqF
         phrQ==
X-Gm-Message-State: AOAM531nQOD2a8vseD6NEBGdivu4aHS+ltp62ysDpL67fTIRKtFnWd9b
        w7rLFQxpPPyBkpsgoUh6tDyoOxbMemjxmxcrFKf3olEDEWCk6eE5tH4psRoN1616qjoOD7fDCYv
        Ow7xcpqcordlhtokqfwEfpljQ8vLQd2ik+C66qIE1WZ38P90LOi7x2CzplBdoItAGYwIm8Jr+4Y
        kd
X-Google-Smtp-Source: ABdhPJy9nheiGb8YuFytRhOkXNUIEzn+9yUgneo7sUZg0C7vDpBGe08k3jnzVZHizN0+dnZE+67d5QyeCc2I/ZIK2Jhb
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:9197:0:b0:44d:a2e9:72cf with
 SMTP id x23-20020aa79197000000b0044da2e972cfmr12520827pfa.38.1635528674235;
 Fri, 29 Oct 2021 10:31:14 -0700 (PDT)
Date:   Fri, 29 Oct 2021 10:31:08 -0700
In-Reply-To: <cover.1634077795.git.jonathantanmy@google.com>
Message-Id: <cover.1635527389.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [WIP v2 0/2] Conditional config includes based on remote URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a version that implements the URL lookahead. Compared to an
approach in which we rerun config in order to just get the remote URLs,
I think that the main benefit of this is that we don't read from disk
twice. One inelegant thing is that we now have essentially two caches of
config variables - the one in struct repository (struct config_set
*config) and the one newly introduced by this patch set. (Although I
think that many commands don't use the cache in struct repository,
instead just reading the config in one pass.)

(Of course, there is also the possibility that we should have the remote
repo administrator provide the config in another way.)

I have marked this WIP. This patch set is mostly done, except for the
following:
 - Prohibiting remote.?.url from any files included directly or
   indirectly by a URL-conditional include.
 - Checking that memory everywhere is freed when no longer needed.
 - Documentation (as mentioned in the NEEDSWORK comment in patch 2).
 - Tests that check what the glob matches and doesn't match.

No range-diff included because this version is substantially different.

Jonathan Tan (2):
  config: make git_config_include() static
  config: include file if remote URL matches a glob

 config.c          | 142 ++++++++++++++++++++++++++++++++++++++++++----
 config.h          |  37 ++----------
 t/t1300-config.sh |  60 ++++++++++++++++++++
 3 files changed, 194 insertions(+), 45 deletions(-)

-- 
2.33.1.1089.g2158813163f-goog

