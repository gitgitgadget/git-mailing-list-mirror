Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FE2C1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 16:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbeGaR6s (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 13:58:48 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34450 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeGaR6s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 13:58:48 -0400
Received: by mail-it0-f65.google.com with SMTP id d70-v6so12836262ith.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 09:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XuDGG+0J1Jof8rSTRmyGb0pDKTyGDVQocdxGdq2YwoE=;
        b=k9gRElaBBc9xmdWs7ekC6ihvcgBXn6TtB/dtdWHYljklCon3QsBRvRlwsi1Sf3X5gm
         fN3gQn4qK3c5g3Rk6V6qq+qpwAyc/pZ5sXKAAXykeAWLI1KVTiwr5nobxDtCl8capdMJ
         Xy8zK5D7JnC1ETmk/9Oo8s4HqnsO6lTRrTmZgwGVEvnhiyu8FDfNv7+6XSkNm4yBjJZ0
         9Hwum9lSYnHPO9XfGB4zwEha7BG1Mm9v/DcKGsRBuMENUn6x6ZZKfVJ4765J0PRYbEfj
         lc+Z09yNKK71GH/B6NmxSCBV+kPGl6r5n/d+bg/4Bt9anHFc+FRNaJm7D7rtiFaCksqD
         c4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XuDGG+0J1Jof8rSTRmyGb0pDKTyGDVQocdxGdq2YwoE=;
        b=HRuF56sG6a9thgpEgeYC+OGYbFTCwKfZsOrU6jTAHywOcYI2RDdBg5lXWGRO/I8eHV
         QFia9LblqfH2SH0F4YCvLQ4Bu73Eat6/pIiP+b9MT+f0QFaqBeK6VsGUCJWrBNr6xdd4
         8dvG5ICObQIRU7XxLpbsbUmumA5AGeY2QSpRmSmwapXq6Ewyeq8qHxP5af5cAG7oPC8Q
         vn+yIhK4fDy5tOFx23UKLz+6JjTLku9znVF37sGvsTu5wz9VRX/zme27S4fgsnQrG9AX
         4byv8s/KhkTVrbfxppTLvaMe3dUTXPMoxLMYHia4BqBWZ8SAbGsVx9HPXgq8coZG/2Pd
         MQrQ==
X-Gm-Message-State: AOUpUlHogQJnl2jTS1UqtckILdvyqja7CzCeLO6DeIIyUlzQ8QrRRoVG
        7tAJ6XBvs4uUEYL0ZVM0d3W9e93erVEFD3ePwoE=
X-Google-Smtp-Source: AAOMgpfzzpG7LG0futAo5230Lwzm7dBHvx9kGjf6ow8/tFnz+5sEfGNKK9rrM+llPFYjfsq59E4YxmS7A01N5opzU6M=
X-Received: by 2002:a24:c888:: with SMTP id w130-v6mr367137itf.78.1533053864582;
 Tue, 31 Jul 2018 09:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180730194731.220191-3-sbeller@google.com> <20180731001858.122968-1-jonathantanmy@google.com>
 <CAGZ79kbwt2RGo2Z2ARSzfHOZdL_VWF1sR+=EE=QWx1ibLL+KwQ@mail.gmail.com>
In-Reply-To: <CAGZ79kbwt2RGo2Z2ARSzfHOZdL_VWF1sR+=EE=QWx1ibLL+KwQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 31 Jul 2018 18:17:18 +0200
Message-ID: <CACsJy8DwaLCxY-ryV+=OwRytzwwQZCfVmfXo0z91z9YRMMT0VA@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs: switch for_each_replace_ref back to use a ref_store
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 2:41 AM Stefan Beller <sbeller@google.com> wrote:
> > Taking a step back, was there anything that prompted these patches?
>
> I am flailing around on how to approach the ref store and the repository:
> * I dislike having to pass a repository 'r' twice. (current situation after
>   patch 1. That patch itself is part of Stolees larger series to address
>   commit graphs and replace refs, so we will have that one way or another)
> * So I sent out some RFC patches to have the_repository in the ref store
>   and pass the repo through to all the call backs to make it easy for
>   users inside the callback to do basic things like looking up commits.
> * both Duy (on list) and Brandon (privately) expressed their dislike for
>   having the refs API bloated with the repository, as the repository is
>   not needed per se in the ref store.
> * After some reflection I agreed with their concerns, which let me
>   to re-examine the refs API: all but a few select functions take a
>   ref_store as the first argument (or imply to work on the ref store
>   in the_repository, then neither a repo nor a ref store argument is
>   there)

Since I'm the one who added the refs_* variants (which take ref_store
as the first argument). There's one thing that I should have done but
did not: making each_ref_fn takes the ref store.

If a callback is given a refname and wants to do something about it
(other that just printing it), chances are you need the same ref-store
that triggers the callback and you should not need to pass a separate
ref-store around by yourself because you would have the same "passing
twice" problem that you disliked. This is more obvious with
refs_for_each_reflog() because you will very likely want to parse the
ref from the callback.

Then, even ref store code needs access to object database and I don't
think we want to pass a pair of "struct repository *", "struct
ref_store *" in every API. We know the ref store has to be associated
with one repository and we do save that information (notice that
ref_store_init_fn takes gitdir and the "files" backend does save it).
Once refs code is adapted to struct repository, I think it will take a
'struct repository *' instead of the gitdir  string and store the
pointer to the repository too for internal use.

Then if a ref callback needs access to the same repository, we could
just provide this repo via refs api. Since callbacks should already
have access to the ref store (preferably without having to carrying it
via cb_data), it has access to the repository as well and you don't
need to explicitly pass the repository.

> * I want to bring back the cleanliness of the API, which is to take a
>   ref store when needed instead of the repository, which is rather
>   bloated.
-- 
Duy;
