Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7C1C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 13:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbhKWNHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 08:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbhKWNHg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 08:07:36 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3405DC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 05:04:28 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id az37so43523187uab.13
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 05:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:content-language:from
         :subject:content-transfer-encoding;
        bh=Oy6qM3QpFBdGOuZm21wTnUlucWuiRDSxzeFCDTb/F1k=;
        b=XK7D03cou4ipZUx5uYQRkkBAlhdCLIZ1rUrkjeo+UH2+EAt+cf4UeKda7CnRkaS0Mv
         aUY79vq4Vor//C42TAlW4ofwSVWQRPxCBOwTsLXZVaeIyUyHqIltWPMvHJQ0NdOsnU4f
         pxzsTLvJXadVaifZvwEecbBjq9Z9QjAhMXP55/RQRwWoJkdZENeyhzpsrPGffEzUYvmp
         m3wHhRb4Y0xSF9PWSXtPJ3BNFJSl/bv8mBs9nji5HUDLGNouMMQ+CKZlNty5JQyKf7da
         nvVPgdVvVggCUU8R7RgJY2aRS02n2zy+KGlAS2rHni2q0BMHpVVzBZNGSZLEk4ST5Qyi
         F6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to
         :content-language:from:subject:content-transfer-encoding;
        bh=Oy6qM3QpFBdGOuZm21wTnUlucWuiRDSxzeFCDTb/F1k=;
        b=5l74tCYl4qeqT7bcGVid+gpZCf6tWP4YY20Ob0feiQKdHFKBotV9bCHIEq06Xy1093
         GsZTYXWbKLs3B3kVqNgFAHDBWgnh/wv8MEsXfU+hG2gBw7ASAyrQvYIetVdQXAsGWIyA
         IwoZWRkwD/3XXZRLIybJWFbZcZ424XD3/Qp4CLQ2TT14blDDxr0Zu2BH9m/jIPqmWLu4
         pgiUVEXzD78Q7CPeHarV6nKQNOPO6z1UmOxhVPnUsnuEFdfO5L7IuMGhrXkJpyV3/D8m
         cWa5Au1Mtk5i0lqbxJF4IyLQNx7qUPTstFsKP2EYAPOH39jlMOy78MqcQTynVO4j8AR5
         pDew==
X-Gm-Message-State: AOAM5316TWGwM+1REy0wBOjlJTl9xMRL905ERT7x0CrTC96UH5Cfp82O
        iOB/KugGU7wDAKpZ94CT83/xK9P/Csh+WQJw
X-Google-Smtp-Source: ABdhPJxWq0kSLclbV/fehIn21bq2MRJbEoP+lk15Q5sMXWhBw90Ww/s5XnzXQQvHtKdVfZPax6u7xA==
X-Received: by 2002:a05:6102:356e:: with SMTP id bh14mr9331641vsb.21.1637672667029;
        Tue, 23 Nov 2021 05:04:27 -0800 (PST)
Received: from ?IPV6:2804:d51:4967:1d00:dae3:8c4f:7c4a:db00? ([2804:d51:4967:1d00:dae3:8c4f:7c4a:db00])
        by smtp.gmail.com with ESMTPSA id v17sm6491100uar.15.2021.11.23.05.04.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 05:04:21 -0800 (PST)
Message-ID: <710dc612-0e3f-bf10-b123-f9443e605d00@gmail.com>
Date:   Tue, 23 Nov 2021 10:04:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
To:     git@vger.kernel.org
Content-Language: en-US
From:   Marcos Alano <marcoshalano@gmail.com>
Subject: "format-patch" command doesn't support SSH signing
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I was trying to generate a patch to send to a project (Linux 
specifically) but when I generate the patch using "format-patch" I saw 
there was no "Signed-Off" line, but my commit is signed using SSH. My 
git version is the latest, 2.34.

Thank you.

