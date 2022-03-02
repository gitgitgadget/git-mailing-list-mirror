Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6023EC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 23:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiCBXzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 18:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiCBXzY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 18:55:24 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9628130186
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 15:54:38 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F1B011EAB2;
        Wed,  2 Mar 2022 18:16:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=M6LenNtHH+Nl
        FN0Yl8F9TEEs4VFGR16uMozEBCwNy54=; b=mxa1SzVkg8T7jfZ87vdmI4WiGGh2
        cEBqBxawYnjrKcaBYbn0ZNC/t/hIZUMIUMfRnknIeW2dyZs3d+DXP4JXeD1fJlPi
        qtK+WACJJ6W4E/RFmWN5bj88cFNyI2V9bEaB52h9CJT2u2XyeDbdwOdFxeT3JS1h
        d8YHKObOnwjMgDw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 470E811EAB1;
        Wed,  2 Mar 2022 18:16:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B251411EAB0;
        Wed,  2 Mar 2022 18:16:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 11/15] rev-list tests: don't hide abort() in
 "test_expect_failure"
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
        <patch-11.15-26c838f0560-20220302T171755Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 15:16:51 -0800
In-Reply-To: <patch-11.15-26c838f0560-20220302T171755Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 18:27:20
        +0100")
Message-ID: <xmqqa6e8gd24.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D852BD6A-9A7E-11EC-A39F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change a couple of uses of "test_expect_failure" to use a
> "test_expect_success" to positively assert the current behavior, and
> replace the intent of "test_expect_failure" with a "TODO" comment int
> the description.
>
> As noted in [1] the "test_expect_failure" feature is overly eager to

And noted in [2], it is not a good idea to abuse "test_expect_success"
for this purpose, either, though.

[2] https://lore.kernel.org/git/xmqq4k9kj15p.fsf@gitster.g/
