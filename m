Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0097BC636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 18:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjBWSOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 13:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBWSOA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 13:14:00 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4665B59F2
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 10:13:59 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id r27so12713670lfe.10
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 10:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jX1fz31NGWUhY0afuom0yiXNQp2SrKhIVSohdWKn+RE=;
        b=dq/zW+oMvTcxB0lQEXSBA3u9N6Ju2sR/dCsr98KJgrBM9NNXE/JWPr63wsRGhzvBbK
         H5/ao4jNKm7qZ/fw/Ed4iOnuYHLbbT7Fe9hBZkRCFymJ0PU4QS432YsIMsI7Ugq1fY4h
         vOIH+zZYLQuKOWpp4D3DgajGARExpSSA8E2cCbgEmuOg9KIjzaqNB5FLZ8Wgyc/y97C1
         bPkD5enqW6kYKEL0iTRfPfEVVS42ecLYhB+SGIUcDPmw5etm/RVCUGNbGMlJUej6nCY6
         HRlLAPvKWzyuJQmQ1gjJy5vnxRDsKofWSGMtOn/5ltZG4aut8Lm0vUdXvKBq2cIITm8v
         d8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jX1fz31NGWUhY0afuom0yiXNQp2SrKhIVSohdWKn+RE=;
        b=m2R1+qrewoRS7MS02SFGTLaScrZKn03GlXG3gvyqu20AMfkYwvtcP8P+ZU7Y6oHBKW
         5abDnY6PHxglIoIxP1Tlf734FR4OKntZx+vK987uSel6nBba/g/axO63AD/33q7X66hA
         uILKS00YRIIkibTNFbqo4zG6pxj1BTkbRjB+obpLCf0ps7ekfQmKdbvH02fAkONNT7Co
         zeUf87zemmtEnva19Qf8G/pqK9zz+BUuYOmFfPspbotqbSAco9QAtKti6dG54HD4nHpz
         9xbEZ/SYAE/egNGzK2xAjB7hfqld6Htqov/XsZzcVw+AlqsbHTn93FBq2ZdvsjCrrviO
         n7qg==
X-Gm-Message-State: AO0yUKV7VUTNQhpitieqUgJ7a4JA1DAqSMIHmFq8d8YluFYppyL8RE63
        PcyucKlcUlBKjbCW6yGFxSgPNs/YpVijKPo5pNtBf306y3w=
X-Google-Smtp-Source: AK7set+eCl2fftaENTwVLKrvsA9FaAPQafvxpWX593C+ZHCmrjL7sVVCr2uV3X8VnekmUMmPXSo1GDw+QoCdFOC1leY=
X-Received: by 2002:a19:5207:0:b0:4db:1326:79b2 with SMTP id
 m7-20020a195207000000b004db132679b2mr4030202lfb.2.1677176037302; Thu, 23 Feb
 2023 10:13:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
 <adafa655432dd13d1c727522377ac9a4b515b76a.1677139521.git.gitgitgadget@gmail.com>
 <14c2e90d-e68b-d0ad-f8d4-1842663b33c9@github.com>
In-Reply-To: <14c2e90d-e68b-d0ad-f8d4-1842663b33c9@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Feb 2023 10:13:45 -0800
Message-ID: <CABPp-BG+Um619phvWP8iMs_zBXS5NwH__AHeJeVDB2ctG7jRCw@mail.gmail.com>
Subject: Re: [PATCH 02/16] treewide: remove unnecessary git-compat-util.h
 includes in headers
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2023 at 5:52 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 2/23/2023 3:05 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Since git-compat-util.h needs to be included first in C files, having it
> > appear in header files is unnecessary.  More importantly, having it
> > included in header files seems to lead to folks leaving it out of C
> > files, which makes it harder to verify that the rule is being followed.
> > Remove it from header files, other than the ones that have been approved
> > as alternate first includes.
> ...
> >  compat/fsmonitor/fsm-ipc-win32.c       | 1 +
> >  compat/fsmonitor/fsm-settings-darwin.c | 1 +
>
> It looks like you have a couple .c files here that belong in the
> previous patch.

Oops, indeed.  Bad squash.  (I tended to ignore files under compat/
thinking they were special, but then later found out they also needed
to be fixed so that things would work right.)

Thanks for catching; will fix.
