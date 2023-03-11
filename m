Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC50C61DA4
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 10:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjCKKYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Mar 2023 05:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCKKYf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2023 05:24:35 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BCE122CE6
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 02:24:34 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so4977289wmq.1
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 02:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678530272;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LP5X6mZ/47/CFfAi+YRk5eLF/emXQmLgVPpmp09g9HU=;
        b=bw+lMCsQBJlRGjCKDHnAxXNqbrIWQMOFL9qS6z5w+3pZAKBnbTh/Pb0Jh0PM57qtcn
         sdtW0COjDF3NMvD72UwssWDhCQVpC9fTkx7wLWFa4KYOkWbYpuHYE/s9VRJYc/WzInXS
         DDw/os62sqz+bB0OKeqlUKb22fpQaHrkCrQZMcVrQuj7FXlK+f1rHsQCIR+6XHevUvbq
         U5wEOs4aMl/+XSaGyyRiHEzp7WC+Ej8jc5NP0kiwxeLdkdr1DknfAM5JrW1bX1oSYsGt
         lR+gbQIhBHqoD/06VPxsZRtuN3qRzvBjlrv0G5S+sdE7y2puK3/O6GE0tLypYvYB4sxy
         +XpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678530272;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LP5X6mZ/47/CFfAi+YRk5eLF/emXQmLgVPpmp09g9HU=;
        b=UfGMPv5aQyarGKnMQbfZyckA5DXkWDYhbuqk217R4EUYqraxTHW+ebNOPOxOXuObBW
         5B2Y3Rr6Ki8bGu+yN0hWXKncDXapB4P1JxFIaSv74lmuZVZXMcnk6+zryHp6Su7SlNus
         ohZOyo1A92591UdqmQKkdrz0k/PA6epoI52vldGifMOess2qlmPjGUe1Aw19cTaNwvVg
         DR7PX95S+YPa+CvNn6vAFfUNwxY0H9l4a3EUzA39lPOadGzppJXmOVRflcC66Ee/kHjf
         YHbpkeQhbAL2tcdU1NJxlOhhGrUbtYqvCRLrLj9ajPRHivw5gF8I8RB/FgejPeZWmRCd
         PK7g==
X-Gm-Message-State: AO0yUKVpuP4bJR0WcSytNQyO4UU6/nMTGCMX8ysPwJfnP7Dd5tC2EyOr
        kQQs0syCKPLeXqlDRn3ZGeKe/834oMc=
X-Google-Smtp-Source: AK7set+4cow1JLHs1vUUzhoAd6YdD3se5ojnbrnaO71cfOzP0FVtcQ786dQp9D09hf2k66w/eL3ZUA==
X-Received: by 2002:a05:600c:1908:b0:3e2:1f63:4beb with SMTP id j8-20020a05600c190800b003e21f634bebmr5536422wmq.19.1678530272622;
        Sat, 11 Mar 2023 02:24:32 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id p25-20020a05600c205900b003eaf666cbe0sm2418044wmg.27.2023.03.11.02.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 02:24:32 -0800 (PST)
Subject: rj/bisect-already-used-branch (was Re: What's cooking in git.git (Mar
 2023, #02; Tue, 7))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq4jqww660.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <ce31ee34-df93-5824-d7a8-5a0e19498d77@gmail.com>
Date:   Sat, 11 Mar 2023 11:24:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq4jqww660.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * rj/bisect-already-used-branch (2023-01-22) 1 commit
>   (merged to 'next' on 2023-03-06 at 3508814a41)
>  + bisect: fix "reset" when branch is checked out elsewhere
> 
>  Allow "git bisect reset [name]" to check out the named branch (or
>  the original one) even when the branch is already checked out in a
>  different worktree linked to the same repository.

Maybe we can still adjust this to a more accurate description of the
current state in this series, something like:

  Allow "git bisect reset" to check out the original branch when the
  branch is already checked out in a different worktree linked to the
  same repository.
