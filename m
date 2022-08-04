Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0A6C19F2C
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 07:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbiHDHsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 03:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiHDHsS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 03:48:18 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFEA33A03
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 00:48:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b16so16765228edd.4
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 00:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=SOgA6jhahYqn8fXRwZdUoZSCs+MkM2amtaj+RLFHMH0=;
        b=UK8AfxEy/Ftf6vRp1KRQxfiB9/WCobqTvu48XCh3ETo7ZRonEQ0xTYEzEk4zaPvnXu
         bqWBd5Oc+D+70OG5LNeuLSC05TOfOn8y8wWQEsg3MQDiqhETDNEtTD3Dk892w+AmSTdr
         Gia/AzTg5HkdRUpKlSMJdQ31hEvkeMZ42Gbw9o/R+Jawr7sFlnbALXO560/MAqzqsyIG
         CmrrTRjvPpolQ+3CRb7qtyzykvOY+Ks9K874WmPg1PB7UFKzaX33aP6ZNynPTEpYOLYV
         HbZ9GEOOcnB7Qk/g6uvHhXueu+nLEpSGwrF6BO6IsByQ1UHiUhvzcRfM/CE3GFKIx7Gw
         1crQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=SOgA6jhahYqn8fXRwZdUoZSCs+MkM2amtaj+RLFHMH0=;
        b=B7/kOl2X86By2Il/KWhmR4nmPUjpsQpf35GxGsyXd/mdga2cFykW9oGDknN1BFZmpT
         /PmqIjOz1fLZ51p/H/nxPhAp2HBpjC97oBfiLcq2iMfoneDKoKrRwRGSV2WUmncqDtLP
         fmyxmbiLY2S84jJPLi6/OW+wKREFL9skliYnnWwBgC16lLe7mhopliqUGY0iA9kz6OM1
         XTyMbnguLVvv8H3Ondj6pj6JpH0EeYuWvfFAtwFJk9WhSiUnRquFKfSNADG602nvZmZp
         GmRJUJNHWRj7ir92uH6FlGs3/5arZV7Xbr/sJWZhMkr5JeCgxD10Ehw3VgBu4TXd/OFy
         TxqQ==
X-Gm-Message-State: ACgBeo15nh63Vow+21IpHi2wbKIUZq8eKsttz2B/rhsCzkzlKiJIvlxn
        rWYWGM3YNJuxH24dCTjTqyPL3Kk2mA8=
X-Google-Smtp-Source: AA6agR44hOr7Cqq4gl7+Au6ToHr5aDgdh388oIqeb5bRlXNIIcAaCyfFJC8iiX3xBni6n8GWcZWAYA==
X-Received: by 2002:a05:6402:1e8f:b0:43a:ddfc:5c4e with SMTP id f15-20020a0564021e8f00b0043addfc5c4emr767800edf.358.1659599295604;
        Thu, 04 Aug 2022 00:48:15 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kw10-20020a170907770a00b0072b41776dd1sm73685ejc.24.2022.08.04.00.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 00:48:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJVaX-009fru-1v;
        Thu, 04 Aug 2022 09:48:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 01/20] git.c: update NO_PARSEOPT markings
Date:   Thu, 04 Aug 2022 09:47:33 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220725123857.2773963-2-szeder.dev@gmail.com>
 <220725.86mtcxp8ib.gmgdl@evledraar.gmail.com>
 <20220802173754.GA10040@szeder.dev> <xmqqsfmefjja.fsf@gitster.g>
 <20220803213430.GB10040@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220803213430.GB10040@szeder.dev>
Message-ID: <220804.86edxwe9fm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 03 2022, SZEDER G=C3=A1bor wrote:

> [...]
> hitting 'git cmd --<TAB>' while outside a repository doesn't even
> reaches parse_options() if that command requires a repository.  But
> let's leave that for later and get this series in shape first.

Hrm, I wonder how that interacts with the git-completion.bash caching in
a bad way, i.e. if we were to emit options in a non-repo, then the user
cd's to a repo and tab-completes...
