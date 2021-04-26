Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26E5C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 08:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D23610C8
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 08:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhDZIYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 04:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhDZIYP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 04:24:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42B8C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 01:23:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u17so83207674ejk.2
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 01:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:message-id:references:user-agent:in-reply-to
         :date:mime-version;
        bh=ljAmDCTdUeyA2llp1RmBe2/BeV0yyVbhcubPrlhyN4A=;
        b=Hl2jElvNEbY1FU8SeK0JuoImYNo3tRqmntWIfpucbm0U1c+Mad3750axswWZdtf2GR
         F1q5ntGEBDtfdEkYANWiqGj1u65hxCaCTBuihkTU+yvCGOikiOW/TULw8FAzvNqo8dKv
         366RnZZ3i026TbknfME8bqb0fe4iU0gn5f1b2WiFwl9c5M9MDXnBIjFXy1QdDt+lVlfP
         SEmq4i0gYXUS1/DQcuyICjt1bRiJLXtUKRpjowk/2HDqFBHTN1eM1B1+2S0uvGlR+2Hk
         as0Hbu6lmNSXoBr0tmmI/Fbfztg4MII9m0eCG+rXhuayDGiO3Lsid8oQq1XjaL8Xt3lU
         z/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:references
         :user-agent:in-reply-to:date:mime-version;
        bh=ljAmDCTdUeyA2llp1RmBe2/BeV0yyVbhcubPrlhyN4A=;
        b=dcFTt/uG/VWJiIuF7FMo0G66jrFqPLAg/inUBYksemSwrY3J/n8rRn1gPB6Y5j+Lrq
         1nDCE+xs/mAumcOsTfwPxPIDTygZYEbgMkEeky+NDMruFf0jbUvvW9DOZzn+O2+JvTd1
         9HBymfud+05pdEgEMD29n0Lj0Tp4Fsg9RbE9ETOaURdH/bKLtLq1/hEX8P9+GP9TGVI3
         19LBEBA//5MI45l3X9bknvPiEP6BpkO5ksBG6zGdSQvXX9816onOr4ci6J9Vf6V7Lljh
         Vo7/XxM2oGJg8l0ZuTl+sjyXzW+GJBSTlmgWZQVcdcIkXpODZ+RZYj13tOuhTpDVwZYm
         8oOA==
X-Gm-Message-State: AOAM533Y90Pigu3k7XHzJAPLk/AdyLxnvRjKYNnNkCWCAFLoXJI9RnZy
        SRDHpm4EOkmmhbn1XiKo0yQ=
X-Google-Smtp-Source: ABdhPJw1HaMwc7vS+gTlFFRzb2zwIQpH3aqG43HdhbDMuZtQN6FZzH5Mjk5WLraKFmH+VX6nObkP9Q==
X-Received: by 2002:a17:906:d8a9:: with SMTP id qc9mr17236232ejb.37.1619425413464;
        Mon, 26 Apr 2021 01:23:33 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x7sm758015eds.11.2021.04.26.01.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 01:23:33 -0700 (PDT)
From:   =?us-ascii?Q?=3D=3Futf-8=3FB=3Fw4Z2YXIgQXJuZmrDtnLDsA=3D=3D=3F=3D?=
         Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Shoaib Meenai <smeenai@fb.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] ** glob pattern in git diff doesn't match root directory
Message-ID: <87h7ju21kg.fsf@evledraar.gmail.com>
References: <79834D18-EAF4-4748-9B96-38AAA0760499@fb.com>
 <608391297345f_10cb920875@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <608391297345f_10cb920875@natae.notmuch>
Date:   Mon, 26 Apr 2021 10:23:32 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 24 2021, Felipe Contreras wrote:

> Shoaib Meenai wrote:
>> Am I misunderstanding how `**` should work, or is this a bug?
>
> I would say this is a bug, but I'm not familiar with pathspecs.

I replied on the "is it a bug" upthread...

> I stumbled upoon a very similar issue (I wanted to find all the *.jpg in
> the repository). I couldn't find another way to do it but:
>
>   git diff ':(glob)**/foo'

Maybe I'm missing something, but if you want to find all *.jpg isn't
that just:

    git diff '*.jpg'

?
