Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55644C6FD1C
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 10:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjCIK1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 05:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjCIK0t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 05:26:49 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D9E62FC5
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 02:26:47 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cw28so4972554edb.5
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 02:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678357606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABRjiIR6pmQzdr/kllO/LWdM6PdjYUacaDcfr8a1f3A=;
        b=essai2fgEEy3pCCTwTLe/jmNcW2a++7S0z6B2LuMCKRcBB1Rh5t5RJSCgf+IibMy9+
         Harbe1cnkbEEFMu2jlyowr01QIjAw9zmTYthtKY1bjTgRGerKcA3ibOPStbU9pAMNiBn
         X3PnGWv/sQGpmJKIRQhVZZuCJAc+Lr/ow/GFZpk4lEWfZ3zwZH/pSeNI0bCVE3W7A+OA
         YO7wpTKfigCarpkwj3lnaIm4CRgfa6JkE+vhQToX+aA/fdPi3RHTYyNpEuXmhAHm8mPQ
         yzB8G0mmpKPQttibUj4tZi1qlg+D78IZDX2n8yBX23uCvs7JEjds2NVMiwByEGwuSiy6
         0AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678357606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABRjiIR6pmQzdr/kllO/LWdM6PdjYUacaDcfr8a1f3A=;
        b=Ju3XNx9trscIxEYD0+MBMETsMVF4QEYQjTy78n8Xt7tJWu+xInPjFgxc6pqAiFdSJG
         EzurhbVDyrJXmRXgmXoN+EqwtZ9GRPUDLUaLlUbJtx7MzOtKGkKv1HpYFZwPCAKfR/Yt
         JNhbe4Qnae3vIz6n+Zp+pXPmoRrlrAJUJGgIeXDHLmhu6Di2nGNIGHgWIJJGo/PtiU/Q
         FWscps+c2O9imVCeoBBMS7ZfkhAkAcfAi6V1FNVo9QY3bVv26J1WyhvmamVC8RiHmzna
         mOd9Ikv/vwwIuOymE1gIwGGmZjsPm+Q30kcasDPar+FiRLrAD2m2LS3nQdc2aDBkyxFH
         kDtA==
X-Gm-Message-State: AO0yUKUrh3KYtHT1zKtOwD2ZFRHtKrvuE32WjwkQ/sgSpORk5UEQX3Hd
        +A+XfbKKDzU0k8ZPwdecoaYYlZhX8e5XsAI9aYuOB1W1
X-Google-Smtp-Source: AK7set9NH2QbLSpItfl0RPMpz2NVu4DCycjoA0MRM5hgWGDC2mt+ZaoJKwGcs/Sq3Y9k378jfPEG/BdewNVZkY5UsUA=
X-Received: by 2002:a17:906:308e:b0:879:5db8:8bb2 with SMTP id
 14-20020a170906308e00b008795db88bb2mr10033931ejv.7.1678357605889; Thu, 09 Mar
 2023 02:26:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677850517.git.congdanhqx@gmail.com> <ZAmsikbYncUbNjD2@coredump.intra.peff.net>
In-Reply-To: <ZAmsikbYncUbNjD2@coredump.intra.peff.net>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 9 Mar 2023 02:26:34 -0800
Message-ID: <CAPx1GveS2=8-rh6PVFsOXLvJ4iZGzeo9uUdG=wcbophxiDam0g@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add a CI for unsigned char system
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 9, 2023 at 1:54=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> I like the overall goal, but I'm not wild about having another CI
> provider.

So, why not do an x86 build with `-funsigned-char`? Seems to work with
both gcc and clang.

Chris
