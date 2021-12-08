Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6798EC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 17:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbhLHRIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 12:08:51 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58491 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhLHRIs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 12:08:48 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE17B15D5F7;
        Wed,  8 Dec 2021 12:05:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kbrjWisAVWOx
        T50WpLsVuTyLR1GLJa74fxTF5NjHreI=; b=KSxcKkwzTEvIqmfPWr5RvPcP7ct9
        HfTs+oVEx/EKel2NCPDwHLKCkLg6MT8/jXV0JZZtBxA4YO5SCFCeLbBP2zA29x0B
        ay4Zmuqfz6P1U7LsmMn31Bhj7O32tnhcObULTCxoH+dhxbFtdLzZs+/qMQUGahbL
        7d6EhEzvMuRP3V8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C728515D5F6;
        Wed,  8 Dec 2021 12:05:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CBCFF15D5F5;
        Wed,  8 Dec 2021 12:05:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: Removing -Wdeclaration-after-statement
References: <20211113122833.174330-1-gotlouemail@gmail.com>
        <20211113130508.zziheannky6dcilj@gmail.com>
        <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
        <xmqq7ddbme7q.fsf@gitster.g>
        <211114.868rxqu7hr.gmgdl@evledraar.gmail.com>
        <xmqqilwulims.fsf@gitster.g> <xmqqpmr2j5lq.fsf_-_@gitster.g>
        <61518213-9ce8-00d2-efd9-7f2091c574c4@gmail.com>
        <xmqq1r3eym7f.fsf@gitster.g>
        <211208.86wnkfl1ni.gmgdl@evledraar.gmail.com>
Date:   Wed, 08 Dec 2021 09:05:11 -0800
In-Reply-To: <211208.86wnkfl1ni.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 08 Dec 2021 13:17:16 +0100")
Message-ID: <xmqq35n32fjs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 01D90E28-5849-11EC-AE13-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Why would that be sad? The intent of -Wdeclaration-after-statement is t=
o
> catch C90 compatibility issues. Maybe we don't want to enable everythin=
g
> C99-related in this area at once, but why shouldn't we be removing
> -Wdeclaration-after-statement once we have a hard C99 dependency?

We already heard from people that we do not want vla, and I agree
that we do not want all C99.  decl-after-stmt is something I
definitely do not want in our code, in order to keep the code more
readable by declaring the things that will be used in the scope
upfront, with documentation if needed.  It tends to encourage us to
keep our blocks smaller.
