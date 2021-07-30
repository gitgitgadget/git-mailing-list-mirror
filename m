Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9435FC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 19:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CAA960E9B
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 19:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhG3TvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 15:51:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57027 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhG3TvE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 15:51:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 464DAE9A20;
        Fri, 30 Jul 2021 15:50:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RYCemunoO17kqNPqi9q/gWXWj868I9ggTQV2D9
        HeAhc=; b=o5enR0hihxC9pHWs7X1obkIkVpzAS2Pp3kqovKccQVTwuNXLxlxFGv
        yIOalo/AbXDS8UvrZ/szeQgthNcauZ2yDfdo/W+oRvh46o328OyfFY56hAX7nJRf
        ZoiYjt3amJd+Ncfr0zv7CEagooIHo1UF/qPsITB+bwCwS54pv5v40=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3AD92E9A1F;
        Fri, 30 Jul 2021 15:50:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC62BE9A1E;
        Fri, 30 Jul 2021 15:50:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 0/5] drop support for ancient curl
References: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
        <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
        <xmqq7dh71v5g.fsf@gitster.g>
Date:   Fri, 30 Jul 2021 12:50:57 -0700
In-Reply-To: <xmqq7dh71v5g.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        30 Jul 2021 12:03:39 -0700")
Message-ID: <xmqqy29nzila.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75F8F55C-F16F-11EB-A2D4-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>     +    The documentation[2] currently claims that it was introduced in
>>     +    7.16.4, but the symbols-in-versions file correctly states
>>     +    7.17.0[3].
>>     +
>>     +    I've submitted an upstream
>>     +    patch (<patch-1.1-953bab490-20210730T170510Z-avarab@gmail.com>) to the
>>     +    curl-library mailing list fix the documentation.
>
> I am not sure how to get to the patch, but I suspect you might be
> misreading "up to X", which is different from "before X".  Once cURL
> mailing list confirms my suspicion, we would need to come back and
> update this patch again.

Ah, I found it at https://curl.se/mail/lib-2021-07/0058.html

Nobody seems to have responded yet, but I do think you are
misreading what "X was known under a different name Y up to 7.16.4"
means.  These places do not say "before 7.16.4", which would have
implied that as of 7.16.4 you would be able to use X (not Y).

But because "up to" is "less than or equal to but not more than"
(e.g https://dictionary.cambridge.org/us/dictionary/english/up-to),
what applies to 7.16.3 also applies to 7.16.4, but not to 7.17.0.
IOW, the feature X was known as Y when 7.16.4 was current, so our
use of X would not have worked with that exact version.  We would
have needed to wait until the next version (7.17.0).

