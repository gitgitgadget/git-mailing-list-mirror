Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F57BC2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 22:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6B6207BB
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 22:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HiFqUDiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgKCWCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 17:02:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54569 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbgKCWCp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 17:02:45 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6571BE5A4D;
        Tue,  3 Nov 2020 17:02:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6Ubv2epFbZuuR0dIGaChoGJ6QBg=; b=HiFqUD
        izdsuMUrhywvQHgx20+Y4QVcadW1Fec+sCRm1Qp9bZ/ms+eXPAVkrrL7WUh5u8Md
        QeqHzZq6F6Lp2ZHvP39f/TGQFOH5ApboLt8OY/SeuszYapp7C3dt/LauMxrfLv9z
        EhbdLg8qUkWP10KwGWxr0dv2I8J3Pm88HJ/5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CP4UuGn/MN2OLzgPyfiKbHRTyJMjFJ8N
        W1QOvGunzmDktCCkGFoE5yI826c4CmMyLo6zb0y/S3CkRB3WTRhUoDRoa/gYEkiE
        bXU4Ow8xRmTwSqGd4TAlfw4Im/iyVU0rh1+geTS/uxxg/iOyZgx8KdLyISAAOzgx
        9u/3LgqRxb4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D652E5A4C;
        Tue,  3 Nov 2020 17:02:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8C8B5E5A4B;
        Tue,  3 Nov 2020 17:02:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Chris. Webster" <chris@webstech.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: make the whitespace checker more robust
References: <pull.778.git.1604418931303.gitgitgadget@gmail.com>
Date:   Tue, 03 Nov 2020 14:02:38 -0800
In-Reply-To: <pull.778.git.1604418931303.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 03 Nov 2020 15:55:31
        +0000")
Message-ID: <xmqqsg9qp08x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4AB27760-1E20-11EB-90F0-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>     One thing we discussed earlier whether the log should be pasted as
>     pre-formatted text or not, and we fell on the side of not pre-formatting
>     it. However, in my tests, this does not look right
>     [https://github.com/dscho/git/pull/18#issuecomment-721160985], and it 
>     looks much better pre-formatted
>     [https://github.com/dscho/git/pull/18#issuecomment-721167209] (even if
>     we unfortunately lose the direct link to the commit
>     [https://github.com/dscho/git/commit/68317764849af81b17c4b31906da20bdf2c52082]
>     ).

What is shown in the log are lines from the source files that were
checked, and we expect our source files are shown and edited in
monospace with tabwidth=8, I think it does make sense to force the
"pre-formatted" output.

Thanks.
