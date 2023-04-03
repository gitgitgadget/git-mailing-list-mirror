Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B2CC76188
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 16:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjDCQiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 12:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjDCQiM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 12:38:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381BD26A0
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 09:37:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so33169111pjb.4
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1680539870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sZSEJE24nfQTeImEKWA+ABwRxn69MDCNls02WVpQsmA=;
        b=U1CsA38yKssunp6Vfw35CVfOzZL+p6jsch3YiKfwo0Dt2YJ3ZbDd5ajYQNUBOPFXUt
         EMx1Po/bvYnOSOzsx1Q9ak4AVE6qr7MBaUtQJQx1W7kBrE7R74VE4rb8ScxgFaC1tHAT
         8FwjNcIa5+u20L/2pWYhTILLFwJ2J8LhsSsa4qVH1IN5aUTRX/PNjDs591FCoMDXE9aY
         LORRN8QvWkbXdY2IikxSjFIEaboo4CZAfCAteXLuauPTYZD7wYTkGh4TS9R8G38z4sR3
         LBQ5tVqW9pZFzFx7gkZ/T8r3BTp9XwBfJmySb7ozLPeulprhL3hNqc0Zm7tB6fR2VtC5
         nKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680539870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZSEJE24nfQTeImEKWA+ABwRxn69MDCNls02WVpQsmA=;
        b=KuWtLWRFhS6m7wOiJJM+i9xKuYlN7XLlqyaRAdX2ZfQle/j/CX8fgrMJ6NndSMev5q
         cIlbVQ6tYWHHb9PPJq5bTZIlACCzsKhnFPcX53HXaffWSkh8k19r+sz0M4XyGAJWqGa8
         tmFxyvcR+ZAWK+Tp2yNsFvtVUUk7E7sf0kRucXlRJ0wIqIeUd8K6hffUU1p64y1tGCHg
         9HFuEhiQIxwvyuOUSa+T82JhqJfNMmuB5edC5chp7mddIKg3V48P8gh0k5NNmyzJS22O
         fUVgWv6SXNPV56yaO7Luxii85tQqcOcjJO3aoT2Q5mjNYUVehUrxEbMNhGiqhQveQG1C
         z+gg==
X-Gm-Message-State: AAQBX9evStTGl62jlLvdyWF1kY+HfUZwAZ8EVypaN81Bt2vf2wd3Kzr2
        ds+dJLiCpDkVoQFpLlKHIxlxfi2vn6cACLPOzw==
X-Google-Smtp-Source: AKy350ZXvhWvGWCZy0CGm4uzDrliBhtJHkEaXT16lTM9vdNCJ9X0s3Id++8GyJR3CnfugE4BM5/YrA==
X-Received: by 2002:a17:903:32c7:b0:1a2:8871:b408 with SMTP id i7-20020a17090332c700b001a28871b408mr21973564plr.36.1680539869694;
        Mon, 03 Apr 2023 09:37:49 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id a19-20020a1709027d9300b0019e60c645b1sm6768630plm.305.2023.04.03.09.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 09:37:49 -0700 (PDT)
Message-ID: <9b56e214-7efb-cea9-d3ff-35692c179a7b@github.com>
Date:   Mon, 3 Apr 2023 09:37:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2] describe: enable sparse index for describe
Content-Language: en-US
To:     Raghul Nanth <nanth.raghul@gmail.com>,
        Raghul Nanth A via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
References: <pull.1480.git.git.1679926829475.gitgitgadget@gmail.com>
 <pull.1480.v2.git.git.1680107154078.gitgitgadget@gmail.com>
 <8cb2b7a2-78f2-9221-1234-62814557d2d3@github.com>
 <945ec6f2-8370-0d99-0537-a3724eefde3f@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <945ec6f2-8370-0d99-0537-a3724eefde3f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Raghul Nanth wrote:
> Hello. So, yes, I am interested in GSOC. As for the reason for choosing to
> do sparse-index, I had just missed the part about the micro-projects.
> Sorry about that. So, do I submit a micro-project patch?

No, you do not need to submit an additional microproject. The 'git describe'
integration covers the intended purpose of a microproject (namely, becoming
familiar with Git contribution best practices).

> 
> And as for the changes mentioned, I will make the changes in the title

