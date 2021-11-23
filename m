Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8D8C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 02:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhKWCJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 21:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhKWCJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 21:09:37 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86565C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 18:06:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w1so85307141edc.6
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 18:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=4BL13YBGfWw7dHX5+sMFdByBhEgD41SyH8n7/lwWxnk=;
        b=O5b1hhBCpNzv5rrPVV4O3X9QYrvz37iApSbn/cOoVseUOmlwtd+lpjedNTY4dUaQE+
         dCnQCC7bLarDVEMR46PqlWM+bg+PhEmbBfM9e2BH//eyvqoOb+4giq4GV1rARy4yjWwp
         lIBWvrBYTVNn9tQlhcRHlPSAVCHrAJ+9RgbR7rgTuRXCsuBRKqwOmPTUo1Wg5VUwQj31
         fYDb/2AMgwH+encMAmx1U9bPsZk+bEMPShGPw+XBzf0eCP7iZ7rNvCWbOz2DGAfCEP1Z
         cROHIt2Vmsx94PzePYk2Y8yWnFWLzid4lrtIgmMawPDSNTTqcRrbg8uRnTcmwpbzeuWl
         Nx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=4BL13YBGfWw7dHX5+sMFdByBhEgD41SyH8n7/lwWxnk=;
        b=GC/hr9G9t0yYyd0/kIfqvva2dSyjCGXiM1qX5M2zGJhPrHGfD739TmU7PDarvph5/Z
         bn4fV1tLuTCM2bEtmd9mlaG6yf8WeXX840sRagUaX+YcdolSfjhxl7+Lb4UF8cszQT4F
         TAvseQuVnvN+Xhp219HkgMipPJyxHLhslc6/aAGq2U0fXQNnQH/IQX2sMLtWwq4A3ErI
         OIerxaniBp7nurYu1gklTJ+gyyTpvkp8fct45SWmgGQJrzkrtkIHAAEHGVBUIKK/0/4V
         /lc2FbXjqlrRoxexdygEUpk/8D04KFmg1EHmzpJGNnN+rr17wZBr4zb6dTpLmOUmsmHa
         SwzA==
X-Gm-Message-State: AOAM532gmA4GIzg2N5k19fL1nsl6RoIltKmSXYH2YnRyvagF3X9dpqWM
        fBX/J+gX87ja5QW1ED3IFiO4hROyTFX8Sg==
X-Google-Smtp-Source: ABdhPJzSONOcxup8OnAWb1VQjIJ/vrD0Pd13DruuxMxwwyRqoWHlrOOUvF87K0koULC0HNXvHfNv4A==
X-Received: by 2002:a17:906:3b18:: with SMTP id g24mr2804983ejf.27.1637633187816;
        Mon, 22 Nov 2021 18:06:27 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sb19sm4673164ejc.120.2021.11.22.18.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 18:06:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpLCU-001H38-VA;
        Tue, 23 Nov 2021 03:06:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        vdye@github.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/2] Sparse index: fetch, pull, ls-files
Date:   Tue, 23 Nov 2021 02:57:33 +0100
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
Message-ID: <211123.86lf1fwrq5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 16 2021, Derrick Stolee via GitGitGadget wrote:

> The 'ls-files' builtin is useful when debugging the index, and some scripts
> use it, too. We are not changing the default behavior which expands a sparse
> index in order to show all of the cached blobs. Instead, we add a '--sparse'
> option that allows us to see the sparse directory entries upon request.
> Combined with --debug, we can see a lot of index details, such as:
>
> $ git ls-files --debug --sparse
> LICENSE
>   ctime: 1634910503:287405820
>   mtime: 1634910503:287405820
>   dev: 16777220 ino: 119325319
>   uid: 501  gid: 20
>   size: 1098    flags: 200000
> README.md
>   ctime: 1634910503:288090279
>   mtime: 1634910503:288090279
>   dev: 16777220 ino: 119325320
>   uid: 501  gid: 20
>   size: 934 flags: 200000
> bin/index.js
>   ctime: 1634910767:828434033
>   mtime: 1634910767:828434033
>   dev: 16777220 ino: 119325520
>   uid: 501  gid: 20
>   size: 7292    flags: 200000
> examples/
>   ctime: 0:0
>   mtime: 0:0
>   dev: 0    ino: 0
>   uid: 0    gid: 0
>   size: 0   flags: 40004000
> package.json
>   ctime: 1634910503:288676330
>   mtime: 1634910503:288676330
>   dev: 16777220 ino: 119325321
>   uid: 501  gid: 20
>   size: 680 flags: 200000
>
>
> (In this example, the 'examples/' directory is sparse.)
>
> Thanks!

That's useful, and seems to be closing the same feature gap that the RFC
series I sent back in March[1], but at the time you went with adding
this ability to t/helper/test-read-cache.c.

With your series diffing the two with the data used in your new test
shows that we had this with the helper beore:
    
     diff -u <(t/helper/test-tool -C sparse-index read-cache --table) <(t/helper/test-tool -C sparse-index read-cache --table --expand)
    --- /dev/fd/63  2021-11-23 02:57:00.980651400 +0100
    +++ /dev/fd/62  2021-11-23 02:57:00.980651400 +0100
    @@ -13,9 +13,13 @@
     100644 blob cebd1739abee3e524d72ca9f51465a94d5a71daf   e
     100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391   folder1-
     100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391   folder1.x
    -040000 tree e0f2d30b633eb781d675fedd78808135103fe1a0   folder1/
    +100644 blob 8b137891791fe96927ad78e64b0aad7bded08bdc   folder1/0/0/0
    +100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391   folder1/0/1
    +100644 blob 78981922613b2afb6025042ff6bd878ac1994e85   folder1/a
     100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391   folder10
    -040000 tree 123706f6fc38949628eaf0483edbf97ba21123ae   folder2/
    +100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391   folder2/0/0/0
    +100644 blob 8b137891791fe96927ad78e64b0aad7bded08bdc   folder2/0/1
    +100644 blob 78981922613b2afb6025042ff6bd878ac1994e85   folder2/a
     100644 blob 18912c9a915632d7b3344ec25f349dc8b4b9bf27   g
    -040000 tree aaff74984cccd156a469afa7d9ab10e4777beb24   x/
    +100644 blob 78981922613b2afb6025042ff6bd878ac1994e85   x/a
     100644 blob 2d8c856aebeb20da61bd5112d6fa46ff3f56a9e8   z

Which we can now get out of ls-files:
    
    $ diff -u <(git -C sparse-index ls-files --stage --sparse) <(git -C sparse-index ls-files --stage)
    --- /dev/fd/63  2021-11-23 02:55:13.329613255 +0100
    +++ /dev/fd/62  2021-11-23 02:55:13.329613255 +0100
    @@ -13,9 +13,13 @@
     100644 cebd1739abee3e524d72ca9f51465a94d5a71daf 0      e
     100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0      folder1-
     100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0      folder1.x
    -040000 e0f2d30b633eb781d675fedd78808135103fe1a0 0      folder1/
    +100644 8b137891791fe96927ad78e64b0aad7bded08bdc 0      folder1/0/0/0
    +100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0      folder1/0/1
    +100644 78981922613b2afb6025042ff6bd878ac1994e85 0      folder1/a
     100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0      folder10
    -040000 123706f6fc38949628eaf0483edbf97ba21123ae 0      folder2/
    +100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0      folder2/0/0/0
    +100644 8b137891791fe96927ad78e64b0aad7bded08bdc 0      folder2/0/1
    +100644 78981922613b2afb6025042ff6bd878ac1994e85 0      folder2/a
     100644 18912c9a915632d7b3344ec25f349dc8b4b9bf27 0      g
    -040000 aaff74984cccd156a469afa7d9ab10e4777beb24 0      x/
    +100644 78981922613b2afb6025042ff6bd878ac1994e85 0      x/a
     100644 2d8c856aebeb20da61bd5112d6fa46ff3f56a9e8 0      z

So that's neat, but unless I'm wrong about there still being some
special-sauce in t/helper/test-read-cache.c that's needed this series
seems incomplete without migrating the existing test users of it to this
new ls-files --sparse, followed by a cherry-pick (or equivalent) of [2].

Is there any reason we wouldn't use ls-files instead of the test-tool in
the tests now? I understood from you at the time that the reason for the
that mode of the test-tool existing was an interim state until ls-files
learned to emit this sort of output, but that you wanted to add that
later. It seems we've arrived at that "later" :)

1. https://lore.kernel.org/git/20210317132814.30175-1-avarab@gmail.com/
2. https://lore.kernel.org/git/20210317132814.30175-5-avarab@gmail.com/
