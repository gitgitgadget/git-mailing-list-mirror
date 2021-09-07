Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAFEC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 02:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2605B6101C
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 02:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhIGCeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 22:34:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58691 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbhIGCeA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 22:34:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AEC0915AAEC;
        Mon,  6 Sep 2021 22:32:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=8/H04kkvDSzcF8ESdj1lVCUpg
        x7kb/7IHZAVrMZrnJo=; b=Zh3FVdEJ6NMWU/Bg7xk5zeuMvjNUOaFeoxB10VQ3b
        wYFEsulSmgNkKknqTz9auukflYzCrwkR4Bx99KsMXzjF7KXz3mp/UZ4mpfVCQETz
        L1fWTX8UNvczp0BnjeKhfUa0tCKWh8H0ov67OmCUo71JGyBQrzAYF2nQiRVBx7ru
        lg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A838415AAEB;
        Mon,  6 Sep 2021 22:32:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F13D915AAE9;
        Mon,  6 Sep 2021 22:32:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, lilinchao@oschina.cn,
        Elijah Newren <newren@gmail.com>, jerry@skydio.com
Subject: Re: [PATCH v2] apply: resolve trivial merge without hitting
 ll-merge with "--3way"
References: <xmqqczr26i9f.fsf@gitster.g>
        <20210905190657.2906699-1-gitster@pobox.com>
        <87pmtlnyu7.fsf@evledraar.gmail.com>
Date:   Mon, 06 Sep 2021 19:32:50 -0700
Message-ID: <xmqqo895cdyl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E644E99C-0F83-11EC-90DC-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Sep 05 2021, Junio C Hamano wrote:
>
>> +	if (!image->buf || type !=3D OBJ_BLOB)
>> +		die("unable to read blob object %s", oid_to_hex(result_id));
>
> This die() message seems to only be applicable to the first condition
> here, shouldn't this be:

As this directly was lifted from read_mmblob(), it should be exactly
spelled as I wrote.
