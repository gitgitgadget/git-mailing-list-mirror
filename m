Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EB3C0031C
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 16:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjITQ6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 12:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjITQ6h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 12:58:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F7DD6
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 09:58:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A9BA8353EF;
        Wed, 20 Sep 2023 12:58:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=A3+Bp2zXChNJ34FVuGMYtzZ01OfSy0eynnpUjs
        mxUIM=; b=lR2Fbl7OQFd9cL+1PfZQM+lJr6EBNJeBNySVgnj8Zte/+0FJuSB3Vp
        wlMD99BWyEAvj+bxc81bcz6tfQCWKygy7gUwrhnDlpL1YXv8t0xmBG4nk559Ytw6
        oGGuwvb1CAD4FhDixEu8khrgFperTqTHP8iNkWNdmi9Ki2sWzqdjY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A2F9B353EE;
        Wed, 20 Sep 2023 12:58:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 465A1353ED;
        Wed, 20 Sep 2023 12:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, johannes.schindelin@gmx.de,
        git@vger.kernel.org
Subject: Re: [PATCH] git-gui - use git-hook, honor core.hooksPath
In-Reply-To: <573c6dc5-2102-cb65-8f71-dea37fff0c9b@gmail.com> (Mark Levedahl's
        message of "Wed, 20 Sep 2023 11:30:08 -0400")
References: <fa876f80-02dc-2c04-0db3-bf3f6269b427@gmail.com>
        <20230917192431.101775-1-mlevedahl@gmail.com>
        <mafs01qetq9kk.fsf@yadavpratyush.com>
        <573c6dc5-2102-cb65-8f71-dea37fff0c9b@gmail.com>
Date:   Wed, 20 Sep 2023 09:58:25 -0700
Message-ID: <xmqq7cokaij2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB0AE7E0-57D6-11EE-AE47-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Levedahl <mlevedahl@gmail.com> writes:

> Certainly, folks rolling their own can pull
> from upstream git-gui, but they take the risk of incompatibility with
> an outdated git. Other tools in Junio's tree have already made the
> switch to git-hook (send-email, git-p4) even though they are usually
> packaged separately from git-core, but also version locked to matching
> git-core.

The cross-version compatibility story is the same for "gitk" (which
I believe "git-gui" took the "do not too deeply depend on the
matching version of git" mantra from).  I can understand the desire
and being able to aim for wider compatibility may be an advantage
for these tools that are not tightly bundled with the rest of the
system.  It allowed them to evolve without waiting for Git to catch
up, for example.

But at this point in their history where these tools are very
mature, it may be fair to say that the cross-version compatibility
is becoming a lost cause.
