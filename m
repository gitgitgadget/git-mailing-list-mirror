Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B11C432C0
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 15:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9083420725
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 15:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rqx0Ch5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfLAPrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Dec 2019 10:47:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65347 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfLAPrU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Dec 2019 10:47:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AB023D191;
        Sun,  1 Dec 2019 10:47:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=UGRV4+jXa39P3CZdtrxpDMW3L4A=; b=Rqx0Ch
        5jkHf2/dc3z40Nktn1HXQ3kjQajtSUF8ESWss9uHL9Fvv7Lrnv/ufybJWKvE7Not
        XjHvOvYg6DHFsPAZbD1n2Gxfnct/H03dnYyLdUNKT7+pBrF71HlxMMjNuddKisck
        Lqqw22PiF9qnuzEt2aO6NzdLKwlK1e738i1Cw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xXp/D+OYtthzfu1uCzRoHnP/OpNPBg5U
        NnvOFw9Ebk0a0X9jz6Em6lwKm/+GMirx3GBJgXPpiTJ4tTYeDZ7dqsbtEnPN+Orf
        ZnOCdhBOUBdj51vpmmIcAiQEivPvtNcJiVqHVPfBSnscEUuyrm/Y8jxY5P7NkR/E
        LTMY3rzJnCU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20E0E3D190;
        Sun,  1 Dec 2019 10:47:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C2BB3D18F;
        Sun,  1 Dec 2019 10:47:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/2] checkout: die() on ambiguous tracking branches
In-Reply-To: <pull.477.v2.git.1574872991.gitgitgadget@gmail.com> (Alexandr
        Miloslavskiy via GitGitGadget's message of "Wed, 27 Nov 2019 16:43:08
        +0000")
References: <pull.477.git.1574848137.gitgitgadget@gmail.com>
        <pull.477.v2.git.1574872991.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Sun, 01 Dec 2019 07:47:16 -0800
Message-ID: <xmqqwobgyrnf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA47A1CC-1451-11EA-B5AB-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Please refer to commit messages for details.

When sending an updated series after getting review comments from
others to your earlier round of the same series, please make sure
these reviewers are CC'ed, especially those who thought the earlier
one(s) were not quite right, so that they can say "oh, I changed my
mind.  This round is good", or "I think it is still wrong in this
round, because of ...".

You do not necessarily have to include me on CC: line before the
list seems to have reached concensus that the patches are good.

Thanks.
