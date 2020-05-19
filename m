Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1169C433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 23:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B173C20809
	for <git@archiver.kernel.org>; Tue, 19 May 2020 23:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U5+bRCgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgESXNE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 19:13:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50883 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgESXNE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 19:13:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE13A6D6A3;
        Tue, 19 May 2020 19:13:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IjR+bOvj9VIGreZeKHceOkwA5FY=; b=U5+bRC
        gzRmEnK5/kHBqJhItrjCVxOk2cowSJ+JEaOlpiQsbbMYKKmoZa6T6ThOsGmhBsWL
        0Z+BIYE7zBjEgyS1XtN38Xu2Sy7l1/qii4LJgG8jxwP2rZOx0V77Elap4lV9etqq
        T2/qCnvlFDS3tTNFVQjDs1E7ydkFiYKXq3OhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GXD/tWZoMq2msWJv1hjJH2jWLhLSQjmY
        ZdkGv1BKpr68tS3utscGx9yto1My3vnwLmvk9iobfc8rEd09I3TUNNqTpHj0jhqI
        JaOVE68QO5trsPbZ/pQ5ZZ09+jBDbcThyOF7v46V+YCH73j4AJGuvX2qhMb0oz4D
        b2J4DkJDaXo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B64606D6A2;
        Tue, 19 May 2020 19:13:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 24C9F6D6A0;
        Tue, 19 May 2020 19:13:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] fsck: use ERROR_MULTI_PACK_INDEX
References: <pull.637.git.1589917725263.gitgitgadget@gmail.com>
Date:   Tue, 19 May 2020 16:12:59 -0700
In-Reply-To: <pull.637.git.1589917725263.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 19 May 2020 19:48:45
        +0000")
Message-ID: <xmqq1rnfzfgk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48F53C60-9A26-11EA-AC67-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The multi-pack-index was added to the data verified by git-fsck in
> ea5ae6c3 "fsck: verify multi-pack-index".

That's 66ec0390 (fsck: verify multi-pack-index, 2018-09-13) that
first appeared in v2.20

> This implementation was
> based on the implementation for verifying the commit-graph, and a
> copy-paste error kept the ERROR_COMMIT_GRAPH flag as the bit set
> when an error appears in the multi-pack-index.
>
> Add a new flag, ERROR_MULTI_PACK_INDEX, and use that instead.

Thanks.  Will queue.
