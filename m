Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235231F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 15:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfJUPOL (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 11:14:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39706 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbfJUPOK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 11:14:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id t8so3990851qtc.6
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 08:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5KabIakURM5ZTjw0sQhrMP3lye5GsdCYTXAaal9H3Bw=;
        b=S6r3KLaB1vQL8cctLwfGDyVZJRi7hJRoZaQXY4rvSrEDj4a87h6vvvZTPNUoI3UfNQ
         nD+IQM2GxLNOym6L9+VMX7Z0xO3JvJIR8blyKGIB7pgLPseAWdvDUHMd2Q5v1HaN7HCU
         YHAFJuqw15H5YVfagjmiOO1cO59lC7U2Eqi4QdQLH7UWAJUyxTXxA2JMkqsDDn/ZYjz4
         IELGBoAGNLZjR5bORLUcFZEPTrSj9eWGNlbNrcInL9eZk3GDGboZbaxV4FPaOmhyeBuR
         MhVsHcwazsDU8IxU9+TIRtn7KHdA29MckeWRrQUZSsR5O+J7bZA96seB1j97MiYrrZIJ
         CtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5KabIakURM5ZTjw0sQhrMP3lye5GsdCYTXAaal9H3Bw=;
        b=CFmP57hV9/4L8EWbvwhtBIod2pKwEsKKjMb1epNFNMU9ZRrBGI8dslEjkktEmrs3el
         /4dlvgESF//v7m4whjMQPILb82T6cvathq6dTc6NcoJOtmM7E52IUy2gIYEeJ8yxDnYv
         bL8DTG/tCa/oPwgBmbG2N4yXPm3sQErbz0C3CINqSsdG4rLSv0fk1bkiMNPLQtXv/RME
         RU6FWuUBFKdjA2LaUNRlsinowuLixq8krIcNldW+IeD5w9hj7Pa5uZRVaEQKg6DdNNq1
         25hajBNYBxli1k7C417Ewpy3edzwQz+KDF1t6OxEvddV66l9aLz/TTuaoVqvIEpv7mxa
         fqtQ==
X-Gm-Message-State: APjAAAV3tyyw0M5Mn1pHBz7qI307eAKEHaLhrpDrREMKcdNuD1SIHupW
        eyHUbNr66dPm3rPmdbVyzV0=
X-Google-Smtp-Source: APXvYqxTL/6AaryAhIQ4g5SjqhQYQoo3+WDl6avISPvAHqEXrP8jAOEv9Shs0uUiGUlAD1jXrIZ75g==
X-Received: by 2002:a0c:e708:: with SMTP id d8mr10879078qvn.225.1571670849768;
        Mon, 21 Oct 2019 08:14:09 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4018:ebea:d287:d7b3? ([2001:4898:a800:1012:f14b:ebea:d287:d7b3])
        by smtp.gmail.com with ESMTPSA id w45sm10768839qtb.47.2019.10.21.08.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 08:14:09 -0700 (PDT)
Subject: Re: [PATCH v5 13/17] read-tree: show progress by default
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <a229e1ee0cb96c5f8c2c5d430641c386bc082a2d.1571666187.git.gitgitgadget@gmail.com>
 <3de0f590-c75c-2470-232f-73a07876df88@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <857e23df-c447-7297-df74-3546424386d9@gmail.com>
Date:   Mon, 21 Oct 2019 11:14:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <3de0f590-c75c-2470-232f-73a07876df88@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/21/2019 11:04 AM, Phillip Wood wrote:
> Hi Stolee
> 
> On 21/10/2019 14:56, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The read-tree builtin has a --verbose option that signals to show
>> progress and other data while updating the index. Update this to
>> be on by default when stderr is a terminal window.
>>
>> This will help tools like 'git sparse-checkout' to automatically
>> benefit from progress indicators when a user runs these commands.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   builtin/read-tree.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
>> index ca5e655d2f..69963d83dc 100644
>> --- a/builtin/read-tree.c
>> +++ b/builtin/read-tree.c
>> @@ -162,6 +162,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
>>       opts.head_idx = -1;
>>       opts.src_index = &the_index;
>>       opts.dst_index = &the_index;
>> +    opts.verbose_update = isatty(2);
> 
> I'm slightly wary of changing the output of plumbing commands like this. If a script wants progress output it can already get it by passing --verbose. With this change a script that does not want that output now has to pass --no-verbose.

If a script is calling this, then won't stderr not be a terminal window, and
isatty(2) return 0? Or, if the script is run with stderr passing through to
a terminal, then the user would see progress while running the script, which
seems like a side-effect but not one that will cause a broken script.

> If 'git sparse-checkout' wants progress indicators why not put the isatty() check there and pass the appropriate option to read-tree?

It is not necessary for the sparse-checkout builtin by the end of the series,
as the extra process is removed and unpack_trees() is called directly. However,
it does seem like a helpful user-interaction for people still using the "old"
way of interacting with the sparse-checkout feature.

Thanks,
-Stolee
