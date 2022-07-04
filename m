Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D438C433EF
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 13:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiGDNFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 09:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGDNFI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 09:05:08 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF9CC2A
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 06:05:07 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p69so8566712iod.10
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=igkA0DdSsjm7zBShPQJI7jVc9T10lcUHK7GLf05tevg=;
        b=MGqaQRFhXCZ+ld/LMeBCjOY2YOSwdbjSy6PhbCdgBU8HkmSXXySuBZtgwVCfkwTizH
         CnwctXsd3WFZn3HfkeI0jDi9ppAlZkI/aUqljW/kDnojSsVPkHn9/oUj4Xk0Ir2cgnSh
         Tyi4TX7XaI2pkfwmSsa//D8jm7peOPC1eVbayJCmRUE/+yrWs2M5th980HzDjA1hoL3i
         QSNH5Uzm7iaz7eJsTcXZBJBjtsYRrL1fl+t/tMvimsTU1pApgZcPTq5gvVzrRY6R//iN
         gcHhFuTTiV3QBcTXeHtIyKAmEhgbsfv3K1DMBMpBn2G1OPZNMNZDnvh6kDozoIn361bP
         6V/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=igkA0DdSsjm7zBShPQJI7jVc9T10lcUHK7GLf05tevg=;
        b=ZOda6YUTyRA0Vy8BSv81VPowC69mtn55bctMJDOGrP83yMkAY9+7SdATvFH6BIFzVR
         UqptfzrC8CGe91mZFv36WBKhrq2AAC30TFamivyw8ushNcppnkxeF8gyUkwEDXSZpDBf
         fxNjHrujrwAD6eDERJoVYOVqJZCvJjYDz9xnStkflG3adyBuM9GI7S5N5q/7mivWqm0O
         lWLuIKx6nBnDUbFb6Mrfnqzp7ApHg9Mz6djz4MFMI5zVvFtkWJgDxXPaWj0IHue1TfhX
         l+lYEpZBlsIrjod2+ny/woB/PWA3TbnHkwNTSjqCkK8f/+Qttxwfj9A/50u5ceN6CXrA
         yhvA==
X-Gm-Message-State: AJIora+PhRLq4oiPUbQaz/dOJRysPuLiarw8zSM0GNm4Ya/M7PHRYCWm
        lXIqRy59xv8BTIdFQX88VGKp
X-Google-Smtp-Source: AGRyM1vLMgv7Lgrcn2m4QRbH2E8wADTLs4HK/zJuiqBvN/xx6gB9+Rwnbx8/F15oVmrxLdT3fbrdKQ==
X-Received: by 2002:a02:cdc5:0:b0:339:cca1:8d3f with SMTP id m5-20020a02cdc5000000b00339cca18d3fmr17762031jap.53.1656939906471;
        Mon, 04 Jul 2022 06:05:06 -0700 (PDT)
Received: from [192.168.103.184] ([4.1.157.141])
        by smtp.gmail.com with ESMTPSA id f17-20020a056638113100b003314830ab40sm13536020jar.6.2022.07.04.06.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 06:05:06 -0700 (PDT)
Message-ID: <5002269d-5cab-3ba4-b99e-dca0c3615118@github.com>
Date:   Mon, 4 Jul 2022 07:05:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v3 7/8] rebase: update refs from 'update-ref' commands
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <72e0481b643e98c5670eee0bf5c199c4fb693b16.1656422759.git.gitgitgadget@gmail.com>
 <CABPp-BG++8LAwyH6P-QDj5Lu6-cevOBOjpdY7QsSdwiT0w9URA@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BG++8LAwyH6P-QDj5Lu6-cevOBOjpdY7QsSdwiT0w9URA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/1/22 5:18 PM, Elijah Newren wrote:
> On Tue, Jun 28, 2022 at 6:26 AM Derrick Stolee via GitGitGadget

>> Not only do we update the file when the sequencer reaches these
>> 'update-ref' commands, we then update the refs themselves at the end of
>> the rebase sequence. If the rebase is aborted before this final step,
>> then the refs are not updated.
> 
> Why update with each update-ref command?  Couldn't the values be
> stored in memory and only written when we hit a conflict?

I think that is a natural way to optimize the feature. I didn't
look into that option as it seemed more error-prone to me. I'd
be happy to be wrong here if an easy tweak makes this possible.

>> -static int do_update_ref(struct repository *r, const char *ref_name)
>> +static int write_update_refs_state(struct string_list *refs_to_oids)
>> +{
>> +       int result = 0;
>> +       FILE *fp = NULL;
>> +       struct string_list_item *item;
>> +       char *path = xstrdup(rebase_path_update_refs());
>> +
>> +       if (safe_create_leading_directories(path)) {
>> +               result = error(_("unable to create leading directories of %s"),
>> +                              path);
>> +               goto cleanup;
>> +       }
>> +
>> +       fp = fopen(path, "w");
>> +       if (!fp) {
>> +               result = error_errno(_("could not open '%s' for writing"), path);
>> +               goto cleanup;
>> +       }
>> +
>> +       for_each_string_list_item(item, refs_to_oids)
>> +               fprintf(fp, "%s\n%s\n", item->string, oid_to_hex(item->util));
> 
> Here you are storing the ref and the new oid to move it to.  Any
> reason you don't store the previous oid for the branch?  In
> particular, if someone hits a conflict, needs to resolve, and comes
> back some time much later and these intermediate branches have since
> moved on, should we actually update those branches?  (And, if we do,
> should we at least give a warning?)

The branches don't move forward because other Git processes respect
the update-refs file (this does not take into account third-party
tools that don't know about that file, but we need to start somewhere).

You're right that storing the old value would help us in this case
where another tool updated the ref while we were in the middle of the
rebase. The storage of the null OID is only to prevent writing over a
ref when the user has removed the 'update-ref <ref>' command from the
todo-list. It's probably better to remove the ref from the list when
that happens.

>> +       if (!found) {
>> +               struct object_id oid;
>> +               item = string_list_append(&list, refname);
>> +
>> +               if (!read_ref("HEAD", &oid))
>> +                       item->util = oiddup(&oid);
>> +               else
>> +                       item->util = oiddup(the_hash_algo->null_oid);
> 
> Seems a little unfortunate to not use a cached value from the latest
> commit we picked (and wrote to HEAD) and instead need to re-read HEAD.
> But, I guess sequencer is written to round-trip through files, so
> maybe optimizing this here doesn't make sense given all the other
> places in sequencer where we do lots of file reading and writing.

It's also possible to optimize several things, but I tried to
minimize the amount of change to the existing methods. This is
my first foray into this part of the code, so I don't always know
which information is readily available. I appreciate your attention
here.

Thanks,
-Stolee
