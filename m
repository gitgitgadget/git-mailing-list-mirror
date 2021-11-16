Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EC5C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 07:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6859361BD3
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 07:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhKPH1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 02:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhKPH1C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 02:27:02 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A44C061570
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 23:24:05 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m20so37664728edc.5
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 23:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=7wwSfTSj9p6moJsDxYozMPGDAb6pCK4NEBJDH9NN/9E=;
        b=BY5V3JYSZIAzYWmtm6anMIyCBGGqszEFUeqCzoQzA+aRSQiv/6xPG68Xwp8UTvkxwE
         vKT9jfRgV+JfKyUhkqfnCg8qXEp/JcF7UTO/kM7mdCi+SwMfG1NypALZk71a1zr+btQH
         l6Qld9G15dLazOihBbCQN+MG5Djh3876qPrFSAMvFP9tmrhd4JfLx8r/OtCG8WoPCvAi
         6B1/mxvOWj54acpcou6+NF+opZ74e2dP8HAIA6ytQBD2bdbiyPGnCvehCfObcxC5+ZNo
         8SKJG9+cTZub7tj87m44MQ2TfgpPFFMmCHSMIoLSaiA3GkQlXn9js1p9Nc58ZJ0Zx7gM
         sCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=7wwSfTSj9p6moJsDxYozMPGDAb6pCK4NEBJDH9NN/9E=;
        b=yw3nyP4uxJdM9LsJS5HBZNEms/mgV5Qk3KBT2UwW5kJD2kGMG8DS3HImza8LhsR8Na
         WHjGKmciTCtZ50PFNiD6Fw3kX7jDAJcPUxXIHrSG5gnvXs7hDb1wNJbnIKfUHoJKnH66
         wIeVnmOdACRhnDYY1fV5vOlVC4d2p72m/MqH1ay6iqsnljos85fAkYTeJ0KfGNVwOoRN
         mzB76iVOnfcagtyRcGSN4AiKq9YIoCebUuHS6ji5WcU+TTz7Uc7XQaZc8U+0A+Y3FdAt
         ghoU8jiguq5hlgywKYT2j9fl63PiTPm0mQTPB7IP+chCpUmNybzvci9yeKh+qfDRMOh8
         Yrvg==
X-Gm-Message-State: AOAM530Gtewm190Gk1OOCk/UTqN73GAHPjNP1gXPU7aZZxKz1FTRBrpS
        4CBVyzroLBYNjodT7k7OF9NO+xISsuW6nw==
X-Google-Smtp-Source: ABdhPJyw4P5wbEugtYasXVWj20NonOpoAZ5eL98M7fjWlqWCWb4EEeeTMnsAO4uxOSYe5emTWP6DNw==
X-Received: by 2002:a17:906:6a18:: with SMTP id qw24mr7253927ejc.118.1637047443542;
        Mon, 15 Nov 2021 23:24:03 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t20sm2567902edv.81.2021.11.15.23.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 23:24:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmsp0-001I7s-Bh;
        Tue, 16 Nov 2021 08:24:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v9 2/9] tmp-objdir: disable ref updates when replacing
 the primary odb
Date:   Tue, 16 Nov 2021 08:23:21 +0100
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
 <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
 <71817cccfb9573929723a34fe9fb0db72498d4b9.1637020263.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <71817cccfb9573929723a34fe9fb0db72498d4b9.1637020263.git.gitgitgadget@gmail.com>
Message-ID: <211116.867dd8r2b1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 15 2021, Neeraj Singh via GitGitGadget wrote:

>  	/*
>  	 * This object store is ephemeral, so there is no need to fsync.
>  	 */
> -	int will_destroy;
> +	unsigned int will_destroy : 1;
>  
>  	/*
>  	 * Path to the alternative object store. If this is a relative path,

Why add this as an int in the preceding commit and turn it "unsigned :
1" here?
