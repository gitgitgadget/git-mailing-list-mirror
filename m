Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1723C77B72
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 15:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjDTPzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDTPzh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 11:55:37 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02784A7
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 08:55:36 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63d4595d60fso8068144b3a.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682006135; x=1684598135;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DitP84K5/55ESV7eKFDvbcSY/wA9JTTxk8kkbGEE1oE=;
        b=XlzcEBJMqQ0GTiy4ccqGgVTOJhOLSa9Ljy4Co/HXyuTiB7OWO9YaSy3kc8lMAW0Hlv
         81278Zgzx+nDAJKZRFGbLcTkqQx4SneIb4wF1pPuajiqwjEqsj8kCRvn+22IR+KLn2kN
         NEKd+mhqkMxTQwoeJvkJIqVmQRz3eT1FxCig6PyLjy9NzxnLjSSO4pUumtjvC6Das7Cb
         wKCyIVmEVtWD5Pm8TZc7nAwKxUFN0tni99aTFrbbod8q98lWNj+q7eYTw3jMift/EOj0
         7tNu1E85/jmsiGUgPBvjDuBfoOmsCapqji+kTZ8A4POPpdcKFYog1+1iNkpb3vFJEjGS
         2xcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682006135; x=1684598135;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DitP84K5/55ESV7eKFDvbcSY/wA9JTTxk8kkbGEE1oE=;
        b=g4+0W+p+sygpV5ElxKDJIt/JxlOeUaBg9KwdIyJIw3707FT9AfDRsCut9emHQtZ9zA
         LXsWAE6oBwjp19365XfCOU3hGyqrTvsYduV1LcBloTakmcERTfuiVGI0kqdSg/38+wjG
         2X+3H+PyOhfNpL1wDQav7wTx6dTyQbTntjU5WfjzyZ8/v0orlgj6cKcwjSAxsEfthkJ3
         kH3MHrfOvqHntNamaKfo2/x6L76xSJ9DPKsGcUt/a2fJPq8iHki7lfgO9uQO7HNpC400
         0xf/IxmNNUCoW13alkpceFIHLozimwx7U1rlHzITspFDhHdZT/nHECeiZv4z4QfcIVu3
         g+mA==
X-Gm-Message-State: AAQBX9fg3bbzCDzd/pfQUo4xlvLgF0P6qM9JKgysfk2QQAIgP3RKGwo2
        zf0Vg3eYTJZFAMU/F1SkuQQ=
X-Google-Smtp-Source: AKy350Y2StA5tX5UUMUA238Tngx2jqZFCiXzgtTFr0d/ELVlKxYRf7c2etlhJM7lP1Yhnv1Gwlc4sg==
X-Received: by 2002:aa7:8554:0:b0:63d:40bb:a88b with SMTP id y20-20020aa78554000000b0063d40bba88bmr6158882pfn.14.1682006135374;
        Thu, 20 Apr 2023 08:55:35 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id 123-20020a621881000000b00638965d4248sm1388970pfy.184.2023.04.20.08.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:55:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     Victoria Dye <vdye@github.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3] write-tree: integrate with sparse index
References: <20230404003539.1578245-1-cheskaqiqi@gmail.com>
        <20230419072148.4297-1-cheskaqiqi@gmail.com>
        <xmqqildran7n.fsf@gitster.g>
        <CAMO4yUGzGzT4XC8t_LE=Z=ebERJq9Egq+wFj1K=1aUxHfPcnNA@mail.gmail.com>
Date:   Thu, 20 Apr 2023 08:55:34 -0700
In-Reply-To: <CAMO4yUGzGzT4XC8t_LE=Z=ebERJq9Egq+wFj1K=1aUxHfPcnNA@mail.gmail.com>
        (Shuqi Liang's message of "Thu, 20 Apr 2023 01:24:18 -0400")
Message-ID: <xmqqleim4kg9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

>> Sorry, but after this exchange
>>
>>     https://lore.kernel.org/git/xmqqmt3bw9ir.fsf@gitster.g/
>>
>> I am confused what we want to do with this version.
>
> Apologies for not noticing the patch was already merged to master.  I'll make
> the necessary changes and submit a new patch soon.

No need to apologize.  I should have been able to guess what happend
myself.

Thanks for offering to make your updates incremental.  Will look
forward to seeing them.
