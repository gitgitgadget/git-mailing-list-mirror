Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A9F71F463
	for <e@80x24.org>; Fri, 20 Sep 2019 19:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfITTyb (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 15:54:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61563 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfITTyb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 15:54:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3129B8E3BB;
        Fri, 20 Sep 2019 15:54:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qXJt2JicZnuOIpQMT5q/R/H7xBA=; b=BLbCyH
        6uVFan1jaD0QoO4D50IpQVI5apTaByiAZ0tyoJ/QO859u/XwDVeqvFQouFL2k/hU
        cN28ojEP3c1er90Cot0FLHsD1UwEhfGEgmuOBLIh6z+K5s4Bl1wjqL3+P6NSmkrJ
        KUrE+iysmZQx6rLCTKNXBsG0wlujXFmkwW7cs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GU3ciKZPfeVh88K1s2BhtehdJ/fA0yCU
        wa1mkSuiVt8OyEEsPfpWxV32jy1VzHh6+VzCA6MZZM7iqkmKT+YI5WW0hIuunP2J
        IX0KMEAz5B9e/yZhYudM1LVHa6sm+t2f48/dw9jstXyZgnHzvk8wMH+w7u6z3cib
        BSZA5rqFgxA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28E298E3BA;
        Fri, 20 Sep 2019 15:54:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 55FCB8E3B9;
        Fri, 20 Sep 2019 15:54:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, jeffhost@microsoft.com
Subject: Re: [PATCH v2 0/6] multi-pack-index: add --no-progress
References: <pull.337.git.gitgitgadget@gmail.com>
        <pull.337.v2.git.gitgitgadget@gmail.com>
Date:   Fri, 20 Sep 2019 12:54:24 -0700
In-Reply-To: <pull.337.v2.git.gitgitgadget@gmail.com> (William Baker via
        GitGitGadget's message of "Fri, 20 Sep 2019 09:53:47 -0700 (PDT)")
Message-ID: <xmqqv9tmu4jz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 733770C4-DBE0-11E9-9BAC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"William Baker via GitGitGadget" <gitgitgadget@gmail.com> writes:

> William Baker (6):
>   midx: add MIDX_PROGRESS flag Add the MIDX_PROGRESS flag and update the
>     write|verify|expire|repack functions in midx.h to accept a flags
>     parameter.  The MIDX_PROGRESS flag indicates whether the caller of
>     the function would like progress information to be displayed. This
>     patch only changes the method prototypes and does not change the
>     functionality. The functionality change will be handled by a later
>     patch.
>   midx: add progress to write_midx_file Add progress to write_midx_file.
>      Progress is displayed when the MIDX_PROGRESS flag is set.
>   midx: add progress to expire_midx_packs Add progress to
>     expire_midx_packs.  Progress is displayed when the MIDX_PROGRESS
>     flag is set.
>   midx: honor the MIDX_PROGRESS flag in verify_midx_file Update
>     verify_midx_file to only display progress when the MIDX_PROGRESS
>     flag is set.
>   midx: honor the MIDX_PROGRESS flag in midx_repack Update midx_repack
>     to only display progress when the MIDX_PROGRESS flag is set.
>   multi-pack-index: add [--[no-]progress] option. Add the
>     --[no-]progress option to git multi-pack-index. Pass the
>     MIDX_PROGRESS flag to the subcommand functions when progress should
>     be displayed by multi-pack-index. The progress feature was added to
>     'verify' in 144d703 ("multi-pack-index: report progress during
>     'verify'", 2018-09-13) but some subcommands were not updated to
>     display progress, and the ability to opt-out was overlooked.

Do all of these commits have overly long title with no body recorded
in the commit objects, or is this just a mail sending program
screwing up?

