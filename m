Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE46CCA47C
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 17:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346892AbiFGRwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349392AbiFGRuq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 13:50:46 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE281109BA
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 10:38:23 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6609B1376A8;
        Tue,  7 Jun 2022 13:32:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=P0H4l0EFSr+e
        sFlC2cbw0tBAstg6qSmx7himG7jD5V8=; b=RdjZcLTZ+oD5lyvULGdotJS3afzL
        J4/uGWz/5OHggAt3zj53ycPKh5kHws33+kSE2e7+8BlVSMR8ztT+bbp8x7g/W+a7
        JpG9nzi78CdsZlTv1rxJs1jENLsFJVwCS4wWRV14Mhd/ED31X/dBAXmQyUube0By
        x9x+7LZ5HJDgPSg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C2231376A7;
        Tue,  7 Jun 2022 13:32:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C099F1376A6;
        Tue,  7 Jun 2022 13:32:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH 0/3] remote API: fix -fanalyzer-spotted freeing issue
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
        <cover-0.3-00000000000-20220607T154520Z-avarab@gmail.com>
Date:   Tue, 07 Jun 2022 10:32:53 -0700
In-Reply-To: <cover-0.3-00000000000-20220607T154520Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 7 Jun
 2022 17:50:02 +0200")
Message-ID: <xmqq7d5sxttm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DD388008-E687-11EC-B2C5-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This series is spun off from the recent RFC -fanalyzer series[1] and
> fixes a clear bug in remote_state_clear().

[1/3] is a pretty-much "Meh" (read: if it is already in the code, it
is not worth a patch noise to go and fix it, even though we would
avoid newly introducing the construct in new code), and some part of
[3/3] I am not so sure about (read: it is a mixed bag of changes),
but [2/3] is a bug that I find surprising that nobody noticed at
runtime.

Thanks.  Will queue.
