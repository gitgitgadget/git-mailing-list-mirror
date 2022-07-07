Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEA7C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 22:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbiGGWGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 18:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbiGGWGM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 18:06:12 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA882BB05
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 15:06:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EA3261B02E4;
        Thu,  7 Jul 2022 18:06:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kd6VC+78PyGNQiB2nVIEs4HxIjdyi+OlFX9Wv7
        fs2Oc=; b=Zpl40Y0OWAlTHQz9n+x65WkeVBOWr7nDMMftuPRQ7WKnbSg6fkG966
        Wz+PQMgdHrz8svUu0m8hiH3GCDYsYZcpJcJrQh14UlX83wpcdcO97/neM9gwJQTz
        40t0gobUc638it2XgtB4eQjWlL/GwC6RC+jCl2DVQnPq8tj+MDhPs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E2D681B02E3;
        Thu,  7 Jul 2022 18:06:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 991A61B02E2;
        Thu,  7 Jul 2022 18:06:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk, avarab@gmail.com,
        congdanhqx@gmail.com, christian.couder@gmail.com,
        johncai86@gmail.com
Subject: Re: [PATCH v2 0/4] Add support for mailmap in cat-file
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
        <20220707161554.6900-1-siddharthasthana31@gmail.com>
Date:   Thu, 07 Jul 2022 15:06:06 -0700
In-Reply-To: <20220707161554.6900-1-siddharthasthana31@gmail.com> (Siddharth
        Asthana's message of "Thu, 7 Jul 2022 21:45:50 +0530")
Message-ID: <xmqqsfncy3w1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00814FEC-FE41-11EC-A703-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> Changes in v2:
> - The commit_rewrite_person() has been improved by restricting it to
>   traverse only the header part of the object buffers.
> - The callers of commit_rewrite_person() now don't require to call it
>   multiple times for different headers. They can pass an array of
>   headers and commit_rewrite_person() replaces idents only on those
>   headers.
> - commit_rewrite_person() has been renamed to a suitable name which
>   expresses its functionality clearly.
> - More tests have been added to test the --[no-]-use-mailmap option for
>   the tag objects.
> - Redundant operations from the tests have been removed.

I agree with the general direction and the implementation strategy.
I've noticed a few decl-after-statement and also at least one public
helper function that does not need to be public.  Are you building
with "make DEVELOPER=YesPlease"?  It enables -pedantic and -Werror,
-Wdeclaration-after-statement, among other options (see the
config.mak.dev file for the complete list) to help you catch these
locally before sendign your patches to the list.

Thanks.
