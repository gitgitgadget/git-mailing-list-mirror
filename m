Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6C21F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 04:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753951AbeGFEhI (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 00:37:08 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:46170 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753926AbeGFEhH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 00:37:07 -0400
Received: by mail-yw0-f173.google.com with SMTP id e23-v6so3240732ywe.13
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 21:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFJozQMGZV55vVVZgJzhX5IWmehe+48019uhI5ppJ6A=;
        b=O2YSEDNl7WzUjPWab7O4jSAP6PJirocRFXHAP1Ze2K6yHxryH/cZhjZXu4F5KLkLws
         +TrGQlBCgxtLXKv8iaKXDzHrO5mydUY/mI5JzG0z988uGl79c0kTkvsqNwVlGzMIesqA
         PbL4jLQD9FnO5I3rZcEC3Dl7I2xUuqbcPXkPpE38CnzG0Ay0m+U7Xch1/rbj3pKNLkNc
         RSrk1GO3qzeKYUVGAIZln5OAEnqxO5wBRG7ONgMTOT+U8L/UUoaC9clOS+GhYs/h3cWS
         2zZaLeCdQ/DZXPEoz2lH/1L7AIhE1DbYWuBxMBgS9JXj95/71b7jsbUxkgHCH3aBPOsn
         ySow==
X-Gm-Message-State: APt69E005zzrqzU2R4YhdFT0uuY8SjbtnTM1E3eFxFCW2+0vbm1TH4DB
        6NjMFRzZZpg5cBMRdQ95+td9JbhDeN4WXpkaWNg=
X-Google-Smtp-Source: AAOMgpffJFkyouvcAuPXGZqVu/Ya3Cgt7C1pQkb82iQRb+0gJC71et1bV3x+tg2kz7Z7w1UKcUAg83SB9jkqqv9w0ak=
X-Received: by 2002:a81:110e:: with SMTP id 14-v6mr4046896ywr.16.1530851826961;
 Thu, 05 Jul 2018 21:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180625143434.89044-1-dstolee@microsoft.com> <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-8-dstolee@microsoft.com>
In-Reply-To: <20180706005321.124643-8-dstolee@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Jul 2018 00:36:55 -0400
Message-ID: <CAPig+cTO=UPuCRUAAWfBwaNhRD+=dgSwpgEB2fQJuWyFEd7Aew@mail.gmail.com>
Subject: Re: [PATCH v3 07/24] multi-pack-index: expand test data
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 5, 2018 at 8:54 PM Derrick Stolee <stolee@gmail.com> wrote:
> multi-pack-index: expand test data

Since this patch is touching only t5319, a more typical title would be:

    t5319: expand test data

> As we build the multi-pack-index file format, we want to test the format
> on real repoasitories. Add tests to t5319-multi-pack-index.sh that

s/repoasitories/repositories/

And, since the title now mentions t5319, this can become simply:

    Add tests that...

> create repository data including multiple packfiles with both version 1
> and version 2 formats.
>
> The current 'git multi-pack-index write' command will always write the
> same file with no "real" data. This will be expanded in future commits,
> along with the test expectations.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> @@ -13,9 +13,108 @@ midx_read_expect () {
>  test_expect_success 'write midx with no packs' '
> +       test_when_finished rm -f pack/multi-pack-index &&

Should this test_when_finished() have been added in an earlier patch?
It seems out of place here.

>         git multi-pack-index --object-dir=. write &&
>         test_path_is_file pack/multi-pack-index &&
>         midx_read_expect
>  '
>
> +test_expect_success 'create objects' '
> +       for i in $(test_seq 1 5)
> +       do
> +               iii=$(printf '%03i' $i)
> +               test-tool genrandom "bar" 200 >wide_delta_$iii &&
> +               test-tool genrandom "baz $iii" 50 >>wide_delta_$iii &&

Alternately:

    {
        test-tool genrandom "bar" 200 &&
         test-tool genrandom "baz $iii" 50
    } >wide_delta_$iii &&

which makes it easier to see at a glance that both commands are
populating the same file. Same comment for the other files. (Not worth
a re-roll.)

> +               test-tool genrandom "foo"$i 100 >deep_delta_$iii &&
> +               test-tool genrandom "foo"$(expr $i + 1) 100 >>deep_delta_$iii &&
> +               test-tool genrandom "foo"$(expr $i + 2) 100 >>deep_delta_$iii &&

Or, just use POSIX arithmetic expansion:

    $(( $i + 1 ))

> +               echo $iii >file_$iii &&
> +               test-tool genrandom "$iii" 8192 >>file_$iii &&
> +               git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
> +               i=$(expr $i + 1) || return 1

Ditto, POSIX arithmetic expansion:

    i=$(( $i + 1 ))

(Not worth a re-roll.)

> +       done &&
> +       { echo 101 && test-tool genrandom 100 8192; } >file_101 &&
> +       git update-index --add file_101 &&
> +       tree=$(git write-tree) &&
> +       commit=$(git commit-tree $tree </dev/null) && {
> +       echo $tree &&
> +       git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)        .*/\\1/"
> +       } >obj-list &&

Perhaps indent the content of the {...} block?

> +       git update-ref HEAD $commit
> +'
> +
> +test_expect_success 'write midx with one v1 pack' '
> +       pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
> +       test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx pack/multi-pack-index &&
> +       git multi-pack-index --object-dir=. write &&
> +       midx_read_expect
> +'

It's odd to see all these tests ending by creating an 'expect' file
but not actually doing anything with that file.

> +test_expect_success 'Add more objects' '

s/Add/add/

> +       for i in $(test_seq 6 10)
> +       do
> +               iii=$(printf '%03i' $i)
> +               test-tool genrandom "bar" 200 >wide_delta_$iii &&
> +               test-tool genrandom "baz $iii" 50 >>wide_delta_$iii &&
> +               test-tool genrandom "foo"$i 100 >deep_delta_$iii &&
> +               test-tool genrandom "foo"$(expr $i + 1) 100 >>deep_delta_$iii &&
> +               test-tool genrandom "foo"$(expr $i + 2) 100 >>deep_delta_$iii &&
> +               echo $iii >file_$iii &&
> +               test-tool genrandom "$iii" 8192 >>file_$iii &&
> +               git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
> +               i=$(expr $i + 1) || return 1
> +       done &&
> +       { echo 101 && test-tool genrandom 100 8192; } >file_101 &&
> +       git update-index --add file_101 &&
> +       tree=$(git write-tree) &&
> +       commit=$(git commit-tree $tree -p HEAD</dev/null) && {
> +       echo $tree &&
> +       git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)        .*/\\1/"
> +       } >obj-list2 &&
> +       git update-ref HEAD $commit
> +'

There seems to be a fair bit of duplication in these tests which
create objects. Is it possible to factor out some of this code into a
shell function?

> +test_expect_success 'write midx with two packs' '
> +       git pack-objects --index-version=1 pack/test-2 <obj-list2 &&
> +       git multi-pack-index --object-dir=. write &&
> +       midx_read_expect
> +'
> +
> +test_expect_success 'Add more packs' '

s/Add/add/

> +       for j in $(test_seq 1 10)
> +       do
> +               [...]
> +       done
> +'
