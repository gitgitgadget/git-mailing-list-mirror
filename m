Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC62C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 12:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiJYMfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 08:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiJYMe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 08:34:57 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0F014FD26
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 05:34:55 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id i65so10187078ioa.0
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 05:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oH1zjBU3A6Ly9UJMT8SUc8P1g3pW0xHsbScExzbe4jI=;
        b=cB2q+CHm7qhL+pewy41cvMsDo8nNv1QPAivM5RbG4U2Tj2eSGhsFoEk7lR2mK+H2TO
         pZhOIL4s3j1AyDUuG1bgKYmnG5eOcaSCUd3fe52KGukCKa2XiIPgkdsZFHmmfPLq4sLd
         2LFYbeivjHUTuZ2XNFUfcKDccXxH8MdiIMyPHd+f60Qf9xox7Ct7+5g5PONXKIRzOWOJ
         xCy43lc+AGFcLcmPXTKX5AiVH1WGbYTVC/uRJEONaJW7jg7iuommSj7YXTxvm1LFfBXT
         Uc7E5XIwS43tMrUf119r+xbnmv+Bv4d5Azrb4Eqet82PY/K4yvmM+5/iIGipHbltwKOD
         9WSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oH1zjBU3A6Ly9UJMT8SUc8P1g3pW0xHsbScExzbe4jI=;
        b=35snpWTWofx+u2y14k5/naBIUBrZGBOu/Jdjndt/Zb38AwLPrSfcAIKXkXAs4cUqQO
         Ur/rpg+6Mn5fI+DreDk0ZmtQCOcQlXvhAhf+O5kP1R73+4j0HquhUZatZqNyTiGFNh2v
         Oea6CtWdtPirJD7mPnSQd+8tBUJd49XfLQGsY7LJVvfwr/2zy/TlzJpMcEkoYaQ0milb
         HP6e8JOys4WShbQ7GSU664EXUtFJnyh1fhVjAJYhlLEXwCN7dituKqvUvDFuUvaisc98
         qDO4aH7SrhNft510N015YlGEuEPRpd5odFEUv7seoG5eHGEZCItkJkIT63Am5g0xF6c9
         gwGA==
X-Gm-Message-State: ACrzQf1IyVQVveBGPvCNVxFf/iyQ4qqKfcsONoVJxEV5wejUlmRSLYx2
        piycAF8StI18q6s8Jz7OjPHA
X-Google-Smtp-Source: AMsMyM6NVJF5WzlE/RaAiljNRJTb5AChi1ePlDi/2mfkqCbE1LzoWFEmao1sbYDtkgagQ94rD/N7DA==
X-Received: by 2002:a05:6602:15d2:b0:6bc:7aaf:8e1c with SMTP id f18-20020a05660215d200b006bc7aaf8e1cmr22041877iow.14.1666701294368;
        Tue, 25 Oct 2022 05:34:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:880d:bbf9:8364:e715? ([2600:1700:e72:80a0:880d:bbf9:8364:e715])
        by smtp.gmail.com with ESMTPSA id y10-20020a056602178a00b006bbe7f012b9sm1063936iox.8.2022.10.25.05.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 05:34:54 -0700 (PDT)
Message-ID: <c9e90df3-6f70-6422-00db-beb7afda0439@github.com>
Date:   Tue, 25 Oct 2022 08:34:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 3/3] glossary: add reachability bitmap description
Content-Language: en-US
To:     Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <ttaylorr@github.com>
Cc:     GitList <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
 <20221022222539.2333-1-philipoakley@iee.email>
 <20221022222539.2333-4-philipoakley@iee.email>
 <CAPOJW5zmYC9q8+aXh9-kZnvT28GQ1ud3LenFi9qxV4DVdCWKxg@mail.gmail.com>
 <xmqq1qqxuqf0.fsf@gitster.g> <746491f4-fb41-92fe-7360-20a845dc21fc@iee.email>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <746491f4-fb41-92fe-7360-20a845dc21fc@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/24/2022 5:23 PM, Philip Oakley wrote:
> On 24/10/2022 17:39, Junio C Hamano wrote:
>> Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:
>>
>>> Small correction here - A repository may have multiple bitmaps (one
>>> for each selected commit from the preferred packfile or a
>>> multi-pack-index) but it can have only one ".bitmap" file (as of now).
>>> Bitmaps for the selected commits are stored in that ".bitmap" file.
>>> So I think the below lines (or similar) will work  -
>>>
>>>     The bitmaps are stored in a ".bitmap" file. A repository may have
>>>     at most one ".bitmap" file. The file may belong to either one pack, or the
>>>     repository's multi-pack-index (if it exists).
>>>
>>> Feel free to rephrase it accordingly.
>> Sounds good to me.  Or Philip's original can be tweaked minimally to
>> say "... may have at most one bitmap file (which stores multiple
>> bitmaps)".
>>
> Thanks both. I'll tweak the description in a day or so to allow Stolee
> to comment if required.

I added my comments about the commit-graph file, and agree with
Abhradeep's suggestions here.

Adding Taylor as a possible reviewer, too.

The one thing I will say is that there can be multiple .bitmap
files, but Git will only use one of them. Not sure if that is
worth being pedantic about here, though.

We'll need to keep this glossary section in mind in case things
change (such as "at most one bitmap file").

Thanks,
-Stolee
