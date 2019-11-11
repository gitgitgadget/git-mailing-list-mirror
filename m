Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73D0B1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 02:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfKKCpy (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 21:45:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59786 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfKKCpy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 21:45:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 015633DCC5;
        Sun, 10 Nov 2019 21:45:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OJPEdFfUIzknj98l/qkAcNCqVQU=; b=yX6xtg
        Jvjhkhc5ivRtp/Hv//NWARF4EOBlWIZ5xy/sKp+eOjzGu+HlPQet4efI9h0mrcQg
        Ydtx//ZGFWKmQsudEcJy48l8r77wO9Tdgr4pLFKlcAwsT5ySOCw0zycUNnj3kCdP
        ORuDXcpYlLUDx8A5w/F5ZXKlgYzE9juYarwrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EZp/xYKjRC0rPCv0PtyESLABYx6TG/Nu
        5fGTPuauJxfSaFp02wxFMEYxNjRZ/XB8kC/Z1eMBKX0AwkzrSu1HUAmfWkEomVGR
        HSFcIVF6zkEdBE49BO5ACbWukfZWpPKVpiMCojlOtMXAXlWVNUvmfLdERqdObIjI
        atQl853jPik=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDB5C3DCC4;
        Sun, 10 Nov 2019 21:45:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 243113DCC3;
        Sun, 10 Nov 2019 21:45:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v2 15/20] parse-options: move doc to parse-options.h
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
        <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
        <3d1e7e72efca06d18606b6f9dd8c3b6771dfde06.1573034387.git.gitgitgadget@gmail.com>
Date:   Mon, 11 Nov 2019 11:45:50 +0900
In-Reply-To: <3d1e7e72efca06d18606b6f9dd8c3b6771dfde06.1573034387.git.gitgitgadget@gmail.com>
        (Heba Waly via GitGitGadget's message of "Wed, 06 Nov 2019 09:59:42
        +0000")
Message-ID: <xmqqh83bi10h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F91A8F8-042D-11EA-9B7C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> + * Steps to parse options
> + * ----------------------
> + *
> + * - `#include "parse-options.h"`
> + *
> + * - define a NULL-terminated
> + *   `static const char * const builtin_foo_usage[]` array
> + *   containing alternative usage strings
> + *
> + * - define `builtin_foo_options` array as described below
> + *   in section 'Data Structure'.
> + *
> + * - in `cmd_foo(int argc, const char **argv, const char *prefix)`
> + *   call
> + *
> + * 	argc = parse_options(argc, argv, prefix, builtin_foo_options, builtin_foo_usage, flags);
> + *
> + * `parse_options()` will filter out the processed options of `argv[]` and leave the
> + * non-option arguments in `argv[]`.
> + * `argc` is updated appropriately because of the assignment.
> + *
> + * You can also pass NULL instead of a usage array as the fifth parameter of
> + * parse_options(), to avoid displaying a help screen with usage info and
> + * option list. This should only be done if necessary, e.g. to implement
> + * a limited parser for only a subset of the options that needs to be run
> + * before the full parser, which in turn shows the full help message.

After just looking at Documentation/technical/api-parse-options.txt
for real reasons (i.e. not for the purpose of reviewing this patch,
but to review a patch that uses parse-options API), I must say that
applying this change would have made the documentation quite less
useful, at least for my purpose.  

My reading began by "git grep PARSE_OPT_STOP_AT_NON_OPTION" to find
the page that this patch proposes to remove, and in that document,
the list of flags the PARSE_OPT_STOP_AT_NON_OPTION belongs to comes
immediately after the above message, so it was much easier to see
where in the overall API usage the option comes into picture.

With the description moved close to enum{}, I know there would be
less risk of adding a new member without documenting it, but that is
for convenience by the developers of the parse-options API, and not
necessarily makes it convenient to learn and use the API.  I would
have been forced to jump around to hunt for the necessary pieces of
info sprinkled in the header file to form the overall picture, that
a simple flat-file text document would have much easily given me.

So, I dunno.
