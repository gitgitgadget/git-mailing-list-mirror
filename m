Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0481DC433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 18:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiJFSBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 14:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiJFSBP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 14:01:15 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7AAB2DB3
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 11:01:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w18so3871598wro.7
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 11:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/FkI/1+gXjaLcnOmFZS+xUUIl1Mwr3PV9N5HZ/Yt2g=;
        b=L74i+stz2TdV5hs4ZRTdQsE8ltNQrPBV+HWpfs/QsqsAXGtxZV2nhhZuLVtiman02O
         JckATQa0GBY+Zv+QJtG+bqBKjFRfZX+osJQTb7NDRXaokDPzPIegF6hRUKBn7SzLezvR
         2hibjkAYZPbVLKpqR3xlpuyhyrlbWvJHSVvTkjI6ZGiqGVQUjdcUCFRcRaq8/RebRNwJ
         pcOQlqId+f5lwnHtdEZfEiio5XxXyTCFYm/2Sc54TOLhjbVCm7i2lZbtWoRTeSXmb3IW
         3ssKBtyE7z84gqCNkKI4whK/8BRvC6eg1TFIjTsQDoXh5UXovqF5MES5AhcgRBHy7YZf
         undQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+/FkI/1+gXjaLcnOmFZS+xUUIl1Mwr3PV9N5HZ/Yt2g=;
        b=C98t9Ip/vqlJhhPRFcxV8ogFoYooVdYCIdMZXNL2A1FhYBIMahuzbCwuh0ps10Ofp4
         5iXtMLZf1FAbp2774cWtUsaMkI9SE1+dwG9KXdTqrlKcDbOsW3zbUOTikyKbgPWTN570
         oqiRutJ/J8r5usLYAws+W7AFjl/NuACP6rJQ0R/1qg3rEa6dnN8f5NfaByNe+7zKv5Jm
         YI7cKcH0NoIuV9uaAjwDZbe4eSrlurc5od7+KVh1JLrKt74gAn1Foy5oGhQdDTwWo3lQ
         mSL6dAAEME4VXoPsdRaFYk4ZFGUioP0qNirdkDC11UZidmkq3bjHsP9mu4HhOOqkSFQA
         rTWQ==
X-Gm-Message-State: ACrzQf29IiChOeY0euRQIKRenjyW/0mlaYTovuy65eyoXbXhiDjzm+mF
        1TUHCVAEmUhKfZaVwzzxOTlYylCw5NnCMzi4of0=
X-Google-Smtp-Source: AMsMyM5T9y+bQq2esVvtafTzS6R5qL9/YJyl3kFQ5uOgBxhsAoll4f6RES4TTnBi4zgIpU/llZwOKA==
X-Received: by 2002:a5d:64a8:0:b0:22e:409f:a3cb with SMTP id m8-20020a5d64a8000000b0022e409fa3cbmr791920wrp.168.1665079271626;
        Thu, 06 Oct 2022 11:01:11 -0700 (PDT)
Received: from [10.114.212.24] ([91.195.99.187])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d6b03000000b0022860e8ae7csm11463804wrw.77.2022.10.06.11.01.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 11:01:11 -0700 (PDT)
Message-ID: <6e4a08d2-5d72-29fd-6917-11f0a74e9314@gmail.com>
Date:   Thu, 6 Oct 2022 21:31:07 +0330
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   m <mahg361@gmail.com>
Subject: [feature request] resume capability for users in enemies of Internet
 countries
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In my country government make connections unstable on purpose. Please 
add resume capability for commands like git clone

