Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5B6C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 17:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376287AbhLBRYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:24:14 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54493 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbhLBRYO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 12:24:14 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3A24415A362;
        Thu,  2 Dec 2021 12:20:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VxZzI3vD2aDogaoEuHJuCVl0CmgE1c5luPPPUv
        XRq4o=; b=AGX3XTX4Fm5VqTyLi/Tf924prccysDE/X8WHoQGG5yZIi6R0ipoTSx
        RklnkXZK1PGrDUTbkTH2Fr7NacztW8Vx2Tnz7CDL3FjxMMnLksO7ftFKTsJf8CxK
        GrFgK6VNEJMkn/GCGYLQdfYQHRF7XmvtEysdADxp8LMzR6d+a/DIM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 335BA15A361;
        Thu,  2 Dec 2021 12:20:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DA2F215A35F;
        Thu,  2 Dec 2021 12:20:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     git@vger.kernel.org
Subject: Re: RFE: Split diff.noprefix for git-diff and git-format-patch
References: <20211202003900.26124-1-jengelh@inai.de>
        <xmqqee6vwj67.fsf@gitster.g>
        <s6r03p31-o7o7-2142-9oo7-qno483r213s5@vanv.qr>
Date:   Thu, 02 Dec 2021 09:20:45 -0800
In-Reply-To: <s6r03p31-o7o7-2142-9oo7-qno483r213s5@vanv.qr> (Jan Engelhardt's
        message of "Thu, 2 Dec 2021 11:27:19 +0100 (CET)")
Message-ID: <xmqqr1auvs7m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 301C8288-5394-11EC-9860-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jan Engelhardt <jengelh@inai.de> writes:

> In interactive git-diff invocations, prefixless is the arguably desired mode,
> so as to facilitate xterm copy-and-paste of the pathname (since a/ does not
> exist, you would want to have it in the copypaste operation anywhere).
>
> I can see why git-format-patch would make use of the "diff.noprefix"
> config directive, but equally, it's a bug that diff.noprefix has such
> broad implications and that there is no way to distinguish between
> diff and format-patch.

I do not think it is unthinkable to have "log.*" configuration
variables that mirror "diff.*" configuration variables and have them
override the broader "diff.*" counterparts, and further add "format.*"
configuration variables to do the same as even narrower override.

I do not offhand recall hearing anybody who wanted format.noprefix
separately in the past, and I take it a sign that people are happy
with paths with prefix in their "interactive" invocations.  I of
course am among those, as that is most of the diff snippet I send to
the list are created when I say "how about doing it this way" in my
response and tell "\C-u \M-! git diff --stat -p" to Emacs to include
the output from the command to the message I am composing.
