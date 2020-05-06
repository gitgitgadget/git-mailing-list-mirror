Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2154C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 23:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BDE020659
	for <git@archiver.kernel.org>; Wed,  6 May 2020 23:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q9KFE/mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgEFXOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 19:14:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61203 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgEFXOc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 19:14:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D8AA623A9;
        Wed,  6 May 2020 19:14:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QMmqPmnsd+ltXdQd7CwOFKnTJ5Y=; b=Q9KFE/
        miJUSbia4SWbzzYjEF2nR1V0Rap4hK6VoZcSVCEjqJa0cKWdMMuLEKubZ8yjursE
        P/PnTw5zCB1RnLoN4rDkXMTWewGt/bKHjx5v3PreptrQ11wV0HPc+xCyEC30nD0d
        jRVUbXAVERe6rYMemRxGgX5CvVEadRKli++DM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T+RGZCfNwSE30AGhEFwqmiV9tBNLtSj9
        K90HiR/dT3PiZ4UqLXxQvHgOCpq2g1Dg13/bc/L7idNU3UAeXeMJgzeyO1txEcyU
        /fOybv8zvW+Jub7Xx95J5Xb3/HjLnrO5srIp/fYVtUMpy/eLp5JRIs2M5UWj4rXv
        doHjOdGs9hU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55053623A8;
        Wed,  6 May 2020 19:14:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C9F45623A7;
        Wed,  6 May 2020 19:14:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v14 0/7] New proc-receive hook for centralized workflow
References: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
        <20200505144131.30048-1-worldhello.net@gmail.com>
Date:   Wed, 06 May 2020 16:14:28 -0700
In-Reply-To: <20200505144131.30048-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Tue, 5 May 2020 10:41:24 -0400")
Message-ID: <xmqq4kss64h7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 567197A8-8FEF-11EA-A987-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> This topic introduces a new hook named "proc-receive" for
> "receive-pack".  We can use this hook to implement a Gerrit-like
> centralized workflow.

https://github.com/git/git/runs/651179641 shows us that osx-clang
job ends like so:

Thanks.


Test Summary Report
-------------------
t5411-proc-receive-hook.sh                       (Wstat: 256 Tests: 273 Failed: 0)
  Non-zero exit status: 1
  Parse errors: Tests out of sequence.  Found (27) but expected (26)
                Tests out of sequence.  Found (28) but expected (27)
                Tests out of sequence.  Found (29) but expected (28)
                Tests out of sequence.  Found (30) but expected (29)
                Tests out of sequence.  Found (31) but expected (30)
Displayed the first 5 of 249 TAP syntax errors.
Re-run prove with the -p option to see them all.
Files=906, Tests=22778, 1347 wallclock secs ( 8.21 usr  3.04 sys + 1322.42 cusr 2031.60 csys = 3365.27 CPU)
Result: FAIL
make[1]: *** [prove] Error 1
make: *** [test] Error 2
##[error]Process completed with exit code 2.
