Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5302DEB64D8
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 02:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbjFOC5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 22:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjFOC5k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 22:57:40 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C7726A0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:57:39 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-666818500f4so589731b3a.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686797859; x=1689389859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vp2spRJZqIsOQjLgM16zJDdLDhIWi5Ax2iLcCtdOwFg=;
        b=ORT0WzfA5lzgN1CbGotRPg/3u059v+6oa85Nev44mw7Yo749Va+YAxoB/6tTgKcnv2
         AmpzqKcAe/vJiSnlka3j4dikH654IqolobDzLpGftErhdWVs8FzR6psNQKUy+EExAxdf
         XL+/lCn//YmI9kLkh0UXxO3BaVbxjSVHM/WkjhLWuLV+ihSR9FRgBmktOnhPO4PXxrIX
         A0wlecCNUqk4RDcmi+QTNu8P8fu3SK3BmE9wjgSPbtyIKINTHiNTBlb9WUsm4IGRA1xz
         HZqIS6fJDwnLrn0IvjgyI8t6B3wGE2DLrnWmCEIHUDq7SNv01AMDiGbSaxRapyWzV/VG
         DJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686797859; x=1689389859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vp2spRJZqIsOQjLgM16zJDdLDhIWi5Ax2iLcCtdOwFg=;
        b=CCnpbm3V4rbMematKMb5iLxDdebmqycTqF8Gj9DyxcQVznkpnhZKhjFhOJ8nyxcFKZ
         JhmX5Y+zu5z8HTpvLgPnKstBekXPuW4wwBVZWEn6mJSO86mdWhVTSnL1nwBtQML4Ba8c
         0JxiIEup86gOinxwlnHtOUXGhhCIr/YuUbMHdMKmsYa67iwRaKgfzmxA02eM79TwlXoA
         mjmAfXrr601inA7ckwl6Lv+S6pY07nBg0vx+jObiMvZ68SOR2CqUfvzVx9CekXmXk0v/
         gEsf/7B6j1UFz20ovuLkQZQoApbbseS3XDhl6UaylE2M1Lvmvv/Iews04ESmcrOmZcd2
         ZELw==
X-Gm-Message-State: AC+VfDyKpLCFKxWtw5rBaovaYHrDV6OtltiAY8s/oFwKoCQ1zOc7wcPy
        K/0eq8SMHUCD+jz1slJKdwAh7sTZL50=
X-Google-Smtp-Source: ACHHUZ4SFZUy88E4Ctu9vHWu65kaieQXbzMUef9gkhldzSIa+NBC5dMYN7xNl0pq0B1x1XrXsr/Lt4FQ87o=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:1a05:b0:663:5498:9964 with SMTP id
 g5-20020a056a001a0500b0066354989964mr1116708pfv.0.1686797859017; Wed, 14 Jun
 2023 19:57:39 -0700 (PDT)
Date:   Wed, 14 Jun 2023 19:57:37 -0700
In-Reply-To: <CAP8UFD2iej1EhUtR=+wqcnnoYrwCPFoR2ed71Wswyd8CYPthFA@mail.gmail.com>
Mime-Version: 1.0
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
 <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com> <e0a56c8e61d80ef345885bf266e9844de289695f.1686017304.git.gitgitgadget@gmail.com>
 <CAP8UFD2iej1EhUtR=+wqcnnoYrwCPFoR2ed71Wswyd8CYPthFA@mail.gmail.com>
Message-ID: <owlyleglo2ji.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 3/9] doc: trailer: drop "commit message part" phrasing
From:   Linus Arver <linusa@google.com>
To:     Christian Couder <christian.couder@gmail.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> +This command can also operate on the output of  
>> linkgit:git-format-patch[1],
>> +which is more elaborate than a plain commit message. Namely, such output
>> +includes a commit message (as above), a "---" divider line, and a patch  
>> part.
>> +For these inputs, the divider and patch parts are ignored, unless  
>> `--no-divider`
>> +is specified.

> I think saying "the divider and patch parts are ignored" is a bit
> ambiguous. It could mean that when a patch is read by the command only
> its commit message, possibly modified by the command, is emitted on
> the standard output.

Indeed. Updated in v4.
