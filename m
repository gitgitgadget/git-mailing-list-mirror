Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0926CC433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07452082F
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RMI3iOx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404796AbgFXQZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:25:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55147 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404468AbgFXQZY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 12:25:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 04695C97BE;
        Wed, 24 Jun 2020 12:25:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F0Z/HsTgJGhLj6OVaXL+sLhorKc=; b=RMI3iO
        x4izhbObE3bJFHNoyIueOIi7YMo3PpspNoY5jf9/zkBJwwZSf1Xfvg2pwFx8hSV7
        uo6N31JAEkaGWamI6sF2e7GzdgGQ3B83yuif2/uCpI6SIhvvKMhgVa9UoLlgkVuv
        E2K1sx3hVXF+oTcCGQRRB9JLdxKVK6+w2gDfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t2tYbDAMp8yzlPAPjAYXLPlmDQpC3U2b
        xeo6X+pZWUuOLrl+mb7kMSxGaRgD+GbKPSzt+p+DlXbn+kzEgscPU2F3i6ezsUTg
        pW3rIKyu5f97kXETiu9xBsdwemxJ85L7m+bmeNf+bQbMevvVvzYWKpbLVJ2NwKP7
        PaIuuL/qa+E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EFCE5C97BD;
        Wed, 24 Jun 2020 12:25:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2CB37C97BC;
        Wed, 24 Jun 2020 12:25:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 5/8] init: allow setting the default for the initial branch name via the config
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <a500e0f214a0ea4bf5cf4e26f688ae68a0b84bcd.1592951611.git.gitgitgadget@gmail.com>
        <xmqqftal9su2.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006241455210.54@tvgsbejvaqbjf.bet>
Date:   Wed, 24 Jun 2020 09:25:18 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2006241455210.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 24 Jun 2020 14:56:46 +0200 (CEST)")
Message-ID: <xmqqo8p877o1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BF537BC-B637-11EA-849D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> 	reinit = create_default_files(...
>> 			initial_branch ? initial_branch : "master",
>> 			...);
>> 	if (reinit || initial_branch)
>> 		warning(_(...));
>>
>> in the previous step and then we can teach the caller to use the
>> configured value instead of the hardcoded "master".
>
> While that is really tempting, there is another called of `init_db()`
> (which calls `create_default_files()`): `builtin/clone.c`. And I do not
> wish to duplicate the logic there.
>
> So I left this as-is.

I am still on the fence after seeing v4, but let's leave it as is.
The reason why I wanted to leave the "default to" logic out of the
helper was to make sure it implements little or no policy, which
would leave the door open to let other callers of the helper to use
their own and different default, but we can revisit when we acquire
the third caller.  I do not see an immediate need to make the
clone's fallback default configurable separately from what init uses
for the default initial branch name, and with modern servers it is
doubtful that the fallback default by clone is ever used anyway.

Thanks.

