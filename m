Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8800C77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 03:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjEPDCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 23:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjEPDC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 23:02:27 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B3A6587
        for <git@vger.kernel.org>; Mon, 15 May 2023 20:02:14 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ac8cc8829fso128566481fa.3
        for <git@vger.kernel.org>; Mon, 15 May 2023 20:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684206133; x=1686798133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUFjSC4eXzlfg+LMlUC+618Oa+vm4qvZV71ncCSM8xo=;
        b=lmS9seClI2ozRdVixzanXSgieZDHiyYxeMO9Hwz74WQjWs62P5bS1q8W09Z7Ed1jRW
         9O745W1oaMDEQUudubHzieLp9vcbCPTZU3J4MzHKC1K97jc21G5w39CVOs5SlB30jXf4
         CjgNVijrPse62qIAGzSHkvcH4Hq0YE2saVGDRY2Ek7nhRCDZXJgNXlLOJKlBhZygwfUR
         LwpOnGUnHNIQ6k4lIqSQT//mXIr9x5I9I84GHagsJeoS/nBbRApf0nyXoKJbQtUlzru/
         dxnCSR6lDCp3TQvCCDgqIbZJ901jdeaz0WeuJhEObi1kMGbAWbJ9gUAvnueqRvYVwI5S
         5M0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684206133; x=1686798133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUFjSC4eXzlfg+LMlUC+618Oa+vm4qvZV71ncCSM8xo=;
        b=XxIDCG3sYWbzQfDtILR9x63aZXEKkEVMm4UKwV3svzDQZ0y8MLrLSp1tHEhVDP5BBj
         +P4HTLvTFv/q7XdVxOBMUukmn6dq/ld6Dk9w1uVh5hEyOipf04P7iw6GL79kdu2PRbX1
         ah4DOWfR1wcsGzSNoBCfzItnROGciY5/Mu69eJ24/urNSk0fFru03Wfpz+ObS91Ywwbr
         +vpDtgKUi29MPGa3XTjHIaW/9HoX78h4Jk+rJsqVASvjtPmuTUuPEl1kbrvOnTwYXoJY
         zYEsbBAQ/bIiNQCfmbRsCHgyi2aH+RbANy+V4hjvIAkYRC1k13PeIJIhoBlObSk1OMXW
         UkgQ==
X-Gm-Message-State: AC+VfDyi3sm2z/LvlbHoN1X5kaMZ0zviSnPKLeb3p1+cL8u8ucgS0r8+
        dPTaGq7C8QCEKn5NfSxL+g7vqc5BjR3gETvzgh0=
X-Google-Smtp-Source: ACHHUZ47rCAit1mabJICEfx+nFrbW5NjeBYS+FBeFcDWZce0Gmo5m3EJykpnUmN9EFCb6sHHB42McI+9HrdiYAwT/Fo=
X-Received: by 2002:a2e:b70b:0:b0:2ac:83bb:ab46 with SMTP id
 j11-20020a2eb70b000000b002ac83bbab46mr7408417ljo.30.1684206132386; Mon, 15
 May 2023 20:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <8f021be54e0795f56ab67e1d269abfcdac587f9c.1683875071.git.gitgitgadget@gmail.com>
 <20230516000241.1459276-1-jonathantanmy@google.com>
In-Reply-To: <20230516000241.1459276-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 May 2023 20:02:00 -0700
Message-ID: <CABPp-BH-cmCm4CGrCpyPXCYhQtJSab5hPD7Y8GOB5jW3ngxqCg@mail.gmail.com>
Subject: Re: [PATCH v2 17/27] cache.h: remove this no-longer-used header
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2023 at 5:02=E2=80=AFPM Jonathan Tan <jonathantanmy@google.=
com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Since this header showed up in some places besides just #include
> > statements, update/clean-up/remove those other places as well.
> >
> > Note that compat/fsmonitor/fsm-path-utils-darwin.c previously got
> > away with violating the rule that all files must start with an include
> > of git-compat-util.h (or a short-list of alternate headers that happen
> > to include it first).  This change exposed the violation and caused it
> > to stop building correctly; fix it by having it include
> > git-compat-util.h first, as per policy.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
>
> Ah, a monumental effort indeed (to finally remove cache.h). This patch
> was one of a few called out in the cover letter [1] as needing reviewer
> focus, but this patch seemed straightforward to me (changing the text
> wherever cache.h is mentioned in relatively obvious ways) so hopefully
> I'm not missing anything.

I mostly called it out simply because this patch was different than
all the other ones, due to the Makefile and Documentation changes.  I
figured that those who wanted to "spot check" deserved an easy way to
find the different kinds of changes involved.

Although, I was a bit curious after the patch what the purpose of the
SHA1DC_CUSTOM_INCLUDE_SHA1_C and SHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C
defines were and why there were two different ones.  I tried to do a
little history spelunking to find out, but it didn't shed any light on
the issue for me.  Setting them both to git-compat-util.h works just
fine, so...*shrug*.
