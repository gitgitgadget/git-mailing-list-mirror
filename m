Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD76C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 19:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344443AbiCWT42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 15:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344169AbiCWT42 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 15:56:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19F88BF19
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 12:54:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C10541875C2;
        Wed, 23 Mar 2022 15:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hsaZXpTQVicca/LNyhUwU8WPgOSqSOTcFDL6NW
        CtZsE=; b=qptYvskj+ybCk+EAhBAA5qkiZ7JBsaK7cH4AxFWAFqH/+lld23YdZ1
        YA+gZpR6JkINK3ZM2zH0u7itqZkc/A4PpRJvUzYLw1HFoGNQJFLu1+lip97fD9i9
        BLAeGOXGFa9bxAqe+z6BP69v8P44x7Mi9bpA1s21R6s2c+BT55bHY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8B031875C1;
        Wed, 23 Mar 2022 15:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 292461875BD;
        Wed, 23 Mar 2022 15:54:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, martin.agren@gmail.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v14 00/15] ls-tree: "--object-only" and "--format" opts
References: <cover.1647846935.git.dyroneteng@gmail.com>
        <cover.1648026472.git.dyroneteng@gmail.com>
Date:   Wed, 23 Mar 2022 12:54:50 -0700
In-Reply-To: <cover.1648026472.git.dyroneteng@gmail.com> (Teng Long's message
        of "Wed, 23 Mar 2022 17:13:00 +0800")
Message-ID: <xmqqee2ssaut.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19FBA956-AAE3-11EC-B491-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

>  8:  55f1e10d7e !  9:  f4fc377dfa ls-tree: slightly refactor `show_tree()`
>     @@ Metadata
>       ## Commit message ##
>          ls-tree: slightly refactor `show_tree()`
>      
>     -    This is a non-functional change, we use a new int "shown_fields" to mark
>     -    which columns to output, and `parse_shown_fields()` to calculate the
>     -    value of "shown_fields".
>     +    This is a non-functional change, we introduce an enum "ls_tree_cmdmode"
>     +    then use it to mark which columns to output.

I think readers will read "non-functional change" as "we changed it
and made it not function anymore", but you meant something else ;-)

I'll let it pass, though, for the sake of expediency.  The series
somehow ended up to be unnecessarily longer and more complicated,
becoming closer to a complete rewrite of the implementation,
compared to the earlier rounds which were more like incremental
enhancement.

Thanks, will queue.

>          This has the advantage of making the show_tree logic simpler and more
>          readable, as well as making it easier to extend new options (for example,
>          if we want to add a "--object-only" option, we just need to add a similar
>     +    "short-circuit logic in "show_tree()").

