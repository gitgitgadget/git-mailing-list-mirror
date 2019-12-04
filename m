Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF7AC43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 19:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEC12084F
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 19:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ezE6qei2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfLDTZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:25:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55072 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbfLDTZo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 14:25:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1B6A3358C;
        Wed,  4 Dec 2019 14:25:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=decpZ2n6+w7bm6baBHeGa/NZpts=; b=ezE6qe
        i2VR9/GKI4TaTlZXwALi0fCJcV8boKpfwlDjLbl/Fmhf+KEGgiJH4eMt5brk+N7w
        3IZBGhqPMNl2ldIi7LNXSFY9pmYgDhThOpjvHzfSQSqx3fVeommMThY0g6yNoUAg
        u4QZjXv/9+rr3+Rx42e72u7nplMakL65YRCs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TlhFmmth740L0Zd1K64MJbfpNd3ow86A
        NIimPxB2gmsG7o91FQroMk5u3pZNtkqTNK5TJ9C7+xXsUDgVK0y3tUwC+bEnarRN
        KC0psvoOi/GhSubsvTmzb3++m2Y8DUFzsOQ6cmImVwHlaECImDT8GrBcMjXflyOm
        jpgAj11+xH0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA63A3358B;
        Wed,  4 Dec 2019 14:25:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3008233587;
        Wed,  4 Dec 2019 14:25:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 00/13] Add --pathspec-from-file option
References: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
        <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
        <xmqqpnh55oxi.fsf@gitster-ct.c.googlers.com>
        <e4165215-c0f0-8659-8abf-9e91be671e8b@syntevo.com>
Date:   Wed, 04 Dec 2019 11:25:42 -0800
In-Reply-To: <e4165215-c0f0-8659-8abf-9e91be671e8b@syntevo.com> (Alexandr
        Miloslavskiy's message of "Tue, 3 Dec 2019 18:06:27 +0100")
Message-ID: <xmqqfthz51vt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD1E2EB2-16CB-11EA-8EB3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com> writes:

> On 03.12.2019 17:55, Junio C Hamano wrote:
>
>>> Changes from V3:
>>
>> Yikes, perhaps our mails crossed or something?  I think the previous
>> round is already in 'next'.
>>
>> Let's wait and see they cook enough to graduate to 'master', and
>> build a separate series on top to teach other commands the option
>> using the facility introduced by the current series (which is the
>> first 6 patches you sent here).
>
> My intent is to support more commands, so I was working on other
> patches in the background. Today more patches were ready and I wasn't
> sure whether to submit another topic or continue the old one. After
> some thinking, I decided to continue the old one.

Well I've split the new patches into its own topic to queue on the
am/pathspec-f-f-checkout branch, that builds directly on top of the
am/pathspec-from-file branch, for now.  I suspect that they may want
to be two topics (i.e. for "add" and for "checkout/restore"), but
I'd like to keep them out of 'next' either way for a while until the
base topic proves to be solid enough.

> Please give me an advice: when the time comes, shall I prepare even
> more patches and submit a massive branch, or shall I submit today's
> remaining patches, then wait again? I imagine that massive branches
> are scary and will deter reviewers?

Scary will probably not be an issue for the follow-up topics around
the pathspec-from-file theme, but a huge topic tends to wear out the
author and the reviewers, inviting trivial bugs that would otherwise
be found easily go unnoticed.

Thanks.
