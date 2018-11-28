Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22061F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 06:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeK1Rfd (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 12:35:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58584 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeK1Rfc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 12:35:32 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C30C72036A;
        Wed, 28 Nov 2018 01:34:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uGjidp32WRPm
        IRAi6e90R5sZ/q0=; b=LiJ5Mpb2suYYJGln1YRQvgBq5nlqJfT9bH+pBZ3pHBIp
        1l9P0qsEudrWPvZHHF50qCro56xld3L6F40GwtBO0nFNtShxa6CLLRal1RIt2h+w
        qG1MpvCs5XaFva5RPcanp8ouGIC9+0yNecufQnDZURpwBFWKj8p5GVTiLqgpNY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=N/lMUC
        xdGO1TcdODS27xkujEgPfpg41x1LkxD5H+HFwPZ1k0khdW3agR/dX/DG0nvUABll
        28auE7o39MSY9y8IYke5Ox5EnX8tSIN8NtxuXASuApZNvZAsW2gVOkjWZFZMxfJV
        nK9dRTa97V7f3yJOHBlbt1qHk/8nL2yi1tb+0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA65720369;
        Wed, 28 Nov 2018 01:34:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CFFD520368;
        Wed, 28 Nov 2018 01:34:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH] advice: don't pointlessly suggest --convert-graft-file
References: <82ccde9ed8a390133852a5d9e07ef471f94db263.1524955439.git.johannes.schindelin@gmx.de>
        <20181127201255.3529-1-avarab@gmail.com>
Date:   Wed, 28 Nov 2018 15:34:54 +0900
In-Reply-To: <20181127201255.3529-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 27 Nov 2018 21:12:55 +0100")
Message-ID: <xmqqy39dr9pt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B8E4D15E-F2D7-11E8-AF0F-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The advice to run 'git replace --convert-graft-file' added in
> f9f99b3f7d ("Deprecate support for .git/info/grafts", 2018-04-29)
> didn't add an exception for the 'git replace --convert-graft-file'
> codepath itself.
>
> As a result we'd suggest running --convert-graft-file while the user
> was running --convert-graft-file, which makes no sense. Before:
>
>     $ git replace --convert-graft-file
>     hint: Support for <GIT_DIR>/info/grafts is deprecated
>     hint: and will be removed in a future Git version.
>     hint:
>     hint: Please use "git replace --convert-graft-file"
>     hint: to convert the grafts into replace refs.
>     hint:
>     hint: Turn this message off by running
>     hint: "git config advice.graftFileDeprecated false"

That's a good one.  The glitch is real, the improvement is obvious,
and the implementation seems to be straight-forward and sensible.

How did you find one, is the real question ;-)

