Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDEFC43464
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 20:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B4420717
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 20:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GaWXMCKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgIQUEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 16:04:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56085 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgIQUEN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 16:04:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFD5D6890D;
        Thu, 17 Sep 2020 15:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UjtvM5cx0x/Ulbx6N28ognDzt/A=; b=GaWXMC
        KNcTIl55uPwfS0Fi7OfkwxYUegmubUwa3SDzR2bSghbfwbbTB69UMca7B1sg5NOB
        zk5mwOcjOmXHv93ZgpiWtz82k9AcqSy8rXm0pjlD3ajP3TaYoITl6nuGJYCaCLCj
        scvj9hNtKProQmR4YRHyN9HweBjhGyil1Tw7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uj7pwCWgbkLv3Fs7LT3IV6qyoq4Zag6A
        e3nE85GXsAfmdehTO4IqjwU/oDh2zgRSqjEYNdDQlO9fSfPJBDxKeYEDjsnPm052
        CraQWdcvxd6W7MQO7IB2ijE+wd7nu9Gf7l8Yr+zDBgCCc9iBJmh3TQniZVALqTFl
        ChuGLkIbJno=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8D816890C;
        Thu, 17 Sep 2020 15:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3DE7768908;
        Thu, 17 Sep 2020 15:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2020, #04; Wed, 16)
References: <xmqq8sd9t679.fsf@gitster.c.googlers.com>
Date:   Thu, 17 Sep 2020 12:52:47 -0700
In-Reply-To: <xmqq8sd9t679.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 16 Sep 2020 20:47:38 -0700")
Message-ID: <xmqqlfh8qiy8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CB235E8-F91F-11EA-9165-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * ab/mediawiki-fixes (2020-09-16) 15 commits
>  - remote-mediawiki tests: annotate failing tests
>  - remote-mediawiki: fix duplicate revisions being imported
>  - remote-mediawiki tests: use CLI installer
>  - remote-mediawiki tests: use inline PerlIO for readability
>  - remote-mediawiki tests: replace deprecated Perl construct
>  - remote-mediawiki tests: use a more idiomatic dispatch table
>  - remote-mediawiki tests: use "$dir/" instead of "$dir."
>  - remote-mediawiki tests: change `[]` to `test`
>  - remote-mediawiki tests: guard test_cmp with test_path_is_file
>  - remote-mediawiki tests: use test_cmp in tests
>  - remote-mediawiki tests: use a 10 character password
>  - remote-mediawiki tests: use the login/password variables
>  - remote-mediawiki doc: bump recommended PHP version to 7.3
>  - remote-mediawiki doc: link to MediaWiki's current version
>  - remote-mediawiki doc: correct link to GitHub project
>
>  Modernization and fixes to MediaWiki remote backend.
>
>  Will merge to 'next'.

This series goes in good direction, but I think there were a few
good suggestions for improvement in the review.  I'll mark it as
"expecting a reroll" instead.

Thanks.
