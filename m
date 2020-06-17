Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53860C433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 12:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28EE621532
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 12:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dly2e4bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgFQM1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgFQM1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 08:27:24 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F730C061573
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 05:27:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l10so2110976wrr.10
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 05:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=3NMNv+KZL7iKRdQ18LTD3dFMcQfpckam3X2d1ezQeIQ=;
        b=Dly2e4bsRq/Mj3rUlA240oNJcJdRDoXmduaK7DiwXlM5fYBdu41l9LLeK4EuPYMT6D
         rqWIV8nePgnP4uQnQeL4qqmnXRFSPVRdUck7zfPlJ32mp7kR2K+1D3GzFyxisgx1xsM/
         QI8f9w7z1hgqvebdvEfGnbE4O0VpzKhMpG5CY16UZiedb/yHTnkYm6HcvByeSWluhIEO
         brNn5CAmMPpiIWz9e3KGGAfCrhoAKFJbHrgwkV9p2aoC0pD0MZqwuVqnI4gKQuot438N
         hEy3NbtBVTDUw9EvxxViUpsfwyp0pvZdEi7Ok0gy1dHecXqIphr+Obo0HsZqoKE6e4rN
         /qIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=3NMNv+KZL7iKRdQ18LTD3dFMcQfpckam3X2d1ezQeIQ=;
        b=EM+ni+K8rintnupKMr9N88qm918nckYNPUHb+BAMMO0h1roAUmrQMC4FnZ44K+hKKS
         n9H6lyYZ20TQ64sqv+b2ZEf0Yjy0yHdvLok03Qejoi5L0yxJBOlX4cBy+oIHw66qfpDg
         iLxheRn8lq0xoqlfC71CsTpM2gh7od4ES/iXo3GjUawb1KK1iiJe/3y5ZoQ8bwRNSyGj
         5XV5RD27JsP77ocUjm+as/oHEUiUGzvmW9emveiE+27VdUsx7U+rWgZqR/p8o3KmTWnF
         jryST/3hIMe8oaYVYjPgtKQQDA7NhmfH5O00nTOUByrxYgorNFJcdNb9dMM5Euz2auvw
         tqYg==
X-Gm-Message-State: AOAM532M36FJV1wJjsoBsDASBwZPOFWtFfRmj1JiLoDVCvTTY1nlGM9l
        N1Yfz/z3jNR4QrBp1OTBs8Kg/DSr0bbxuORqlw7megQ+
X-Google-Smtp-Source: ABdhPJwCE0C0OOw+gMqjdVz1h/b0gTxeSjeC/Vx1FJcVBDU0WU4R/3uiEPfNikjXdDJ5S8do7j1qzR/6fGJ8KL43ays=
X-Received: by 2002:a5d:4e45:: with SMTP id r5mr7526979wrt.92.1592396842045;
 Wed, 17 Jun 2020 05:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <B67468F4-98BB-4213-9763-1A09EC256769@alastairs-place.net>
 <CAGqqT2w=ntxd6RNkpy175TbgiudUSOc0tAPoDsbjv=4V+73cXw@mail.gmail.com> <CAGqqT2zFkCUTdUnzdp4oTR2cnxBpKeY-EZtxacLLVDsF8Jiekw@mail.gmail.com>
In-Reply-To: <CAGqqT2zFkCUTdUnzdp4oTR2cnxBpKeY-EZtxacLLVDsF8Jiekw@mail.gmail.com>
From:   Zac McChesney <imzacm@gmail.com>
Date:   Wed, 17 Jun 2020 13:27:11 +0100
Message-ID: <CAGqqT2x7PY4eGWSduV_seHEXSktqCzE_7u9ECjr+7LXOdb9e1w@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just to give my view on this (I've been following for a couple days).

I started using git in 2016 so everything I've ever done with git has
a master branch, every tutorial I've followed uses a master branch,
and everyone I've worked with since 2016 is used to using a master
branch.

I don't want to join in a political debate, and I don't see why
politics has to have any impact on non-political software, there is no
technical reason for this change that will eventually impact every
developer that uses git, which is most developers.

Git is a version control software, if someone is using git to manage a
political project, they're free to use a different branch name, but I
don't see why a backend developer working on non-political projects
should be impacted by an unnecessary breaking change.

An example scenario I can see happening (especially to inexperienced
Devs) if the default branch name is changed:

Dev gets a new laptop and installs git, all their projects work as expected.
They create a new project with "git init".
"Where's master?!" "Did I do something wrong? Every other time I've
done that it created a master branch".
