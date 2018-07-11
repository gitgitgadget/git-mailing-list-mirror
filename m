Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1BD01F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 21:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387457AbeGKV6o (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 17:58:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37761 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbeGKV6o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 17:58:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so19611748wrd.4
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 14:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=aeRxTuzRvNBhyeXqGV8m2oaq1dqVlrYnWldQ0TAJyx8=;
        b=mKO9cprSDOSxl+dqUVWqZWVGg0bL6jnkQn+yhzXSNUY7KAECdmHqs9IurG2P3j8Ynd
         4T6l5AuI2qLvGP2zSi1L7ZthTTnEKMbYaJo022HiEY5SbmYDBO1OaRoAGCIYuj7HAWGx
         dIeVA2R3mozUbzjttgl0Qv3HCg4ivn3cNjCsCj/9YhZNCb9UiKLCsxFXBYUYuE20wvSW
         dNwLRHWqcOs8NDlSono9DighPO6KWEw41r/laP0UP1HY0RjWong/JAUSnk7d4loAvN5U
         v6rj9Tr2gsCJuVOX2ob4uWzRHl8p3ByxRsXWwsvdSonUwQWOngIYbbYe5CTx+njQKC1Y
         zUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=aeRxTuzRvNBhyeXqGV8m2oaq1dqVlrYnWldQ0TAJyx8=;
        b=h6yG1/r56k6ZMfiH5n5prEpDsL481iM/jVGQnYP03MDpuH1zhAk2qCQQri7DELA44i
         gilVjY5K0mnT94hzrtSelX+UYBWPHvd/R0rz43gDvQ4qP23awesKDl6ej/AYb3VO2lru
         62mg/xGRf4DPs3UJkAjbWxzYImApAcbX4mtL8nOHSqJ2TqK/tTFrkkNFQUFl/+3Ft3Fa
         V0HbprMsPZDBlzl6Ozoor35afAqsopVUIBnG+xqctsQWeX7AR+1ZqMKqXGu4SIOLIfD6
         WXZPI+pR3wNVDojHKlqtn7NAN4GZrJn0usxZ6QQpP/lc73e9h9HAIAwhR7cs9fvnt96U
         J3yA==
X-Gm-Message-State: AOUpUlGMsM6B697hWkI2oQ123dtjEFhz2oNZFqV2k9eTHFQ2rr4eTifC
        iBSAyTNwWvaA9kXzrVmyvs0=
X-Google-Smtp-Source: AAOMgpeseuQdGm/9RwZ8Z2FyU+ChWIPb6qNFabDjWDMBxyZ8HDJ9/LQ+vw5A9tqD+8cLhuiFw3sAFg==
X-Received: by 2002:adf:b815:: with SMTP id h21-v6mr247903wrf.40.1531345941549;
        Wed, 11 Jul 2018 14:52:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s124-v6sm3256170wmf.47.2018.07.11.14.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 14:52:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/3] rebase --rebase-merges: add support for octopus merges
References: <pull.8.git.gitgitgadget@gmail.com>
        <03d0907ec61f0ea53b59659c84b8a6662e9e7607.1531312689.git.gitgitgadget@gmail.com>
        <CAPig+cS1KQseynMCGC_6FZwzB0waJX8+C7CVKNqACzOhjB4uSg@mail.gmail.com>
Date:   Wed, 11 Jul 2018 14:52:20 -0700
In-Reply-To: <CAPig+cS1KQseynMCGC_6FZwzB0waJX8+C7CVKNqACzOhjB4uSg@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 11 Jul 2018 14:49:03 -0400")
Message-ID: <xmqqfu0p1luz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> diff --git a/sequencer.c b/sequencer.c
>> @@ -2932,7 +2966,8 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
>> -                       strbuf_addf(&buf, "Merge branch '%.*s'",
>> +                       strbuf_addf(&buf, "Merge %s '%.*s'",
>> +                                   to_merge->next ? "branches" : "branch",
>
> Error messages in this file are already localizable. If this text ever
> becomes localizable, then this "sentence lego" could be problematic
> for translators.

I do not think we'd want to localize these default merge messages,
though.

>> @@ -2956,28 +2991,76 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
>> +               cmd.git_cmd = 1;
>> +               argv_array_push(&cmd.args, "merge");
>> +               argv_array_push(&cmd.args, "-s");
>> +               argv_array_push(&cmd.args, "octopus");
>
> argv_array_pushl(&cmd.args, "-s", "octopus", NULL);
>
> which would make it clear that these two arguments must remain
> together, and prevent someone from coming along and inserting a new
> argument between them.

A valid point.  It is OK to break "merge" and "-s octopus" into
separate push invocations, but not "-s" and "octopus".  Or perhaps
push it as a single "--strategy=octopus" argument, which would be
a better approach anyway.

>> +       (GIT_AUTHOR_NAME="Hank" GIT_AUTHOR_EMAIL="hank@sea.world" \
>> +        git merge -m "Tüntenfüsch" two three) &&
>
> Unnecessary subshell?

Right.
