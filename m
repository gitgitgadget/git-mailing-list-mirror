Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35EDC433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 13:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB89222795
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 13:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgLDNkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 08:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgLDNkV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 08:40:21 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A0BC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 05:39:41 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id k26so6188660oiw.0
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 05:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=knymxKRyBjI7IPWVzU12tsvRCxCYDREKbEEcGM9MqGw=;
        b=XRFtVBkF8ko99nCc8dDApJeqo+/gRU8KDh29C+6vky6Xqr340i+UnnYDgCPr+8P/d+
         sDwYxYgGuzbl2koGz2nLMCFLPHMmTJHGw6esqmd14Y5CBcsmQOIwJ0VoYrARv6e7Mh+Z
         u97OKpsve7JVWqKlZ4tkHp+dQAyqIMvHsqUxkNoZ3Zj/4MgGcxsDnrr+fkDjUA/KsXzw
         m2KCkp9YzRJZ2UWrD98bR1BqhdQdOX/cNt/MQB/dlCn+p/Dytz2DidEROmjOmzxAf6P3
         Lly7dA3jtTytR7Tl+l/kB1as6OfglXoMOT+XecQvZCDATN9bjNfvuoBS8Q6XtlPJWqDD
         JByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=knymxKRyBjI7IPWVzU12tsvRCxCYDREKbEEcGM9MqGw=;
        b=WVZUJ6rXaeml3G8iMuyY5yvSb//u8qfF9q3zDYQJjqy6JTLtu3zr929XSfDqp3Tg1R
         cVvuzmRQq3KFAeegUb2OIIApcf+NxXpgzMVrS9D1qYiUXN7zLQlbLgLB8jojA655lCCw
         sq7rQ/Qde+X+LWfZL+OsTxxgOYYjjgBkeQpBkxdpPHUuFfGK0aXFNkYdIOiiSTS/gsR8
         DvD7WtpcH1RCEt9WrHEtCvF0+c4Xa+nXfzwovVCSA/EloWVny1BEDyx716ZXYOAvmDCe
         kWZTGTAy7gEjHlaNml6FKnwx9OKnplQNz7qGd0Xq+3IvXF7hYkB16BWUnRzOuZiYlX3w
         yZqQ==
X-Gm-Message-State: AOAM530VpSutq+EJFHyHHCHqKl7YWehx6SsdHCBEyTxwrlG1Wa4YPMT9
        p3WhjlmqzVPEarb7BHGxTfs=
X-Google-Smtp-Source: ABdhPJw7wydna6HCfmBMSyUL7udHCwmDhb+R5DPgfPC3Z3Hy8ItLLIk007eHevwIl6mPBNrZjg2ZsA==
X-Received: by 2002:aca:6103:: with SMTP id v3mr3242375oib.64.1607089180407;
        Fri, 04 Dec 2020 05:39:40 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id b25sm661629ooe.18.2020.12.04.05.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 05:39:39 -0800 (PST)
Subject: Re: [PATCH 05/15] midx: add entries to write_midx_context
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
 <491667de2baef422e801df1e2c7d3173462a96ff.1607012215.git.gitgitgadget@gmail.com>
 <xmqqim9ih8hz.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f9ca5bd8-3a7a-232b-f038-3311087d60f1@gmail.com>
Date:   Fri, 4 Dec 2020 08:39:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <xmqqim9ih8hz.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/3/2020 4:42 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> -static size_t write_midx_oid_lookup(struct hashfile *f, unsigned char hash_len,
>> -				    struct pack_midx_entry *objects,
>> -				    uint32_t nr_objects)
>> +static size_t write_midx_oid_lookup(struct hashfile *f,
>> +				    void *data)
>>  {
>> -	struct pack_midx_entry *list = objects;
>> +	struct write_midx_context *ctx = (struct write_midx_context *)data;
>> +	unsigned char hash_len = the_hash_algo->rawsz;
>> +	struct pack_midx_entry *list = ctx->entries;
> 
> I know this is meant to be a faithful rewrite, but can we lose this
> "length of the hash function output must be smaller than 256"
> imposed by "unsigned char" at some point, perhaps after this series
> settles?  .rawsz field is size_t IIRC.

There's no reason why this should be "unsigned char" except that
I was probably thinking about the "hash version" byte in the
header when I added this line. Clearly there isn't a failure (yet),
but it's better to be safe.

Thanks,
-Stolee
