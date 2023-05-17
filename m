Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BCEC77B7A
	for <git@archiver.kernel.org>; Wed, 17 May 2023 17:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjEQRBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEQRBk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 13:01:40 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0024D1BF3
        for <git@vger.kernel.org>; Wed, 17 May 2023 10:01:39 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9BD3E204EAD;
        Wed, 17 May 2023 13:01:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EUwIetb7nfCem+nOJUG8IDwVwQgQ83HmrqckeW
        6ChJE=; b=iJmv9gmG4ooPkF9A02i2ykAqNd5pvvuAH0YZqaWJHHzNfd3kq9povg
        S+Fj4kFWj8hI6YF6cIShQdBTYjeZCIxNAF5VCLfI5LwgHYZkAjSIU5cGBGitFxQb
        0ggX70lH5qc6Tc+cbvKTYS6BhPPgHdOebrrmFgCWFi7o+yla04nj0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 93FEE204EAC;
        Wed, 17 May 2023 13:01:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BC775204EAB;
        Wed, 17 May 2023 13:01:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Hesse <list@eworm.de>, git@vger.kernel.org,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
References: <20230517070632.71884-1-list@eworm.de>
        <xmqqwn17q7ou.fsf@gitster.g> <ZGT6fEZFumAsZnxu@nand.local>
        <ZGT/eK6+IKlCM6Sg@nand.local> <xmqqcz2yrjbe.fsf@gitster.g>
Date:   Wed, 17 May 2023 10:01:35 -0700
In-Reply-To: <xmqqcz2yrjbe.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        17 May 2023 09:53:09 -0700")
Message-ID: <xmqq8rdmrixc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BEFAC66-F4D4-11ED-B32E-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>         if ! gcc -I $(pwd) -E $f | grep -q 'struct strbuf {'
> ...
> What does the above prove, more than what your regular compilation
> that does not fail, tells us?

It is actually worse than that, isn't it?  This does not even use
the definition in the config.mak.uname, so it is not even matching
your build environment.

I am uncomfortable to use this as an explanation of what due
diligence we did to convince ourselves that this fix should cover
all similar issues.  Perhaps I am grossly misunderstanding what your
investigation did?

Thanks.
