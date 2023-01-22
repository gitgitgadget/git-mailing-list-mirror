Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730A5C38142
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 16:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjAVQhK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 11:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjAVQhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 11:37:09 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F837FF3F
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 08:37:05 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r18so7355091pgr.12
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 08:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpMzlZBrL5vxBCYtEaMhAc9AjD0MqRaXC4oRU8QIKt4=;
        b=BR+rGJ1wxigdJFSE4KWy/WTSKN5uI9nD5FdUjyQDktoYMSjxmSEaZPK4nFCIAPNiFi
         usKAFxRTbldM7xyVpkX12HW1CQGQ2ffqi382I+NcToz7SwRbfv5MXcj0/wRhTdxvjVc8
         1dP5vR8P4b6KLoQkir3iPmPiFUhksENJp2Pm1oOwixOrTYMgoDFJUj7pzAPXXkUctUwq
         mpR6cD8p9w1b1adEu1tpdlRFVqldkmgGJAlj5F7oM2//qodfGFXat+4eihegPcbH55uZ
         PJp3/7pDdlJSxqmCJZXc8xyOywBZ7vmCMh2p/MUSXigpbg2UFMSlq1sDjDdMmEedhDOU
         /YoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TpMzlZBrL5vxBCYtEaMhAc9AjD0MqRaXC4oRU8QIKt4=;
        b=n32dYX688SGljV7CrHKhGQQN3X7fZhCuWtN0UmI2ephaqJ7FnEe+L6zQMcHUhXTGuv
         f+ulxJdWhr6hqNtxP27GTDJwbIhWP4QHoGDNl+7hCJNgi8fasltXAUobdWjChx0+Ijva
         bpmRSt2/jnoMuqXEW5txK9RfCpE4lfgALZ57MNluYTZAmDyesTujDRLvSDWSkgPBHl2p
         W8mgXMQs5+nDr5fYzbc80rbKswFt+eIANbUi/Lhn2dCithsk2opqmlmQY6vJuYwRkGZs
         7qWPc1I/1VWEzVJi1UtwrjyUYXYD3wOd5Ald8heAGo6ttDaBoPXNjfYSZMGVu1O8C3Tt
         F+0g==
X-Gm-Message-State: AFqh2kpOvD2lb7pz7e7h4H8BkL6N5mA+AO9zsVApa07s8zbMrlCrGwE+
        kW1NgiPa7cLDJvz5pKhEqWdkBc01o5U=
X-Google-Smtp-Source: AMrXdXuKRMaXOhAuT51+suizldYZ5a7giQBTnnkWJmSNNpowOWYdJbSkZZod5xpcdXrYVbdt01Zw+Q==
X-Received: by 2002:a05:6a00:420a:b0:588:eac0:b05b with SMTP id cd10-20020a056a00420a00b00588eac0b05bmr23015244pfb.27.1674405425143;
        Sun, 22 Jan 2023 08:37:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q4-20020aa79824000000b00581d62be96dsm17286382pfl.197.2023.01.22.08.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 08:37:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2023, #05; Tue, 17)
References: <xmqqv8l581ov.fsf@gitster.g>
        <6aaa2463-a92a-de06-5e16-f0980be3ed3f@iee.email>
Date:   Sun, 22 Jan 2023 08:37:04 -0800
In-Reply-To: <6aaa2463-a92a-de06-5e16-f0980be3ed3f@iee.email> (Philip Oakley's
        message of "Sun, 22 Jan 2023 15:56:40 +0000")
Message-ID: <xmqqfsc2sez3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> I've now sent a re-roll. It primarily updates the documentation, and
> adds a test to cover the wide chars and combined characters.

Thanks!
