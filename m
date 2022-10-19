Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44ACC4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 19:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiJSTna (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 15:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJSTn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 15:43:29 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550791B76C6
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 12:43:28 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA6871C2240;
        Wed, 19 Oct 2022 15:43:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vk8Ds3gEzSmS
        dvzstMTlq001QRwEirZbN72RL6heA3c=; b=E23RiA12uZqBdC6RXNOiMdW8HIx6
        qjm30s0MtMHsl0OPZsEB+8brCjAduE076SucVihM8yJ7u2iedMbNEbmlftAQKyjt
        z5Y4NvJQuK9lbnSy2Go+1tdVKVed7lK4aAKXJE3Fw1LQQJkFGWwJ0F4fm9OOar9N
        zx75SEGmGf3wqI8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B21601C223F;
        Wed, 19 Oct 2022 15:43:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA7331C223E;
        Wed, 19 Oct 2022 15:43:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3?= =?utf-8?Q?n?= 
        <carenas@gmail.com>, Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 3/4] Makefile: really use and document
 sha1collisiondetection by default
References: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
        <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com>
        <patch-v2-3.4-78ef8636c57-20221019T010222Z-avarab@gmail.com>
        <CAPig+cS8jvUn9bR=1ywWgCC3gPosgycdcdbm+aASo59mXz6rfw@mail.gmail.com>
        <xmqqo7u7srp4.fsf@gitster.g>
        <221019.867d0vhbsz.gmgdl@evledraar.gmail.com>
Date:   Wed, 19 Oct 2022 12:43:23 -0700
In-Reply-To: <221019.867d0vhbsz.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 19 Oct 2022 20:54:29 +0200")
Message-ID: <xmqq1qr3r44k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4BB7C418-4FE6-11ED-909B-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> They distract us from the core changes and slows us down.  It is OK
>> to do them as totally unrelated clean-up changes long after the dust
>> settles, but not entangled with the other more important changes
>> like these patches.
>
> There's things I can eject from this series, but I don't really find it
> to be "while at it" changes, I suspect what you're thinking of is
> one/some of:
> ...
> Or maybe you're OK with topic(s) at large, i.e. "switch the default,
> update the docs, make sure noone's left behind", but would just like it
> done in more incremental steps?

I said something on this in a separate thread. Let me look it up.

 * Updating the build procedure so that sha1dc is used by default
   everywhere is a good idea, but that is less urgent and should be
   done separately, preferrably long after the dust settles from the
   above.

