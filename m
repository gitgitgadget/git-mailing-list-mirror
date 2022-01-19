Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E92C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 19:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbiAST1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 14:27:30 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60703 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240387AbiAST1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 14:27:25 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C1E916FDB7;
        Wed, 19 Jan 2022 14:27:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7+a2JqbMw9ekkOJkEwow2Jx0cZocyHEIMrCJcb
        tpINg=; b=TM/EaWyATd4LbvB1C8Wa4tyo2Bpo/nih+iy2GOsPjQ6J3Td6Yw2jlX
        PAmiPW0Dhx2U77Ntx3TNtYCP04vr0OH5c3wPMwQUbLhtllu8g5sfz344FuTwIwjC
        d/h5ue29Tnfz+Yxf5EUAEa74fY1RsuotYkfeoaKo7qpvMX6E+ctpw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3541216FDB6;
        Wed, 19 Jan 2022 14:27:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8A2D816FDB5;
        Wed, 19 Jan 2022 14:27:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] getcwd(mingw): handle the case when there is no cwd
References: <pull.1120.git.1642618562012.gitgitgadget@gmail.com>
Date:   Wed, 19 Jan 2022 11:27:21 -0800
In-Reply-To: <pull.1120.git.1642618562012.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 19 Jan 2022 18:56:01
        +0000")
Message-ID: <xmqqr193mspy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3505B8E-795D-11EC-B233-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> While technically not possible on Windows via the regular Win32 API, we
> do run the regression tests in an MSYS2 Bash which uses a POSIX
> emulation layer (the MSYS2/Cygwin runtime) where a really evil hack
> _does_ allow to delete a directory even if it is the current working
> directory.

Wow.  I am not sure if I should frown or smile ;-)

>     The bug fixed by this topic was noticed due to test failures while
>     rebasing Microsoft's fork of Git onto v2.35.0-rc1. It may not be
>     desirable to take it into Git v2.35.0 this late in the -rc phase, even
>     though I do plan on integrating it into Git for Windows v2.35.0

I think we can and should take it in my tree (even direct to
'master'), as it is very clear it affects nobody other than Windows,
and even if this has any unintended negative effect, having that
common with "Git for Windows" would only help.

Thanks.
