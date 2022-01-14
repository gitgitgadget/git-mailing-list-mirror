Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844FCC433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 18:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243634AbiANS4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 13:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiANS4v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 13:56:51 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A04C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 10:56:51 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id w204so3544281pfc.7
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 10:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=L4t+LpuUEbjw7FtpSF++181A446wmZ5EC7TMHtM21zE=;
        b=q3V0SnMSDQ4kqv6e/FwniugUciAJyJyDotILwzo7k9Dl9DbZcLubfAt0HwJDwBGHve
         c801dCpJqHifso9PJLu0G5KTxSk8KvaY9K2cZXWiDW3zrI7N/oZBk6zqQgng0J+lZkRi
         /FwhFpfAWb6V2/cpyrxBA3OUCF/ht8xLuitoMtRvWEUr1sEMG3/kpsnYkxkOSbEF+gZe
         KiSPfz+HAkPQUGRb9eQm9u2VWDG7eNs6wGsDgIJ/m2wOSOM0/aK/+oyu8E8zuLhp+ude
         fZb5Hhe1R7++rf50c/u7w09ilfoYQI1SqvxMk5eOM3SpGC9oAhkmLxoYtPQUr34WRaJ+
         zxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=L4t+LpuUEbjw7FtpSF++181A446wmZ5EC7TMHtM21zE=;
        b=CpfcxFLldX9B2GpIImxIWh2XdGZ0+a8W4DDFRlPX5yhpnXNhfmHC2IqGvz1GzD2ahQ
         ADN93PNLyduo+rArPXzBWoB19qK6brU7ogr8ev4ts8xBm93HHR3a8w+9oNLq1tF2QxTo
         Fi7SIk4XQFNVruJyTYqsD4QjOP0OOe10x+05WZmOLTGMDcxnOyhwpK3wB+r3CL3NKXat
         RUXUsRFZ2IJPVdCZiXzv8OXvCm5nmcaViPplSuoH6f+cxTYsJ9da5/YRK6J5mnf0MnFM
         Zt3Ctj6GFEXA2Kg4jECzUy9cbtbpqrLn/RzwCuUCBOm9zvSkCV/XDdsIQc4BIj1ME4En
         TFJQ==
X-Gm-Message-State: AOAM5323oARr7Xf9INF1+gFQrDZAqeYp2Yuma4OmNZFQhs3TObEiLaOX
        sKG7trx5YyTBKCQhif4Pri6qQ1KtJpnLxg==
X-Google-Smtp-Source: ABdhPJwAqOY7rDcf4SF7sh+br52hEAWIPG3PkeUGoyMvKJEDt0F5aqOKNHhjaz+e70+YFkx25uBRnQ==
X-Received: by 2002:a05:6a00:15d1:b0:4c1:e1d2:347c with SMTP id o17-20020a056a0015d100b004c1e1d2347cmr9773749pfu.29.1642186610863;
        Fri, 14 Jan 2022 10:56:50 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4d75:7abc:9063:64b3:ac13? ([2405:201:a800:4d75:7abc:9063:64b3:ac13])
        by smtp.gmail.com with ESMTPSA id x29sm6524287pfh.175.2022.01.14.10.56.49
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 10:56:50 -0800 (PST)
Message-ID: <11860e44-beff-39e6-2efc-53324223caee@gmail.com>
Date:   Sat, 15 Jan 2022 00:28:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   Jaydeep Das <jaydeepjd.8914@gmail.com>
Subject: A new feature command request `cmd_ignore`
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Generally, To ignore files from a repository, we just have to add the 
file name in `.gitignore`. But this task becomes a bit
tedious when there are a lot of unstaged files which you want to ignore.

`git ignore [file names]`

would add that file to `.gitignore` and other parameters like `--force` 
could be added which would delete that file cache if that
file was already committed.

This is my very first mail in the mailing list and I look forward to 
becoming a future contributor to the git project. I would like
to hear your opinions on this command and would like to implement it if 
approved.

Regards,
Jaydeep.

