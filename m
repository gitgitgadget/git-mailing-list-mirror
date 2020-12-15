Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2988EC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 14:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE67422518
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 14:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgLOO2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 09:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbgLOO2A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 09:28:00 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA82BC06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 06:27:19 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id q25so19482449otn.10
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 06:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S2RAFSvttQq4jAzRnUMJUN3mDllVs5hgI0ZKvKbHs94=;
        b=Zy3TPymoIsclCQVrbGW8MlKdldou2Jt/hJmJ61mAVuBVjQklEiOoBR7thr8Q9p3OAQ
         cYIlmI/9Cxc96wxR67I3C1k04tzMvu40xos7C0ptVCNKOg5/hf0eSfitSlQ37+FXFiD7
         7j8MRRbJyvik8Vg2c4xkqPbdatqqBgU55bLvwzRuP9xorkQG+LgTjMPygWgrHcSROzWt
         EKPKBZ0zdluzdgWd3L7xpVhL5e7QPRwzJ2+3mP559k9z8ATqOCKL3VUCGiv8eBidkC04
         mlnsvGupXNO+Hh/UydVmDySZP3SlXQ/gKyLSpHus6zXlv7jQJI9rylczWEN9VHP5TBvT
         5FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S2RAFSvttQq4jAzRnUMJUN3mDllVs5hgI0ZKvKbHs94=;
        b=KEuID/Sh4B/aRH+QI1jZMLvikTp2fZzl+tWMheIuT1aVcLOsUrpp+A2qpJKE62mnRp
         HA7g2hIUBD/GoqHW0OvSV+SLVGOVno1fW1HsGVNanYb1pIqDoBfmHQAwSRmGA4nuA2z1
         Ma5owV7RVIuyF7kq9piDbCqY/j+/DLeCP7j0TQVfLd3JTsNTRUGj4xukkqR50U78RXsl
         Jf+H5++eXXVvm/d+Wqw3rruSdTZOd0l4rulzkNmBy8/KVaGoXJc1WXAwpPWGQ5JuoiQe
         5Ia6gcU9W9ZomD8OhuYGaFJAZp6EB+WbI0RrqGpxLmRuQZVdW+VWTRWm9c+mdo9FWdUc
         c4tQ==
X-Gm-Message-State: AOAM531kvjYIcYwqyZyQPqEmmk4x1U8zBm0xIZtm2v0WsISEZ10jPClk
        v10G976FJz5vjghUC8kjn06PpBunP5gckw==
X-Google-Smtp-Source: ABdhPJzHR4Yb+WsNDKFziJS4VJRpZRHHUXNS7zeyN9kFb2b2EekPP91eo43i6WX1PZt93IfbyJL91Q==
X-Received: by 2002:a9d:3645:: with SMTP id w63mr7408611otb.117.1608042438993;
        Tue, 15 Dec 2020 06:27:18 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id e81sm5072248oia.30.2020.12.15.06.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 06:27:18 -0800 (PST)
Subject: Re: [PATCH v2 09/11] merge-ort: add implementation of rename/delete
 conflicts
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
 <f017534243c967caa0137e6899f4e1c69ff02c2e.1607962900.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <217853ab-35c3-e5c9-f29e-2e1470386feb@gmail.com>
Date:   Tue, 15 Dec 2020 09:27:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <f017534243c967caa0137e6899f4e1c69ff02c2e.1607962900.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/14/2020 11:21 AM, Elijah Newren via GitGitGadget wrote:
>  		if (type_changed && collision) {
>  			/* special handling so later blocks can handle this */
>  			die("Not yet implemented");
> +		if (source_deleted) {

I didn't catch this in my earlier message, but the opening brace
of the if (type_changed && collision) gets squashed here, causing
a compiler break.

Thanks,
-Stolee
