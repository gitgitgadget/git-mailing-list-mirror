Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A27BC3DA7A
	for <git@archiver.kernel.org>; Thu,  5 Jan 2023 19:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjAETJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Jan 2023 14:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjAETJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2023 14:09:37 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2107264
        for <git@vger.kernel.org>; Thu,  5 Jan 2023 11:09:36 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id s9so30725186qtx.6
        for <git@vger.kernel.org>; Thu, 05 Jan 2023 11:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfQaaj1UpUmrk2MIuYb/SCQoc6iXIC0BLAFa6gnSs5Q=;
        b=BaM+BlAp7tQM1btacPqh/ECm8WWbnHX58v56GOo6z4RgKZphILgYmpxMZXGxmEWvgo
         c64u/HFAENG4jZhI8RuYNaHXSNNqPsS3TkUbLyXwbZAZYA2IqAWa6wkTXGe7aPG82U2U
         ner9KrRCS3twRlPjDgKPbkB/JRBjiZmadt8zR/qpbNQJGSE4L5KOiF2z7rHGaeAe6Hat
         amvW/rmSxCxAynDbaZC1cOVt/DUgouOYE7Xg2N7KeSTwggdZZj5rpQce6VWVvdOWFiOo
         NJnPJHvFIWiNd2HzCN2Lr69AOVVzPlg+Tx8pXcKHNuqtmYcQ9RvhkYdCld0DMiyJFHZ+
         1AMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfQaaj1UpUmrk2MIuYb/SCQoc6iXIC0BLAFa6gnSs5Q=;
        b=QTwkjJhs/FqSoQy28wvU617VVTi2+pBcs9rxAoe2X3jWmNY7H+IyRyoXTLnAXa9nAc
         h0qIwxTeoihx9MXMREJD1KiRh8lYG7ZhP0chhENoMXBg6ESa6yqx6clUiuIl+L9EoBH9
         YlNWkgOgK2qyB8P/uOhXcA006CVchgYoKsFzxgs6xTVJQaMMK10ztUYNo4ABmvmps1Wk
         QF39HrCuNybGNNli56MrTq3pFrlqaQIAyPwY5LCiXc476rXSEGk/k8zZhNflwZ/X+/xW
         Ov7xclaYw5sNMg0ViXYHhFQtbhYP+5d5k8Vy0ytk3tdnLdr27IX1ZZSW3I4A/VWw4I8y
         jDMg==
X-Gm-Message-State: AFqh2kqRs+lj4KvTuiuZBEdMd+Vqus/HWsf/xaooWAPusUFVt3ZuPV8I
        R8z4xNPZukWQg3OYHxG1MCqX
X-Google-Smtp-Source: AMrXdXs1d4XXXoSLEd0uNOjVAPcUpVDmAQCXFCsAIX7GRJaOvsvzaeEZ1J9Vcj5lI6YkTXe6nrpmgw==
X-Received: by 2002:ac8:7648:0:b0:3a8:20e5:49bc with SMTP id i8-20020ac87648000000b003a820e549bcmr69083766qtr.41.1672945775727;
        Thu, 05 Jan 2023 11:09:35 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:64ab:8abc:361c:e8c7? ([2600:1700:e72:80a0:64ab:8abc:361c:e8c7])
        by smtp.gmail.com with ESMTPSA id a19-20020ac81093000000b003a4f435e381sm21848322qtj.18.2023.01.05.11.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 11:09:35 -0800 (PST)
Message-ID: <9bc96719-d6c7-a127-d80e-a42ecaa0803c@github.com>
Date:   Thu, 5 Jan 2023 14:09:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 06/11] bundle-uri client: add helper for testing server
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=c3=86var_Arnfj=c3=b6r=c3=b0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, mjcheetham@outlook.com,
        steadmon@google.com, chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Victoria Dye <vdye@github.com>
References: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
 <13e4c82e3380d8b91583550e61671bd8eac69ab1.1671722058.git.gitgitgadget@gmail.com>
 <Y68Sc3V5x6xSucZW@coredump.intra.peff.net>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Y68Sc3V5x6xSucZW@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/30/22 11:31 AM, Jeff King wrote:
> On Thu, Dec 22, 2022 at 03:14:12PM +0000, Ævar Arnfjörð Bjarmason via GitGitGadget wrote:
> 
>> +static int cmd_ls_remote(int argc, const char **argv)
>> +{
>> +	const char *uploadpack = NULL;
>> +	struct string_list server_options = STRING_LIST_INIT_DUP;
> 
> These two variables are initialized to NULL and empty respectively, and
> then not accessed until here:
> 
>> +	transport = transport_get(remote, NULL);
>> +	if (uploadpack)
>> +		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
>> +	if (server_options.nr)
>> +		transport->server_options = &server_options;
> 
> where neither conditional will trigger, since they will still be NULL
> and empty.
> 
> Is this function missing some argv parsing that would affect these? Or
> if it's not needed, would we want to remove them, like:

...

> Not a huge deal, but I noticed that Coverity complained about the
> uploadpack one because this hit 'next' (the server_options one I found
> manually, but it was kind of obvious when looking at the other).

Yes, removing these lines would be fine. Perhaps there were
uses for these in an earlier version that were dropped. But
we can remove them now and then add them back when they
actually connect to functionality.

Thanks,
-Stolee
