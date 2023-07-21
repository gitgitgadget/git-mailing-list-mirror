Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74241EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 22:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjGUWfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 18:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGUWfX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 18:35:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A1F3583
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 15:35:22 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FD9219B92B;
        Fri, 21 Jul 2023 18:35:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H/G1LJzCU2sYd8H+AakT0hE1OelCTahONxUpoj
        7fuRo=; b=Bnk8BbDX+K4Dc6PhigJqEXVkdXNs6ZMth8nGQIx/MG1aQjdzX5T4Hn
        J89c2/yIuJRwmtwqd55kQfSbgMOjmFBqGcF9vC/GcorD10VHhhza/1vnpePa0zZX
        PlEiqy6OudmQ0SG6VV6xFQ09z6hsSR8ZfY7V66l85r2GgqqFOUPDk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6863319B929;
        Fri, 21 Jul 2023 18:35:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C333019B928;
        Fri, 21 Jul 2023 18:35:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/5] commit-graph: test cleanup and modernization
References: <cover.1689960606.git.me@ttaylorr.com>
Date:   Fri, 21 Jul 2023 15:35:16 -0700
In-Reply-To: <cover.1689960606.git.me@ttaylorr.com> (Taylor Blau's message of
        "Fri, 21 Jul 2023 13:30:08 -0400")
Message-ID: <xmqqmszouc4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE3F46FE-2816-11EE-9528-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Most importantly, it removes many instances in t5318 that change
> directories outside of a sub-shell, altering the current working
> directory of subsequent tests. This makes it difficult to run a subset
> of tests, or otherwise include `cd "$TRASH_DIRECTORY"` at the top of
> each test.

Thanks for tackling this aspect of this test script.  It does look
problematic and unnecessarily makes it harder to debug the test
itself.

