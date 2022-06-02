Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B54EC433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 14:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbiFBOra (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 10:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiFBOr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 10:47:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C168859301
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 07:47:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v25so6574828eda.6
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=M9LZho10tWbIXmpylhfnduUEIPRZ3OtHHNUXzQMn1nM=;
        b=NsZK+CnKPciMW89OKaV7Qynkb3/v2KnlFaLcuLRWLzaw4cYZYD/m6uN6mKw/aCPD3u
         H+OakWx5SHZZd+12h8pK1OTliIlhrjXyaBupmCSJzkrKkniYCmF89K7s6I03Y99N/8uo
         fVhuJBKJLWAb2ToJcF/dAY/DoSx2G8kzXGmlxPeM6hMy0w5g8L7Lhz7FU+8/LicpKLNP
         EsXsgIpdCsutubvz47iUkHVmLcAlsD4JQuq0jxw60TNYU7L/w7glvBtgwJumbKkT3weT
         OvIoZhWSwlrElUAxaqIy7PZoCtjVSn90CQ8OiLhqcAUSKfNDcJbE8hVhMHuOuLk6f9Ze
         L+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=M9LZho10tWbIXmpylhfnduUEIPRZ3OtHHNUXzQMn1nM=;
        b=2V2DBWGZd3Q8CUbhrxxmCT2SN3o4ohB/CLEEBFbYiDhtxLDuFMJigQI/LIMonK4Zef
         QRn9nTM5yt1JAZezQMBiaAXN7VXuXoP4Zk3vvQ1WihwIovCGUBYExhLanzvP87toGtdd
         yW7iH4adm9bT6P/JggbT3g53yesXZJ7zlb3ZhOp8kYUXyjyunmmGvTpYCmULXKNRmyq6
         AjuFxP1WWNO/QonyLF1sLlNzxxKUYhL9gAla+b5r4cuNIvnr+UJA1B91x5e/q9dbFyNW
         tcwWTRSdz9ZiBWrhUeXCDSjSwjg3kI1SdGr3CP6DDO5FDBzdTM0E++rt7RKXhFaXBHa8
         g92g==
X-Gm-Message-State: AOAM531E6GHobGS/BmWWgZA/IXlDyXnA99ahlw2OtxfxZEzqVwDQjcGd
        IdIdf/JsYA/mR/8u7totDWQ=
X-Google-Smtp-Source: ABdhPJxR9e75ECKrRhNXcn32c3UJQXBQtcHiZTiQi7LnBu5rRVAD5tu99eULPFNkFzNQmRgrgXwAAQ==
X-Received: by 2002:a05:6402:26c7:b0:42b:456d:946b with SMTP id x7-20020a05640226c700b0042b456d946bmr5849518edd.400.1654181247216;
        Thu, 02 Jun 2022 07:47:27 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ay25-20020a056402203900b0042cf43e1937sm2617677edb.75.2022.06.02.07.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:47:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nwm6g-001X0c-AW;
        Thu, 02 Jun 2022 16:47:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/bug-if-bug (was: What's cooking in git.git (Jun 2022, #01; Wed, 1))
Date:   Thu, 02 Jun 2022 16:46:52 +0200
References: <xmqqee07q3xc.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqee07q3xc.fsf@gitster.g>
Message-ID: <220602.861qw7yvep.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 01 2022, Junio C Hamano wrote:

> * ab/bug-if-bug (2022-06-01) 6 commits
>  - cache-tree.c: use bug() and BUG_if_bug()
>  - receive-pack: use bug() and BUG_if_bug()
>  - parse-options.c: use optbug() instead of BUG() "opts" check
>  - parse-options.c: use new bug() API for optbug()
>  - usage.c: add a non-fatal bug() function to go with BUG()
>  - common-main.c: move non-trace2 exit() behavior out of trace2.c
>
>  A new bug() and BUG_if_bug() API is introduced to make it easier to
>  uniformly log "detect multiple bugs and abort in the end" pattern.
>
>  Will merge to 'next'?
>  source: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>

I think it should be ready with a hopefully final re-roll at
https://lore.kernel.org/git/cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com/
addressing the outstanding v2 comments. Thanks!
