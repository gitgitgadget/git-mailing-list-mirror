Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE689C433EF
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 00:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiAOArc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 19:47:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55702 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiAOAra (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 19:47:30 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1C0A11495F;
        Fri, 14 Jan 2022 19:47:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A+B7EUlDbBxZ88NvnXWv8c8fTZEd0XhQmOkDsf
        /LoSk=; b=CO73M4YMv7W9YE0LK+ztQuOCym5Bq9ZXN47cQChSLraYE+2yb85sMR
        vIhhdjV8GQex1eEHWu7LqIHOzs0k5FyUT3GA1/Rw0H6+RplGZjc+xTJBbHvJ5ihs
        7fTJOtfBI00CDcQG0HLLoic3NwCWTdJvhtNalMVwMTuzPRQ11qyKc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C30DB11495E;
        Fri, 14 Jan 2022 19:47:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3797711495D;
        Fri, 14 Jan 2022 19:47:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] README.md: add CodingGuidelines and a link for Translators
References: <pull.1115.git.1642182615339.gitgitgadget@gmail.com>
        <xmqq7db2avij.fsf@gitster.g>
        <6b626f9d-05d6-1903-0b38-e3566e357472@iee.email>
Date:   Fri, 14 Jan 2022 16:47:28 -0800
In-Reply-To: <6b626f9d-05d6-1903-0b38-e3566e357472@iee.email> (Philip Oakley's
        message of "Sat, 15 Jan 2022 00:08:05 +0000")
Message-ID: <xmqqv8yl6d0f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B74FD758-759C-11EC-A357-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Unfortunately it `[]` is not working for me for the new additions.
> GitHub magic?

Let's step back a bit.

Is there somebody reading README.md as a more generic MarkDown?  I
do not think our build procedure creates any rendered document from
it.

My recollection was that we moved from README.txt to README.md for
the sole purpose of showing it https://github.com/git/git/ as more
than just a plain text, so it is a hard requirement that GitHub
flavored MarkDown renderer is happy with whatever we write in the
file.

If GitHub flavored MarkDown only supports [] and breaks with (),
then there is no need for further discussion.  We must stick to []
that has been working for us in the file.

On the other hand, if both () and [] work well at GitHub, I am OK to
replace [] to (), so that it shows well at GitHub and also it can be
used with other MarkDown renderers.

I prefer, from the organizational point of view, to see two patches,
in this order, if we were to go that way.

 [PATCH 1/2] README: link to more contributor documents

which uses [] (not ()).  After this, README.md uses only [],
including the two links you add in this step.  And then

 [PATCH 2/2] README: use "()", not "[]", to please more MarkDown processors

which replaces all uses of [] with ().

That would allow us to queue both, try them out, and we can back out
[2/2] if GitHub's renderer does not like the result.

