Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32072C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 09:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF45606A5
	for <git@archiver.kernel.org>; Mon, 31 May 2021 09:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhEaJUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 05:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhEaJUS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 05:20:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADF4C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 02:18:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c3so10150474wrp.8
        for <git@vger.kernel.org>; Mon, 31 May 2021 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NSPHnlTgy7CvCITWYFPf3Txy2RUfdq9BXbWfF7o/bqY=;
        b=jfuGd7Z7/Qy6dGTaIa31te082HGd7iI6wGdEdO+RRzH2LxQ1xtVk+ExhLwQdyCtjtB
         JGpuNfRJhL/3a++INzJ3cTlOgmKNp5qG9UqHW7H30DeHSmWWmFVBUlfNTvXoTmAZDJot
         acPV6uGKhDdW8X7e7+KCwnLQt1Yu09p126VS2tFJlaPmMMMn5eU3xrNqA2BstUa3TNYw
         +11MqHbBhraNDDurJcGtwrTHC2/IFYxsmRg4jfF9Nkx35GKvV3kRz2iE8SHcCRWbFWb0
         9j/8T5smHafx5+MvpdwnpjGtpnoqL+tGw5243Ei80xnPdYQmZMfd9BN/HQJyRncYHRR1
         Dwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NSPHnlTgy7CvCITWYFPf3Txy2RUfdq9BXbWfF7o/bqY=;
        b=js/YfII0tmCrvHmFljMm5qL1HbnrAbX+BMOnvDFUtuS07OqB/Le3M7bFXjSa8xs8xz
         CCmKG+no49443CBCqNBA1pYM5RYwtKqpJUAkw+6PH+glXyLZHoBgAm0K7TENdK7Mt0gb
         oi7FDuTivpC7fEaDpkVGCkIU0xVRT0t9YnUmWwYKl5cY7ySv3S5QGTtc0R4NprFZQhVc
         GIKLlqJg02r9sBvqSrqe+wZXEr7ntc5KxAth1H4Ag9RRmJLzT+AfEgr3TUQr/b9K38MY
         zJVfgu6G+9WNLgp1vsd0wHJxbdODxQ+WkvnaBGoIXKBR/eFBuYU6+SXkB5DqVeY+bNT9
         b1Yw==
X-Gm-Message-State: AOAM5330steqXwwQgTeQauVxiQ5cJMG8OhKtp8kMLhNSKIN9AdGFv5w4
        PcKsT4RsJWM7YMJ/EZan/g+wBx3q3vPl4A==
X-Google-Smtp-Source: ABdhPJw5Kw4p4DNZFdwfrEKPvrx7JyGbARfJLUd6ZoTwuVpIhNVGf8oyLQwMaK/3guvHHvKyK6Nj/w==
X-Received: by 2002:adf:df8d:: with SMTP id z13mr20961966wrl.267.1622452713228;
        Mon, 31 May 2021 02:18:33 -0700 (PDT)
Received: from ?IPv6:2a02:8388:e002:8cf0:25d1:fff3:8887:500f? (2a02-8388-e002-8cf0-25d1-fff3-8887-500f.cable.dynamic.v6.surfer.at. [2a02:8388:e002:8cf0:25d1:fff3:8887:500f])
        by smtp.googlemail.com with ESMTPSA id d131sm17793752wmd.4.2021.05.31.02.18.32
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 02:18:32 -0700 (PDT)
To:     Git Mailing List <git@vger.kernel.org>
From:   Mathias Kunter <mathiaskunter@gmail.com>
Subject: Default behavior of git pull
Message-ID: <7a97ac78-f405-2dca-2998-f03637cc8255@gmail.com>
Date:   Mon, 31 May 2021 11:18:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-AT
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wouldn't it make sense if "git pull" would by default also pull the 
branch with the same name from the remote, in case no upstream is 
configured?

If I can push to a remote with a simple "git push", then I'd also expect 
to be able to pull from that same remote with a simple "git pull".

Does anything speak against this?

Example:

   git clone $url
   git checkout -b fix-1
   # do commits
   git push           # push to origin/fix-1 (works)
   git push origin    # push to origin/fix-1 (works)
   # other people push to origin/fix-1
   git pull           # pull from origin/fix-1 (fails)
   git pull origin    # pull from origin/fix-1 (fails)
