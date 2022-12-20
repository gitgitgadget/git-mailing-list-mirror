Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096C8C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 14:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiLTOCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 09:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLTOCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 09:02:16 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF435FA9
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 06:02:15 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id i26-20020a9d68da000000b00672301a1664so7199661oto.6
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 06:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BT8HQ9Z07eOIm5Jzy+FZ3kk6wQwkNCbbftHXp+ZHB+M=;
        b=CuUpkLmGOq5N/3gNlzM2jj+xlxr+q9k57a6NN/0I9ldvUV9+ua8kE03q8w9xat5z98
         znOD0SLqpT2kqJ0JJiDDjqUsZFu/MSuK1vkNGCMx+2ahpbMeI0Y1IgHMmkM0Hy0x7Uer
         olqmq9jYXjDCmE8pAfoKFz+HviEjM/9n6z+QTfaT7WFvxBehSoq1fyHhUzL54qn+2CiC
         I642EGhPVxcSvuk4kqr4z25nuuJAW0/grJcswv4vwlYcSxU/GZWz/9HrDNij1RSo0TkJ
         J8ZYADhdiZkud3LWLyOepRFO5QAE+nK+brAX6SECxS8VOIGLdNl40vnzTHv/cSUqO7J9
         Gz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BT8HQ9Z07eOIm5Jzy+FZ3kk6wQwkNCbbftHXp+ZHB+M=;
        b=HWnoA3GO/J6dmaSrtnq78x03sJpv6IO+jeckquZPFtSMJeiMZDAy/WcQXWSMb4JuZ6
         N9D74xenGhCmHtmim7JRrHmgvmklBM6bt/Ofs10qwXgzAqs9SoQAVPkk2AGArAifhz3D
         R6hZi1y8MNJdC6nptJ849Ig3VJ6ITGPN/17WKNgwSCxN/r7MHovXzdujQqiIqdHgLK++
         Af3DwTtYt/mkJFGnEmIe5XDlzCc6n+Sx585ABI+uAADYIZbT0cL5CnjMTVf9h/iH6Byr
         gafkglYE3KhusMkyrzawvhoDecH3qikqQerJCd2cfAL4p/2lHVfqhNk7YYZr6t+EKT45
         drtg==
X-Gm-Message-State: AFqh2koUW0EYmKvlXzw3PODAIe+MyZDi6US5LmB2NeE0hBefsNhglBm8
        f0LHIR5Uy/QoKGfm77sx3tFL
X-Google-Smtp-Source: AMrXdXu60Sgh9Pm85FOkLEnFFu+yXRsMSxO2DmhcXsf6S0WsujxERNySPh1Jzf6PRT1l/13OnrvsFw==
X-Received: by 2002:a9d:6004:0:b0:66e:ab28:cced with SMTP id h4-20020a9d6004000000b0066eab28ccedmr4771022otj.13.1671544934849;
        Tue, 20 Dec 2022 06:02:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:6103:2a44:3e02:702f? ([2600:1700:e72:80a0:6103:2a44:3e02:702f])
        by smtp.gmail.com with ESMTPSA id n17-20020a05620a223100b006fc40dafaa2sm8563013qkh.8.2022.12.20.06.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 06:02:14 -0800 (PST)
Message-ID: <be44ef00-2d80-18d5-4dab-357faca20853@github.com>
Date:   Tue, 20 Dec 2022 09:02:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 1/3] bundle-uri: drop unused 'uri' parameter
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, vdye@github.com
References: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
 <d17f08ed4b68d711b452b5cfb54a949845bdea81.1670866407.git.gitgitgadget@gmail.com>
 <221219.86tu1rzmbs.gmgdl@evledraar.gmail.com> <xmqq4jtq292e.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq4jtq292e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/19/22 7:49 PM, Junio C Hamano wrote:

> I think these three patches were designed to be "oops, that was
> wrong and here is a band-aid" follow-up fixes on top of what was
> back then in 'next'.  Now the base topic has been kicked out of
> 'next' together with these, we can afford to roll them into the base
> series before merging it back to 'next', but due to things generally
> being slow toward the end of the year, that hasn't happened yet.

I wasn't expecting to re-roll the base topic, but I'll get
started on that now.

However, the comments in this review are barely actionable. They
provide very little value especially for how verbose they are. I'm
frustrated to see such a drive-by review so late in the process.

Thanks,
-Stolee
