Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198A3C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 21:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiJMVMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 17:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJMVMf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 17:12:35 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE146191D70
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 14:12:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 907B81BCC56;
        Thu, 13 Oct 2022 17:12:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=DspNT9531vBnKCVZGVQdwT54L2qQs4w3m01AYC52pbA=; b=P1h5
        cbIierb4Qjiw+519+govp5YbS5FaxCEeBCq7PrfDMHuw8zoTEGl5VeYkQLJUyrJq
        EiJdoVFnq27ad+rYWkOJboKQSQu1Ybh1QN69fOj4pWfynoyrYHFba8iBZuTsocJA
        YZD+PJLcAjwdD7vN5dZrK0Gu3Y1wXqCp2xogRHM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 86A5A1BCC55;
        Thu, 13 Oct 2022 17:12:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BA0531BCC53;
        Thu, 13 Oct 2022 17:12:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 5/7] trace2: convert ctx.thread_name from strbuf to
 pointer
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
        <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
        <4bf78e356e23c947b8328a91ba435a357cd51f43.1665600750.git.gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 14:12:25 -0700
Message-ID: <xmqq1qrbe8cm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD33AC06-4B3B-11ED-90EB-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Convert the `tr2tls_thread_ctx.thread_name` field from a `strbuf`
> to a "const char*" pointer.
>
> The `thread_name` field is a constant string that is constructed when
> the context is created.  Using a (non-const) `strbuf` structure for it
> caused some confusion in the past because it implied that someone
> could rename a thread after it was created.  That usage was not
> intended.  Change it to a const pointer to make the intent more clear.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  trace2/tr2_tgt_event.c |  2 +-
>  trace2/tr2_tgt_perf.c  |  2 +-
>  trace2/tr2_tls.c       | 16 +++++++++-------
>  trace2/tr2_tls.h       |  2 +-
>  4 files changed, 12 insertions(+), 10 deletions(-)

Looking good so far.
