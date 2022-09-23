Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F675C6FA82
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 14:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiIWON6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiIWONg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 10:13:36 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580C013F723
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 07:13:31 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id v1so222678ilq.1
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=El2moLw7B3jEbWVNIvhtR3mU4CesqAY4iuRJWyqhAfc=;
        b=fRoZfh0urF14c7IoirKFYRETInMMHhIgbpQWfXCyGJED8J8FcrMC4OcmYUeSKvhSZP
         D1Qr46BHu3QYQeslyswuWf6hlEeYFskY+mVqVOuom2Gs2XZm6avbMksSAiF8CRC3kLTu
         q/wycFghti3EjcR/FeLK+jmraLxIxClvD4dYQPBWNEaRChaAM2ss/54YERoctfrbfpPV
         dK0tweC6BTqbzGBvm+12yah5NiznEjm0Etcna4FqinwRxIGW6KyRONC2LeYMV0lKZyit
         dRP3q/PxeFPqgiKv/EpOusRpkGsfqXr9E4P8QNi0ke6GrQIU7/Gq7++qJnVGnZzvZ4TC
         Bl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=El2moLw7B3jEbWVNIvhtR3mU4CesqAY4iuRJWyqhAfc=;
        b=jF50sOd9slS31RsTSf8XFJElaLwqSgFEQ7e0qa1GkJDXbEfqn2tbqADVwnbbpttPaw
         Gi/cp4HMAgLDYNKcKHAbq9EnrkDc9gO6cJTxY1lxLY5qftARPvd+ioIzm9tvRU+fIhfk
         FsHiYvvnMBOsfLPr90cD7Wi6h4MQQjnHQSXUxCpjk2LZS2QPBegEt50yhQxH6IRJa6E6
         F3hgfTwOY9uB6aVxdrAkqEDxshTq2Fyg16+rPTF7uvHi8d01PpI9VFKWscue+Kj/cjKg
         oSO4aDyX7DLcVOP28DOgNci/nuXNqwjWnY+B52slt/JvfKy0cJdxo/lyBMxXzsXna+bU
         OmKw==
X-Gm-Message-State: ACrzQf3BdEFTkyvrSl+MP5tvjhDO+y0Asg3bclrmG/frXrFQiOwNXmgF
        65RZe5+K78+HezMvt0ATLI5T
X-Google-Smtp-Source: AMsMyM7Z+R1a5D9+BxDL4cTO16+0ou3Pq26gURai/TnA7cG4O90sAHZg4s8J1v4N+3li3QetDkQs6A==
X-Received: by 2002:a05:6e02:1aae:b0:2f1:e8c5:356d with SMTP id l14-20020a056e021aae00b002f1e8c5356dmr4172081ilv.166.1663942410177;
        Fri, 23 Sep 2022 07:13:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:4176:a2ac:5b9f:2ef3? ([2600:1700:e72:80a0:4176:a2ac:5b9f:2ef3])
        by smtp.gmail.com with ESMTPSA id b88-20020a0295e1000000b00349c8fe9109sm3408392jai.174.2022.09.23.07.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 07:13:29 -0700 (PDT)
Message-ID: <d09c13a9-855a-c38a-bf80-d8d602a0366a@github.com>
Date:   Fri, 23 Sep 2022 10:13:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v6 0/1] grep: integrate with sparse index
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, newren@gmail.com,
        avarab@gmail.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220923041842.27817-1-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220923041842.27817-1-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/23/2022 12:18 AM, Shaoxuan Yuan wrote:
> Integrate `git-grep` with sparse-index and test the performance
> improvement.
> 
> Changes since v5
> ----------------
> 
> * Drop the `--sparse` option patch and edit corresponding tests. 
>   We can wait until a better name is decided to replace `--sparse`.
> 
> * Modify the commit message, especially get rid of the `--sparse`
>   occurences.

It's nice that now that you are calling grep_tree() when reaching a
sparse directory entry, you can still have all of the ensure_not_expanded
tests work even without --sparse.

There is definitely room for improving the user experience to focus on
the sparse cone by implementing a replacement for --sparse in the future,
especially for users with partial clones.

But this patch stands on its own. Thank you for your hard work here.

Thanks,
-Stolee
