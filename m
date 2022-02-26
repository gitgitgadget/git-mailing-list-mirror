Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A19C433F5
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 04:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiBZEXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 23:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiBZEXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 23:23:16 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BFB2668FC
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 20:22:42 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id bd1so6357727plb.13
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 20:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppf7mQfabr52pOKLCugdxXS2X082f9wdC31AYFxaC/Y=;
        b=TJmqB3Q8N5oVFuMhBsGd9Yilu+A2FXwcXXNpYal/1Shl39bfWqsRVfQe+xSm4+bhNu
         LzEHe/CdalIasoie3gEUQjSixdeyqkZzEFZcX9EkzhiQ+8GYv6wnY56N26LyNwa2FRom
         KVQel2eklaDIyvBJWWfqspvQgLq2WdnKWnJq0lGdQ+i82tmGpuFWvnhojLIGitF1dIpM
         f6u/NGttfdcVuzboSRLSKjx1m3MrWSZY5beBit+C0XnDQj9TXnhQJRUFTlIj5JynWArE
         3nW9UIo8nSCCZl2+7pcE/UqUca+KLw3IW8DjJxcN+1qghmuQvYxhfbgPqAq7Bz2GIHXT
         tgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppf7mQfabr52pOKLCugdxXS2X082f9wdC31AYFxaC/Y=;
        b=1Lt6iFoJaHF+4CbTq1RQ+Z2xAQo52JkLlCAkEPcBT1l73Fm4JJM2aDolKK6y6ylLDO
         8wdMsKOvavXPsTm4hiJxxluEeED8SJAL3Ta1VXPGeu00dv8Y7MMFWJx/Y4iBloPGtdPW
         11jox07MeSNwHSlJa0aCO8IdJ0wUF4rxKZjGR0uRDk94P/oqB0kvPlIcFpS4KWiev7yb
         YlGOMWFfaHJDkhy7+dDPs9owHqh6ExyFXgWQWgd7QO4dvzayOpPhV7YTRjmhlUj0Uvkk
         KLu7LcAX1fkAMl9z9iEZSl83UHbBjZwgGL+uZ7OCERXifB9Fd8FHphU0yiGtM6AKvPx4
         XzeQ==
X-Gm-Message-State: AOAM530+uDERTWvHiPejao/Gs4V3aZphU0DxsTz4vfRiPOd+TcE8EdY+
        swZdDyr7oZd9S39hTLrCUxY=
X-Google-Smtp-Source: ABdhPJwaYrw/CQ5ClmgumQLW/cOmbs3z893HehUGIql8ughkI3Qize7ni/lVSriS6r3334Hnnk/aOw==
X-Received: by 2002:a17:90a:c252:b0:1bc:52a8:cac8 with SMTP id d18-20020a17090ac25200b001bc52a8cac8mr6286501pjx.61.1645849361638;
        Fri, 25 Feb 2022 20:22:41 -0800 (PST)
Received: from localhost.localdomain ([202.142.80.180])
        by smtp.gmail.com with ESMTPSA id u15-20020a63470f000000b00372d063da1fsm3902924pga.29.2022.02.25.20.22.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Feb 2022 20:22:41 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Julia Lawall <julia.lawall@inria.fr>, git <git@vger.kernel.org>
Subject: Re: [PATCH] add usage-strings ci check and amend remaining usage strings
Date:   Sat, 26 Feb 2022 09:52:14 +0530
Message-Id: <20220226042214.1413-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <220225.86zgme7vxo.gmgdl@evledraar.gmail.com>
References: <220225.86zgme7vxo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:

> A. I think you're right about the t0012-help.sh output being bad,
>    but that's rather easily fixed with something like the [1] below.

Do you think the fix you suggested should be a part of this Patch series
or a dedicated patch request is needed for this?

> C. The case of 42 tests failing because of this could be addressed by just having
>    t0012-help.sh do these checks if we wanted, although in that case we'd need to
>    make sure we deal with other test blind spots. I.e. the
>    "GIT_TEST_PARSE_OPTIONS_DUMP_FIELD_HELP" suggestion I had.

Pardon me, I am having problem to understand the 
`"GIT_TEST_PARSE_OPTIONS_DUMP_FIELD_HELP" suggestion I had.` part
here. Could you please explain a little bit?

Thanks :)
