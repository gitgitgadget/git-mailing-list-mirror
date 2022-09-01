Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967B9ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 16:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiIAQT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiIAQTz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 12:19:55 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57BD6261
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 09:19:52 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y29so13856452pfq.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 09:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=z97HTzpBaWKj/uM4nDE1TKMvPRnPFFxiNtwHq0bT/Kk=;
        b=nCT1pir9W9JJl13p79Cn2quLZCIm0ojmGyIkdlFEeH9GurtS5lMl5CkZjHZxOJpKEX
         A3tDY3BjwvUxrn3JCarVfo2KVYJmkHspsgpVvSdD+/mzLdC5W8KEtOoIYPXyhVxflNu7
         YB60e8vQ0ziG3pmUfF2QjaNUIbVZePdhWrMaI6yP5dLZU45eUdnU1keo9MRFVHUbpcbL
         bSsiIU7VBsTwnyGs0BWO0EQLJFTYqZkjsHiuBYjlBGl6GbkaCxx2iZdmQEZ9TH8dmmlA
         nzFPTh+yvdzWH0imJf+pQh0DoZjQqapRl18ysvFn4cJWRUneL2Vxegcgw7kriRnBJr+0
         f9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=z97HTzpBaWKj/uM4nDE1TKMvPRnPFFxiNtwHq0bT/Kk=;
        b=2Gpts/syyD8UoZxicG08IdfQSPe9GJijXMj0UGIGGK+u5diGY9bjH55VWo5aaYaguH
         aXor8niXWebEaoJo2Lk6SFhzgxRAiFTeRxNQIIG82Up9+NxDDpepgTGe/8U7umrCflp9
         FLagjJR6RayNhsngj3oBRfIniCkHCRBUz4diNwR8wNifXFjgm8Vxw7ZbPB8S8ue5tOa4
         HN1FLHdo36LwxAyZECCBIJw+OvHUr/FmnINjY7S1oHlY0RIf87GnOege4z6pNo4nB5SU
         +7ONPyRdhwawIHkeDxB5R4fFLDx3FFgzXWiLt6D8CbHqYlfR0zKKizYI8p9i5hZKPC+J
         4MHg==
X-Gm-Message-State: ACgBeo2eHbtmf1PrbG8iJxsd/lLmrNPUHQ9sJPRHWDToMgBsl1c1bqYy
        njWwMKuGZ7d6ih7oPKkPL/o=
X-Google-Smtp-Source: AA6agR5eChb8JABcPJZ2qew+zHZgxZ93WkmzuZbqg1ivQ967r+DG6TZWQa3fLuRbUgn4c9nvsHkpPg==
X-Received: by 2002:a05:6a00:a1d:b0:536:90d3:1930 with SMTP id p29-20020a056a000a1d00b0053690d31930mr31484897pfh.25.1662049192364;
        Thu, 01 Sep 2022 09:19:52 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y14-20020aa793ce000000b0053818255880sm9647010pff.193.2022.09.01.09.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 09:19:51 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 0/3] built-in add -p: support diff-so-fancy better
References: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
        <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
        <77046611-03ae-3b0f-736a-c377a63274c2@gmail.com>
Date:   Thu, 01 Sep 2022 09:19:51 -0700
In-Reply-To: <77046611-03ae-3b0f-736a-c377a63274c2@gmail.com> (Phillip Wood's
        message of "Thu, 1 Sep 2022 14:55:30 +0100")
Message-ID: <xmqqk06nawyg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> This version is looking much simpler and nicer, I've left a couple of
> comments on the second patch as we're still not quite printing the
> output of the diff filter verbatim.

Yes, this round looks a lot more sensible.  Thanks, all.
