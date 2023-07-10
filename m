Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01268EB64D9
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 15:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjGJP4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 11:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbjGJPzy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 11:55:54 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B353E5A
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 08:55:34 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-34574eb05f4so17428785ab.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 08:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1689004529; x=1691596529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjtr21x3NY2AD1A+4HRPLrCSKIyP31CQkWAqLogoPCo=;
        b=KgUNiiN8AQFYWNyopjnG2hyk9yissB8uKFsgxFH2bGsz1glH4CDNJ54Uf2UHRyDCaf
         wXI74ammVONlLjGjLtI3iL77A4OAaCvMWuDHnP6mLVcG/OqTax1+EZBZETBu1KAhZSk+
         OVhd2sKlKktnaV0EYux2JvPBbQ4RFNnqKE0yTYXaUuhEI+ZpurXsfWKmSNGpQq2yow4x
         DqIEE4FW/zkSwWjaVfoeQyBRhmAnc9YXBHM+2yDPEEwFVeya8sIw/0g/wHU1eIFCwBtb
         ui7CrQRGz+EvEE3kHiiG9RADCNnwhOIp6HnkuTpJGD77dc1PNHGZ5H/JWLSZ2TN9X6J1
         stHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689004529; x=1691596529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjtr21x3NY2AD1A+4HRPLrCSKIyP31CQkWAqLogoPCo=;
        b=BdWvtxrnnrDansflloD954A9WFd+4OL6OSXJoDwz4D1opmgE9dWsgoihuj9qoUAlK1
         gbzwS1aq/DkWoHktuoNU+M3hM6a0i4ijh5pVAl2slv1UPavpcW8DP72NArqByBni7PQI
         zGevZLcD2S3RPsJciZs5LYdEkMmnQj4O4kTh0B7GgCJGBJpKdcD8cw3zp6QFVIRAfCO6
         /enFCraF3Nb5aXx33iy37/YuSRPQFH+/5SXKYAYBv4xQmR5mrgNZMDcxdTq9Ku92dNaM
         O8izqPg9TdGYcfm+0rLFdtEAMdjmVxnSMP7LFRua9NWyD/em258ljBgAkZknYImdBx/7
         2HYg==
X-Gm-Message-State: ABy/qLZSgc5N4PVnFqQHJQAf12VrdnsS40cbvNFYJn2t2FcE7jZRPUHt
        qmtEN5d/86mq6sii3+Aj6RE8
X-Google-Smtp-Source: APBJJlF0Xx3Xvv7mfgKceTUIsMIGJd9sRFnkkzQTj8GI6KIQSjczWW9S31yw32rIr9dI9KQR9gs3Ow==
X-Received: by 2002:a92:dc44:0:b0:345:a201:82b7 with SMTP id x4-20020a92dc44000000b00345a20182b7mr11308720ilq.26.1689004529484;
        Mon, 10 Jul 2023 08:55:29 -0700 (PDT)
Received: from [10.0.0.16] (75-166-6-41.hlrn.qwest.net. [75.166.6.41])
        by smtp.gmail.com with ESMTPSA id s2-20020a92cbc2000000b00345d3f2bb6asm3564990ilq.56.2023.07.10.08.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 08:55:29 -0700 (PDT)
Message-ID: <21f0945a-c51d-304e-82ec-9f6253818668@github.com>
Date:   Mon, 10 Jul 2023 09:55:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/6] fsck: squelch progress output with `--no-progress`
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover.1688776280.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1688776280.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/7/2023 6:31 PM, Taylor Blau wrote:
>This short series addresses a pair of issues where the `commit-graph
>verify` and `multi-pack-index verify` steps of `git fsck` produce output
>regardless of whether or not `fsck`was invoked with the
>`--no-progress`option or not.
>
>The first two patches address the commit-graph and MIDX issues
>respectively. The final four patches further clean up the output of
>`git commit-graph verify --progress`when verifying multi-layer graphs
>to produce a single progress meter instead of one per graph layer.
>
>Before, the output of `git commit-graph verify`on a repository with a
>commit-graph chain with two layers looked like:
>
>    $ git.compile commit-graph verify
>    Verifying commits in commit graph: 100% (4356/4356), done.
>    Verifying commits in commit graph: 100% (131912/131912), done.
>
>After this patch series, the output instead looks as follows:
>
>    $ git.compile commit-graph verify
>    Verifying commits in commit graph: 100% (136268/136268), done.
Thanks for noticing and fixing these issues. The patches are structured
well and make the refactoring easy to follow. This is especially tricky
when swapping from recursive to iterative, but the patches break this
down nicely.
v1 LGTM.
Thanks,
-Stolee
