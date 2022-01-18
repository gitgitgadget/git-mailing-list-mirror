Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3666AC433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 20:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349110AbiARU0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 15:26:15 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56584 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343552AbiARU0P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 15:26:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3906C16B456;
        Tue, 18 Jan 2022 15:26:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=e03p4GffTt0+
        0HcyxwXgr5DvBPUChfi9rssDqq32vr8=; b=V20ILGE6sbZREBm7S4W3+QUd8ud7
        pCt/2KR3pQXlr3x7xrmotCKZfoUkwplimr0ufcHEv27P38h7f3a9BAwM6TMdoiAf
        6roR/BhEMNWkz/rg2keApWFleVFasC4Fd1h9OH5sO4QNceaa0RyMiF+iKzilcWFY
        R2oWV4eTUDHsrws=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3132916B454;
        Tue, 18 Jan 2022 15:26:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9FAED16B453;
        Tue, 18 Jan 2022 15:26:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: ab/config-based-hooks-2
References: <xmqqy23h4nss.fsf@gitster.g>
        <220118.86a6ftowx3.gmgdl@evledraar.gmail.com>
Date:   Tue, 18 Jan 2022 12:26:10 -0800
In-Reply-To: <220118.86a6ftowx3.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 18 Jan 2022 16:59:04 +0100")
Message-ID: <xmqqczkossd9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E066B91A-789C-11EC-A533-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Jan 14 2022, Junio C Hamano wrote:
>
>> * ab/config-based-hooks-2 (2022-01-07) 17 commits
>>  - run-command: remove old run_hook_{le,ve}() hook API
>>  - receive-pack: convert push-to-checkout hook to hook.h
>>  - read-cache: convert post-index-change to use hook.h
>>  - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>>  - git-p4: use 'git hook' to run hooks
>>  - send-email: use 'git hook run' for 'sendemail-validate'
>>  - git hook run: add an --ignore-missing flag
>>  - hooks: convert worktree 'post-checkout' hook to hook library
>>  - hooks: convert non-worktree 'post-checkout' hook to hook library
>>  - merge: convert post-merge to use hook.h
>>  - am: convert applypatch-msg to use hook.h
>>  - rebase: convert pre-rebase to use hook.h
>>  - hook API: add a run_hooks_l() wrapper
>>  - am: convert {pre,post}-applypatch to use hook.h
>>  - gc: use hook library for pre-auto-gc hook
>>  - hook API: add a run_hooks() wrapper
>>  - hook: add 'run' subcommand
>>
>>  More "config-based hooks".
>>
>>  Will merge to 'next', with minor nits?
>>  source: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com=
>
>
> I'd really like that, if you're OK with it.


Obviously I am not ready to say I am OK (or not OK for that matter),
and that is why I was soliciting comments by the reviewers whose
comments were ignored.

And knowing how proliferate you can be when you want to, adjusting
patches for reviews you received and testing the result thoroughly
would be much better use of time (include the time already spent by
reviewers to comment on the previous iteration), no?
