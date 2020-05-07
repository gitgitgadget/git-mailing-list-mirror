Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228A8C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A69208E4
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PWxpYnNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgEGTxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 15:53:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57347 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgEGTxM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 15:53:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C6D2533E8;
        Thu,  7 May 2020 15:53:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qC0D4hvho6zEvQ3Pvy9Pz4fsZpk=; b=PWxpYn
        NlvFxZt43jTFQ+c/m5rrV+Qs6sDx3eL1rF+RQHLKOPgB2MhPBX5iepJ7fUcqkPQM
        Bado26HW4Sx+4PVbS77Z3/52/045pwa75gQgm7GOR+njZ0jiqTjMg+xe3JqmwbGd
        siOKssIqT6VAEIZe3pG1/FhqEpRZqHXsKcLZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q9q1CrI2aqSgTP1VAtbh506xbo2fdw7R
        lQf7Mh/PkjC2vIOpF2qpCBYLF5/Oqb1ervIcUtuVYIDYzBx4PCpVyUUMsozerFGI
        MqhJBdkHaXwUDTjZTE4QFdIWpu7mMX/jbpSjBZyzpiDKldf4SIv4UvHooPOHD3dp
        4Y6bSezXDOc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 656EA533E6;
        Thu,  7 May 2020 15:53:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F0660533E5;
        Thu,  7 May 2020 15:53:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] ci: allow per-branch config for GitHub Actions
References: <cover.1588607262.git.congdanhqx@gmail.com>
        <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
        <20200504162311.GE12842@coredump.intra.peff.net>
        <20200504215824.GC45250@syl.local>
        <20200504233634.GB39798@coredump.intra.peff.net>
        <20200505002055.GC64230@syl.local>
        <20200505164326.GA64077@coredump.intra.peff.net>
        <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
        <20200505182418.GA66702@coredump.intra.peff.net>
        <20200505210451.GA645290@coredump.intra.peff.net>
        <20200507162011.GA3638906@coredump.intra.peff.net>
Date:   Thu, 07 May 2020 12:53:09 -0700
In-Reply-To: <20200507162011.GA3638906@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 7 May 2020 12:20:11 -0400")
Message-ID: <xmqqwo5n34ka.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60B56A8E-909C-11EA-9CA1-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +        - id: check-ref
> +          name: check whether CI is enabled for ref
> +          run: |
> +            enabled=yes
> +            if test -x config-repo/ci/config/allow-ref &&
> +               ! config-repo/ci/config/allow-ref '${{ github.ref }}'

Is it deliberate that the output from the script is not redirected
to >/dev/null, which would mean they are allowed to do something
that looks like:

		echo "::set-output name=enabled::frotz"

or emit other random ::string-that-affects-github-actions to its
standard output stream?

> +            then
> +              enabled=no
> +            fi
> +            echo "::set-output name=enabled::$enabled"
