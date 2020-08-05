Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09652C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D81C320792
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OIOIOWd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgHEWbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:31:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50099 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgHEWbi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 18:31:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E1388A631;
        Wed,  5 Aug 2020 18:31:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4TjuLS5ca/ZtxdjcUv2B6+VF1y0=; b=OIOIOW
        d7ejX7ch0wKBMgA9EggNg49h+gM+8ZIsS+8v0cwRzDK2I0EGWgGDr8sXchol+jaQ
        hJ3wMv+CQfr3zldV6egPg+SirW6t1z3POetUscSSAO9ME95Ke6snIOBgtVgjNrNU
        LRJ5tVIsufbfVOapbKsGtrwWI3I8bdQggKA88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sdBapkMLw1VYPPKvdCkTAQUetsPZ2oLV
        KJghPDWb5Q3rkRMZfIKhWi3L2b3fHr+SYM4/9w0wRy3SXKqbF7cCJDSSF6hCSFbc
        sU7tUHZTWCEJxhf5aeQqKyUvghmFSTslR2ytZIfTHFdB0pC8skdxnimEK4SwCwLv
        tyh4sJoePS0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 257F98A630;
        Wed,  5 Aug 2020 18:31:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB4C78A62F;
        Wed,  5 Aug 2020 18:31:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH  3/3] t/t4013: add test for --diff-merges=off
References: <20200805220832.3800-1-sorganov@gmail.com>
        <20200805220832.3800-4-sorganov@gmail.com>
Date:   Wed, 05 Aug 2020 15:31:35 -0700
In-Reply-To: <20200805220832.3800-4-sorganov@gmail.com> (Sergey Organov's
        message of "Thu, 6 Aug 2020 01:08:32 +0300")
Message-ID: <xmqq3650n2rc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BBC0CBA-D76B-11EA-8973-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  t/t4013-diff-various.sh                       |  1 +
>  ...--diff-merges=off_-p_--first-parent_master | 78 +++++++++++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 t/t4013/diff.log_--diff-merges=off_-p_--first-parent_master
>
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 40e222c94520..86fb11cecc61 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -298,6 +298,7 @@ log --root -c --patch-with-stat --summary master
>  # improved by Timo's patch
>  log --root --cc --patch-with-stat --summary master
>  log --no-diff-merges -p --first-parent master
> +log --diff-merges=off -p --first-parent master

I think we want to also test it in a different order, e.g.

    log --first-parent --diff-merges=off -p master

other than that, these three patches all look good to me.

Thanks.
