Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A445C433FE
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 19:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239109AbhKVTDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 14:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhKVTDD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 14:03:03 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C5BC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:59:56 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id o17so17573371qtk.1
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6HWBIFqMM/lp3GJe7c1/tRp3mZpgfFLinbumPxI9U8c=;
        b=d/kba4mpomNPhJ1bXPWfWClOqm/nbEdp+tOhsZHaKsh6KZ2UkoMiiVyOMZyqP3Z9Ym
         oojAqLQ3CfPNX7VMVbD93IeL4ITJ+pBMIT7oAhV96D1BU9ck8tTuSD7HVvUCJG3z7vmY
         B5n6AxtpH9wKVqx9WPprI9KvC/xTPWB3cc6MMH+0IAnVDmvP94MIXrjyjhHWhn/uI5jH
         Lil5coEOz+6cn5+8w5Qnq7qHm37e3N4B+BdaPJp/DU+xsfazjHwh1F/1Z/KD8hB1+Pd9
         ccPNxqEQi5gs2iU2i++gKBeIF45KJGpK68OtuC1j1LgPcIZmlwN8BI9pmMOD39Rl8jNO
         AC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6HWBIFqMM/lp3GJe7c1/tRp3mZpgfFLinbumPxI9U8c=;
        b=JWmN9yopvsEb7nnVYl9iWLpHJNXMvEE0vBSQdDcOCdpxvME3Gqobf0s/0z1ZlcxlUr
         iF5DYLjccNMv00YjDDPsbEPKuZed+Q5GoF+0EBAZXWrsDONt7t72OG0m8GwOY/qYjVRx
         /Eg1RD5JvKo/fSMbkpCQC4++PRDFq1egorDIn8uUroRg19OK5QPzHGnXE36PKMIwBCnN
         1DfMVhcmLbuqDPSPXiceA/2lP18NUOfFqjZwO4jsZQWFneKKXofDeX0FUKPgLjG3Pm+B
         htgIcCyz5gaREzxXdpBELQK4ZQjJJXvCOj4HMWLUMWMUiU985feYieM3AYa8A62k4wcH
         uyug==
X-Gm-Message-State: AOAM532CKYWlVAdBxQAIPabVlswvKN65zKmd3uKYDbyjggjRHR6fWnfP
        c3GOFSKiFH86qMQGrJRSUIHAGmTTqg0p
X-Google-Smtp-Source: ABdhPJz4ieUuaIDBUZX5xrTLAeL7nbz1R/gd0DXexLTdWCmUOVKPEaPRa7DVsMyZXoAEBlt2C/v8hQ==
X-Received: by 2002:a05:622a:449:: with SMTP id o9mr33357425qtx.158.1637607595904;
        Mon, 22 Nov 2021 10:59:55 -0800 (PST)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id d16sm4543422qtn.59.2021.11.22.10.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 10:59:55 -0800 (PST)
Message-ID: <dc20df3f-7648-6440-0b0a-0057a7645d74@github.com>
Date:   Mon, 22 Nov 2021 13:59:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v4 4/4] sparse-index: update do_read_index to ensure
 correct sparsity
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
 <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
 <b67cd9d07f8a3802e5b50d58965f283620cd3876.1635515487.git.gitgitgadget@gmail.com>
 <CABPp-BGU=HHeydt3arF=RF2P81cFbe3NfX6tqiBHb8xkhOALgg@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BGU=HHeydt3arF=RF2P81cFbe3NfX6tqiBHb8xkhOALgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Fri, Oct 29, 2021 at 6:56 AM Victoria Dye via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Victoria Dye <vdye@github.com>
>>
>> If `command_requires_full_index` is false, ensure correct in-core index
>> sparsity on read by calling `ensure_correct_sparsity`. This change is meant
>> to update the how the index is read in a command after sparse index-related
> 
> s/update the how/update how/ ?
> 

This was probably the result of mixing up "update the way" and "update how".
I'll go with the latter.

>> repository settings are modified. Previously, for example, if `index.sparse`
>> were changed from `true` to `false`, the in-core index on the next command
>> would be sparse. The index would only be expanded to full when it was next
>> written to disk.
>>
>> By adding a call to `ensure_correct_sparsity`, the in-core index now matches
>> the sparsity dictated by the relevant repository settings as soon as it is
>> read into memory, rather than when it is later written to disk.
> 
> I split up reading this series across different days, and when I got
> here, my first reaction was "Okay, but why would you want that?
> Sounds like extra work for no gain."  I went and looked up the cover
> letter and saw you mentioned that this "introduces the ability to
> enable/disable the sparse index on a command-by-command basis (e.g.,
> allowing a user to troubleshoot a sparse-aware command with '-c
> index.sparse=false' [1]).  That seems like a good reason to me, and
> sounds like it belongs in this commit message.  But it sounds like you
> had other reasons in mind.  If so, could you share them; I'm having
> difficulty understanding how this would make a difference other than
> in the troubleshooting scenario.
> 

The troubleshooting scenario was what inspired this change in the first
place, but it applies any time someone changes repository settings outside
of `git sparse-checkout init`. One relevant scenario I can imagine is if a
user enables `index.sparse, commands would not use the sparse index until a
command that *writes* the index is executed:

$ git config index.sparse true
$ git diff      # read full index, full in-core, no write
$ git add .     # read full index, full in-core, write sparse
$ git diff      # read sparse index, sparse in-core, no write

Another scenario might be enabling `index.sparse`, then running a command
that turns out to be surprisingly slow because it's operating on a full
index in-core (i.e., much slower than the convert_to_sparse + command with
sparse index would be). 

These are definitely edge cases - they rely on manual config changes, and
they're only really noticeable 1) if the config change is immediately
followed by index read-only commands and 2) if the first index-writing
command after the config change is slow. That said, on the off chance that a
user (or future developer) encounter one of these scenarios, I think it'll
be helpful to have `index.sparse` take effect "immediately" after the config
change.

I'll include these (and the troubleshooting) examples in the updated commit
message.

>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  read-cache.c                             |  8 ++++++
>>  t/t1092-sparse-checkout-compatibility.sh | 31 ++++++++++++++++++++++++
>>  2 files changed, 39 insertions(+)
>>
>> diff --git a/read-cache.c b/read-cache.c
>> index a78b88a41bf..b3772ba70a1 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -2337,9 +2337,17 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>>
>>         if (!istate->repo)
>>                 istate->repo = the_repository;
>> +
>> +       /*
>> +        * If the command explicitly requires a full index, force it
>> +        * to be full. Otherwise, correct the sparsity based on repository
>> +        * settings and other properties of the index (if necessary).
>> +        */
>>         prepare_repo_settings(istate->repo);
>>         if (istate->repo->settings.command_requires_full_index)
>>                 ensure_full_index(istate);
>> +       else
>> +               ensure_correct_sparsity(istate);
>>
>>         return istate->cache_nr;
>>
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index ca91c6a67f8..59accde1fa3 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -694,6 +694,37 @@ test_expect_success 'sparse-index is expanded and converted back' '
>>         test_region index ensure_full_index trace2.txt
>>  '
>>
>> +test_expect_success 'index.sparse disabled inline uses full index' '
>> +       init_repos &&
>> +
>> +       # When index.sparse is disabled inline with `git status`, the
>> +       # index is expanded at the beginning of the execution then never
>> +       # converted back to sparse. It is then written to disk as a full index.
>> +       rm -f trace2.txt &&
>> +       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
>> +               git -C sparse-index -c index.sparse=false status &&
>> +       ! test_region index convert_to_sparse trace2.txt &&
>> +       test_region index ensure_full_index trace2.txt &&
>> +
>> +       # Since index.sparse is set to true at a repo level, the index
>> +       # is converted from full to sparse when read, then never expanded
>> +       # over the course of `git status`. It is written to disk as a sparse
>> +       # index.
>> +       rm -f trace2.txt &&
>> +       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
>> +               git -C sparse-index status &&
>> +       test_region index convert_to_sparse trace2.txt &&
>> +       ! test_region index ensure_full_index trace2.txt &&
>> +
>> +       # Now that the index has been written to disk as sparse, it is not
>> +       # converted to sparse (or expanded to full) when read by `git status`.
>> +       rm -f trace2.txt &&
>> +       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
>> +               git -C sparse-index status &&
>> +       ! test_region index convert_to_sparse trace2.txt &&
>> +       ! test_region index ensure_full_index trace2.txt
>> +'
>> +
>>  ensure_not_expanded () {
>>         rm -f trace2.txt &&
>>         echo >>sparse-index/untracked.txt &&
>> --
>> gitgitgadget
> 
> The rest of the patch looks fine.
> 

