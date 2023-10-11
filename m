Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFEACDB465
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 23:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjJKXfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 19:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjJKXfw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 19:35:52 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4139E
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 16:35:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1E5381D7B9;
        Wed, 11 Oct 2023 19:35:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=ea+NAkjv95fcuSxb6RtvVFvZqZw602zhMvoeYs
        dzX+I=; b=E3IeUHzj0HYDtzgzK5JU5oC3kpSpDPZp8nx4BfPp9UC6CepC/urXF8
        cY/eikm6Bd2ZwIEMR0/eoM/rs+T5WYRy2qIfwhYJY4RoEJYO+wr0QKKZS/ZrHbxO
        UMOcNb+EL1Wgdi39E23n/b4+JUQr1bPR0QUZAlyiJ7qy72s3+tjUs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 16DD31D7B8;
        Wed, 11 Oct 2023 19:35:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 42D651D7B7;
        Wed, 11 Oct 2023 19:35:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Kerry <richard.kerry@eviden.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
In-Reply-To: <AS8PR02MB73027943EE0A30DD8DAAD4639CCCA@AS8PR02MB7302.eurprd02.prod.outlook.com>
        (Richard Kerry's message of "Wed, 11 Oct 2023 10:06:25 +0000")
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
        <xmqqttqytnqb.fsf@gitster.g>
        <AS8PR02MB73027943EE0A30DD8DAAD4639CCCA@AS8PR02MB7302.eurprd02.prod.outlook.com>
Date:   Wed, 11 Oct 2023 16:35:34 -0700
Message-ID: <xmqqmswoivg9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0E60038-688E-11EE-93B4-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Richard Kerry <richard.kerry@eviden.com> writes:

> An option might be to state, in config, whether a project, or
> everything, should be managed on the basis of "all untracked files
> are precious" or "files may be explicitly marked precious", or, as
> now, "nothing is precious".

I do not think there is any need to have a separate "all or none"
option.  We do not have to make things more complicated than
necessary.

If all untracked files are precious, a user should be able to say so
with an entry that matches all paths "*" to mark them precious, and
nothing more needs to be done.  By default nothing is ignored and
nothing is precious, until you start marking paths with .gitignore
entries.
