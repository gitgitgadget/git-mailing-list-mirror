Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5578BC433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 10:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3378360E96
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 10:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhJYKk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 06:40:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58543 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbhJYKk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 06:40:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 06C47D8D7D;
        Mon, 25 Oct 2021 06:38:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=cm3E6X+yoX+yYJ+t8pcyHcskTn4L3LitjX286uIlQL8=; b=IMAK
        z5yMSLp1v1MRc/wq/ipI2tF7yARO+ORLQ3WBJ+A6/GIenlSnnWuuLRrn/b2lzcRh
        lkdYlWHdIlLSM4smJsJIi0JeLjAuju1DUoTatWHvBrKB/m6/qlqgAwA9YDxxeVCG
        9JCBv+CAUd+oAMC+DfNUUQHK/hSKU0AJLTFBHjY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E33F9D8D79;
        Mon, 25 Oct 2021 06:38:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 418EED8D78;
        Mon, 25 Oct 2021 06:38:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marco Beck <mbeck@eaddrinuse.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: allow selecting key id with env variable
References: <20211024193625.148-1-mbeck@eaddrinuse.net>
        <xmqqsfwq40w7.fsf@gitster.g> <YXXMroOBvDERXIMP@octopus.int.carobme.de>
Date:   Mon, 25 Oct 2021 03:38:04 -0700
Message-ID: <xmqqwnm12xv7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2F6FD66-357F-11EC-A253-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marco Beck <mbeck@eaddrinuse.net> writes:

> On Sun, Oct 24, 2021 at 01:35:04PM -0700, Junio C Hamano wrote:
>
>>Can you explain why we want to add another way to specify the key?
>
> Motivation for that patch was that I usually use the same .gitconfig
> (all dotfiles actually) with multiple identities (e.g. company and private
> email address). It's really convenient to switch to a different identity
> for the rest of the session by just setting e.g. $GIT_AUTHOR_EMAIL and not
> needing to remember adding --author to every invocation of git-commit(1)
> etc. Thought it would be nice to have that convenience for selecting a
> signing key as well.

If you are flipping between two (or more) idents using GIT_AUTHOR_*
but not doing the same for GIT_COMMITTER_*, then your commits may be
made under the same committer identity for both work and hobby
projects, which may not be what you want.  And if you are flipping
between multiple committer idents via GIT_COMMITTER_* environment
variables, the GPG signing key should follow the committer ident at
no extra cost, I would think.


