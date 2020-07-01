Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FB9C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 16:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A8120771
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 16:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD/LnfaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbgGAQ4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732602AbgGAQ4r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 12:56:47 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645BFC08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 09:56:47 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t25so23423154lji.12
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lnPxAE4Mi/gt+Ihy4UEuFmHnDltjU4oda79VafyX4aI=;
        b=kD/LnfaIMoAr5DJDHGgHfOY5kzio7HX2Jatf74JusluaU+lLMieo8CbI9qO/ZM7CvC
         jG5qs33uYRp/4kh7F1vdKLeHdDYNyyTF8kBCicDd81k1GuHWR+AKP0UVFfaSH7CUr6PD
         wyBgcdmv7w3bszZFD+sam1ZhTdi0iWreMGph9v0uLyjRj5FGbPm4jx+oR415eebJqYsG
         vnW6BG6R9HZyvWOVgXG/4AUz0HSjxLaw5fE0rIz5zwtk9uUGA+60brm+VZYvgLAr4EaL
         /wIsAVN3r6cdBPHkrMUtC2fq6VLRpVXy7jQie0mzjzg/mkKkNncrqT7dX+WYdAW4hN6p
         +oGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lnPxAE4Mi/gt+Ihy4UEuFmHnDltjU4oda79VafyX4aI=;
        b=g+AukukvGc4vdrsHS5+XhwXKFnQBqPDwnIn8L1wnDkZaX020U0HWPydun8sAgmU+2V
         7mMuv1+5a/e5WbaPUGSyYA/vMHcMWL5wCrg52s0L3fCFD/AwzzfalJ4JCcl+XKTspD+v
         m4jBpZdXoRvm2BU8MJ9IEvEaZO7xwx6bSzJ478tCdcdRDtJd09TZiiHtASF6aicirO5M
         pXelXrH8S1dKE7CXoQAj3KP/J84mdjDop+dgSsj3C5BQbPc65Btx9EfS1GZG0lPDTqkv
         yJlEniIz4/gMIRI9l5k/Sn/wYCE3t7S5HklgnZ2HIv2GpN5/SoAXBM0SBdxNGdeOQFCU
         oXmQ==
X-Gm-Message-State: AOAM532Q/FUQkaT8Lr0sPUuP82JFikhJSVy9NyFAfVpXwylT3B93INSN
        nwpTak2qoizyAmNcG2Ez4bBED3pZ3yKjNlNc2Hd8+K2j
X-Google-Smtp-Source: ABdhPJzBkq05U140HRmeZ0DT6Id/WgpJAibD0ORNtcREOr6JhgflxEBF2YQLipO1fXFG1uNLurU1xUtxlmJNtS4AquA=
X-Received: by 2002:a05:651c:c1:: with SMTP id 1mr13178257ljr.292.1593622605860;
 Wed, 01 Jul 2020 09:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
 <pull.539.v19.git.1593457018.gitgitgadget@gmail.com> <125695ce92218ca2ddb9868880db542acb0d2a79.1593457018.git.gitgitgadget@gmail.com>
 <xmqqmu4lfxet.fsf@gitster.c.googlers.com> <CAFQ2z_MuD0e+a_r0_-GMpjr1mV==hdh2=0gyVrT7f8tDbXC6xQ@mail.gmail.com>
 <xmqqftacds2a.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqftacds2a.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwenn@gmail.com>
Date:   Wed, 1 Jul 2020 18:56:34 +0200
Message-ID: <CAOw_e7bcfUyumKkQRubf=zg6zso4pOtiC8-6d8qQiVL7vyfCog@mail.gmail.com>
Subject: Re: [PATCH v19 03/20] checkout: add '\n' to reflog message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 1, 2020 at 1:58 AM Junio C Hamano <gitster@pobox.com> wrote:
> > I initially thought we could or should fix this across git-core, but I
> > think it will be a lot of work to find all occurrences.
>
> I think we are on the same page, even if the definition of which is
> correct might be different between us.  As long as all the refs

Right. The practical upshot of this is that I should drop this patch, though.

-- 
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
