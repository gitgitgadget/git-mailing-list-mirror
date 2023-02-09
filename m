Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1C8C636D3
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 19:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBITu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 14:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjBITuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 14:50:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FBF23671
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 11:50:24 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m2-20020a17090a414200b00231173c006fso6636320pjg.5
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 11:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lsbxzGKDdoO2JnHYLrLQdxqtgly2FVA0TvvFFumbMZE=;
        b=F7xPypoFij+lm3F5cLCO8kbC73GYN/fE19PM2A/uQ2hqvL4UlMK1TOhSogpRJA/qE9
         hGzaCHo7+za7LuoDiPT4g5XN21a5jvJb/KjnIhtPK1Rw80bejZrrzubKt8l9EFkqzL+f
         bMNvpNePgpC2aIimVAy4nkJLTJqH36ccYgs8/QpyrWqPPRR7SGhoI3S9y8OP119I78hh
         6X8ZQqpWPAGhrzH9PWv+leKaC4Ick2N+pWIaELkbG+DPxOlQbUK6UMmnlebhRe+doHF5
         H5ZguCoOu95fZNTITwXSYc3y42Zai90OTH8SQc1hWgMEOjW20d6m4LaOS79TnGGhEkjk
         xOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lsbxzGKDdoO2JnHYLrLQdxqtgly2FVA0TvvFFumbMZE=;
        b=52WUp3pvssJOSQY+z1cKJ3tOXt1WrsTfFlzbXRUuEnrI9ceDTfCngBq/c2vRjq3iA2
         8IfoDHRDeUAWgJIMEOqa2puDoqdQ/ApNn7i+/Xzb58rnrzcJSZuMzd3K+ua/BlWVhKeX
         Bake6vlfJ0cCW5Gcw5KzXTSXizhQC0fpwFguywI/6TasiDo4bg1X7T89PfMu65Y+1LCC
         oUjwDrg6Wvo0138YvMyJo1u29C/BNX8NKgxQ458HTdYzA5OcRL4vzzbeKHUevQf1Kzsg
         STH4IW1plhUfmW1SDKlwapWtzQ4Cz9LKjxh8SVFejKgGupmQhMJ3jO68Ix14CARKKCS7
         cZpg==
X-Gm-Message-State: AO0yUKUn5MVTHVQp53xX+++xnA//IW89vgjPmfhUeqQr6RFHBJoWOoCw
        oHc2tdfdheq0ClSF4BQqTJB9Zhf+RsA=
X-Google-Smtp-Source: AK7set+n3hRVgpgmd7JSTQ1OIQtJFcCiAhuTqe2YbIcKCUWs/j81PzveJTLdYHLSGATnjmYbwIwrPg==
X-Received: by 2002:a17:90b:17cf:b0:230:b6e1:42b with SMTP id me15-20020a17090b17cf00b00230b6e1042bmr14122880pjb.49.1675972224352;
        Thu, 09 Feb 2023 11:50:24 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id cc11-20020a17090af10b00b0022be36be19asm1703217pjb.53.2023.02.09.11.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 11:50:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v8 0/6] submodule: parallelize diff
References: <20230207181706.363453-1-calvinwan@google.com>
        <20230209000212.1892457-1-calvinwan@google.com>
Date:   Thu, 09 Feb 2023 11:50:23 -0800
In-Reply-To: <20230209000212.1892457-1-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 9 Feb 2023 00:02:06 +0000")
Message-ID: <xmqqwn4qmxds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Original cover letter for context:
> https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/

Thanks.  I'll try to take a look at this today.

By the way, how are you driving send-email when sending a
multi-patch series with a cover letter?  It seems that all
messages in this series including its cover are marked as if they
are replies to the cover letter of the previous round, which is a
bit harder to follow than making only [v8 0/6] as a reply to [v7 0/X]
and all [v8 n/6] (n > 0) to be replies to [v8 0/6].
