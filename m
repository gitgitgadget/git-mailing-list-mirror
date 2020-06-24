Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A6CC433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4E320781
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LL8LAS6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405083AbgFXQQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:16:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56555 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405071AbgFXQQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 12:16:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D152B60768;
        Wed, 24 Jun 2020 12:16:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wm4chtB7oO8D+8C1fwCK713cD08=; b=LL8LAS
        6DJ9Ns4byhk0kTs1RGSFfiQRhx1sA1TREsyUBW+6Z0Ow+xIl5urzkszkeYp1oO46
        TIn5LAAvz57FgHWUoj6Xiv8Jf1yvGezsQ0+z8PC9clHr9tZ4zGGonS4DSFP+COIw
        LpN3Ss9gLwG4JpVNGafcwXTDwksMPUZHDge5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hjh+Cg+cA8+lsZyBdYJ+PCWC26NvCsGm
        nvgoDwQe2M+GniTMSFmSQxgtcyIN0kl1KAepSth0IdFZR/lOJBjd5S+SrsqEu5n0
        9VDBC/4/gp5cnfS34RW084brPIGXNnrd3HI+8J/29vLh3t43Ai9GjyRYHTlLIDkm
        M1T9pB48HdQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5E5860767;
        Wed, 24 Jun 2020 12:16:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B4C260766;
        Wed, 24 Jun 2020 12:16:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 1/8] fmt-merge-msg: stop treating `master` specially
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <fffdb9944fc2672ccb7eac776cdd18855a1f99dc.1592951611.git.gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 09:16:11 -0700
In-Reply-To: <fffdb9944fc2672ccb7eac776cdd18855a1f99dc.1592951611.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 23 Jun 2020
        22:33:23 +0000")
Message-ID: <xmqqzh8s7838.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05670542-B636-11EA-AA4F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In the context of many projects renaming their primary branch names away
> from `master`, Git wants to stop treating the `master` branch specially.
>
> Let's start with `git fmt-merge-msg`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fmt-merge-msg.c                               |  5 +-
>  t/t1507-rev-parse-upstream.sh                 |  2 +-
>  t/t4013-diff-various.sh                       |  4 +-
>  t/t4013/diff.log_--decorate=full_--all        |  2 +-
>  t/t4013/diff.log_--decorate_--all             |  2 +-
>  ...--patch-with-stat_--summary_master_--_dir_ |  2 +-
>  t/t4013/diff.log_--patch-with-stat_master     |  2 +-
>  .../diff.log_--patch-with-stat_master_--_dir_ |  2 +-
>  ...ot_--cc_--patch-with-stat_--summary_master |  2 +-
>  ..._--root_--patch-with-stat_--summary_master |  2 +-
>  .../diff.log_--root_--patch-with-stat_master  |  2 +-
>  ...root_-c_--patch-with-stat_--summary_master |  2 +-
>  t/t4013/diff.log_--root_-p_master             |  2 +-
>  t/t4013/diff.log_--root_master                |  2 +-
>  t/t4013/diff.log_-m_-p_--first-parent_master  |  2 +-
>  t/t4013/diff.log_-m_-p_master                 |  4 +-
>  t/t4013/diff.log_-p_--first-parent_master     |  2 +-
>  t/t4013/diff.log_-p_master                    |  2 +-
>  t/t4013/diff.log_master                       |  2 +-
>  t/t4013/diff.show_--first-parent_master       |  2 +-
>  t/t4013/diff.show_-c_master                   |  2 +-
>  t/t4013/diff.show_-m_master                   |  4 +-
>  t/t4013/diff.show_master                      |  2 +-
>  ...ot_--cc_--patch-with-stat_--summary_master |  2 +-
>  ...root_-c_--patch-with-stat_--summary_master |  2 +-
>  t/t4202-log.sh                                | 72 +++++++++----------
>  t/t6200-fmt-merge-msg.sh                      | 36 +++++-----
>  t/t7600-merge.sh                              | 14 ++--
>  t/t7608-merge-messages.sh                     | 10 +--
>  29 files changed, 94 insertions(+), 97 deletions(-)

This must have been tedious as the tests with merge commits are all
over the place (I know updating t4013 would not have been too much
of the work as it has its own self-update knob, but it still is a
lot of work to verify that the changes make sense).

Thanks.


