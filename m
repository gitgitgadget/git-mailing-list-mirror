Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 211CC20248
	for <e@80x24.org>; Sat, 23 Feb 2019 20:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfBWUKq (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 15:10:46 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39635 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfBWUKq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 15:10:46 -0500
Received: by mail-ed1-f68.google.com with SMTP id p27so4534840edc.6
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 12:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=DnL3r/Dke0G6+k4exTI4JooGCP+wkwzYUhLzFxL4wa4=;
        b=Egq1XgbbDWkzAEtM8h7V2TVGg1tWBoYtDtrtq30zsRoBtzdW44FDU7dhNApa3MNyFg
         O8zCxx+ie7ay8ZblN+hIs51N5LlCETlNp0ZyzEFADUDz0Rt+YDiYgU/Th4RsUgA60zvP
         Kr1TIuL6wJHgyes3BOsEJQxlmQaJhsqqNHPHibFqnQ9GORfnwpLekDmkcY4OvX0EFcy5
         uog/n3SnTXPavl2dXfykOmCPlFihVylH4TQB3z+1CqdF27cMQ51tM+2M6ZRyBXATpwhU
         YV6x2+jtg2Sy8AEbsheGySkJA9sNNCG15CuvbY7L+tAhaZ6YLj84RBFNKZdeSeDnhKzr
         J21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=DnL3r/Dke0G6+k4exTI4JooGCP+wkwzYUhLzFxL4wa4=;
        b=CwrSJsIxfTo4s7mgzvVzmAnGpZL3AzjJ9wYWkH1TrCpR3qeCdu9mtmYfX1u9ArHO3B
         iE0CN3238oO6dvmQA6c+p405BTvEYNA39veZMq1yMiBR3g61WESqiMHhkrBloOwwfNpk
         CvHhRS86Jzu/dG676bb9qLsjcFXTyanPZsg46K6uSgRHuOn7D6xi6uCkG82O7teicAsu
         5d7KQLxIwmwQ54QQHqnr4S8qaI/mbreo22J76xo9qPkDpZTMR0OCUNdeOiWcHNPMBIAo
         uTT6atg4Y4ZTi8/OZJHec0TEIe3ZK9HdlWY06+khusQ297fQbmaRXbwyPKx8e3lnXOs6
         y6rQ==
X-Gm-Message-State: AHQUAuZpHJzD50HFPdVSEcBAkTpuUqxUUkOFaVeor9LS75JiMEOdVBlE
        nsTXCCK6B4dg8ymGyR8A5x0=
X-Google-Smtp-Source: AHgI3IbBJOlNlaiEGGRUmHDb9PwuVHOiaRc6sIdUz50CMYM2nj3yMk+5sU/7zJ3cB8GAoJ0I+1xnJg==
X-Received: by 2002:aa7:df8b:: with SMTP id b11mr8270455edy.166.1550952644266;
        Sat, 23 Feb 2019 12:10:44 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id k16sm39159ejd.13.2019.02.23.12.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 12:10:42 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC][PATCH 0/3] clone: convert explicit dir traversal to dir-iterator
References: <20190223190309.6728-1-matheus.bernardino@usp.br> <CAHd-oW7iLZq+fE-q2gGmPBPHSqAyz=YyecsdHkcYAoACxGfY1A@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAHd-oW7iLZq+fE-q2gGmPBPHSqAyz=YyecsdHkcYAoACxGfY1A@mail.gmail.com>
Date:   Sat, 23 Feb 2019 21:10:41 +0100
Message-ID: <87wolq4666.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 23 2019, Matheus Tavares Bernardino wrote:

> On Sat, Feb 23, 2019 at 4:03 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
>>
>> Add pedantic option to dir_iterator_begin at dir-iterator.c and convert
>> explicit recursive directory traversal at copy_or_link_directory
>> (builtin/clone.c) to the dir-iterator API.
>>
>> This is my microproject for GSoC 2019. Idea taken from
>> https://git.github.io/SoC-2019-Microprojects/#use-dir-iterator-to-avoid-explicit-recursive-directory-traversal
>>
>> Build: https://travis-ci.org/MatheusBernardino/git/builds/497512561
>>
>> Matheus Tavares (3):
>>   dir-iterator: add pedantic option to dir_iterator_begin
>>   clone: extract function from copy_or_link_directory
>>   clone: use dir-iterator to avoid explicit dir traversal
>>
>>  builtin/clone.c      | 72 ++++++++++++++++++++++++++++----------------
>>  dir-iterator.c       | 23 ++++++++++++--
>>  dir-iterator.h       | 16 ++++++++--
>>  refs/files-backend.c |  2 +-
>>  4 files changed, 81 insertions(+), 32 deletions(-)
>>
>
> Sadly, I forgot the v2 tag, but this is a v2. Should I resent the
> series with [PATCH v2 ...] or is it ok?

It's fine. No need to resend.
