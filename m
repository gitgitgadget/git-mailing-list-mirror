Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFFCC678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 22:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCHWPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 17:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCHWPP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 17:15:15 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F69580912
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 14:15:15 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id x10so11389177ill.12
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 14:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678313714;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rW7ZOlAgfdMFR6+1ANYq9r2g+USEiONnwwewC/Mktc=;
        b=CG7yW+YJXzV8UxqQ7E0ODQvInKfYt1cPr+DB/qoqwUq4nS7inhrOdGSGiPASOhciz6
         lzPu9WK7DJ2rhKB3/a+i7hj8WnesMY4Us1nffkF+lpldU0aKHXiPeF9NluOk0dsIfl9q
         5ek1O+g19pKs9WJwfDYF0SxDnpbRhMAeXwYvRJJeJwFRJQ2jcJJkqNgMHzUMx3X0tHfm
         TG/k29dSwRK/0a84Ado3t+YFnHFbQS9uLX1iobrZQGcas7gPMLYvyb3oD1xO5BRrQiqF
         E8CZ4S3j+tyTuuV8cQ0atVn6yb8nRXXR7iD6RYYSI0xLloHh9lwppH0qwlmz8ASjm6jf
         cLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313714;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9rW7ZOlAgfdMFR6+1ANYq9r2g+USEiONnwwewC/Mktc=;
        b=oT5z3yK8rr2OxLmBzlnoy1nShJ+7iiwDxW/OchDpG+U2crSXfyk0yna9Zm6ZvEmapa
         SFHFm1SZLMhxB5/kOiRqM3vaIuFCd54zfawsscENF5QKGVVUfw2Y5pP3AyDdNCEWS/sZ
         0XW9u/DE+FTPsyFVPbT2fDvy8ADaK1/BHdUP2VNDZsBOcHv3OTby0ZkfVJDgOXAXe3c8
         DWyoBiAKMB6n6C0yGLfUnZ6Pvt9GmMqkpiDMu4+m8ukw1wCwprFDBlUXRM70xe0Ymekf
         iUNsWFKd7Hz7PNxIi/hE3tbE2RrAsa2w1YtA9Jr/mVtRpWq31DbMVnXsBRnvdhQ5JEBq
         LuBw==
X-Gm-Message-State: AO0yUKVOjGOkZ+wewLFClRBVD9JldOGrXNINBYgxzBWC4ssi3vORWp3V
        ZDfv4klqzTHOBfEqXUNgiBE/mg/f9jG9Urj0XAbiHmVbZuy/vplAfUkxQheTHtNrKge6ULv4U9e
        xoBq6SCMd54LvoF7J4jBTVnX/JSzB+fLzbaSwMz36o6hSePG+potmWEBErD75GngxRHdpe22a
X-Google-Smtp-Source: AK7set9cdBDsqgwU3Fzja9KBMSouMZQQQmUcEJgvDn9MxDZ5JPXGH8bovuDG7rFR/rluX+TVXnPtQA==
X-Received: by 2002:a05:6e02:2162:b0:315:503c:ca4e with SMTP id s2-20020a056e02216200b00315503cca4emr16875803ilv.17.1678313713658;
        Wed, 08 Mar 2023 14:15:13 -0800 (PST)
Received: from [10.0.0.153] (c-68-47-28-129.hsd1.mn.comcast.net. [68.47.28.129])
        by smtp.gmail.com with ESMTPSA id a3-20020a02ac03000000b003ad13752c9csm5231291jao.72.2023.03.08.14.15.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 14:15:13 -0800 (PST)
Message-ID: <e6fe68ad-b6cc-4e2f-2c8b-3fb99bced1f9@github.com>
Date:   Wed, 8 Mar 2023 16:15:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   Keanen Wold <keanenwold@github.com>
Subject: Git for Windows 2.40 build time frame
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello team,
With the scheduled release and tagging of Git 2.40 on Monday, we are 
planning
to have the new Git for Windows build ready by the end of the day Tuesday
the 14th.

Thank you for your partnership,
Keanen and Johannes
