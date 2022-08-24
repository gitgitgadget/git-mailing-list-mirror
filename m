Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E554C00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 16:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239274AbiHXQrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 12:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbiHXQqK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 12:46:10 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B861E220C1
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 09:46:08 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B86AC145CBB;
        Wed, 24 Aug 2022 12:46:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ycaVFu1NZu3V
        XapBFQmdplib9CHF7LWy/dcZh5XCt6s=; b=LlNdGqjo1QX1506jUV8oO6UGUn6x
        JRwuSjXwCmptq1DwZL5lwjgqlAqe3yeia7C9MfBbVLaKwe5RPwp4+FqIJJe9S89C
        t5rtr+LhrkSenaesGymEB9Gwu57N7tmwiMMybWGpsNVudUFK3cZCPTTAkGqUmhna
        5UQmsfxSjb7uN7U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5E1E145CBA;
        Wed, 24 Aug 2022 12:46:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3E804145CB9;
        Wed, 24 Aug 2022 12:46:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v3 0/2] fsmonitor: option to allow fsmonitor to run
 against network-mounted repos
References: <pull.1326.v2.git.1661259820.gitgitgadget@gmail.com>
        <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
Date:   Wed, 24 Aug 2022 09:46:02 -0700
In-Reply-To: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com> (Eric
        DeCosta via GitGitGadget's message of "Tue, 23 Aug 2022 18:55:39
        +0000")
Message-ID: <xmqqfshl8u9h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3E3ECDD6-23CC-11ED-8F91-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> cc: Johannes Schindelin Johannes.Schindelin@gmx.de cc: Jeff Hostetler
> git@jeffhostetler.com cc: Eric Sunshine sunshine@sunshineco.com cc: Tor=
sten
> B=C3=B6gershausen tboegi@web.de
>
> Eric DeCosta (1):
>   fsmonitor: macOS: allow fsmonitor to run against network-mounted repo=
s
>
> edecosta (1):
>   Check working directory and Unix domain socket file for compatability

Please describe why v3 exists (iow, what was wrong in v2 that v3
improves) in the cover letter.  Especially when you send out two
revisions in less than 12 hours, it gets disorienting at the
receiving end.

Thanks.

>  compat/fsmonitor/fsm-settings-darwin.c | 72 +++++++++++++++++++-------
>  fsmonitor-ipc.c                        | 40 ++++++++++++--
>  fsmonitor-ipc.h                        |  6 +++
>  fsmonitor-settings.c                   | 67 +++++++++++++++++++++++-
>  fsmonitor-settings.h                   |  4 ++
>  5 files changed, 164 insertions(+), 25 deletions(-)
>
>
> base-commit: 795ea8776befc95ea2becd8020c7a284677b4161
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1326%=
2Fedecosta-mw%2Ffsmonitor_macos-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1326/ede=
costa-mw/fsmonitor_macos-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1326
>
> Range-diff vs v2:
>
>  1:  40ce21e85c9 < -:  ----------- fsmonitor: option to allow fsmonitor=
 to run against network-mounted repos
>  2:  46b4efd96cc =3D 1:  cd16d8bb3d6 fsmonitor: macOS: allow fsmonitor =
to run against network-mounted repos
>  3:  9b128a98149 =3D 2:  f977d140afa Check working directory and Unix d=
omain socket file for compatability
>  4:  15c965801f8 < -:  ----------- Minor refactoring and simplification=
 of Windows settings checks
