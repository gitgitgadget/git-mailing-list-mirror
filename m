Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E10C43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 20:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493B92078A
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 20:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KgPDGA1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgCXU7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:59:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65102 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgCXU7h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 16:59:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 27A7BB084B;
        Tue, 24 Mar 2020 16:59:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zGWx1unH4Fdjy38cyEIra8QMHOI=; b=KgPDGA
        1t3wXXu2bncOntforzQqDgXcsauIioQ9DXus38YUBbP5qQlT3y4SwmOGLhq3sZMb
        Ub9P11d9/eyqZGSbQ6zZb9nCKY4bE29oE8knjJWBFs8TtmDZZr9OdkD5oh2WEXBY
        pF6F7Om4YAp6tcdKzmtgkrXFZ7wR+HxZlJo4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F7pNv+snOWCK+mrhNgwnp9FEqDkMp6gm
        0RGftRtGBLFJPK1fHZMSv9LEUpXEWCXpj10XHu9k1An2y+GugYT3ICwCSe7T4A7n
        6+vghTVhhGn/VBJUqbghNROXasQAoZuY7E1Z1cIUGTMGFtTuS+KI/Eplo0ObVDBq
        9eQepDCkYJE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FFFAB084A;
        Tue, 24 Mar 2020 16:59:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 67627B0849;
        Tue, 24 Mar 2020 16:59:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] tests(gpg): allow the gpg-agent to start on Windows
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
        <287a21f1033b2a74420029c529ad4db956051a85.1584968990.git.gitgitgadget@gmail.com>
        <xmqqd09355h7.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2003242043050.46@tvgsbejvaqbjf.bet>
Date:   Tue, 24 Mar 2020 13:59:30 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2003242043050.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 24 Mar 2020 20:55:04 +0100 (CET)")
Message-ID: <xmqqh7yd1nbh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C3FDE0A-6E12-11EA-97CC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I fear that this distinction really is lost on anybody who does not have
> to deal with MSYS2 on Windows.
> ...
> In short: I am convinced that this is a subtlety in our test suite that we
> cannot reasonably expect any contributors other than Windows-based ones to
> get right, and I am fairly certain that we will just have to keep
> monitoring the CI/PR builds for similar issues and then help the
> contributors by suggesting the appropriate fixes.

IOW, this cannot be made an engineering problem and has to stay a
black art? ;-)

That's somewhat sad, but I guess we have to live with it.

Thanks.

