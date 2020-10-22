Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7209C388F7
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 19:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 520FD24658
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 19:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n+uE1jZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370300AbgJVTaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 15:30:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64518 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509624AbgJVTaE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 15:30:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2598EEC2E;
        Thu, 22 Oct 2020 15:30:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=15oiWY2s2JJmNihWuuMh5re/HUQ=; b=n+uE1j
        Zk9tFxwJScTxoVBKyM7VI9k8AKFOExOKV5DrMjWmvdb/6zGHex9lfYWg0ytPLu1P
        W9XBXxab82a7YbUyk+mMNQfgh/2odvle4GXbUPQjL4kSrEmARcEVqzsDcZxdCJuT
        ojxH+qovbZq2/AbD11GlacStVEaT7g4D10uf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Mu4UElKZY5KPiw8dvG+eJ3uSHocbUBc3
        9AggAKE92Vf8xLz7+nitgyagE75hPq+C8GOpbvFNcI+Bp+8qZidCCb7aSbY+wEm5
        9Ssz3x0WfPy5Q/kkmbFib1eM6Y0qgdJB2cm0zVTc2OL/qvj69lYe7IhClA5v6h0b
        6WR71ZUHhZg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C2ACEEC2D;
        Thu, 22 Oct 2020 15:30:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B2546EEC25;
        Thu, 22 Oct 2020 15:29:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Nikos Chantziaras <realnc@gmail.com>
Subject: Re: [PATCH] svn: use correct variable name for short OID
References: <rmpve5$q2s$1@ciao.gmane.io>
        <20201022011811.853465-1-sandals@crustytoothpaste.net>
        <20201022030051.GB1480820@coredump.intra.peff.net>
        <20201022032400.GC1480820@coredump.intra.peff.net>
Date:   Thu, 22 Oct 2020 12:29:58 -0700
In-Reply-To: <20201022032400.GC1480820@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 21 Oct 2020 23:24:00 -0400")
Message-ID: <xmqq3626m53d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F97360EE-149C-11EB-BC81-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The fact that we have to touch every perl file is a bit ugly. So I
> dunno. Maybe worth it, or maybe too nasty.

Just a single pragma per file?  That does not sound too bad at least
to me.

Thanks, queued.

> Note that the mapping from the GIT_TEST_* form to the GIT_* form in
> test-lib.sh is necessary even if they had the same name: the perl
> scripts need it to be normalized to a perl truth value, and we also have
> to make sure it's exported (we might have gotten it from the
> environment, but we might also have gotten it from GIT-BUILD-OPTIONS
> directly).

And GIT_PERL_FATAL_WARNINGS is cleared together with the other GIT_*
options upfront, so here we only need to worry about setting and
exporting it.  Makes sense.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index ef31f40037..dfad820dd4 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -499,6 +499,12 @@ then
>  	export GIT_INDEX_VERSION
>  fi
>  
> +if test -n "$GIT_TEST_PERL_FATAL_WARNINGS"
> +then
> +	GIT_PERL_FATAL_WARNINGS=1
> +	export GIT_PERL_FATAL_WARNINGS
> +fi
> +
>  # Add libc MALLOC and MALLOC_PERTURB test
>  # only if we are not executing the test with valgrind
>  if test -n "$valgrind" ||
