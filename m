Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 290401F4BD
	for <e@80x24.org>; Mon,  7 Oct 2019 01:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfJGBwX (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 21:52:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63930 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfJGBwX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 21:52:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D813D8DC4C;
        Sun,  6 Oct 2019 21:52:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cPRJ1r6fYaU9EEXdF1Vdxuh4v0g=; b=VMVD32
        et2QhPFgUiEwOV/v5yylJhuxDeW8ZybujDYCwelm9FTuStPzQo8Smn3NAMJFTjB7
        XAJdMvhKAyHV6vQbaUjxRqrMB5TgZ6W6W/cxBZEal8fP1F8QJI9mIOkPpvpFNvzR
        ZtTickLKtjxpcgjOLvRWvsBU31G/FGQk8l9xg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=swuheMK21SBqo/Mot+pq9pNJ3SZAIdh5
        RmM73gbUuNyqWNvlwKI60EPhkk7LMyuuXCkRIUqIHE7bx0XwhpPgHfq4HF+irl5U
        TDosaPzgQGDIaNoqODOYMk9rj7eIsjZ3u5CM1l1HAuGKjBfX+ISLiyNXsnBNZ3Fo
        WD6K5zvMHWo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C222D8DC4B;
        Sun,  6 Oct 2019 21:52:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DB5C58DC4A;
        Sun,  6 Oct 2019 21:52:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 20/20] hashmap_entry: remove first member requirement from docs
References: <20191006233043.3516-1-e@80x24.org>
        <20191006233043.3516-21-e@80x24.org>
Date:   Mon, 07 Oct 2019 10:52:15 +0900
In-Reply-To: <20191006233043.3516-21-e@80x24.org> (Eric Wong's message of
        "Sun, 6 Oct 2019 23:30:43 +0000")
Message-ID: <xmqqeezp490w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17DD34E4-E8A5-11E9-B32E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Comments stating that "struct hashmap_entry" must be the first
> member in a struct are no longer valid.
>
> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  attr.c                  | 2 +-
>  builtin/fetch.c         | 2 +-
>  hashmap.h               | 4 ++--
>  merge-recursive.h       | 4 ++--
>  ref-filter.c            | 2 +-
>  refs.c                  | 2 +-
>  remote.h                | 2 +-
>  sub-process.h           | 2 +-
>  t/helper/test-hashmap.c | 1 +
>  9 files changed, 11 insertions(+), 10 deletions(-)

After this patch, there is one "/* must be the first member! */"
comment left in convert.c, which is both misleading and unfortunate;
a structure 'subprocess_entry' wants to be the first field of any
enclosing structure, where 'subprocess_entry' has a hashmap_entry as
its first field.

