Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D09C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 17:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81BAC64E85
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 17:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhBWR67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 12:58:59 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51451 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbhBWR6d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 12:58:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 11AFD10CD1D;
        Tue, 23 Feb 2021 12:57:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=c6Fbj1qYN0uy
        k+W8oDfH4wdEcDI=; b=cLvu6YKzhF/RDzV/WSKP6RS5Xz0Sb81xbysroXzfhveG
        vvBloaUXQN6SUzO7JidJhCcn8o4MzmqJbdT7ROxnT2XOXuk4sRRoWNoY/qeNK5Uc
        W8CSnOjwSjnx8mE+Tu/BBv876mqsFgkQv6gtN86nbRhrwzzmDZQryTlNqjT4dSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EG4/mt
        VSmFc3NoLF07DDOT64FsGicLFDtNDFGRkeUHuSAl0ZcrWkqA8xyHFcQ3tOODnGFW
        D+JUsrIdX7kxXG5ZzmaJdRvQOb0CsVh27nFrpWCHeYecSDY3kMbgzgyPqk3ij8J0
        XPLvDcFy+Z5KAUgpE3PqOqKPCWR+jq2kQR5Rk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0606510CD1C;
        Tue, 23 Feb 2021 12:57:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 49C7B10CD19;
        Tue, 23 Feb 2021 12:57:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/6] Makefile: add {program,xdiff,test,git,fuzz}-objs
 & objects targets
References: <20210201111715.10200-1-avarab@gmail.com>
        <20210223114132.24345-1-avarab@gmail.com>
Date:   Tue, 23 Feb 2021 09:57:44 -0800
In-Reply-To: <20210223114132.24345-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 23 Feb 2021 12:41:26 +0100")
Message-ID: <xmqqblca4qg7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A27DC2FA-7600-11EB-9832-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Addresses feedback on v2:
> https://lore.kernel.org/git/20210201111715.10200-1-avarab@gmail.com/
>
> Changes:
>
>  - Added .PHONY targets as appropriate
>
>  - Instead of removing fuzz-objs from "all" we now run it in the CI
>    build instead. I think this accomplishes the goal of avoiding
>    bitrot without needlessly compiling them on every build of git.
>
> As Jeff points out in
> https://lore.kernel.org/git/YBuc5iOCCHk4fPqs@coredump.intra.peff.net/
> the use-case for having "{program-xdiff,test,git}-objs & objects"
> targets is a bit harder to justify.

I like these for their clean-up value alone anyway, so ... ;-)

Will queue.  Thanks.

