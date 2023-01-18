Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3F9C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 07:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjARH5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 02:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjARHzj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 02:55:39 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1902F5CE4D
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 23:30:48 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gz9-20020a17090b0ec900b002290bda1b07so1191897pjb.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 23:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQAkQlaHiO2j0e9oIzF1v1xVqY8pYjMVevJ627zBS1c=;
        b=MTF5Gi5qyLHu9MMxFDz2GAOqKUfO1ezauDqvfU90vK5Gs/nCw/E5v32D/2l16vcyOd
         XeBqg/G6tPOojyeVq1KrSUX+BGcfybSBl2p/qs/G5AjKIXL97FJl0ZnlIENZQj4myUjE
         9vVBpzmgI1z1KcgXZNg+ogD6drsHZcCBNS3WaG0hj+tqJevW/pxA91i+lUIlnXxTIy1f
         H3G3zkcrkQRFevqS1t4p3URBjzRqJwkfOFMP3RC4/hLcP9kzDBIiXr4IN9Buv79QQoWH
         UZwsEjBt6K1Moa+Y+FUndx2V70wmnLDIDMF9Cx7V0J83DaPn7fsD4yegwl8ZCWMo3tbK
         CYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UQAkQlaHiO2j0e9oIzF1v1xVqY8pYjMVevJ627zBS1c=;
        b=sSR8IfH5h2NwEioLTRtmfVOagWMt2ZXPg2FyBQfQIJSWE1VNqL9WswJ6bOHKeiJrGZ
         k+T6C/uUQiRJtA/b6PwDyKKnHvpJ7hp2SHRJOpO91TgXbysZpERq5Q2EMDEOL5dSrYDn
         uB5qbLcLGUFkbBZslKIqzLBOLCAZbzj3K9qIQoz+qeazmPmg1hcGsaNgdW73AuR2MvXx
         WYVRT+arT5tz+k/Ujc5uGB6uPhPbziOSO8TCrK4AQGJkDVzTXDfnZLW+j4+3x26gkknO
         IoYYtk5otw5x4FploqVcBXL6363g+O8ZA/GjbLzEciAWEsxrDDQAUEglR7xOGMO4SBNu
         FTZg==
X-Gm-Message-State: AFqh2koJ7V3wfVnGcU8HdPrcv5MWFmSyk15bd2+IMlHIjrW88rmOoXV+
        MojEPy1HaZt/0RdOPIH62c3x3nMbJ08=
X-Google-Smtp-Source: AMrXdXu0V5yp9BWHlb3GTlEo37Aia5x7qbvvBsyRVUshN4zqHcqZc+EuMiyemVzOylwYlMvgX0oNhQ==
X-Received: by 2002:a17:902:eaca:b0:189:cbf6:9534 with SMTP id p10-20020a170902eaca00b00189cbf69534mr6087916pld.0.1674027048025;
        Tue, 17 Jan 2023 23:30:48 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709027c1800b00192588bcce7sm709634pll.125.2023.01.17.23.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 23:30:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH v8] curl: resolve deprecated curl declarations
References: <pull.1435.v7.git.git.1673987583356.gitgitgadget@gmail.com>
        <pull.1435.v8.git.git.1673991669894.gitgitgadget@gmail.com>
Date:   Tue, 17 Jan 2023 23:30:46 -0800
In-Reply-To: <pull.1435.v8.git.git.1673991669894.gitgitgadget@gmail.com> (Rose
        via GitGitGadget's message of "Tue, 17 Jan 2023 21:41:09 +0000")
Message-ID: <xmqqmt6g7109.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Rose via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1435%2FAtariDreams%2Fcurl-v8
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1435/AtariDreams/curl-v8
> Pull-Request: https://github.com/git/git/pull/1435
>
> Range-diff vs v7:
>
>  1:  23094afb2e6 ! 1:  5e44592695e curl: resolve deprecated curl declarations
> ...

Please stop throwing in quick succession so many unsolicited
iterations of the same topic at the list, before waiting for reviews
from others.

I do not mean "after you sent an initial revision out, even if you
find problems in it, do not send updates in for a while".  I mean
"do not send out that initial revision out, before you spend enough
time reading it to find these problems in it you found in, like you
did in these previous topics."

In other words, reviewing your own patches to carefully find
mistakes and correcting them is VERY GOOD, but rather than doing so
in public, you can do so in private before sending the patches out
to polish them sufficiently so that you won't find more trivial
problems [*].  Prepare patches in private and pretend to be a more
perfect human with fewer trivial mistakes ;-).

    Note. And you shouldn't be offended by me saying "trivial"; they
    were found by yourself in a few minutes to a few hours after
    you sent out the previous iteration.

That way, you'd save yourself from public embarrassment and also
save reviewer time.

Thanks.

P.S. Doesn't Peff's 3-patch series already solve the same issue this
patch is trying to address?
