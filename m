Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9028DC07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 17:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiIZRtU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiIZRtA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 13:49:00 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595D41036
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:20:46 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B5CE15B86A;
        Mon, 26 Sep 2022 13:20:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QON2l5s1kjJhQ1Q3TM7k/JKQGu5tn/UaG2faK8
        4dgek=; b=nPuRVM0C6YMAFlypYIv4HAMbqi9mQUSURF58zxx1HKCyfI7o6Rdlmn
        L2e12W63XAHjL3Ey+tzJ47Po0qNJJkN9nPFQt/iw1kk0+S928e+N/5/QuW2q8pO2
        CTQkCFzHSagVm+ZYV7esJ28wLLmrIrHdFaf+piFrWNLuNUsJr/tU4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72F5D15B869;
        Mon, 26 Sep 2022 13:20:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CC81015B868;
        Mon, 26 Sep 2022 13:20:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout
 directions
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
Date:   Mon, 26 Sep 2022 10:20:42 -0700
In-Reply-To: <pull.1367.git.1664064588846.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Sun, 25 Sep 2022 00:09:48
        +0000")
Message-ID: <xmqqa66mqcgl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D64BAE4-3DBF-11ED-9035-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Once upon a time, Matheus wrote some patches to make
>    git grep [--cached | <REVISION>] ...
> restrict its output to the sparsity specification when working in a
> sparse checkout[1].  That effort got derailed by two things:
>
>   (1) The --sparse-index work just beginning which we wanted to avoid
>       creating conflicts for
>   (2) Never deciding on flag and config names and planned high level
>       behavior for all commands.
>
> More recently, Shaoxuan implemented a more limited form of Matheus'
> patches that only affected --cached, using a different flag name,
> but also changing the default behavior in line with what Matheus did.
> This again highlighted the fact that we never decided on command line
> flag names, config option names, and the big picture path forward.
>
> The --sparse-index work has been mostly complete (or at least released
> into production even if some small edges remain) for quite some time
> now.  We have also had several discussions on flag and config names,
> though we never came to solid conclusions.  Stolee once upon a time
> suggested putting all these into some document in
> Documentation/technical[3], which Victoria recently also requested[4].
> I'm behind the times, but here's a patch attempting to finally do that.
>
> Note that the "Implementation Questions" section is pretty large,
> reflecting the fact that this is perhaps more RFC than proposal.

Thanks for starting this.  The document even in the current
iteration with a large set of "questions" helped me refresh my
memory on where we are in the bigger picture, and will offer us a
good frame of reference.

