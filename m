Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFD0C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 16:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD0220675
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 16:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cDbOVOEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLCQe7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:34:59 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56595 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLCQe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 11:34:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4BD79A51E7;
        Tue,  3 Dec 2019 11:34:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yT/SKCsUwaUTSLlTj+OGvmqi+ng=; b=cDbOVO
        EwgrAc2htApw1UWnYvziBkVArKRP9NaSJoWujDIjtAcXlmFdEb8rOlb2Lq78ftIa
        xY8vRYN+Me9pJahe7u+EYRIoxbT0dl3yN3PFp59/zeoBEa4UtoHDW3PwhaxHZxEp
        OoXHzLA76endzuToXX8xDdyj015gecyR74SBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LJUQyHAtp1+40pf+DphJdXhVoOOOkO0a
        K9UaTmE+jA8DoAzWQigZFYaVciLitT3PahkO1jFI8AfByB9VAARUMaiF14QDyccx
        gM3Iy1bgzOFdrmV9rOQOhBR5CdP6t7myttiXE+rmjKeNiEW1+LuCtsYm2itfqxBF
        o7uD2nkKDgM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 440C8A51E6;
        Tue,  3 Dec 2019 11:34:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7B7B7A51E5;
        Tue,  3 Dec 2019 11:34:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2019, #01; Mon, 2)
References: <xmqqpnh6yfrl.fsf@gitster-ct.c.googlers.com>
        <20191202210534.GA49785@generichostname>
Date:   Tue, 03 Dec 2019 08:34:52 -0800
In-Reply-To: <20191202210534.GA49785@generichostname> (Denton Liu's message of
        "Mon, 2 Dec 2019 13:05:34 -0800")
Message-ID: <xmqq36e174gj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D602059A-15EA-11EA-94C0-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> vague commit messages from the first round of review. Note that 4/5 has
> a spurious change that should be removed ...

Which was exactly why I did not pick up the last posted one.  In
general, I would not pick up a series when the author is aware of an
issue to be fixed, and more importantly, when the author knows how
to fix that issue.  That way, I do not have to be as intimate with
the issue-and-fix as the author and the reviewer, who came up with
it in their exchange.  That way we can avoid unnecessary mistakes,
trying pick up the latest one and making an incorrect tweak that is
different from what the author and the reviewer agreed to be the
good way forward.

It's a different story when that reviewer is me, of course---in that
corner case, I should be just as familiar with the final issue as
the author would be, so it may save time without risking mixups for
me to add the final finishing touches myself.

