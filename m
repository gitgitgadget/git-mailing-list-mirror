Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6A0C432BE
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 11:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF6A61058
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 11:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhHRLyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 07:54:15 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:40042 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232191AbhHRLyN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 07:54:13 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mGK8X-0000xo-Cx; Wed, 18 Aug 2021 12:53:37 +0100
Subject: Re: [PATCH v3 08/25] Provide zlib's uncompress2 from
 compat/zlib-compat.c
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
 <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
 <d92338467d66fcfedd57f209c97a798e9920d1e5.1629207607.git.gitgitgadget@gmail.com>
 <e1959ed9-beed-f110-c9a8-da8ed352dcda@iee.email>
 <CAFQ2z_P1EnNYPxiTZ8GeTTVsJaa0S0vz5M4kqu7Kf3yGbUt0kQ@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <916368b8-7c6f-09df-3dd8-03a4f99f9d1a@iee.email>
Date:   Wed, 18 Aug 2021 12:53:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAFQ2z_P1EnNYPxiTZ8GeTTVsJaa0S0vz5M4kqu7Kf3yGbUt0kQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/08/2021 11:39, Han-Wen Nienhuys wrote:
> On Wed, Aug 18, 2021 at 12:14 PM Philip Oakley <philipoakley@iee.email> wrote:
>> On 17/08/2021 14:39, Han-Wen Nienhuys via GitGitGadget wrote:
>>> From: Han-Wen Nienhuys <hanwen@google.com>
>>>
>>> This will be needed for reading reflog blocks in reftable.
>> How large might the reftable become? In particular will it exceed the
>> 32bit Long limit on Windows?
> A reftable file is organized as a sequence of blocks. Each block has
> max size 2^24, and the zlib compression is done per-block. So zlib
> should not introduce a new 4G limit. The intra-file offsets for the
> blocks themselves are encoded either as varint (index values) or as
> uint64 (file footer), so reftable files beyond 4G should be no
> problem.
>
Thanks, that's good to know for planning any Git upgrade to cope with
4GB file sizes on Windows.

Philip
