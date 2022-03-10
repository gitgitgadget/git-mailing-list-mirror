Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A43C433FE
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 21:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343952AbiCJV1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 16:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiCJV1h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 16:27:37 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12766FABEA
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 13:26:34 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1210318B98E;
        Thu, 10 Mar 2022 16:26:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yDcJqsu158eAZv6S9LcwSlxKYyf/kTFv1VEg3m
        E6Nys=; b=TsI9Oi7NBc30OnABmha7GTzsVFWVvFNtQJOhYXIV6ijCdhigLOW/r/
        TE2KtffA2wMRJfUfdTEToiNs3TGZ3JIN1icTVFz47NjEZO1W06hjM7Jb5Z2wXtB8
        ACAQDG/bjz/0qAJXMVH9RULkZiMWkKa2bA4pX8CUNpMcJNphqmfFE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 042DA18B98D;
        Thu, 10 Mar 2022 16:26:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3E0D018B963;
        Thu, 10 Mar 2022 16:26:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git List Mailing <git@vger.kernel.org>
Subject: Re: RFC: Using '--no-output-indicator-old' to only show new state
References: <CAHk-=wgh8emJn-+FtxN=m_SCPiP6cGKHU-5ozzV9tWBMxn+xcA@mail.gmail.com>
        <xmqqo82dd0qv.fsf@gitster.g>
        <CAHk-=wg+n_-btzoyMqnDYsJxFYAyUh0Kb=TkpS8RiD_h3G=_cA@mail.gmail.com>
Date:   Thu, 10 Mar 2022 13:26:29 -0800
In-Reply-To: <CAHk-=wg+n_-btzoyMqnDYsJxFYAyUh0Kb=TkpS8RiD_h3G=_cA@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 10 Mar 2022 12:40:06 -0800")
Message-ID: <xmqqfsnpcxdm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0529EFC-A0B8-11EC-8437-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So "--new/old"? "--pre/post"?
>
> Or it could be something random, and tie it with the existing "-U"
> option, where "-U+" would be "positive side only", and "-U5-" would be
> "5 context lines, negative side only". Very dense and convenient,
> maybe not all that intuitive?

I often use -W and the above would give us a natural extension, but
I agree that is a bit too dense and totally unintuitive.  As we use
parse-options for patch output formatting options, my pick would be
"--new-only" vs "--old-only" (if there were existing options that
has new/old in their names, "--preimage-only" and "--postimage-only"
would also work, but that's much longer), and let the option parser
accept unique abbreviations like "--new" and "--old".

