Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7835ACA101B
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 22:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244811AbjIEWCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 18:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjIEWCH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 18:02:07 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88513FA
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 15:02:02 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A17A21B9D72;
        Tue,  5 Sep 2023 18:02:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=2fYf3OnEkCRNEJ66HF/ZlD0XX6GijnvZq3edHE
        BpWTQ=; b=rRa/vzZC9aVlkAXWT0mTewOI52yv/we1uNGicSoL8ftOS7GvKe5Z//
        ezXlBMpx1WkTjUe3aYjEH3CJSn+P+RJnXUZKk5Qw+MSCjAwC74CGbuo5pP1S64R4
        xI0ULQgBdgIc17MaPBGafSmz33XGXg65b4IDHt3X0vwYgkSyI8OD8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BC1F1B9D71;
        Tue,  5 Sep 2023 18:02:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FEB61B9D70;
        Tue,  5 Sep 2023 18:01:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wesley Schwengle <wesleys@opperschaap.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] builtin/rebase.c: Emit warning when rebasing
 without a forkpoint
In-Reply-To: <2e1f1d2a-4aec-4b60-bc96-685a27055c06@opperschaap.net> (Wesley
        Schwengle's message of "Sun, 3 Sep 2023 08:34:54 -0400")
References: <xmqq1qfiubg5.fsf@gitster.g>
        <20230902221641.1399624-1-wesleys@opperschaap.net>
        <20230902221641.1399624-3-wesleys@opperschaap.net>
        <xmqq4jkckuy7.fsf@gitster.g> <xmqqlednuagl.fsf@gitster.g>
        <2e1f1d2a-4aec-4b60-bc96-685a27055c06@opperschaap.net>
Date:   Tue, 05 Sep 2023 15:01:58 -0700
Message-ID: <xmqqfs3ss2i1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6827A22-4C37-11EE-937A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wesley Schwengle <wesleys@opperschaap.net> writes:

> I like the idea of the warning, but it could be loud indeed and you'll
> want to turn it off in that case.

I tend to think that a single-liner warning would not be too
intrusive (it might actually be too subtle to be noticed),
especially given that it is issued only when the fork-point does
move the target commit from what was given.

Giving a shortlog of what is lost in the history does sound like a
bit too loud, I am afraind, though.
