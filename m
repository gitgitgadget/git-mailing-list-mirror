Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EBFC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 21:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCIVyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 16:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjCIVx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 16:53:59 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCB0F16AA
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 13:53:56 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y10so2440491pfi.8
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 13:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678398836;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ei/0oPxXpBUGB9eLAvIH9YqOTfx1vq11M0PFLPmi86Y=;
        b=QA6mzyiRMMs5ZRC9/Ly9QwNYYsRn5ebGoEIBfOkfXCb/oRXqNBLrtexHKIumtWf7M2
         bYL6jG9P67slsqgZi+ae4b+M8pvs2K4qesjKozr9CZdNwQJXdfBB58olvuXXpR8Pn6xA
         IvsE2JqHHqxMIaLvQU4QdlXrBuwbDKve0c80PenKSIUEo0Jgnrv/HpmP8dvJffeXe3m/
         4OSiZ2Rga88ujM8so0JwajO4FJEL4nAPnZHbMn4M2lqTN6M11QmD4SkKHY63XOfRKDZd
         61CLPHSoGG7/KDW3UhAfQiu5pHFol/qizeyR7VcOKGPwbNzwOsDfTC/WCKA2JWCjKRWd
         VGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678398836;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ei/0oPxXpBUGB9eLAvIH9YqOTfx1vq11M0PFLPmi86Y=;
        b=aRL/d95TztjC/IyQt5IKgrvro8tuLckOaxl1b2vY1yj0MxTTB5KtvxTqKVry6IKVpk
         kOYnXdhRV6pj77axsrbPXx+pP2Pcr53Wbvt7sOBhCI8paM0PRSRtnWMyV6KlXHf3wOIA
         8zZn7zW+mGVnqizoKat17V97boBg1ZNp8aWc2MYcNJU1YTN6wHKptvTCMmVQnLQf/Epj
         JpOtkmIC+vGG5yvaV0K9s6tnn5Vsa2FkQqaKJULgsBsPZhmrazqQlspuXx0OmpWHIzH4
         7yR/qEKYYx8OhmMDrSQe6WeQx54gvvGB7z+JpaPen8EiBzg+wQK8halOa7NLomFGqvrc
         e6sA==
X-Gm-Message-State: AO0yUKWMQfHmBcE7m+bvLs3hbzbKGzkxFc6i3GL/SB//U7WLyI9S4rr6
        5VL2wMtIjr3WmV2JIphzxRw=
X-Google-Smtp-Source: AK7set9UWX6G3cfWePmdiVxY97Ee6RrQTDCstjXtaABFlD9yLvOjae8q3puWUCwnvAitHJYjWrEjfQ==
X-Received: by 2002:a62:1dc8:0:b0:5a8:a250:bc16 with SMTP id d191-20020a621dc8000000b005a8a250bc16mr17600667pfd.3.1678398836024;
        Thu, 09 Mar 2023 13:53:56 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id j24-20020a62e918000000b005a8de0f4c76sm71367pfh.17.2023.03.09.13.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:53:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Better suggestions when git-am(1) fails
References: <897c200c-afb3-ceb4-bf44-9af651f5feb4@gmail.com>
        <ZAlPtxZ/0Z28r5tF@coredump.intra.peff.net>
        <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
Date:   Thu, 09 Mar 2023 13:53:55 -0800
In-Reply-To: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 9 Mar 2023 01:06:36 -0500")
Message-ID: <xmqqr0tx8ubw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So here's a patch series which I think should help with the sending
> side. Most of it is just filling in gaps in the code and tests for
> current features. Patch 4 is the actual change. Patch 5 adds an
> equivalent option just for format-patch. I'm not convinced anybody
> really wants it (which is why I split it out), but it's probably worth
> doing just in case.
>
>   [1/5]: diff: factor out src/dst prefix setup
>   [2/5]: t4013: add tests for diff prefix options
>   [3/5]: diff: add --default-prefix option
>   [4/5]: format-patch: do not respect diff.noprefix
>   [5/5]: format-patch: add format.noprefix option

I've reviewed these five changes, and while I am not 100% sold to
the idea that we should force our -p1 worldview to those who choose
to use diff.noprefix for whatever reason, I think these patches
describe what they want to do and implement it in a very readable
way.

Thanks.  Queued.
