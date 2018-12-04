Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A554211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 17:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeLDRET (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 12:04:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37334 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLDRET (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 12:04:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so10070773wmd.2
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 09:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qraUTF+pGQgus4S0U2o+L4YU1/ZJIxcj0IaT2s12kbc=;
        b=uqm7qlQuuqMyWqbhWmu4U2GpBk6mOrSgalmYmoVOlqggFKJ+ytjfEywVgAozOPNdCx
         RDuepGkyXrL6vZIKiga7PV7r48M6zv8a7IxfaDdypeA/EOWemupl0W+z1OX3IpH3Ts6C
         zbsXouz0Sco2LGjIOwLWKD0/IFETMMy4hUL17vEDp9w92n0+qS8vCEAn6LGKENZJgiif
         Zv/jX7IO/ZXS34BkqO9HkeKQ31CcGr2n0KeLuuq94FiArCEpSDfctkh+z83Uow54NBll
         8sI2dyUiYGElSjwvZuff0aJuUVlZOM3Fw0W78mUNXlItlvD1jlpaRhSA2OGBH3ZZjm3d
         wqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=qraUTF+pGQgus4S0U2o+L4YU1/ZJIxcj0IaT2s12kbc=;
        b=NBxBRfH6QfJRYCknyaXMEkY4KXtsJLV3Q2K7M4h9tHbYRCngheXFPPRwTV2yyveG3X
         vp1ZGrWJozF7DEB8ru1xH6EcDzjnrXEyQ0ejr0q7sk8hJ3M2xgWl6fVKup74fh1iypEP
         /6DT3+rHoNPEFbma/QfJpXoax6sB2aW/fd+oo4KMo/rxxn0AG0OCzcfqV2+puBSnPGbG
         LR22b5vKJbH7+NNtmKnX6rT031+DBsACq5Slk/O7rezji40cd2qJgGtosjouq0jgUkjv
         sl0PGiBBjq3MJNCThio5lnkT3roTV2RbBw/I3gH9pEFT+FhSLhQFwm7ypFnPxYulJWvx
         Cftw==
X-Gm-Message-State: AA+aEWbjI+dq5GG9K+yFuVYgNASC9oUug4wIEyKyx3Aa1sYyV79e3x5I
        O2/jLMjy0qSknVMEqHTcBnw=
X-Google-Smtp-Source: AFSGD/WgyNNiO3tsA/LnPLaYiiUrOUadRBOFw4eYkQwNsctoDwb4yjxJSYDIRxrQpicbTM3ZdtTF8g==
X-Received: by 2002:a1c:6783:: with SMTP id b125-v6mr12943255wmc.147.1543943056586;
        Tue, 04 Dec 2018 09:04:16 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id d4sm7151929wmb.25.2018.12.04.09.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 09:04:15 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a test repeatedly under load
References: <20181204163457.15717-1-szeder.dev@gmail.com> <20181204163457.15717-4-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181204163457.15717-4-szeder.dev@gmail.com>
Date:   Tue, 04 Dec 2018 18:04:14 +0100
Message-ID: <87o9a1z0j5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 04 2018, SZEDER Gábor wrote:

> The number of parallel invocations is determined by, in order of
> precedence: the number specified as '--stress=<N>', or the value of
> the GIT_TEST_STRESS_LOAD environment variable, or twice the number of
> available processors in '/proc/cpuinfo', or 8.

With this series we have at least 3 ways to get this number. First
online_cpus() in the C code, then Peff's recent `getconf
_NPROCESSORS_ONLN` in doc-diff, and now this /proc/cpuinfo parsing.

Perhaps it makes sense to split online_cpus() into a helper to use from
the shellscripts instead?
