Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6819CC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 13:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiGONNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 09:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGONNe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 09:13:34 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879B67AB04
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 06:13:32 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 125so3824528iou.6
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 06:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OqeGoCSDn24Y2At+xu5UcmKcr31AFOIpOF6i51AqgZI=;
        b=PfdrliD3j2PCLeeWkR8/zY+8kXMo3cA7jTOfdLITLOQjD7Bf6HqOmNxccxgya/wij0
         fW23LcoRxA1H438msYnRpGq1rFkLzEx7UB6LYbIsneTEAc1eXucdfCI8fgtxMFaiPvTo
         E6x+MRnNFiDe1z1CdundHtEtkn7WB2mFzeSALdJfWOBxA7kdga+35ai99QbwLGGmfNsE
         /yWuFv2vjbHaZf/ZC+xhJrKfv+mt7JGrA5YjSn5OPFtqaZllsJVTgt0F9ze9LHrD2ehf
         +dqz4p0k5gXKmHTr5Lpm6rZE/lBS5BQ96PpbTFo8wBkxsmERXDBJbPj7OXbFt+od3WdC
         EF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OqeGoCSDn24Y2At+xu5UcmKcr31AFOIpOF6i51AqgZI=;
        b=ebiwA7SFfL81UCV3JVJnP+kCbazD2nbB0Ow4BF0QrNd7c0mIs2LLHK962UbtD7K3NV
         LU4u9Q6AURF65FGW/0URRjX1iBJEyeI/dZkyQEyowqxDlg0TbwUQYZQCYbb7I+D1vqwi
         Eq+Q16ygFjh5XctcNasZa1aBSpdWhyMdJdNbcdXtUX8n77u6AGt2UfcLrVHoEj/Yayu4
         NqYwALZVZWh94gkAUwe1IuHsK97P2Mts3PWYu2NYNuKLc7raqkEKBRHliCvQLoQVdrNa
         oDgaIvmzMQNepnb03gXhhuNczKWVKxby/ew2EMV2/gbbBBpBp51v8zDj1NRHfRp1KDR+
         JsQg==
X-Gm-Message-State: AJIora8MBnXujUSDAwAzJCXl25m+CKxf8Ht88zdtBDV3ZdFrfA3Ys1lA
        DMRcC428YI9mlznRqgYUE36v
X-Google-Smtp-Source: AGRyM1vstpbe3H9em00VG7PlLuoN4K3IxU9PBdbczQB8CRc7uQr7CNp3cqLQTGPHMKDeY7qxAkmDQQ==
X-Received: by 2002:a05:6638:34ab:b0:33f:5eb3:22a5 with SMTP id t43-20020a05663834ab00b0033f5eb322a5mr7223598jal.157.1657890811864;
        Fri, 15 Jul 2022 06:13:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:34ca:20bc:bde7:c407? ([2600:1700:e72:80a0:34ca:20bc:bde7:c407])
        by smtp.gmail.com with ESMTPSA id c25-20020a023319000000b0033f0589eb52sm1930620jae.2.2022.07.15.06.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 06:13:31 -0700 (PDT)
Message-ID: <638f6b51-0045-f08e-fa63-d16a571d0099@github.com>
Date:   Fri, 15 Jul 2022 09:13:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 09/12] sequencer: rewrite update-refs as user edits
 todo list
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <29c7c76805abb9b8afd44a65cb39d8f9d3c95892.1657631226.git.gitgitgadget@gmail.com>
 <7a471a98-09d1-78cb-d6dd-a7faaa9071ba@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <7a471a98-09d1-78cb-d6dd-a7faaa9071ba@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/15/2022 6:27 AM, Phillip Wood wrote:

>> We can test that this works by rewriting the todo-list several times in
>> the course of a rebase. Check that each ref is locked or unlocked for
>> updates after each todo-list update. We an also verify that the ref
>> update fails if a concurrent process updates one of the refs after the
>> rebase process records the "locked" ref location.
> 
> Thanks for adding this and taking the time to write some good tests. When adding a new update-ref command to the todo list it would be nice to check if the ref is already checked. We could print a warning or force the user to re-edit the todo list as we do if they delete a pick and rebase.missingcommitscheck == error

I agree that that would be a helpful feature instead of the user
discovering the issue at the end of the rebase (as they do with
the message from patch 12).
 
> The checks below are quadratic but we don't expect that many refs so that should be fine. I don't think it is worth the complexity of building a hash table or whatever at this stage.

A hash table would be the natural approach if we see users having
trouble from such high use of the feature.

I think both of these concerns would be excellent for a follow-up,
since they would shave off some rough edges. I hesitate to add them
to this series since it has been growing quite a bit already.

Thanks,
-Stolee
