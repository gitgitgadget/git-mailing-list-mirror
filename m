Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274DDC433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 00:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1327613EA
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 00:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbhDFAOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 20:14:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54298 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbhDFAOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 20:14:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6939E125529;
        Mon,  5 Apr 2021 20:14:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jjGrP+BaCIG8YnZ/zMqtk7/f4rw=; b=BxUfua
        +x2zZUyKK8ufKoP1WL2bcsOZ3NtzwZKzvlsrHEchIG2l0q1VcJtqxfXIMoURd1Vw
        wqcWfnj6To2UI+ASxmBMPIA9/k/gFyDw5NdTdfaD5YI0F32Y2PWUiEqU58rX1Gn5
        Xt+FuSoY/wqfL2v4/Zk5Jx/VGlCJtRpvJ9ajk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aE8n3+HTC5mkz25Ww4Z/xEQblS3LBWTl
        uf8J4GG/aLUEsA1ceLgzrnT/G/yh2NPciPHPajjvLAD9WYFJf/1H2PvvwD9OATOw
        aaNaQ/h7tbykgk9uNz7l97uPL69joqDL0kWeHkEsp5qao6F6yPBqhI7wQZjtvI5y
        NuBMeSr4M2Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 627B1125528;
        Mon,  5 Apr 2021 20:14:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 28916125524;
        Mon,  5 Apr 2021 20:13:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Albert Cui <albertqcui@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
        <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
        <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
        <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com>
        <xmqqmtuc49cm.fsf@gitster.g>
        <CAMbkP-SBQMLeM14d9KSnzE44KsfhHPsxWQ1PaskauWPynTJvWQ@mail.gmail.com>
Date:   Mon, 05 Apr 2021 17:13:57 -0700
In-Reply-To: <CAMbkP-SBQMLeM14d9KSnzE44KsfhHPsxWQ1PaskauWPynTJvWQ@mail.gmail.com>
        (Albert Cui's message of "Mon, 5 Apr 2021 16:40:24 -0700")
Message-ID: <xmqq7dlg46d6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBE71ADA-966C-11EB-B5A4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Albert Cui <albertqcui@gmail.com> writes:

> I'm a little confused, and maybe it's because we have different
> definitions of what "installing hooks" means. By installing hooks,
> I meant the addition of the hook command to the config, e.g the
> outcome of:
>
> `git config --add hook.pre-commit.command pylint`

Yeah, I was envisioning that it won't be as a simple, mechanical and
unconditional single command invocation.  Rather, the 'pylint' part
would have to become different depending on the environment (e.g.
what operating system you are on, what editor you prefer, etc.).
And the part that decides what kind of environment you are on would
have to be written by the project that controls the "project-managed
hooks"---unfortunately that would most likely to be an error-prone
part.



