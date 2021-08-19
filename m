Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A79C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 21:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C586103A
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 21:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhHSV5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 17:57:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61458 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhHSV45 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 17:56:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E17D0D236F;
        Thu, 19 Aug 2021 17:56:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vfTHr2TeprZ61HtWVBA3WYT+NW7E61B5HF0asQ
        hzhPA=; b=AD6LPEmIarWx8RXzAEk8/rUkn2bRloFyR+7qXGTwaqjnZnx0HNZTes
        YQMWcfrO5lvgz2Iu44ZxMVRTQwoWqpDVi32f8rUkJ8ewFRxqkCUYghEAya0vfgOP
        F+sNcJZ50wnsu5OdpS6p1vFsHvqNJnKmyPObqn6xf2gsWh/sdcfiE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7F5CD236E;
        Thu, 19 Aug 2021 17:56:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65988D236D;
        Thu, 19 Aug 2021 17:56:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bja?= =?utf-8?Q?rmason?= 
        <avarab@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 0/4] cache parent project's gitdir in submodules
References: <20210819200953.2105230-1-emilyshaffer@google.com>
Date:   Thu, 19 Aug 2021 14:56:18 -0700
In-Reply-To: <20210819200953.2105230-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 19 Aug 2021 13:09:49 -0700")
Message-ID: <xmqqwnohxfnh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48E433B4-0138-11EC-B0F4-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Since v2, mostly documentation changes and a handful of small nits from
> Junio and Jonathan Tan. Thanks for the reviews, both.

Will queue, but ...

>      +submodule.superprojectGitDir::
>     -+	The relative path from the submodule's worktree  to the superproject's
>     -+	gitdir. This config should only be present in projects which are
>     -+	submodules, but is not guaranteed to be present in every submodule. It
>     -+	is set automatically during submodule creation.
>     ++	The relative path from the submodule's worktree to its superproject's
>     ++	gitdir. When Git is run in a repository, it usually makes no difference
>     ++	whether this repository is standalone or a submodule, but if this
>     ++	configuration variable is present, additional behavior may be possible,
>     ++	such as "git status" printing additional information about this
>     ++	submodule's status with respect to its superproject. This config should
>     ++	only be present in projects which are submodules, but is not guaranteed
>     ++	to be present in every submodule, so only optional value-added behavior
>     ++	should be linked to it. It is set automatically during
>     ++	submodule creation.
>      ++
>     -+	In situations where more than one superproject references the same
>     -+	submodule worktree, the value of this config and the behavior of
>     -+	operations which use it are undefined. To reference a single project
>     -+	from multiple superprojects, it is better to create a worktree of the
>     -+	submodule for each superproject.
>     ++	Because of this configuration variable, it is forbidden to use the
>     ++	same submodule worktree shared by multiple superprojects.

... I think this will regress the format from what I've queued in
'seen' unless you dedent the "Because of this..." paragraph.  It is
unfortunate but AsciiDoc wants the follow-up paragraphs that follow
the single '+' line to start at the left edge without indentation.

