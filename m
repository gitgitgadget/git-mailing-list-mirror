Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E544CC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 19:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244112AbiHHTB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 15:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbiHHTBW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 15:01:22 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BA86160
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 12:01:18 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2E821B3A19;
        Mon,  8 Aug 2022 15:01:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/QoG1E3rKlqeLWisSmWs70SCmYfQbnyfLZYjL1
        qvHyw=; b=mqNOIfIbR9i9YKrckKRey4NGy5lA3/z2Ng4eNjg8muhhywHBu6PHbd
        87mBwIRO5B41I4Gfc9OUlFqVXLqkRiuc593jp9A5UE1ns93arYVGmxP7wjAh0KNf
        hQfMKqBNOGRp4x6tR9/9X/+ToJWCmVWNrOTkRCaa9vOKc7jBEe9So=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B68DB1B3A18;
        Mon,  8 Aug 2022 15:01:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 753DF1B3A14;
        Mon,  8 Aug 2022 15:01:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: [PATCH v2 0/4] rm: integrate with sparse-index
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
        <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
        <xmqqmtcesl6e.fsf@gitster.g>
        <9ae61888-f7eb-0b36-8ed6-cf72104efb9d@github.com>
Date:   Mon, 08 Aug 2022 12:01:11 -0700
In-Reply-To: <9ae61888-f7eb-0b36-8ed6-cf72104efb9d@github.com> (Victoria Dye's
        message of "Mon, 8 Aug 2022 10:51:20 -0700")
Message-ID: <xmqqczdasgp4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 787FCF7C-174C-11ED-8164-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> This test failure is a result of a behavior change in the logging of 'git
> rm' in this series when removing a sparse directory. Patch 4 talks about it
> in more detail [1]; I failed to account for it in my series.

Ah, OK.  When a directory being "git rm"'ed is outside the cone(s)
of our interest, it indeed does feel like a waste to expand the
index only to report which paths in that directory are being
removed.  It would be OK for the behaviour to be different inside
and outside the cone(s).


