Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CC8C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D88F9205ED
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZjIwAKP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgEMUfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 16:35:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60258 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgEMUfI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 16:35:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4760054FE3;
        Wed, 13 May 2020 16:35:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pskCrfjLPmnKAC/VA8kZiAqmiSI=; b=ZjIwAK
        P53DmvC1Ta4+qeE0ToYQCEwPZZIXajhRtYjGzgGz2oO+kDh0sDql1sm/w50zhZ4i
        SsX7DWcOoDzRRqJiA4gpt4Jwlek1BfjQkCpMtL6leG525ChB2y5UHzCMAJffCJQd
        ZPAw9hjsUKG0nikfVAy97ju38Q/UlzUjCI/w8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X4/cdQ9wDJWhtOLIM/el+Of63zfWHXFz
        ihPN+7mLGrIuNhb6JeDmB1YtWfI81X3Am6DHJ/b0tG+BdO61EHHzbhQz9IbAWpzJ
        LWC4BzYbxmLZ37jQoVpbd9vVGtQrxGoBg7SK9CkrnJ7fu37ibZzALEDY/XC5/vph
        zVoVczGsQl0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B37E54FE1;
        Wed, 13 May 2020 16:35:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71F2F54FDF;
        Wed, 13 May 2020 16:35:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
Cc:     "Guillaume G. via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] submodule--helper.c: add only-active to foreach
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
        <xmqq8shxc7ct.fsf@gitster.c.googlers.com>
        <cf25c55e-e0c8-6374-3adf-84f4314869e9@gmail.com>
        <xmqqwo5fvoe1.fsf@gitster.c.googlers.com>
        <83b37142-f6f0-2f5d-e92c-de3891e8fe18@gmail.com>
Date:   Wed, 13 May 2020 13:35:03 -0700
In-Reply-To: <83b37142-f6f0-2f5d-e92c-de3891e8fe18@gmail.com> (Guillaume
        Galeazzi's message of "Wed, 13 May 2020 22:07:54 +0200")
Message-ID: <xmqqwo5fshe0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A885EAE-9559-11EA-9144-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Guillaume Galeazzi <guillaume.galeazzi@gmail.com> writes:

> The difference is that you repeat twice the same flag. Sometime
> repeating a flag overwrite the previous value,...

I already said I was *not* suggesting a concrete syntax.  The more
important point was to make us realize that we need to think outside
of "active-only" and make sure we can support other kinds of selection
criteria for submodules.

So whatever syntax you would want to use to specify more than one,
combine, and negate, I do not care too deeply, as long as it is in
line with what we use in the other parts of the system ;-).

> Regarding previous example, it use '!' to negate the value. Not all
> people know the meaning of it.

We mark the bottom commit by negating with ^ (e.g. "git log ^maint master"),
we mark "not ignored" entries by prefixing with '!' in .gitignore,
we mark "unset" entries by prefixing with '-' in .gitattributes (the
'!' prefix is used to mark "unspecified" entries), and "rev-list --boundary"
output uses '~' prefix to mean "this is not part of the range".

So there are many one-letter "not" we already use, and there seem to
be no rule to pick which one in what context X-<.

So spelling out "--no-blah" to mean "not with blah" is probably a
good thing to do (especially if readers do not mind being English
centric).

