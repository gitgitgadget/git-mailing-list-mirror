Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E87FC433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 19:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D67823998
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 19:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbhAHTMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 14:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbhAHTMy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 14:12:54 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72011C061380
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 11:12:14 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id q6so2633109ooo.8
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 11:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=H1JNqw4bMPvauWEijfus4loBpF9oH6Cx8sc/bd+pmWY=;
        b=nnAfHv4EkDtXZTAktyPCxkyLzqNak0J4s5T1wO7aWSFoZyw8braNDa1CUBruQhhUoj
         7GLFNmCpfxabGB+28Q+MY9UXYAoyofVNPvz4dL6R2WQk612riFaAgXXphG4C58pzFBTY
         4SNu/jNvWzhOms6F03oz5BBRchgCIHshVy6Jr8iQJctM1IKpNFor3dHy91J22nCWeDHR
         bWTsTBmvcwnHxq/RiCMEHsS+VKP4853xnhsAQqaaSTRI3/YPCCQfuwIj49fkW7LjQzGD
         wgrOTHuT661SqFsStvMGq1c3e9XpLFtMcV159mt0wEnxAolqX8WAKDD4cGyRhMzDlPVo
         bNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=H1JNqw4bMPvauWEijfus4loBpF9oH6Cx8sc/bd+pmWY=;
        b=UxcTkCfHWKp2yqj95kH0RsfUYi4hlc88Vs0HSLHItTPTf+O7uTuCNnNBZMZteS1JQi
         8xItGBtnoaa2hP9nH6hXjxxfCFjvzOZ0g4U8ExGXp20S7i3LUEVPoM7iCkDYOOOBzlVB
         kJ9WscpWF6gYIrvke3iH+dQYJssUYTwDGzr9T68rEtVhwus83NthIs0hJ7WV2rCoYm2B
         2FBW+WbDS2Uw5OhxMy6CR8ilVvt9q+9+mJE034BFnLIVcCmt43SYeQyGB+4pMqns5uXp
         Lrf6jaOVL8dLhBq2tTFSj9YzdmgTm5uvQmOMX0N8+W+VVAHtyJslnPv9bXfJa0vJrVHj
         8INg==
X-Gm-Message-State: AOAM531H7SjlCkQ9MipujtpDQTo08MbrjQlM7fx4b+qs6C98I98DOq2w
        ySav9IQS4nYGfV9oSsHzfoxpmxXIMw+XkOtEguWlXjNW9tHvuw==
X-Google-Smtp-Source: ABdhPJx9jCYLzkMXKULHkOh8K7sKA+ZssErMW32TLgGFHjyIo3WXbq9JX1N40TYfrwnyoQgAM3gN0uoiU2HVc3PSLmM=
X-Received: by 2002:a4a:4f0f:: with SMTP id c15mr5293786oob.75.1610133133550;
 Fri, 08 Jan 2021 11:12:13 -0800 (PST)
MIME-Version: 1.0
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sat, 9 Jan 2021 00:42:02 +0530
Message-ID: <CAPSFM5cjKHqvzYhZTe2_f=3XEtQf=9DX=J2mjVO1xEjxGQSMRg@mail.gmail.com>
Subject: [Outreachy] Project blog - 4
To:     git <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone !

This is the next blog post regarding updates on the project :
https://charvi-077.github.io/week5-progress/

Please let me know if you have any feedback or suggestions.

Thanks and Regards,
Charvi
