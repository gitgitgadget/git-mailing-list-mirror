Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D072C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 17:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhKWRWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:22:00 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60779 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhKWRV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 12:21:59 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 252BC15CB74;
        Tue, 23 Nov 2021 12:18:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CwZLfUmaW7e3vAWL1MW5lQK6a99GUsskMpuOvX
        /4pX4=; b=q7rofjYqysTXpRH3rmPG7+2BKPEKPE2iSqOJRxgOwg4qWScPJtTrEb
        ciONMfWTczvQuCCGtNRhePfizwxwm0CS7LRjuBl+C4NswFqViVupqG6Hk/JFzoWG
        haJVC17YK2wDsEwLQRpu6vK21F8K8fuxRPPJ2mf3WlHQhu0fHW24c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0601B15CB72;
        Tue, 23 Nov 2021 12:18:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5F9B615CB71;
        Tue, 23 Nov 2021 12:18:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: preparing for 2.34.1 (2nd round)
References: <xmqqr1b8gkhg.fsf@gitster.g>
Date:   Tue, 23 Nov 2021 09:18:46 -0800
In-Reply-To: <xmqqr1b8gkhg.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        22 Nov 2021 09:37:15 -0800")
Message-ID: <xmqq35nmaiyx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B2A685A-4C81-11EC-81AB-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

There are a few topics [*] to fix regressions introduced in the
previous cycle, which should be in 2.34.1 and I've merged them to
'master'. I hope we can merge them to 'maint' (which now point at
2.34) and tag 2.34.1 in a day or two.

After that, in yet another few days, we will see most of the stalled
topics ejected from the tree, the tip of 'next' rewound, and we will
start the cycle toward 2.35 by starting to take new topics,
hopefully by the beginning of the next week.


Thanks.


Fixes since v2.34
-----------------

 * "git grep" looking in a blob that has non-UTF8 payload was
   completely broken when linked with certain versions of PCREv2
   library in the latest release.

 * "git pull" with any strategy when the other side is behind us
   should succeed as it is a no-op, but doesn't.
   (merge ea1954af ev/pull-already-up-to-date-is-noop later to maint).

 * An earlier change in 2.34.0 caused JGit application (that abused
   GIT_EDITOR mechanism when invoking "git config") to get stuck with
   a SIGTTOU signal; it has been reverted.
   (merge e3f7e01b50 jc/save-restore-terminal-revert later to maint).

 * An earlier change that broke .gitignore matching has been reverted.
   (merge 33c5d6c845 ds/add-rm-with-sparse-index later to maint).

 * SubmittingPatches document gained a syntactically incorrect mark-up,
   which has been corrected.
   (merge edbd9f37 ab/update-submitting-patches later to maint).
