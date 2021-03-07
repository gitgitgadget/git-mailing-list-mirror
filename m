Return-Path: <SRS0=HVLo=IF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF12CC433DB
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 20:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AAE965168
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 20:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhCGUl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Mar 2021 15:41:26 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61193 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhCGUlN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Mar 2021 15:41:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3DF912F890;
        Sun,  7 Mar 2021 15:41:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5xn6DAFljbrT
        6RLmPz8oxlRre5s=; b=BA2rMGBO9c3c8bDEKSVpTgaq3/SXWsqbQMNsTsxrp4fW
        fJWbCyd0/CZc9PrD8834DUX5c04jNomN0op+nWYoztI0fGvWTUyHpueLssT9tDpd
        j87dG/crbb7nHg0K1QnO0PiCPFbqMtZ+95S9gNwqN8PrYdZsm/XtTQWO7XRE2ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hKeKCX
        c21sFENo6qaSyXeXs3amNMD29X/L69XHZIlRvRPUz/eHrR4xyJPLIAtQNT9Kffxh
        K+t1v/mN5YNHevaas/hduowLnf6KYs/HqIbE3CDsEq47qcS/GX3hG1uwRql+2K2V
        T2b1ZuHX/OpxrA7mwsdudXZYzvo+FcdFkqLjg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E029012F88E;
        Sun,  7 Mar 2021 15:41:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 27D9A12F88D;
        Sun,  7 Mar 2021 15:41:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Makefile: generate 'git' as 'cc [...] -o git+ && mv
 git+ git'
References: <20210307132001.7485-1-avarab@gmail.com>
Date:   Sun, 07 Mar 2021 12:41:08 -0800
In-Reply-To: <20210307132001.7485-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 7 Mar 2021 14:20:01 +0100")
Message-ID: <xmqq35x68zob.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 73014824-7F85-11EB-8B60-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the compilation of the main 'git' binary to not have the CC
> clobber 'git' in-place. This means that e.g. running the test suite
> in-place and recompiling won't fail whatever tests happen to be
> running for the duration of the binary being regenerated.

I am not sure why I would want to support the workflow this is
trying to help.

I do not want to see a patch on this list claiming that "While the
whole test suite is running, I tweaked the source three times and
recompiled, so some tests may have used my second iteration while
others may have used my third and the final version of the code---in
any case, all tests passed".  And when a patch that was developed
that way came in, I do not want to hear "Yes, the test suite used
mixed binaries, but I KNOW the difference between my second and
third iteration should not matter the parts of the earlier tests
that used the older iteration".

