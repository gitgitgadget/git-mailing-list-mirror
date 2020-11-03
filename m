Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52333C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 20:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFC622226
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 20:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xCfQNMQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgKCUSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 15:18:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64944 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgKCUSF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 15:18:05 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA4DC9AE33;
        Tue,  3 Nov 2020 15:18:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0ZdEPalRENIrk0PFZUXvMZsG7i8=; b=xCfQNM
        Qxd/vOAgKkUrROfQZYHOMq5WLA0+VypFFWZMN4tPAD4CMnOwZOvYoid90UlUuePa
        m2HSwF0YtBGgjiTozLmhKkc3UMuBLimuSo0g8njx3k//zjxzFnxwmnOFpnkRQ+Rk
        f2+lYMDuU8aR+bhXD11LbNjLCCMxZclYghF4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RHN5QG5OxdcsRzhI6BLW2/I7kWMbWVkm
        OL6v8nroZ2p2cmOZ8i7k4HeJETGTx6XBVCUmH2QQeYQi5bB0Kld9/v0E+K9oOd+Q
        xFFJGsO2Qilw0KG+HPRLyHOtqzWieSvJ+zjcPibJ1kXtwPMK4Gk0GanxRefy3VSF
        3DFZBipc/DQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D16CD9AE32;
        Tue,  3 Nov 2020 15:18:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D8999AE31;
        Tue,  3 Nov 2020 15:18:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?xJBv?= =?utf-8?B?w6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] Maintenance IV: Platform-specific background
 maintenance
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
Date:   Tue, 03 Nov 2020 12:18:02 -0800
In-Reply-To: <pull.776.git.1604412196.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Tue, 03 Nov 2020 14:03:13 +0000")
Message-ID: <xmqqtuu6qjnp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD48F7E6-1E11-11EB-B1B2-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is based on ds/maintenance-part-3.
>
> After sitting with the background maintenance as it has been cooking, I
> wanted to come back around and implement the background maintenance for
> Windows. However, I noticed that there were some things bothering me with
> background maintenance on my macOS machine. These are detailed in PATCH 2,
> but the tl;dr is that 'cron' is not recommended by Apple and instead
> 'launchd' satisfies our needs.

Nicely done.

> This series implements the background scheduling so git maintenance
> (start|stop) works on those platforms. I've been operating with these
> schedules for a while now without the problems described in the patches.
>
> There is a particularly annoying case about console windows popping up on
> Windows, but PATCH 3 describes a plan to get around that.
>
> Thanks, -Stolee
>
> Derrick Stolee (3):
>   maintenance: extract platform-specific scheduling
>   maintenance: use launchctl on macOS
>   maintenance: use Windows scheduled tasks
>
>  builtin/gc.c           | 428 +++++++++++++++++++++++++++++++++++++++--
>  t/t7900-maintenance.sh |  86 ++++++++-
>  t/test-lib.sh          |   4 +
>  3 files changed, 498 insertions(+), 20 deletions(-)
>
>
> base-commit: 0016b618182f642771dc589cf0090289f9fe1b4f
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-776%2Fderrickstolee%2Fmaintenance%2FmacOS-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-776/derrickstolee/maintenance/macOS-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/776
