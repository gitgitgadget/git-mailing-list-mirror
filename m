Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F0FF1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbeDCSdJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:33:09 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:43537 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753124AbeDCSdI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:33:08 -0400
Received: by mail-qt0-f182.google.com with SMTP id s48so20272394qtb.10
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 11:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gtBpmKG3j4q2AwzCVlBc2ZxLdJrw8kDPCdDIw88zIeA=;
        b=PLwE6Eu3HAbTjL7rnmTvQnYoAWoy4Du/RDyFAelVAajPBm7RLzFbDEbWmeWs7mmQ6P
         uoR32XY96T6sYfDpf7lU3Sf6Xw3Dcpsait6Z+mYOjzZVO9nTmJgQbRyKFLRDNpHfMDfv
         OpHITyav/GsxTOPpgPDOWSR4afbZRrOaHmRfgqde6tX/oREeqiNET4xhhhQNBGAVbw9q
         cvVSm/UZW+dWUhpKFGnDm08sWfCqokF/5/ypK5DI8uzP/qNLi8Rthe8O1q6JCE3Rlnne
         Y8DpvGT+e574iAdgV5Fs9uOU2IJdE3j0jmJm+rxK9yFCVCdg7wfgU/h04YbP+zwyBlAp
         0keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gtBpmKG3j4q2AwzCVlBc2ZxLdJrw8kDPCdDIw88zIeA=;
        b=binfMXZ26Sk0qCgEwLsZWTEVNHi64TFTvgY0Hfgx3meLZ/ChgMgzviWz2Vkx8aDnqY
         vftRVLyZ0N+Dy3mISCOAhEj7GaFBWjqTkY4fVNFP2936cc1HqwI0AX+D3YvZSwAdhqf8
         LeRvSzK6rkBpmnvx8IvPQA90lekTJm/iECZ5I8SxLMOa73Ui378n21sWUHZ/dfhKLZIU
         VHACqa8QJMvwdmy6E8hB0U95qDRQBXbOqUBzsCJ3ARNNZKI38icsO/hQXrtvzLjdDDPp
         y+9syWFHNgcockDIRBnnt0aDy+e3aiWDJF1oFFfKtwdBYukJ8h9kBXWMV4PacWlueVQw
         r/nw==
X-Gm-Message-State: ALQs6tB1X7j2fUrOiaPB1pqi/8VFL2B0jsRtNfnunzb0Wz8ja1sYzkGz
        TscCMzKFgzoTgDKDecYcbAs=
X-Google-Smtp-Source: AIpwx49T9EDxRLevDA8YHKiKFSBVTPzoS/z2Sq74GQtqy3cjMmavDWsMBH6NhWIpFZ6W2WQ9Mv1Hbw==
X-Received: by 10.200.48.135 with SMTP id v7mr21668215qta.296.1522780387430;
        Tue, 03 Apr 2018 11:33:07 -0700 (PDT)
Received: from [10.160.98.110] ([167.220.148.110])
        by smtp.gmail.com with ESMTPSA id r22sm2839468qkr.96.2018.04.03.11.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 11:33:06 -0700 (PDT)
Subject: Re: [PATCH 1/6] object.c: parse commit in graph first
To:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180403165143.80661-2-dstolee@microsoft.com>
 <20180403112136.db2aeda65afe0c09f262dfb9@google.com>
 <20180403182846.GB8377@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <04f9d212-58b0-df15-43e1-ce6320585291@gmail.com>
Date:   Tue, 3 Apr 2018 14:32:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403182846.GB8377@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/3/2018 2:28 PM, Jeff King wrote:
> On Tue, Apr 03, 2018 at 11:21:36AM -0700, Jonathan Tan wrote:
>
>> On Tue,  3 Apr 2018 12:51:38 -0400
>> Derrick Stolee <dstolee@microsoft.com> wrote:
>>
>>> Most code paths load commits using lookup_commit() and then
>>> parse_commit(). In some cases, including some branch lookups, the commit
>>> is parsed using parse_object_buffer() which side-steps parse_commit() in
>>> favor of parse_commit_buffer().
>>>
>>> Before adding generation numbers to the commit-graph, we need to ensure
>>> that any commit that exists in the graph is loaded from the graph, so
>>> check parse_commit_in_graph() before calling parse_commit_buffer().
>>>
>>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> Modifying parse_object_buffer() is the most pragmatic way to accomplish
>> this, but this also means that parse_object_buffer() now potentially
>> reads from the local object store (instead of only relying on what's in
>> memory and what's in the provided buffer). parse_object_buffer() is
>> called by several callers including in builtin/fsck.c. I would feel more
>> comfortable if the relevant [1] caller to parse_object_buffer() was
>> modified instead of parse_object_buffer(), but I'll let others give
>> their opinions too.
> It's not just you. This seems like a really odd place to put it.
> Especially because if we have the buffer to pass to this function, then
> we'd already have incurred the cost to inflate the object.
>

OK. Thanks. I'll try to find the better place to put this check.

-Stolee
