Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3F7C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243946AbiAEUSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:18:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55831 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbiAEUSj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:18:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4470AFD88A;
        Wed,  5 Jan 2022 15:18:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QZpS+KnMTLwyX4KgUBpBgayIIqfmUNPZGmoIHM
        AOXHI=; b=vi2axoyggmpQi7PovIFEgi5qs1p3Swdmc4XEScqoxzTRq3DH6VMlb0
        llFCSBUSpldSDhFp2CxfwVt6aZxQjodUpLMpUlTUe6LqkGnEle3wcNycpyqlf62A
        VObbGWHmrt2ST8MTIqWrOH6eq3Jk6PHnNwACucfoSCXEo1jSrwjw0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CF38FD888;
        Wed,  5 Jan 2022 15:18:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA34EFD885;
        Wed,  5 Jan 2022 15:18:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/8] RFC: Server side merges (no ref updating, no
 commit creating, no touching worktree or index)
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
        <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 12:18:37 -0800
In-Reply-To: <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Wed, 05 Jan 2022 17:27:27
        +0000")
Message-ID: <xmqq8rvuhr6q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB0D0E6E-6E64-11EC-A76B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series introduces a new option to git-merge-tree: --real (best name I
> could come up with). This new option is designed to allow a server-side
> "real" merge (or allow folks client-side to do merges with branches they
> don't even have checked out).

Finally.  merge-tree was added by Linus mostly as a demonstration of
idea to trick other developers into enhancing it to implement a full
merge that does not need to touch the index or the working tree, but
everybody failed to be enticed by it so far.  It is true that it can
be used server-side, but I do not think that is what we want to sell
it as (after all, receiving a push, merging it to the history in the
central repository, and checking the result out to the working tree,
would be a good "server-side" operation to have, but it can be done
today without this series).  The selling point would rather be it is
done mostly in-core, without touching working tree or the index file,
no?

Exciting ;-).



