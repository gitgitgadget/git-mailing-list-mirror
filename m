Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A35BC04FE0
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 16:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjHNQ7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjHNQ6x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 12:58:53 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D9C10F4
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 09:58:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2513425289;
        Mon, 14 Aug 2023 12:55:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z7nLtJGcg+5U3rURL8G+CYL9fNNfgzemMqP4av
        4PRog=; b=ZTfbe6liy/8kCSmq4j74mpI0EGJkjnr+HIQQ/KC+8yZpj0bZmd1WP9
        QbDMUMc6uLk0O1kXDOemnxJmK0k9mUW1dQdYXaB39oHlo74jJlCJqDi5aKWXWcsb
        L79u9r6KQZJgyIBvCTpgV/KLSzXfBcycFHtx7jrRW5FbN70h+Vqh0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D7FC25288;
        Mon, 14 Aug 2023 12:55:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A0AD025287;
        Mon, 14 Aug 2023 12:55:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/3] setup: add discover_git_directory_reason()
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
        <fbba6252aeabc9a77d8529e4725feb3ea995545f.1692025937.git.gitgitgadget@gmail.com>
        <xmqqpm3plh8n.fsf@gitster.g>
Date:   Mon, 14 Aug 2023 09:55:21 -0700
In-Reply-To: <xmqqpm3plh8n.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        14 Aug 2023 09:29:44 -0700")
Message-ID: <xmqq8radlg1y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BB5A8A8-3AC3-11EE-85AF-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> 1. The zero value of the enum is actually GIT_DIR_NONE, so nonpositive
>>    results are errors.
>
> True. discover_git_directory() already knows that negative return
> values from setup_git_directory_gently_1() signal errors while 0 or
> positive are OK.

NOnononono.  negative are not.  0 is not returned, so if we saw one,
it would be an error.  And positives are OK.

Sorry for the confusion.
