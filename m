Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F74C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 19:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E357A61075
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 19:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344622AbhIATY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 15:24:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58043 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344621AbhIATYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 15:24:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42210E6403;
        Wed,  1 Sep 2021 15:23:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P9MQCRl3TpTeWbE93N7AVYLATliFGz6rGtIYja
        PmM48=; b=i+cOtAfxpiI6J0hBBwzlFZggY9jxCb9ZST1bQcoiTo7Ktuidt0jOHj
        wGLO6tPYvpxPsAyvvI3EoUW8dn4gSx4Rb6UWrQYX+s3f3m2bPTOqKFbDhvecQTmy
        x71BOEAGJG0j2yMU8s3tI7/Ud9q+VMZ9Tjq7OBkxrTmw9NtQ5Ofew=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 398DFE6402;
        Wed,  1 Sep 2021 15:23:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 88FAFE63FF;
        Wed,  1 Sep 2021 15:23:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v5 00/27] multi-pack reachability bitmaps
References: <cover.1617991824.git.me@ttaylorr.com>
        <cover.1630443072.git.me@ttaylorr.com> <xmqq5yvkqidc.fsf@gitster.g>
        <YS/Pqc7lkMlnlBYR@nand.local>
Date:   Wed, 01 Sep 2021 12:23:26 -0700
In-Reply-To: <YS/Pqc7lkMlnlBYR@nand.local> (Taylor Blau's message of "Wed, 1
        Sep 2021 15:08:25 -0400")
Message-ID: <xmqq1r68qevl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15696B54-0B5A-11EC-88E8-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I'm comfortable with saying what's written in the documentation, since
> even though it happens to work today, we should leave ourselves open to
> not supporting directories which aren't alternates.
>
> But I'm equally OK if you would rather drop this hunk from the
> documentation when staging.

Oh, no, don't get me wrong.  I am comfortable with the documented
limitation, as that is what the area experts have agreed that is
reasonable given the expected use case.

I however am much less comfortable with a documented limitation that
we make no attempt to enforce, and that is why the first thing I
looked for after seeing the documentation update was new code to
make sure we reject a random directory that is not our alternate
object store.

Thanks.
