Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D8EC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 19:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiFHT1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 15:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiFHT1J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 15:27:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A75BD3183
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 12:27:06 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B393D1A17B2;
        Wed,  8 Jun 2022 15:27:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7bBGY9ZbXMLt0U+q+XfH23756nlpoK7NqrXg47
        OsBlQ=; b=uyItg8C2wHKhbFfay6EEOAU3YrVknkrXxHa6oK+Tep4+RzC0/QjWgX
        GXHdEsLf1Hw14mAketqz+Sr6jpAKUUbcP7QNb2dsN6BdrSDq3UjSohuTvGvB78TL
        60Y2sSwgHfZYCQt8e9IHuw6LgRFGQz+Po1Nmrahgu0TyRZCwDLRcw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AB5601A17B1;
        Wed,  8 Jun 2022 15:27:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 567A81A17AF;
        Wed,  8 Jun 2022 15:27:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
        <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
        <xmqqsfoh4ery.fsf@gitster.g>
        <9244644f-2c80-f23d-f054-3f0c961696af@github.com>
Date:   Wed, 08 Jun 2022 12:27:01 -0700
In-Reply-To: <9244644f-2c80-f23d-f054-3f0c961696af@github.com> (Derrick
        Stolee's message of "Wed, 8 Jun 2022 15:20:45 -0400")
Message-ID: <xmqqo7z3q7lm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9198720-E760-11EC-9341-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> How does a client tell which one it got?  Do we register mimetype
>> with iana to use for these two types of files, and have the HTTP
>> downloader to use the information?
>
> My implementation is much dumber than that: it first attempts to
> parse the file as a bundle (looking for a bundle header) and then
> attempts to parse it as a config file after that. If neither
> succeed, then an error is thrown.

I think that is probably the best implementation after all.

We cannot trust what the other side tells us.  "They claimed that
this is a bundle file and not a table-of-contents, and it does look
like one, but it may be corrupt or even malicious file that may look
like a bundle file on surface, so let's carefully examine it" ought
to be the attitude the receiving side has towards the incoming data.

Thanks.

