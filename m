Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F23B31F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 15:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbdGYPJ6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 11:09:58 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:38275 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbdGYPJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 11:09:57 -0400
Received: by mail-it0-f53.google.com with SMTP id h199so52773937ith.1
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Oc1xFRlU6ztn5GRBlTsIGCs6sI832WAKHt3PBF/aJyY=;
        b=okL6tUlyyxxjAvPySZ3vyVFwBrpmLcvAsoEA/QTZHFj5Xrjw71xZJwqkQ4SnsYzYF9
         eoiSzBEadjKKbfv33G2OcsdGCZAlLqISsQgNP+jza+lYf+kZ+/piho9M1yfqjKr4wTU8
         hOcUQ7iaCBMidRDM3I1d6Vv1/OjywyqAKszMTQdzhLF5WvrJiioFOgJJCVFo+oNsm4vo
         Mtdz3nywFxvqIRz0BnQDvt8rynw0DWgDxEPRIvOAEmZdkqdnabZOH1pMaqG1IKOUkFOM
         60KHBilIwfDfiMV1X+xSJcmA1Z6UnxRf/yKA/Xx2fWOmuHGIG5evTQygGqPMHFMUE1+G
         mbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Oc1xFRlU6ztn5GRBlTsIGCs6sI832WAKHt3PBF/aJyY=;
        b=kmo2f+vWHWolLGjtxCl9dI/RSKdUeoQ3x46bVniINlJYQQbs9AGhIfzZli70fAYRtd
         ibk2iTfjFuaCDuOF1IgxzLwj/mAuW0NqFlkZxQLN43XEdBzsy6BfgxrJzK7q20VqqyPV
         YoIOY41NQ4cutmgJmM2hBqPJyR2cMOyNyS9zNZM3FeRj+uiW44ZAvK6xYZHFWRw+m1vW
         v42GxRmE/I2WhNqXMg+Cu9gbB4XQyuDvbfkISNM7ByTfZiCGx2ghBRmA5uoRpCi7MIOL
         ndf+bZIG36pOnIB2rzBlECQzk8/GwpmWnCUHwnxvHDFpvLQp7zWOV0zTCPVfrKWlA6MW
         rOBQ==
X-Gm-Message-State: AIVw1136gBF9IINt5wv6cF9FVm5aOPUOx/xkw61Ne5hYkc1sbQheMUXK
        J4yJ6JbjEYAHNCRmDos=
X-Received: by 10.36.125.11 with SMTP id b11mr6787333itc.47.1500995397010;
        Tue, 25 Jul 2017 08:09:57 -0700 (PDT)
Received: from [192.168.1.6] (d24-150-81-207.home.cgocable.net. [24.150.81.207])
        by smtp.googlemail.com with ESMTPSA id 77sm2656272itw.3.2017.07.25.08.09.55
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jul 2017 08:09:56 -0700 (PDT)
To:     git@vger.kernel.org
From:   Raman Gupta <rocketraman@gmail.com>
Subject: [RFC] Git rerere and non-conflicting changes during conflict
 resolution
Message-ID: <17c46229-3b64-34f1-30fa-d40b77e1c054@gmail.com>
Date:   Tue, 25 Jul 2017 11:09:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had an interesting situation today: resolving a merge conflict
required modification in other files that were not themselves conflicting.

I just realized that rerere does not remember any changes to these
additional files -- only changes to the conflicting files. This makes
the end result of rerere obviously incorrect in this situation.

So my questions are:

1) Is this a known limitation or is there a reason rerere works in
this manner?

1b) If it is a limitation/bug, what would be needed to fix it? With
some guidance, I might be able to submit a patch...

2) In the meantime, is there a way I can identify these cases, without
which I cannot really trust rerere is doing the right thing?

Regards,
Raman
