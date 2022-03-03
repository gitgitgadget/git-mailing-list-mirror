Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE38CC433FE
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 05:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiCCFrO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 3 Mar 2022 00:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCCFrN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 00:47:13 -0500
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599B7119873
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 21:46:28 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id bd1so3550447plb.13
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 21:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pmnuRewm/0rU6eRxAmzXOfQ0kddJCVd9fDTxY88r0ow=;
        b=uNydFfkZl9HK2BaVcTBj5qBzTbmROuOl2vNbQ14d4TVVUiFvcnM4vMk24zkFkO7ycT
         nqlgztA/jXxwcLitrQnG4ZDif6/yrCV0Q0AT3/Gq7JnWJEzubNWhAgAXA12XySOotpAu
         s6MAA/vV6NWwgwa2K6E6UJl7ccIAOpISISVhxAeDVFqR9xuC0BLd1HjJ0hPaP7TDHfpG
         d4jROFl0EK7lDYlsgtXDzjMoSgryI2+TDAEjlK1t7yu/JOVcDaMcDLwhsVBFNGEmzp5L
         zr3zXpuqxp7aSuuclUU3nnc4aiMMQO2IcLj1Yd33g971zSdZ5adRfRYXVhfa+yHOSLSy
         WVcw==
X-Gm-Message-State: AOAM531Ed4IxQRQO8PYH0ialYVA/PXHpBz3IWREzrCfOE7d6CKsrcvvy
        awO+I6ASofMXoyOMRSaN5PVLVIgQNhA1rGLkKsc=
X-Google-Smtp-Source: ABdhPJwZ1GbqNxF3PhbCiFdegt5C+h9C+sYQ78lf0tHts1nXBYdGTkUJTg/1DjZEMSTo9krM2Abvozf3v6stA87Leuw=
X-Received: by 2002:a17:903:2289:b0:151:64c6:20fd with SMTP id
 b9-20020a170903228900b0015164c620fdmr20009298plh.64.1646286387594; Wed, 02
 Mar 2022 21:46:27 -0800 (PST)
MIME-Version: 1.0
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com> <patch-10.10-7fef92872f3-20220302T131859Z-avarab@gmail.com>
In-Reply-To: <patch-10.10-7fef92872f3-20220302T131859Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 3 Mar 2022 00:46:16 -0500
Message-ID: <CAPig+cRfb7AuJK-NhkdAV6P52HviSFqJXB9kvDpmtTYd=yJSUQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] tests: change "cat && chmod +x" to use "test_hook"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 2, 2022 at 8:22 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Refactor various test code to use the "test_hook" helper. This change:
>
>  - Fixes the long-standing issues with those tests using "#!/bin/sh"
>    instead of "#!$SHELL_PATH". Using "#!/bin/sh" here happened to work
>    because this code was so simply that it e.g. worked on Solaris
>    /bin/sh.

s/simply/simple/

>  - Removes the "mkdir .git/hooks" invocation, as explained in a
>    preceding commit we'll rely on the default templates to create that
>    directory for us.
>
> For the test in "t5402-post-merge-hook.sh" it's easier and more
> correct to unroll the for-loop into a test_expect_success, so let's do
> that.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
