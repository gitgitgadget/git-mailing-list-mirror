Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F80DC433FE
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 21:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245280AbiCBV15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 16:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245232AbiCBV14 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 16:27:56 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C35BF965
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 13:27:12 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 98F9017AFBB;
        Wed,  2 Mar 2022 16:27:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HZiVbrQSHI4v
        r9YLS3Ma/tFq47Xo5SkPyNnkL6Txmh0=; b=SYCUJD6ilCt1l6C6RpZGCr0zbdvV
        0gfHHJybkxsrtr/PaxD/0DmC9KzvQCuviMyqSRsrMHiTGhOaemTaxPR2Yod+MeLv
        iA7opH1D6ouKJkFgmZo6l7/z5mQP81CA9agSKMWQUOiMd/VaYBjNQ+U1MiIjnAad
        DkrBTQYo5vtQ8yc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F71C17AFBA;
        Wed,  2 Mar 2022 16:27:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0822D17AFB9;
        Wed,  2 Mar 2022 16:27:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 05/10] tests: indent and add hook setup to
 "test_expect_success"
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
        <patch-05.10-8dc478460ee-20220302T131859Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 13:27:09 -0800
In-Reply-To: <patch-05.10-8dc478460ee-20220302T131859Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 14:22:24
        +0100")
Message-ID: <xmqqv8wwhwpe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 84BA6130-9A6F-11EC-9605-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Indent various hook setup code in the test suite that's using a manual
> "cat && chmod" pattern.
>
> These should also consistently use "#!$SHELL_PATH" instead of
> "#!/bin/sh", i.e. "test_script". Let's fix that in a subsequent
> commit, which will be easier to review after this smaller change.

These do move them in the right direction, but I am not sure if a
step-wise "first we do <<- trick to kill unindented mess, and then
another "use write_script" to touch the same places, consuming twice
the reviewer bandwidth.  I certainly would hate to have to see these
lines twice X-<.

