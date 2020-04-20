Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9230EC54FCC
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 22:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E732084D
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 22:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TTzWwDsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgDTWHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:07:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50677 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgDTWHE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 18:07:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4160CD2C39;
        Mon, 20 Apr 2020 18:07:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hACCEQShm4M16VBIUgubw22XAq8=; b=TTzWwD
        sQjcQ/fqzUTb8Fy80UXOu+NcpAkcibAB5Uo42FEriIZTIIQs02DbmJZrFpU8+ux5
        WvtfFbFnMp/JZxP4l00DzB7nQOgFPCF2Pf70F0dlc1ZcTGIQt/ppivx6frijmys3
        NJww/+e+7LqNXo8+U2dapkVTGScZ5WOFa/mgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UmHiaTKQ3i3pXeVXvahE3KwutweJjCCv
        LDayZvi0sOWi4zrUkEez3bA+0TeAyFL9oajp+GN6WL3An4oaqUmXxJClaxXrXYcg
        YwxPEUOfwYldAQGZou1rbm5C73PCHLT6EgALtIA1sb1uR02OupUWeptgvtCvbMNt
        zlYX5gJE0tQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3B0E9D2C38;
        Mon, 20 Apr 2020 18:07:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7B4D8D2C35;
        Mon, 20 Apr 2020 18:06:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v9 09/10] Add reftable library
References: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
        <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
        <a30001ad1e8f94a0f3901c1694c3dd660ba1e7c0.1587417295.git.gitgitgadget@gmail.com>
Date:   Mon, 20 Apr 2020 15:06:57 -0700
In-Reply-To: <a30001ad1e8f94a0f3901c1694c3dd660ba1e7c0.1587417295.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 20 Apr 2020
        21:14:54 +0000")
Message-ID: <xmqqeeshrev2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41A71BF2-8353-11EA-AB2B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/reftable/update.sh b/reftable/update.sh
> new file mode 100644

Shouldn't this be executable, even though the readme tells the
reader to run "sh update.sh"?

> index 00000000000..0fd90f89675
> --- /dev/null
> +++ b/reftable/update.sh
> @@ -0,0 +1,14 @@
> +#!/bin/sh
> +
> +set -eux

Use of -e and -u are understandable but -x is a bit unusual unless
one is debugging...

> +((cd reftable-repo && git fetch origin && git checkout origin/master ) ||
> +git clone https://github.com/google/reftable reftable-repo) && \

I think you can discard most of the '\' at the end of the line, as
the shell knows, when you stop a line with &&, you haven't finished
talking to it yet.  That would make the result slightly less noisy
to follow.  We don't rely on "set -e" in this project, but this is a
borrowed file from our point of view---as long as we are using -e,
wouldn't it make more sense to take full advantage of it and do
without &&?

> +cp reftable-repo/c/*.[ch] reftable/ && \
> +cp reftable-repo/c/include/*.[ch] reftable/ && \
> +cp reftable-repo/LICENSE reftable/ &&
> +git --git-dir reftable-repo/.git show --no-patch origin/master \
> +> reftable/VERSION && \

> +sed -i~ 's|if REFTABLE_IN_GITCORE|if 1 /* REFTABLE_IN_GITCORE */|' reftable/system.h

"sed -i" is probably GNUism that does not port well.

> +rm reftable/*_test.c reftable/test_framework.* reftable/compat.*

I presume that this is because we copied everything that match
c/*.[ch] and is not about removing what used to exist in reftable/
directory locally?  Not complaining, but checking if I am reading
the intention of the code correctly.

> +git add reftable/*.[ch]

As we flattened when copying from c/include/*.[ch], this "git add"
can also be flat, which makes sense.  Don't you need to also add the
LICENSE file in there?

Two comments on the design:

 - The list of "what to copy in" largely depends on the upstream
   reftable library; hardcoding the patterns here would make it
   harder to reorganize the files for the upstream project.  I
   wonder if it makes more sense to reserve a single path in the
   reftable-repo and hardcode the knowledge of what to copy out
   there?  That would mean the resulting update.sh here can become

	(git -C reftable-repo pull --ff-only && git clone ...) &&
	reftable-repo/copy-out-to-git-core.sh reftable/

   and the copy-out-to-git-core.sh script that comes with the
   upstream reftable library is the only one that needs to know
   where the license and C source files are in the same version as
   itself, and how to produce $1/VERSION file using the commit log
   message of the commit it comes from.

 - The above procedure (with or without the "who should know what to
   copy" change) would cope well with modified and new files in the
   reftable upstream, but does not remove a library file that used
   to exist (and copied to the git-core project) that no longer is
   needed and shipped.  It appears that there has to be some way to
   remove them.

Thanks.
