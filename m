Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499B9C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 18:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJRSso (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 14:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJRSsl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 14:48:41 -0400
Received: from sender4-of-o53.zoho.com (sender4-of-o53.zoho.com [136.143.188.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50BEA221C
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 11:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666118915; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=D7Cz0yV6oAgHI8Knjj7iEenjX5Po7uNt72X2+ErL8GkOOLMqsgjxAAecD1IvHT5ThYaEz6y6exLPezTfufIhXEnxcslg5xAnBsOiWkKnMZ/b/3By8V2+YOrSYsMMkaOdwoz9Y4DNMVy+aJuYXpqN295my4M41ArRs8nu4/NtzKM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666118915; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ow97B19UhUctU8DV8oGe1KSTD36LyBa8CC9cJ4e/O+Y=; 
        b=e2MdqFSJdCpzRPJb0zfJsszV7EzncMZVvMDlAodG8otHtlq6wanxAfMBC+Y/tY5zSUumXYclqYfSDNCsYoMobAHz0wNacvtZDbrhGGjJhSDwFkEebDkkp4fH89bsSkCdAx0u7IWiAh7WB23acmWN3IBT80bjJE7lmbvh1SbSmE4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=alphaservcomputing.solutions;
        spf=pass  smtp.mailfrom=alpha@alphaservcomputing.solutions;
        dmarc=pass header.from=<alpha@alphaservcomputing.solutions>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666118915;
        s=zoho; d=alphaservcomputing.solutions;
        i=alpha@alphaservcomputing.solutions;
        h=MIME-Version:References:In-Reply-To:From:From:Date:Date:Message-ID:Subject:Subject:To:To:Cc:Cc:Content-Type:Message-Id:Reply-To;
        bh=ow97B19UhUctU8DV8oGe1KSTD36LyBa8CC9cJ4e/O+Y=;
        b=SxadtEh5RSyNka5gW0MxAB+rsM7CPj6njxh3QkNlWFTjAbhh1IQZyy4A3k/fqZSf
        Y3NrPUwSzd/BCvuH6Aq7mDdRfyA7jlTlC9F1aPsTaPJ6UflkEXQpia/PQgFatDY2KUM
        AHp7hs5+FjWDtb3rDqrDyJ6wPdMkK7+rYL7r1NYM=
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50]) by mx.zohomail.com
        with SMTPS id 166611891441067.85505702719979; Tue, 18 Oct 2022 11:48:34 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 70so14846875pjo.4
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 11:48:34 -0700 (PDT)
X-Gm-Message-State: ACrzQf11KL3ctBpiVmlCgcM6t3cH3szxnk50/sma474yiDUkiaEg0F8Z
        he7yliE1qb5UntFi+QZlDUyfhWHZdNPuml53kpY=
X-Google-Smtp-Source: AMsMyM7rfNP6vXaD2tapNHxGMJnai6fMpLMr3zF8EeAdlEBtQ23m3XI6EYQzG15QGM5z9249+CGxE/9SwBMQqyAI1ik=
X-Received: by 2002:a17:902:b718:b0:17a:d64:de09 with SMTP id
 d24-20020a170902b71800b0017a0d64de09mr4719869pls.106.1666118913992; Tue, 18
 Oct 2022 11:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
 <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com> <xmqqo7u9t1zf.fsf@gitster.g>
In-Reply-To: <xmqqo7u9t1zf.fsf@gitster.g>
From:   Heather Lapointe <alpha@alphaservcomputing.solutions>
Date:   Tue, 18 Oct 2022 14:48:22 -0400
X-Gmail-Original-Message-ID: <CAFwvh9BwV=NEtF_gsh9Tr8gHz02=78m4MCBQbuXk5SzKCAm4RA@mail.gmail.com>
Message-ID: <CAFwvh9BwV=NEtF_gsh9Tr8gHz02=78m4MCBQbuXk5SzKCAm4RA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] archive: Add --recurse-submodules to git-archive command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
X-ZohoMailClient: External
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for taking a look.

On Tue, Oct 18, 2022 at 2:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Today I was scheduled to be offline, so I won't dig further on the
> issues this topic has now, but the new tests this series introduces,
> namely t1023 and t5005, both relies on being able to clone a nested
> submodule via file:// transport, which no longer is allowed.

I was following the patterns of t/lib-submodule-update.sh. Are there
better examples
that I can follow?

> The patches need to be updated to adjust to the new world order, of
> course, but we probably should take it as an example of what the
> most recent update may be breaking for real world users.
>
> Thanks.
