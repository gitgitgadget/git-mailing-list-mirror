Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32490C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13AA9613A0
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243336AbhI2AOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 20:14:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62722 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhI2AOW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 20:14:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EF96E2CA9;
        Tue, 28 Sep 2021 20:12:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mJutFO3XX5xj
        pwF6xDXy8Kc+cDKDfZpOaYI4BnfMyBM=; b=GA3jwboq/EMkKsgCcybmrgNUEyXc
        iSkFY/Cs5SJdQbR5/coy/9Qz6dfD7fNBgJtmgmKr/a6E8chm9OJ6V9TgDzeaq4O6
        9798SJCyGad1vC8BZR8KGkeuaCappA1yJqflE0VNO+0erzF0iERqj1iTnaUiqUco
        fIigi6AOSodBSVI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 050BAE2CA7;
        Tue, 28 Sep 2021 20:12:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 62D2AE2CA5;
        Tue, 28 Sep 2021 20:12:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 03/10] parse-options.[ch]: consistently use "enum
 parse_opt_result"
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
        <patch-03.10-fbcbaa47329-20210928T130905Z-avarab@gmail.com>
Date:   Tue, 28 Sep 2021 17:12:40 -0700
In-Reply-To: <patch-03.10-fbcbaa47329-20210928T130905Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 28 Sep
 2021 15:14:24
        +0200")
Message-ID: <xmqqee98gryf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F6425810-20B9-11EC-839B-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Use the "enum parse_opt_result" instead of an "int flags" as the
> return value of the applicable functions in parse-options.c.
>
> This will help catch future bugs, such as the missing "case" arms in
> the two existing users of the API in "blame.c" and "shortlog.c". A
> third caller in 309be813c9b (update-index: migrate to parse-options
> API, 2010-12-01) was already checking for these.

As I said, this one I am happy about.  The previous step had a
change related to this enum mixed in it (by mistake, I think),
which belongs here instead.
