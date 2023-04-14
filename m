Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF6AC77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 19:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDNTt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 15:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDNTtz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 15:49:55 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1E949F5
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 12:49:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id la3so19212542plb.11
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681501794; x=1684093794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4fx3rGxvZoQKm2zlKTrHGrlfWXuigVx2PePNLI34m0=;
        b=amQU6E4kUNX2ja1JPs15pVWAKiwAY6EXeAkqQ7nnWdizTR7PqGRFnnzuXJg0e6m7PY
         cAgwoEDPiIwVoQ7NCVahEkBoLD1m1AXowETkOlUB70HQRSvl0NSopIwzyYQGXG5We6ml
         DWLpn9wHn8Cgq5LBRXy5p1qjyL0gdR2B6pGTl9FhCESz+oR6izJiOKRdgK+N68gHipG3
         Ktf7VVcqgftbLS+jweAZ9g/sMzJjjFz+qYVYCO4q896AElbge/O4saar34whJqfd3jw4
         DgOa7RhrEdl8vrdyif+w/bEIO4YhY5V8PYuBwbFYXTmInU5GYcmke1LgcWGRWl2+G1W+
         CcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681501794; x=1684093794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4fx3rGxvZoQKm2zlKTrHGrlfWXuigVx2PePNLI34m0=;
        b=TLxYo9anYhYVMj9tk5Chzxi617PE1ZkvJ/XjVpLeshpEDXdWyVwvV74mMz7EHZTt7P
         ShRukI8W5U9KxE5h/AqGH0/zMZX9E4XrlNkMSLYTAm//FcQWOK/FPb2usN+SiWOXzH/+
         YapAI751P1G9nb2U0XftTWxqeM0q2+SX4RttQ5IRfPpSJPOthGN+WePzbEAOUdqM1dSW
         4JFVz6RWF51cvpvncSzwOLnXSSdMkhpSE58DEZyq2SwPejnGygQ9TtuR8tdgsdyjiEbL
         ZaB2TEJuiBMu+WN2+LITCU2j7KDYd37gfM/04qIWtgpIV2yCa4apn7GH59tsCxBG7YKG
         osRQ==
X-Gm-Message-State: AAQBX9cq5mfAfLP5WmPduH4WLBwGzG+byaXl/K+vuYCEa2K1G5nk+ofF
        7ZiZQF+14t9yT3CQ4nLbhCIf
X-Google-Smtp-Source: AKy350amroSnSlSgOxxQ1rBwKIVY2nJYXM8/d1yI1HOePHXiQvU8FFEbukdGZ/LFH8iUdwcNFgRXOQ==
X-Received: by 2002:a17:903:1c6:b0:1a5:298c:a6ed with SMTP id e6-20020a17090301c600b001a5298ca6edmr4429786plh.24.1681501794123;
        Fri, 14 Apr 2023 12:49:54 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902bd0800b001a656784229sm3383291pls.211.2023.04.14.12.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 12:49:53 -0700 (PDT)
Message-ID: <90d1402c-b0b0-4b7e-0c6e-930774b02dfe@github.com>
Date:   Fri, 14 Apr 2023 12:49:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 0/5] Document 'AUTO_MERGE' and more special refs
Content-Language: en-US
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain via GitGitGadget wrote:
> Here is a breakdown of the patches. First the "other special refs" patches:
> 
>  * [PATCH 1/5] revisions.txt: document more special refs
>  * [PATCH 2/5] completion: complete REVERT_HEAD and BISECT_HEAD
> 
> Then a preparatory cleanup for the AUTO_MERGE patches:
> 
>  * [PATCH 3/5] git-merge.txt: modernize word choice in "True merge" section
> 
> Finally the AUTO_MERGE patches:
> 
>  * [PATCH 4/5] Documentation: document AUTO_MERGE
>  * [PATCH 5/5] completion: complete AUTO_MERGE
> 
> Thanks Elijah for this very useful feature! Dscho, I'm CC-ing you since you
> opened https://github.com/gitgitgadget/git/issues/1471, I hope that's OK.
> 
> Cheers,
> 
> Philippe.

The documentation you've added is clear without being too verbose (the
AUTO_MERGE description & example in patch 4 are especially helpful), the
completion changes are a nice quality-of-life improvement, and the patches
are well-organized. Aside from one minor (and entirely optional) suggestion
in patch 1, everything in this series looks great to me. Thank you for
making these changes! 

