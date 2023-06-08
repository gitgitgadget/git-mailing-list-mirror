Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BD3C7EE25
	for <git@archiver.kernel.org>; Thu,  8 Jun 2023 19:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjFHTyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjFHTyB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 15:54:01 -0400
Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567732733
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 12:54:00 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.102])
        by smtp with ESMTPA
        id 7Leqqq887qd5l7LerqmjmH; Thu, 08 Jun 2023 20:50:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1686253858; bh=x0h0x+xXBiM3gqoPojduImGRLQVMHlPjFQqOW0I+UQk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iSE2LrmLhG1RMXqpR9rddrkQZsc/oHhlxk1FRUYvk6GSFdTTFUWYjqhe/ciAzohdI
         ssMXSGG5/7eLzUMrFiycRkLTF/GnbAegi/RQrOLR3q/w5fh0V47wgF3gfWnfvKmIhu
         lnSyJb4PWTruTySZE2fSZ94isOAlxYuwTdYfx/pmSCql9aemx0is7/QzGWjhNSpWtE
         jPNhfjiNqAHJwhibHkTCtq8XPUCr2ToiicsbPyc3m+TZgGhR2+j9ijaUNCnYxRblb5
         3I/ZXa/vb4BRQ5ndmvJbpbTDnSbDy72QdxxbtdzlNk2y8DYr2SvfuzxuACwzVNQoDe
         newfP+JIsBRQA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UpJwis8B c=1 sm=1 tr=0 ts=64823122
 a=O4HnXJxpn4bBnFCb4s/IkQ==:117 a=O4HnXJxpn4bBnFCb4s/IkQ==:17
 a=IkcTkHD0fZMA:10 a=eNlqBDlVKP2VOXqIr5MA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <3ff7acfc-0fd2-88a8-3e31-2c6405a03f59@ramsayjones.plus.com>
Date:   Thu, 8 Jun 2023 20:50:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/4] Changed path filter hash fix and version bump
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1686251688.git.jonathantanmy@google.com>
Content-Language: en-GB
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <cover.1686251688.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLSiqDlWSyPZf/b2IJSGrSKfEPxMKTKgCp84/57WtaB4kISjQ8TaanyAb7rlOAPyQUfw0GZKVpI0ehXu1kt/5iDSpMU27avKz35FZfymB2RdBJEKmHyO
 xeq3CBdl1a2RMATsJPUc3uea/ACXLs0o1VXNM5yghGW7pIL2k4QK86hB3INEVd6WMw82OBbEIEt+dLMwjMtYBQOPjDuZhtjX+a0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/06/2023 20:21, Jonathan Tan wrote:
> Here's an updated version with changes only in the tests:
>  - resilience against unsigned-by-default (a "skip" will be shown)
>  - for systems that have different quoting behavior, the tests
>    will be skipped (see patch 2 for more information)
> 
> Some of the test changes may seem a bit of a hack, so if you have
> a better way of doing things, please let me know.
> 
> I've also included a change to the file format specification. To
> reviewers, if you generally agree that we need a version 2 but are still
> unsure about how we should migrate, consider saying so and then perhaps
> we can merge the first patch while the rest remain under review. This
> will give other projects, like JGit, more certainty as to the direction
> that the Git project wants to take.
> 
> Jonathan Tan (4):
>   gitformat-commit-graph: describe version 2 of BDAT
>   t4216: test changed path filters with high bit paths
>   repo-settings: introduce commitgraph.changedPathsVersion
>   commit-graph: new filter ver. that fixes murmur3
> 
>  Documentation/config/commitgraph.txt     | 16 ++++-
>  Documentation/gitformat-commit-graph.txt |  9 ++-
>  bloom.c                                  | 65 +++++++++++++++++-
>  bloom.h                                  |  8 ++-
>  commit-graph.c                           | 29 ++++++--
>  oss-fuzz/fuzz-commit-graph.c             |  2 +-
>  repo-settings.c                          |  6 +-
>  repository.h                             |  2 +-
>  t/helper/test-bloom.c                    |  9 ++-
>  t/t0095-bloom.sh                         |  8 +++
>  t/t4216-log-bloom.sh                     | 86 ++++++++++++++++++++++++
>  11 files changed, 219 insertions(+), 21 deletions(-)
> 
> Range-diff against v2:
> -:  ---------- > 1:  d4b63945f6 gitformat-commit-graph: describe version 2 of BDAT
> 1:  c587eb3470 ! 2:  aa4535776e t4216: test changed path filters with high bit paths
>     @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation backfills empty comm
>      +# chosen to be the same under all Unicode normalization forms
>      +CENT=$(printf "\xc2\xa2")

I think the only change you need to make here (because /usr/bin/sh
on Ubuntu is usually 'dash' not 'bash') is to use octal rather than
hexadecimal. ie: CENT=$(printf "\302\242")

HTH

ATB,
Ramsay Jones

