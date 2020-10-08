Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A042CC433DF
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 19:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A93F22202
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 19:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hcFRUmCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgJHTti (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 15:49:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50477 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbgJHTth (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 15:49:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9FF67FCE4;
        Thu,  8 Oct 2020 15:49:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F/Y8SC+ESExfnoNcD+aidqdNIlw=; b=hcFRUm
        CjLhDLnGOenNcTsWhX7QefcGqzc695njcc2hkWPD2dFuPr3VwTZ7J/c1+jV34oYi
        UFrFxpugvyXNAdQLwY1lleZSz4xYp+ej7mNxtCjVpcKoKlRJNDk4ysE87ik+gIxy
        ycB5mkpXMFUgSk4Fx7d29WoNKBYQhC178MgU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vahPgULNrw3toY+KshV50oA6wrwyeJou
        W6OgvOb8w/DszZtAdNliIzfP4mAm8Ffyw/jSyqYJ2xQ+yb6eTMcJXNneIF9jh98Q
        jg/uWGMYnpGHD0JRzy6EL7OgX6Di5cVLz/q0fcmXC2dwY9v/t1TvUzgnm01xW8fl
        /3bHsZ1cy4M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1CC77FCE2;
        Thu,  8 Oct 2020 15:49:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 284AC7FCE1;
        Thu,  8 Oct 2020 15:49:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Shengfa Lin <shengfa@google.com>, git@vger.kernel.org,
        nathaniel@google.com, rsbecker@nexbridge.com, santiago@nyu.edu
Subject: Re: [RFC PATCH 0/1] adding user.hideTimezone for setting UTC timezone
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
        <20200930232138.3656304-1-shengfa@google.com>
        <xmqqlfgqes95.fsf@gitster.c.googlers.com>
        <xmqqtuved70y.fsf@gitster.c.googlers.com>
        <20201001034350.GB2930867@google.com>
        <xmqqh7rec5h3.fsf@gitster.c.googlers.com>
Date:   Thu, 08 Oct 2020 12:49:34 -0700
In-Reply-To: <xmqqh7rec5h3.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 01 Oct 2020 08:48:24 -0700")
Message-ID: <xmqqk0w0wl9t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6448476C-099F-11EB-9BB4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> In addition to not having to futz with TZ, I think I like the
>> semantics better.  The motivation that started this thread was not so
>> much "I want to set a custom timezone to blend in" but rather "why are
>> we recording the timezone at all here?"  In that context, it makes
>> sense to me to have a setting such as
>>
>> 	core.recordTimeZone
>>
>> that I can turn *off* to say that I don't think datestamp() callers
>> should consider the timezone to be information worth recording (and
>> instead they should write +0000).  To me that seems a little simpler
>> to understand than user.hideTimezone since this focuses on turning
>> some functionality off (recording of the time zone) instead of turning
>> on a new stealth mode.
>
> Hmph.  It is a valid way to look at the issue, I guess.
>
> Thanks for an input.

I do not have a strong opinion on recordTimeZone vs hideTimeZone any
more (the latter, as proposed by Shengfa, is shorter to type ;-),
but I think it is a good idea to keep it in user.* hierarchy.  It
sits next to user.name and user.email and controls how the user ident
is formulated.

