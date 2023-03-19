Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EA5C6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 17:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCSRaW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 19 Mar 2023 13:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCSRaU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 13:30:20 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999FF1423A
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 10:30:19 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id o2so2824503plg.4
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 10:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679247019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnugZ2AksJRMUtcNWWuIoN7fnwI/CBZCf7Sp4Jwg6HE=;
        b=uMMhUSx+IJjQbxMK1EHoB4TYmr0mVBmQpFztOYRRJYpxAjFsI79wg6b2rqd4EHv5mC
         leH0EFSLyhSexP5YVYXpN27HhTatt95VBpcNxDBvdqoEe/OeCFgrtp917p4lzhH9cUui
         BgMRz2s1BBK9y/Wcg7FnGLeuFJxZOVldVWkFF8BHGmyZhpwBRX9Rghu0Wo7pqGVub/Bh
         pPV+d9A5ziLhb97MXdKDqV2voSaqZjrb05r0FsIvN2Rv2g+Lwn4Ty/H2BwuFy7hMXYmO
         3nabFoq3S4bOcZJdIeBEgGUwSc7ortXxy2BjEwIi92DcF675i+Y0xbIl7bkhfjyRCD38
         CmmQ==
X-Gm-Message-State: AO0yUKWmulTrIoH/ViqvxbtynQQ8X6JNLRO73jTquJZrd5DCuwfVF/e9
        N2Oz44fHjgujoatvb5fqQdld13meSwMqFHGpj3EZTtF8eks=
X-Google-Smtp-Source: AK7set9AdopWYMOVsavVqhj2Vm7eoEnQaj1Cuc1BleRFZeIvge4OOn0ihiQx1nEgg9Qcxg0LiheuLQncBO2iDl77svo=
X-Received: by 2002:a17:902:f7c4:b0:1a0:41ea:b9ba with SMTP id
 h4-20020a170902f7c400b001a041eab9bamr5456132plw.8.1679247018931; Sun, 19 Mar
 2023 10:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1471.git.git.1679153586903.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.git.git.1679153586903.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Mar 2023 13:30:08 -0400
Message-ID: <CAPig+cQ+__c0CVspBgVxcGrzj8AnJJKKaQr-ofT4oLS-C-bQtw@mail.gmail.com>
Subject: Re: [PATCH] Document the output format of ls-remote
To:     Sean Allred via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2023 at 11:51 AM Sean Allred via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> While well-established, the output format of ls-remote was not actually
> documented. This patch adds an OUTPUT section to the documentation
> following the format of git-show-ref.txt (which has similar semantics).
>
> Signed-off-by: Sean Allred <allred.sean@gmail.com>
> ---
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> @@ -96,6 +96,24 @@ OPTIONS
> +OUTPUT
> +------
> +
> +The output is in the format: '<SHA-1 ID>' '<tab>' '<reference>'.

The angle brackets in the '<foo>' notation indicate a placeholder,
however, in the output, TAB is literal, it is never replaced with
something else. So, to be more accurate and less confusing, we should
instead say:

    The output is in the format: '<SHA-1 ID>' 'TAB' '<reference>'.

I understand that you copied '<tab>' from git-show-ref.txt, but we
don't need to replicate that mistake.

Moreover, these days, we support hash algorithms beyond merely SHA-1,
so the first placeholder should probably talk about object-ID instead:

    The output is in the format: '<OID>' 'TAB' '<reference>'.

> +----
> +$ git ls-remote
> +950264636c68591989456e3ba0a5442f93152c1a       refs/heads/main
> +73876f4861cd3d187a4682290ab75c9dccadbc56       refs/heads/maint
> +d9ab777d41f92a8c1684c91cfb02053d7dd1046b       refs/heads/next
> +74a0ffe000da036ce4ca843d991a7c6b8c246a08       refs/heads/seen
> +860bc4360c4fcba0fe2df942984d87f8467af3df       refs/heads/todo
> +d4ca2e3147b409459955613c152220f4db848ee1       refs/tags/v2.40.0
> +8810a79228a149a9773bf9c75f381fca27a6a80e       refs/tags/v2.40.0-rc0
> +f899c182d0bffb6e915da7c8db9be202b144c098       refs/tags/v2.40.0-rc1
> +6bed3304b2b2f1cf440ca3050b57a7cf3a3fe687       refs/tags/v2.40.0-rc2
> +----

I'm not an Asciidoc expert, but despite the fact that the real
git-ls-remote output emits TABs, I'm not sure we really want TABs in
the documentation since various Asciidoc implementations may render it
differently. Also, we don't seem to have any embedded TABs like this
in other documentation. It probably would be better to use spaces in
the documentation.

Those nits aside, the patch makes sense and is well-explained.
