Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBB3C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 11:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiKHLMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 06:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiKHLMo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 06:12:44 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B071007
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 03:12:41 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-13be3ef361dso15816804fac.12
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 03:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2BK/iODU75zqyuJHtfH9jnTF8ce6eWX56mj+Su87uJo=;
        b=GrLQ6dxHb4my+tBqq4XgCB1nDPg+g5CN58rdhk0DlMItsJeczKMRSwG7ib4n4NeNtg
         ztGzSIddBhPk58lOQWERrhCzeu3DbLquCxC0ByJQiO9VycDVrxdFVRF34Pt+l2lFQ6X/
         ueArFfu0k44jZxQ6UhmUr3M/ER13TZ8E28cmzpfPrK3wPFZIzgG0F6xSBzJ5lPdgw/xG
         j3vjaxnb1QGy9a3DE/AWy/ERrLFbacNc5IeZBeXN3IP9DpG9PGss0uBL7WT9/jyM4jsk
         dUH6TCv2ia/iZ8e75tRcsn8xnQig3APn3hcPnBTi0JPex1rhixsRKGVjBydsxybPp1N5
         lyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2BK/iODU75zqyuJHtfH9jnTF8ce6eWX56mj+Su87uJo=;
        b=CXM0yp5gQ1+X5HaGn8TzQyA6oKTZXQ6cUc+EwZ06e+OvmmjjF1avE9CgF0bd2ybrsa
         ujx/IRKFA5beun1n6qv+qj3gMo/TX2VW2vr2hV6Jm/9Fas24oBGz5tq6L+6CFu71os+T
         vGEwKsAxXH8dTuqrH+LHqcpsrjkN+pDpq8s9EUA7xWLBwGkO/KhaFVyY9MGMEMxCVOkA
         onQ5cWHJDQsHC60Lh6dkWxvDDAFBHMy+65l0zc3MBI+FlUqIECC/iWg27IA2ux0A7JAz
         0pks6gpmlMdUUIwTxBMwVi/joblWpIbH77lR9cG6hQYjewVgFa2fvDvby3R8rsJuXNRs
         A/uw==
X-Gm-Message-State: ACrzQf0M9pjNin1CXgRlo5kaxjL8n3P4ORFMaoZnlyncI2731Cu4Bnq5
        2NMzPa/v1EkbgC4LmlEGVKdSel8NpNcVFvlhL42r5sItd+I=
X-Google-Smtp-Source: AMsMyM5NpOKis4sPZJwE6tETOD970xg2VVzupoX9vW2OsF1Vxtugt/KMK6BRGcTs7cTBxbfRZ5qUF4XYJ2NcmrP4ne4=
X-Received: by 2002:a05:6870:8091:b0:13c:50b8:23de with SMTP id
 q17-20020a056870809100b0013c50b823demr37946607oab.183.1667905960189; Tue, 08
 Nov 2022 03:12:40 -0800 (PST)
MIME-Version: 1.0
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Tue, 8 Nov 2022 11:12:03 +0000
Message-ID: <CAGJzqs=+fCQzkDX53H8Mz-DjXicVVgRmmzPjkatSiOpYO7wGGA@mail.gmail.com>
Subject: git-credential-oauth
To:     git@vger.kernel.org
Cc:     peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all. I'm excited to share git-credential-oauth, a Git credential
helper that securely authenticates to GitHub, GitLab, BitBucket and
other forges using OAuth.
https://github.com/hickford/git-credential-oauth

The target user currently uses personal access tokens with
git-credential-store or git-credential-cache. I suspect most readers
of this list use SSH keys to authenticate, but you're welcome to try
it out with HTTPS remotes.

> The first time you push, the helper will open a browser window to authenticate. Subsequent pushes within the cache timeout require no interaction.

This read-only credential-generating helper is designed to be used in
conjunction with existing storage helpers. It's neat how the
credential system supports multiple helpers. With the config below,
Git checks the cache for a stored credential before generating a fresh
credential.

> [credential]
>   helper =
>   helper = cache --timeout 7200 # two hours
>   helper = oauth

Comments and suggestions welcome.

ps. Git Credential Manager already has this feature so why another
helper? git-credential-oauth is a simpler app that just does OAuth.
It's developed in Go so should be easy to package for Linux distros.
The install size is smaller.  For a full comparison, see
https://github.com/hickford/git-credential-oauth#comparison-with-git-credential-manager
.
