Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1A4C2D0EC
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 01:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04ADB206F7
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 01:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jhXhgO9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgDHBaV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:30:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51044 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgDHBaV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 21:30:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27DD6CB2A9;
        Tue,  7 Apr 2020 21:30:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x4uH5UFbbnyVZqqDqIIwXricgbM=; b=jhXhgO
        9H3BaVThntJPMJfKhotPbDOccVyIPNFrjw8cq0KSG9tVrRMdx0RZ8I91Ms4KGWav
        Iid0E/YG5uW0mVxytmzcbFUGWUnnFSF3B78Pyl+dOAkT3c6yxQBHPE/fqhVrcy2r
        1HZcI+yjhPL5pyQxtH6SYzOzmevRbg34bXMdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l3NTqxbGoL4d2L2wE90xuck1mJeq2AoM
        W9kXhDz9RLzeWdzW1/9B8cb6lLe2ZAy1bQq6Cj8kNJayhBurXFb5n7C/n729WKzV
        Yry6rT0Q9eeqRfYGvUWVgJLAYzBWAFYfF3bUdOaMjMMFHVqxhIH21pmkv4sTxCFg
        fmR4ILMYpZU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F905CB2A8;
        Tue,  7 Apr 2020 21:30:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6EC58CB2A7;
        Tue,  7 Apr 2020 21:30:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] revision: --include-diversions adds helpful merges
References: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
Date:   Tue, 07 Apr 2020 18:30:14 -0700
In-Reply-To: <pull.599.git.1586308923544.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Wed, 08 Apr 2020 01:22:03
        +0000")
Message-ID: <xmqqv9mapxw9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 803AB4E8-7938-11EA-B9AB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     This --include-diversions option could use a better name.

True, but I do not think of a better (or for that matter a worse)
one.  

As a new feature, I think this is a reasonable thing to want,
especially it is in line with the push in the past few years to
treat the first parent history specially.

I wonder how this would interact with the ancestry-path option?
That one also, like the simplify-merges option, needs a limited
traversal, and if this new mode can do without a limited traversal
(in other words, the output can be done incrementally from the tip)
and achieve something similar to what these other options wanted to
show, that would be great.

Thanks.

