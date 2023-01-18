Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82751C38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 17:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjARR2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 12:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjARR2w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 12:28:52 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C32821A0D
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 09:28:51 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 7-20020a17090a098700b002298931e366so2877462pjo.2
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 09:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vL+1REH1Wc0552BAok9IqrS1cDmxT7lB5uVZjljrq3I=;
        b=eAfDiTKWdcLHEZjsjFif82FcBWNlHCuleN+xcz2YI2/Sgwkpz7jmJQHME7IlpHB6oa
         VZh5SeYceEXnSndu2eyjFq6Rrp4fVkRsyD2I1it/aclONSVcrrFOWJSxjRveFoE14AV6
         AUwS/S4O9zZK7F+6HCXkNHwK8j6t+AN2XVwV0nbkQViNYTvuW6e22Tf+Pw798m8oPuQ1
         knLUg/t+myRqUe2vAIzo3qY45wYhZTXIaohs3u5iAgi63MSsVOLGhcH1aRLdP50uaXM0
         iXzGbWTdbc9BXTT9JXq0k/WN7A/Dl/ZzBeoktj0+0nNdDMFhEjHbZCClNdjbYjlQF7aO
         SxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vL+1REH1Wc0552BAok9IqrS1cDmxT7lB5uVZjljrq3I=;
        b=AsMBmj+BLmPxxC1k/qKvTNr2xvCGkHV+zLdwKt5Fcdm+Nv3HbkAV9OOLGFJhgNAaId
         RIBfSy9+Ms/4sA7CH4uSOEEcnjSHWRWti5x82Zs7u/eZkaJmJnoa2CanE4k97J8o3oun
         lwQrfCCKQXPEQBj9w327KdSkDFO2632XGJS4DZ1cc6ygA6JmU5+Of1o8TxINxr62mef4
         O1t9DeIdPdo1d7ECpKoP8/JzVxuT8IbHeQjPN241v7eWj8eca2cnHomd2ktGzXW6cO+D
         Hd1hbxql1BNqtHtVTXqJigjSs3Uzog4pyoqmtCvcF6Nv4PNn92/da0kaWfxb83JlvLK2
         EYiw==
X-Gm-Message-State: AFqh2koqlE+cgKQ0eta0qa7biBe0ILDj0uwhGuwGXGe3zUhnTDSqSc4m
        AGzmS6QLXnG+JCrtqsTIvXeLLDyYAqjcEDU=
X-Google-Smtp-Source: AMrXdXtv27DAsr3SVa3xIrdNpacz6VEIdRylmq42KdEe2XUWpOrzWtVR++nJvaGytE4SbDvFXOVoLA==
X-Received: by 2002:a17:902:efd4:b0:194:5ee5:3c44 with SMTP id ja20-20020a170902efd400b001945ee53c44mr26822407plb.17.1674062930529;
        Wed, 18 Jan 2023 09:28:50 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id z1-20020a170902ccc100b00192a8d795f3sm23366629ple.192.2023.01.18.09.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 09:28:50 -0800 (PST)
Message-ID: <aa8abc8d-284b-b87e-f594-27ee40cc4bec@github.com>
Date:   Wed, 18 Jan 2023 09:28:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v6 10/12] http: replace unsafe size_t multiplication with
 st_mult
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <cc9a220ed1f12aef2f4df940e71adc1fad917a6b.1674012618.git.gitgitgadget@gmail.com>
 <230118.863588xeat.gmgdl@evledraar.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <230118.863588xeat.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Jan 18 2023, Matthew John Cheetham via GitGitGadget wrote:
> 
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>
>> Replace direct multiplication of two size_t parameters in curl response
>> stream handling callback functions with `st_mult` to guard against
>> overflows.
>>
>> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
>> ---
>>  http.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/http.c b/http.c
>> index 8a5ba3f4776..a2a80318bb2 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -146,7 +146,7 @@ static int http_schannel_use_ssl_cainfo;
>>  
>>  size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>>  {
>> -	size_t size = eltsize * nmemb;
>> +	size_t size = st_mult(eltsize, nmemb);
>>  	struct buffer *buffer = buffer_;
>>  
>>  	if (size > buffer->buf.len - buffer->posn)
>> @@ -176,7 +176,7 @@ curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
>>  
>>  size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>>  {
>> -	size_t size = eltsize * nmemb;
>> +	size_t size = st_mult(eltsize, nmemb);
>>  	struct strbuf *buffer = buffer_;
>>  
>>  	strbuf_add(buffer, ptr, size);
> 
> This is a really worthwhile fix, but shouldn't this be split into its
> own stand-alone patch? It applies on "master", and seems like something
> that's a good idea outside of this "test-http-server" topic.

While it's this change *can* stand alone, please keep in mind that
suggestions like this (recommending a series be split and resubmitted) can
be highly disruptive to the in-flight topic and the original contributor.

Monitoring and iterating on multiple series at once is time-consuming for
the contributor and reviewers, and often (although not in this case) it
creates a dependency of one series on another, which comes with a cost to
the maintainer's time. Not to say those recommendations should never be made
(e.g. in a clearly too-long series early in its review cycle, or when
certain patches lead to excessive context switching while reviewing), just
that they should be made more carefully, with consideration for the time of
other contributors.

So, with that in mind, I don't think this patch is critical enough to
separate into an independent submission, and (subjectively) it does not
disrupt the flow of this series.

