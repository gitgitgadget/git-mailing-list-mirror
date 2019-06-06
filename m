Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77BE21F462
	for <e@80x24.org>; Thu,  6 Jun 2019 16:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfFFQ6B (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 12:58:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53642 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFQ6B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 12:58:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EBE316A449;
        Thu,  6 Jun 2019 12:57:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=43F8kI93B/5VqTUT2cV/gfk8ZE0=; b=gbvAee
        psZADFcXYhWZEGT38BHfxxoStUWODCbCHGIENAFMaqx4AjR0Ww+ibht2zdSIJ+e8
        2jnPsZ3utE74rGPg3lNKx8uIK7P3XcIaW10QOtR2Rh2IZor6EltoMBLCE4PzjyBN
        Tdqm01UIr1Gu2bY/vNhD8VQsHQO5iqo04Xeto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aF7ZSDk8VZ9B97eplkyL2sxZFCH3trm9
        gaCHAgsXlqMf3L7B2Zn/I5vtiuodl87USgu7f6LfwrrcinvbD/X+IPxqQnUZGsnT
        QT1YJ6s1DLNNk2BXEoy6gao/gqd1X3/JkOVhWv6K3i0ffEB0HKaUf/WNIhoQJiv6
        8QRnUddD2Fs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1407816A448;
        Thu,  6 Jun 2019 12:57:59 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 676F116A447;
        Thu,  6 Jun 2019 12:57:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH v4 00/14] Commit-graph: Write incremental files
References: <pull.184.v3.git.gitgitgadget@gmail.com>
        <pull.184.v4.git.gitgitgadget@gmail.com>
Date:   Thu, 06 Jun 2019 09:57:57 -0700
In-Reply-To: <pull.184.v4.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Thu, 06 Jun 2019 07:15:28 -0700 (PDT)")
Message-ID: <xmqqmuiur6qy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C88D480-887C-11E9-90BD-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is based on ds/commit-graph-write-refactor.
>
> Thanks, -Stolee
>
> [1] 
> https://github.com/git/git/commit/43d356180556180b4ef6ac232a14498a5bb2b446
> commit-graph write: don't die if the existing graph is corrupt
>
> Derrick Stolee (14):
>   commit-graph: document commit-graph chains
>   commit-graph: prepare for commit-graph chains
>   commit-graph: rename commit_compare to oid_compare
>   commit-graph: load commit-graph chains
>   commit-graph: add base graphs chunk
>   commit-graph: rearrange chunk count logic
>   commit-graph: write commit-graph chains
>   commit-graph: add --split option to builtin
>   commit-graph: merge commit-graph chains
>   commit-graph: allow cross-alternate chains
>   commit-graph: expire commit-graph files
>   commit-graph: create options for split files
>   commit-graph: verify chains with --shallow mode
>   commit-graph: clean up chains after flattened write
>
>  Documentation/git-commit-graph.txt            |  26 +-
>  .../technical/commit-graph-format.txt         |  11 +-
>  Documentation/technical/commit-graph.txt      | 195 +++++
>  builtin/commit-graph.c                        |  53 +-
>  builtin/commit.c                              |   2 +-
>  builtin/gc.c                                  |   3 +-
>  commit-graph.c                                | 794 +++++++++++++++++-
>  commit-graph.h                                |  25 +-
>  t/t5318-commit-graph.sh                       |   2 +-
>  t/t5323-split-commit-graph.sh                 | 240 ++++++

This breaks test-lint, as t5323 is already taken in 'pu' by another
topic.  I tentatively moved it to 5234 for now.

Thanks.
