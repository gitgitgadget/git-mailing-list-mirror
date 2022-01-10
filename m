Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B28C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 18:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbiAJSAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 13:00:07 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63839 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238610AbiAJSAG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 13:00:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 857AB17ECD4;
        Mon, 10 Jan 2022 13:00:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NusvfrksNDiSXWpfdGmtM/xdx4b4IMe1Na83qN
        /Hh6E=; b=xA3ZknhC1GFixBNzO5hvsXCbBAXaLDuWfnFEypTBAJje+cJeHm/F0m
        kfeFJ3rACY1/VpERe3an8MaxxqjNSbbYNXpuX9Yiji5Xaf8Q1TaiiKNuVLsgcUeZ
        pnqqwmPA578CGwT9b4uOJpOTolwV2cFik9CE++22/eAHy/P7F7tRI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7DFF217ECD1;
        Mon, 10 Jan 2022 13:00:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 373CF17ECCC;
        Mon, 10 Jan 2022 13:00:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: Re: [PATCH v2 6/6] refs: skip hooks when deleting uncovered packed
 refs
References: <cover.1638874287.git.ps@pks.im> <cover.1641556319.git.ps@pks.im>
        <0fbf68dbf434986aa971961e20598675b2194d51.1641556319.git.ps@pks.im>
        <xmqq1r1j3s0v.fsf@gitster.g> <YdwyFmqs0MhU0wA6@ncase>
Date:   Mon, 10 Jan 2022 10:00:01 -0800
In-Reply-To: <YdwyFmqs0MhU0wA6@ncase> (Patrick Steinhardt's message of "Mon,
        10 Jan 2022 14:18:14 +0100")
Message-ID: <xmqq4k6b1nfi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 221C4E88-723F-11EC-B7FA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> It does so only if the ref exists in either the loose or packed backend
> though. If trying to update a ref which exists in neither of those, then
> the reference transaction would fail with an "unable to resolve
> reference" error in `lock_raw_ref()`.
>
> So this should behave as expected: deleting a packed ref calls the hook
> once, deleting a nonexistent ref fails and doesn't call the hook at all.

OK.  Your explanation deserves to be in the log message for those
who ask questions next time, not lost in the archive in a message
just answering my question and explaining it only for me.  After
all, that is why I ask questions in my reviews.

Thanks.


