Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DB3C636D6
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 20:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBVUy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 15:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjBVUyY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 15:54:24 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E232CE8
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 12:54:24 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id f14so1306107iow.5
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 12:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNsRR4S90mKVKk0Ta6x4WPn8puMg+o9lhHRkj/2O9Jk=;
        b=Z5lmTxCSyCxIlcWt2Rrrz2djBxmWSTDgQgOCxuSwYx89LgVuie6SOdor2wpBUcptcG
         3Mfiuvld3iZDK5eq0v81sXa/X9C9pVGjTFD4Hqq09Z4woyzLN5IKAoOqSb5YUCaCJ2cE
         LK2Cp2xcxPF4IzrPayYSySb+Wtpf9whldk0sZahzI1vm61OXZxM8v2QoAvXo/W4A5HLC
         FXzS6+KT6PrW24LDkIa9g0sWHF2esrss7TgsEstkhtAQg9GFwBjMyBfhFl9P4f+3dPgJ
         J+fJkNVkSq/CJh8sCtPISOt1gZAvIoxEJOZECbbSSEzcXIZ4WU8g4bJQvOokbP/dLZZ2
         vFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wNsRR4S90mKVKk0Ta6x4WPn8puMg+o9lhHRkj/2O9Jk=;
        b=It04fVzOVwSAgVcrjqyvXEEAgauNQToSk6VYX8NQOUqPunGTcPEHDwRbRj0YPWjFCh
         vEDR27zMr6zPEpKL3m1R1PKCPoE/3M95h6jY7hBstgfxq6okdGYKVfYR6dXeSCZEW3wj
         SR9W2JtXYyQQdKnrAUyVvZHq+Brymozv+RzbFuiwyy1DUcsvekuVBFAmIOA8fglhMQeq
         71WcViXXHb8RQTIzcHNpPtIm4OVLWTGrVxNgyYTBtXq7Uzs9h7yfH331gcAWLHs3KS3T
         e43Gu/6+qKgqrPzwWH5dQ72hDpvPgZp4Ty/ScOUCVvK24Piohx/0UXiQ8t/OUfXijXIl
         02Mg==
X-Gm-Message-State: AO0yUKXv2DNDPD0R/XPSvzxTgt2QOszUPaBrO5BDa6IRfXE85zL039QS
        /0JJgR7maVKnbLuPwabh9vJwdatErviLCI53nIXjBqQ/I0xLSURPmrTnvoHBvSA8ztWou2HfRyl
        JBqf5jCYpYiY+3gJJ8SHbpieFez9inLB+V5tGvm65R9+MjU5hI/5JR87SIWRdOp+elo2yOQ==
X-Google-Smtp-Source: AK7set91D2tFpq4SztqueXpw65yB9/4h+Zn/55dLezs8gkDVNtDhRvxJ/QX3VYlVKgkt42VMv4oReQ==
X-Received: by 2002:a5e:d509:0:b0:74c:99e8:5de1 with SMTP id e9-20020a5ed509000000b0074c99e85de1mr1363984iom.17.1677099262975;
        Wed, 22 Feb 2023 12:54:22 -0800 (PST)
Received: from [10.0.0.154] (c-68-47-28-129.hsd1.mn.comcast.net. [68.47.28.129])
        by smtp.gmail.com with ESMTPSA id e11-20020a02a50b000000b003a58ae912aasm1347966jam.28.2023.02.22.12.54.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 12:54:22 -0800 (PST)
Message-ID: <e805f06f-fb2b-b92f-9d6e-92b866b842fa@github.com>
Date:   Wed, 22 Feb 2023 14:54:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   Keanen Wold <keanenwold@github.com>
Subject: Git for Windows 2.40-rc0 time frame
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello team,
With the tagging of Git 2.40-rc0 later this week, we are planning to hold
on the Git for Windows build due to the weekend and plan on having a release
out by noon UTC Monday the 27th of February.

Thank you for your partnership,
Keanen and Johannes
