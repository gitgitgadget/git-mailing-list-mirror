Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644E0C7EE23
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 13:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjFENWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 09:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbjFENWr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 09:22:47 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5B2DB
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 06:22:39 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bad05c6b389so6062028276.2
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 06:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1685971358; x=1688563358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lGVXshxvxNWitLkPyl1In1DlRor4jHzldmxmrK8HxeU=;
        b=NNTwE5q25IcZ46q7xUi/cGrebQWmHmgyt2clEu0e0zbaaxvl5OPB6Lhkct2/QhQHAr
         JPhb2awM/fdkzRzQU67kew+PHnppWFcnzr6hJEGa5sOG9DSCDl5jHZ9NBWItaEd3CgRm
         thgaujl6/1ofwqW6ylWT3kvs6zQuAito+uCe/w2zzMwBUb/uukuM/Lb21mvvr32blzU/
         bP+l5oeANvT6vFsL91wYouMNC3qk7t14O2QLAqP1AXDKtV3QFiIHeoKgDaflHfaSk6Ob
         Vg5wLkQt0KVkVet3c9pW5elJA24DAaBHp1VA1uT1bLGs9PB7loG3ibLPhsP4ImvXKmDZ
         MMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685971358; x=1688563358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGVXshxvxNWitLkPyl1In1DlRor4jHzldmxmrK8HxeU=;
        b=UKeZ5wfAkXp/D4v2YUh8O8YpeuDPncxnGpLvUCtHx8ahVN56TwyiFBkzbgwuKzNifV
         TU5Z/+6mW487WKNySOosniZ6JB77lcSryvKF0zf/I+NQydMdrHsurGqD8uYvp6ZdFlto
         gwyfCdbZBTxTX8To19BcktA0EK30yByrJPdV23hlCDCFhSwA1BRX33WDsvjmFfqmBm/r
         TEySY8rgnqlHBwN/MeNpIb/+KGwJgqcYHSeCVn7Vlx3OXKUD6/YNtjwiszZhdU8lbEi1
         bqGax1T8GDWe0+yaNc2jAB5pOGbQVMPf0KTN9rlbrsNdYcbGuQQOCx7w1wMDnsm1xMb5
         KJ8A==
X-Gm-Message-State: AC+VfDyErv11fPSMDQcpnQQbq3xvMDa2kTJVEWLuUdDjmQRAvh1cJGC0
        Dymek9acW136hEESZRdJobSR6wqx0hIOx1K4vw==
X-Google-Smtp-Source: ACHHUZ4j8TzxWkhPxACeHhjdSOoUFqT9hGtBWYoOX2t3DF9TE0NHuchK5aKiBRhp/Iu5tyw4xIuWcw==
X-Received: by 2002:a25:2cb:0:b0:bac:14a5:ca7b with SMTP id 194-20020a2502cb000000b00bac14a5ca7bmr11622463ybc.30.1685971358204;
        Mon, 05 Jun 2023 06:22:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6cc2:3d2c:f002:d37d? ([2600:1700:e72:80a0:6cc2:3d2c:f002:d37d])
        by smtp.gmail.com with ESMTPSA id a35-20020a25ae23000000b00b8f13ff2a8esm2590246ybj.61.2023.06.05.06.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 06:22:37 -0700 (PDT)
Message-ID: <0a8ab05c-f57e-8d88-30cb-3d979e65d148@github.com>
Date:   Mon, 5 Jun 2023 09:22:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/3] replace-objects: create wrapper around setting
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     vdye@github.com, me@ttaylorr.com, newren@gmail.com,
        gitster@pobox.com, Jeff King <peff@peff.net>
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
 <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
 <0831e7f8b5e23d0af68aa55d66e0cd745ced1e22.1685716158.git.gitgitgadget@gmail.com>
 <a1967c58-48c5-6ae0-f60a-2d8c107f8f66@web.de>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <a1967c58-48c5-6ae0-f60a-2d8c107f8f66@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/3/2023 2:22 AM, René Scharfe wrote:
> Am 02.06.23 um 16:29 schrieb Derrick Stolee via GitGitGadget:
>> diff --git a/replace-object.c b/replace-object.c
>> index ceec81c940c..cf91c3ba456 100644
>> --- a/replace-object.c
>> +++ b/replace-object.c
>> @@ -85,7 +85,14 @@ const struct object_id *do_lookup_replace_object(struct repository *r,
>>  	die(_("replace depth too high for object %s"), oid_to_hex(oid));
>>  }
>>
>> +static int read_replace_refs = 1;
>> +
> 
> This breaks compilation:
> 
>    replace-object.c:88:12: error: static declaration of 'read_replace_refs' follows non-static declaration
>    static int read_replace_refs = 1;
>               ^
>    ./replace-object.h:14:12: note: previous declaration is here
>    extern int read_replace_refs;
>               ^

Thanks for finding this issue within the patch. The removal of the global
should have happened in this patch, but I missed it when adjusting things
for this version.

> And this variable is still referenced in two more places outside this
> file, which won't work now that it has become static (file-scoped):
> 
>    $ git grep read_replace_refs
>    builtin/commit-graph.c:extern int read_replace_refs;
>    config.c:               read_replace_refs = git_config_bool(var, value);
>    replace-object.c: * references, regardless of the value of read_replace_refs.
>    replace-object.c:static int read_replace_refs = 1;
>    replace-object.c:       read_replace_refs = 0;
>    replace-object.c:       return read_replace_refs;
>    replace-object.h:extern int read_replace_refs;
> 
> Perhaps postpone adding "static" to patch 3?

You're right that this won't work unless we fix the config-parsing code
already here, so I should move the introduction of the static global until
patch 3, as you suggest.

Thanks,
-Stolee
