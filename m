Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5774AC4727D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169F42086A
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yCQddnpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgIUWfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:35:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55410 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUWfi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:35:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 23967FCAEB;
        Mon, 21 Sep 2020 18:35:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=edSvDl90Dnvj03OJ+EmsUleKZNM=; b=yCQddn
        pFCwv4hNmRPEawycYajMoyLNsslT7s/qmWwQo8YKnHk5tAmNPUW8dxEd+jIPFyWj
        e6mTkN8z7TGnFC2Y7xj8SSLR7TKhBPtuR8qz6JKQhmPTI6UdtfGEJ+NKVtgH6L5y
        PZ29P5Zh+1uCsEEvIDb1cDyFTF4fLzqhwjo00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yOWZZHJJ4vDwF/XNE66cAnQS2h5qS2e2
        sZ0u0MY2U6s/5XDaxwdBIrmTfAe8+EabZMu61HgKVMz7x8PSe9YgaJZLaAhGqvf3
        Leuq038i2WszcsiW2hRc/ahdPnjY6ytb1ngg540+F8iuakL7yRj3SJ21U3iVutnm
        c4VakG26GxY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C691FCAEA;
        Mon, 21 Sep 2020 18:35:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 66240FCAE9;
        Mon, 21 Sep 2020 18:35:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 5/5] t9902: avoid using the branch name `master`
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
        <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
        <c2c1238b5d9dde684d100fa99437a813140cd615.1600725687.git.gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 15:35:31 -0700
In-Reply-To: <c2c1238b5d9dde684d100fa99437a813140cd615.1600725687.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 21 Sep 2020
        22:01:26 +0000")
Message-ID: <xmqqzh5idah8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2D6BA68-FC5A-11EA-8085-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The completion tests used that name unnecessarily, and it is a
> non-inclusive term, so let's avoid using it here.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t9902-completion.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Here, the tests and the tested feature do not work any differently
on the first-made branch, so the same "just use topic, not the
first-made branch name" used in 3/5 applies here.

Luckily, unlike 3/5 and 4/5, this step does not involve names
derived from the name of the first-made branch name, so 'main'
may be OK as-is, but for consistency across the patches, we may
want to consider using 'topic' here as well.  I dunno.
