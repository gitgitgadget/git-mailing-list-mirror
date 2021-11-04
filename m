Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F138C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 06:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6FD4611C9
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 06:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhKDGaM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:30:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58091 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhKDGaM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 02:30:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5128D16A159;
        Thu,  4 Nov 2021 02:27:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IV/cAjqqrXdaTIiWQWx6+/DXu7jnZfKdPnYDgZ
        7ZFNs=; b=Qq2xNjzplnN7TUyInrlZ2Pf3DHM7mNLZKSFoCDxfVYJD1Itxppbhkw
        x5N+pobJDz1Y9GI+k9cnljnkk4NZX82ONWDHx/mlKjSxW7jWO+e9SsM8/dihI7nS
        auPt6B28z+tVSuDeJAJgmgnsqmKn1kfccpLbmQm3ZoNCqgKIcNAzc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3AC5016A158;
        Thu,  4 Nov 2021 02:27:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BCBD716A157;
        Thu,  4 Nov 2021 02:27:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     phillip.wood@dunelm.org.uk,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Jonas Kittner <jonas.kittner@ruhr-uni-bochum.de>
Subject: Re: [PATCH] rebase -i: fix rewording with
 --committer-date-is-author-date
References: <pull.1123.git.git.1635883844710.gitgitgadget@gmail.com>
        <YYG8aq85UmMMVW4l@coredump.intra.peff.net>
        <101071b2-0b7d-5ee8-ca81-171e08a1ffdf@gmail.com>
        <YYJ1rA8F22SSBeNS@coredump.intra.peff.net>
        <xmqqk0hp6sno.fsf@gitster.g>
        <YYM/bm7cHpJeJoGT@coredump.intra.peff.net>
Date:   Wed, 03 Nov 2021 23:27:28 -0700
In-Reply-To: <YYM/bm7cHpJeJoGT@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 3 Nov 2021 22:03:26 -0400")
Message-ID: <xmqq4k8s4er3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 493D5E9E-3D38-11EC-9DC3-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... I just didn't
> consider it quite the same as a bug that had never been in a released
> version at all (and I know you are often hesitant to throw too much into
> the -rc part of the cycle).

Ah, I see.

2.33.1 was 2.33.0 plus what was queued on 'master' back then for
2.34.0, and more importantly, we do not issue the maintenance track
very often these days (except for occasional security patches).

To put it differently, I didn't have to issue 2.33.1. There was
nothing urgent in there, and it was just that the cycle toward 2.34
was unusually busy and there were too many accumulated fixes on the
'master' front that were 'maint' material.  And for that reason, in
my mind, 2.33.1 cannot be treated quite the same way as feature
releases X.YY.0, when I say "The bug was already present in that
released version, so fixing it is not all that urgent".
