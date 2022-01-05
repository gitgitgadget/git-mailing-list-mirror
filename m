Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E46FC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 23:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245331AbiAEXMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 18:12:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63912 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245328AbiAEXME (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 18:12:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E2D6100E1A;
        Wed,  5 Jan 2022 18:12:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dbsZPiS52CfeadSxqsKxQ1oTil/IG23C018/KE
        po4eE=; b=kDM6/mc7hMqUEY/kpW0JV4uTrRvaEXdgMgrUfrxkl011oLnQ7AXkJJ
        ExB9c1Km1vm5uNrBktz2x0g1e2P8K6wJ1HqiuHofluwZ/LyWBYf74PgtGfDQq13h
        SKOZhvsO+VIG4ZMoA39IHvCpU+VNFSfZdzuPaSzVIuDKTU2tWYdNs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AE3F100E19;
        Wed,  5 Jan 2022 18:12:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9FE9A100E18;
        Wed,  5 Jan 2022 18:12:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v6 0/2] name-rev: deprecate --stdin in favor of
 --annotate-stdin
References: <pull.1171.v5.git.git.1641356439.gitgitgadget@gmail.com>
        <pull.1171.v6.git.git.1641423600.gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 15:12:01 -0800
In-Reply-To: <pull.1171.v6.git.git.1641423600.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Wed, 05 Jan 2022 22:59:58 +0000")
Message-ID: <xmqqfsq1g4la.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E44A8AA4-6E7C-11EC-87BE-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Introduce a --annotate-stdin that is functionally equivalent of --stdin.
> --stdin does not behave as --stdin in other subcommands, such as
> pack-objects whereby it takes one argument per line. Since --stdin can be a
> confusing and misleading name, the goal is to rename it to --annotate-stdin.
>
> This is the first step in a process of eventually fully deprecating --stdin.
> This change also adds a warning to --stdin warning that it will be removed
> in the future.
>
> See https://lore.kernel.org/git/xmqqsfuh1pxz.fsf@gitster.g/ for discussion.
>
> changes since v5:
>
>  * fixed documentation example indentation (again)
>  * moved initialization of strbuf from 1/2 to 2/2

This round looks almost perfect.

One I can think of that _may_ be a good idea to change from this
version is to undo the HIDDEN thing, so that "git name-rev -h",
without "git name-rev --help-all", will prominently say that
"--stdin" is deprecated, and make it an hidden option sometime
later, but that is not even "I think we should do so", but more like
"if other people think it is a good idea, I would be supportive".

Thanks.

