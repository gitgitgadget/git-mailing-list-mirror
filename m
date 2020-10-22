Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E824EC2D0A3
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 00:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C602417D
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 00:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNQMxhND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507410AbgJVAQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 20:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507399AbgJVAQT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 20:16:19 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EB0C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 17:16:17 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n15so3546441otl.8
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 17:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KyL58V5ze2yaYHTupjLkNTI7CwsvF6tPK7m80L7nx0=;
        b=ZNQMxhNDkJ+4YZxo8H9GZo7A7Ip1AhJ90KoOEZMmEX3y9Zfkew9KfAK9F/jGwO94Fx
         X3Go4DvgyGIGIHbYpCfiXiE3ee0cpmrT0zuYuMC8bh11ZjPnStkdMcOdggD9tH/lxB8M
         3OaLRBBz8OoNrUcyysrduZnwosesBElYCaQzMoPfYmHQOGNvarmkcoqZWFkvW2pi2e+0
         4Ch6oSIWfyRZ+tPt9gQF5pjmRQHNTn2KcvfSn8SM4yrac4NHOElXyFlshpZcAyfM7Dxo
         jf3fiUc4vPi+0CjxeOMX66Ns4trWCyIPQkV3d6EvNR8719SSUSpjs3naLOuagK08lW2/
         pu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KyL58V5ze2yaYHTupjLkNTI7CwsvF6tPK7m80L7nx0=;
        b=rmLkLxxZTcu/+nON5vz/DZ2LRgHbDM3MMlWFpXDFD50nPEufPPxTDf9MA1k/WcrGva
         YjM2FCTmGWXIuzLzNTlsy/DqxUCUHrQm2okZCTHxyg0czWm1851o+WeGHVsoEmo8dZB2
         uePKbzt0KOC4N4arOb0X0RruZFTOCqV3fbG4prLDl8D+RF/0CoBh/pq8za2OU3VFIzIH
         MHz8UGEKoHORwZVzXvbNMOS+Ss0yx0RpoRrPhRVKvWcs1S8kmdScqp4d0q/sgsrueWyb
         fJl86lkYli7ES2uBI0WXiHKrIFOU7jIbnOVSygWhECD7FScsSv/0KhmzKjmYSb87wiBp
         uxGw==
X-Gm-Message-State: AOAM531BALD23ZGY/JYxQdpw7ys8xKqiLX/CvrX/91fXDYCrgqe1lspf
        8zNHipNpk7JtCO9mh1C+FJz5TPmaMUAP0cF0AEk=
X-Google-Smtp-Source: ABdhPJw3wKQ9eiwP3p5nvwU64A6eXq3qnss2KfiivYeffCLJm9X/Mr6I0JZXD7OpHM6hNKMqtP37pFrT4DM0BPLB6H0=
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr81038otr.345.1603325776731;
 Wed, 21 Oct 2020 17:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Oct 2020 17:16:05 -0700
Message-ID: <CABPp-BEGo8qfaoz6vUs+ktvmNUZdiHjwda468Qkh5uaD-wAd4w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Beginning of new merge strategy: New API, empty implementation
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Oct 21, 2020 at 6:22 AM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> In this series, I try to show the new merge API I have developed in
> merge-ort and show how it differs from that provided by merge-recursive. I
> do this in four steps, each corresponding to a patch:

I should probably call out that even if folks don't have time to
review patches, I'm particularly interested in opinions on the
following two questions:
  * Are the "pull.twohead" and "GIT_TEST_MERGE_ALGORITHM" names in
patch 4 good/bad/ugly?  (especially the mapping from "pull" to revert,
cherry-pick, rebase, and merge?)
  * Is it too weird to have a temporary/hidden builtin, in patch 3?
If so, what is a good alternative?

Thanks,
Elijah
