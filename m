Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 892FD20288
	for <e@80x24.org>; Wed, 19 Jul 2017 21:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754480AbdGSVcr (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 17:32:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51961 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753614AbdGSVcq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 17:32:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E258F9730C;
        Wed, 19 Jul 2017 17:32:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=88Jys3alBjzAiyM38fLbyjZn8x0=; b=D0Ms50
        4DFfJCXcS38lOypRqoi3/ug/bYI4gP0W9QTH7LIGo9Q4QMe4jkIOs6pyQVgCvD2o
        LbedJGClwcLqUvR9VcKUe5RTQf3xd2mTI8ZNkWoTLT4D9CYsHYvfUPUe80cBzX4o
        26JjIifhNVLEUHlkrCuekXxpNNp9MDkie1+so=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GoMIJDWxEyGldk5O0rZ7Wy1FNNL/FQOl
        QHrH2j4SqIAEb6wDhv5Sa0ZbBP8zFmVxXgESabvpbhTP8yIrR+1059nDlmJaDA1F
        hIq4GV0hCsdhe0/FzfRqiNQTYObjUUrvQwmNGeZT9EWOEC2nGn7YmbWUpQiz+ZFz
        lfniMDVhHtA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D92989730B;
        Wed, 19 Jul 2017 17:32:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 392CF9730A;
        Wed, 19 Jul 2017 17:32:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
        <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
        <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com>
        <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
        <xmqq60epfy27.fsf@gitster.mtv.corp.google.com>
        <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
        <alpine.DEB.2.21.1.1707191456010.4193@virtualbox>
Date:   Wed, 19 Jul 2017 14:32:37 -0700
In-Reply-To: <alpine.DEB.2.21.1.1707191456010.4193@virtualbox> (Johannes
        Schindelin's message of "Wed, 19 Jul 2017 15:25:09 +0200 (CEST)")
Message-ID: <xmqqd18wm7t6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C97930D6-6CC9-11E7-B875-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Gettext handles macros such as PRIuMAX in commit 8b45c5df1 ("Add
>> support for ISO C 99 <inttypes.h> format string directive macros.",
>> 2002-07-23 12:33:13 +0000).
>
> Wow. This is ugly.
>
> If I understand correctly, then this will not even work correctly for
> PRIuMAX on Windows: ...

I think it is the other way around.  Without such a special-casing,
and producing message identifier that has "%<PRIuMAX>" in it, they
cannot get a .po source that is usable across platforms.

Imagine a hypothetical xgettext that does not have the special case,
but just does what CPP does.  Running it on a platform where
uintmax_t is "unsigned long" would have "%lu" in resulting .po for a
message that uses "%" + PRIuMAX.  But the same source compiled on a
platform where uintmax_t is larger would pass "%llu" in calls to
_(...) it makes; such a string will not be found at runtime in the
corresponding .mo file, because you started with "%lu" in the .po
file.  By leaving a special marker %<PRIuMAX> in the .po file by
special casing, the toolchain can make sure that the actual
parameter given to a _(...) can be found at runtime in .mo file that
was produced by compiling the .po file for the target platform.

So our own PRItime was a good idea for maintainability's point of
view of _our_ code, but it was not very friendly to i18n.

I can see two possibly usable approaches to make it i18n-friendly
while retaining our ability to later change the underlying type of
timestamp_t.  But neither is very pretty.

 - One is what was in Jiang's earlier proposal.

 - Another is to replace PRItime with PRIuMAX _but_ leave a comment
   to tell us that it wanted to be PRItime, so that we can later
   "git grep" for such a comment if/when we want to update the type
   of timestamp_t.

