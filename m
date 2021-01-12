Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5495EC433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 00:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA1B22D57
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 00:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391807AbhALA0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 19:26:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58896 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404227AbhALAFH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 19:05:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4697A127D4E;
        Mon, 11 Jan 2021 19:04:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gn2BcJp6RE8xeYfNSi439czj/yo=; b=CwF5Ti
        lZMzHc02b5Xqnr2yoC1AmQjZPxTZTgiD7V81vMpF826QFChCQ8jGc9/4ju+dJRfT
        cG5g7Q3LNUjOU9e6vpnuyUid1MiqVacmcws8TH9uzT4oNj4eLUJAolgrpNE8GLcb
        jWXV4zvjweaSCqRcoSpAJ77v9zpwuBu7tyJ3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JZGEIr1kmQ0QHo6W2kMYuimCS9VTJPQy
        YVCgWKFdDreOpjeAX4WOZ8DtS0+feDZpfveTJxXATkzKBIEfUSoI3zoUk9nwk5kt
        ZbpHBiFLoCocZOK0NCqWC197FC4u2J9SZWCtYT3euenoD3D8gjpJpgVz7WUH2VlV
        P2l6sQ8ptTI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 410F0127D4D;
        Mon, 11 Jan 2021 19:04:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 882CB127D4B;
        Mon, 11 Jan 2021 19:04:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 0/5] fetch: implement support for atomic reference
 updates
References: <cover.1610027375.git.ps@pks.im> <cover.1610362744.git.ps@pks.im>
Date:   Mon, 11 Jan 2021 16:04:20 -0800
In-Reply-To: <cover.1610362744.git.ps@pks.im> (Patrick Steinhardt's message of
        "Mon, 11 Jan 2021 12:05:11 +0100")
Message-ID: <xmqqo8hv58cb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B984F80A-5469-11EB-9025-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Changes compared to v2:
>
>     - `append_fetch_head` now takes a `struct object_id *old_oid`
>       instead of a `char *old_oid`.
>
>     - Handling of the merge status marker was moved into
>       `append_fetch_head`.
>
>     - I've unified code paths to format the line we're about to write to
>       FETCH_HEAD in atomic and non-atomic cases, which is the new 2/5
>       patch.
>
>     - We now always initialize `fetch_head->fp` and use it to derive
>       whether anything should be written at all instead of using the
>       global `write_fetch_head` variable.
>
> I think this should address all of Junio's feedback. Thanks for your
> input!

Looking good.  I left a few comments on remaining or newly
introduced issues, but IIRC all of them were rather minor.

Thanks, will replace.
