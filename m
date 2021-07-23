Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5460C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 01:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A587260E9A
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 01:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhGWBSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 21:18:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65183 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhGWBSa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 21:18:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C397BCEB87;
        Thu, 22 Jul 2021 21:59:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YAWYL299/FIl
        iuoRKN0bMapBEMvkuICE5RrSM4YujfA=; b=xORaFPrAemjvAil57uevN+1I6QzC
        0OTBNAQ8U+xxBsZh3Pejf7WeGync4W7qN/WMM9jtLSgqLWQ85PMzt1XNT93OLI92
        DAa/bTVmJS9r2w1jfHGJb4my7+Lmu5j3wEmSG+dy3Jy1isRf4Vq3r+BtG4NflMAc
        g7q1XV+QjkUgBzI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6670CEB86;
        Thu, 22 Jul 2021 21:59:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9109ECEB84;
        Thu, 22 Jul 2021 21:59:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Tom Cook <tom.k.cook@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] setup: only die on invalid .git under RUN_SETUP
References: <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
        <patch-1.1-fc26c46d39-20210722T140648Z-avarab@gmail.com>
        <xmqq5yx29nj3.fsf@gitster.g> <87mtqet5aw.fsf@evledraar.gmail.com>
Date:   Thu, 22 Jul 2021 18:59:01 -0700
In-Reply-To: <87mtqet5aw.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 22 Jul 2021 23:08:23 +0200")
Message-ID: <xmqqfsw5rdsq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8DA78D1A-EB59-11EB-9656-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I guess another easy alternative would be to issue a warning() in this
> case, which is a relatively light refactoring of passing an error
> message up from the relevant function(s) instead of having it die()
> directly.

I think the end users deserve a warning even when they are running
ls-remote or bugreport in such a corrupt repository-lookalike.  It
might be sufficient to make "git diff [--no-index]" safe enough.

Thanks.

