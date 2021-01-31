Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300F8C433DB
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 00:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7AE264E09
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 00:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhAaAoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 19:44:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53403 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbhAaAoO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 19:44:14 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5ED73A4102;
        Sat, 30 Jan 2021 19:43:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ulK2q0xZFeSJ
        J6Vu//m57t7diso=; b=o4pHafTTm3xUjDfH9hIjhl2x5IlgAa9Kvd3XUMlIELHN
        deWCwcJxG3bQTdrn7RoUU11PVx5NvvUAGbe8TS+dqlnF+V06juEM4tV2+Lx1YGlg
        8C/MTGPxpwaV1D6I1bOFxFTq9s0x7acSsySJ+g2UN2nH8a78kds7lMBQBOozRUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JfXN/e
        9Of9yvrTO/JAsBAZwSxhKY+EWEkDziBMqPL+LcN+0Ox+n4tDjnQx+nWDv374e49y
        LgwfILW42LS2U3ELOwvWlq2CXQShfwaDdxVnp8kbVLQqUDMvlpvRE0UVio9sBHRO
        2aHtEIU0QtMJ2xUcE4Y4wdocxAKicoTT2OaAA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 44E82A4101;
        Sat, 30 Jan 2021 19:43:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F280A40FF;
        Sat, 30 Jan 2021 19:43:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, random_n0body@icloud.com,
        levraiphilippeblain@gmail.com
Subject: Re: [PATCH v2 1/1] MacOS: precompose_argv_prefix()
References: <A102844A-9501-4A86-854D-E3B387D378AA@icloud.com>
        <20210129171512.28167-1-tboegi@web.de>
Date:   Sat, 30 Jan 2021 16:43:30 -0800
In-Reply-To: <20210129171512.28167-1-tboegi@web.de> (tboegi@web.de's message
        of "Fri, 29 Jan 2021 18:15:12 +0100")
Message-ID: <xmqqk0rundfx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 578A78DE-635D-11EB-8FFB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
> ...
> There may be room for more cleanups.
> This change intends to be a bug fix.
> It does cleanup for the Git commands that have test cases in
> t/t3910-mac-os-precompose.sh, more cleanup needs more tests and done
> in future commits.

Also it seems to break many tests only on macOS (quite
understandably).

https://github.com/git/git/actions/runs/524162837
https://github.com/git/git/actions/runs/524265437

