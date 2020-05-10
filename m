Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5A9C38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 18:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 083BE208DB
	for <git@archiver.kernel.org>; Sun, 10 May 2020 18:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qtcxOfzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgEJSMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 14:12:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59406 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgEJSMV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 14:12:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B7A32CA3B7;
        Sun, 10 May 2020 14:12:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0l762hVVdiRyhAR8IULz2G4d0wI=; b=qtcxOf
        zug3BjrG3uVq5XjYlbkJNs9fGFrPccGIg+EatGZBHpeeNRwrSJ2ukFmZvBfIiOUa
        FX9C7buIivoJq9BSSd0tn4a39k9AVAGrLuKv0fVjUeHXvDDOZb5ukumr9f5cPh+K
        2DHTgdS73o8Gqoj2wmDR31ngVBGjkpjMZc38I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=flPkbD6c1k4T/oBnXbaawSksnPedaW5E
        8ipRiFdGGTozWa/p0ixHi5mK9fPMzA0igN7FeI3V2hN4tMsGs/JAr/pmSuvb2irx
        1bFR2e87s5LDmLVPqMJ5nKb37DjhGCqeT1FKpOVI2Y2pNpB+OUIV3UBbnJVhjicW
        SZg7xC36aDA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C950CA3B5;
        Sun, 10 May 2020 14:12:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E4888CA3B4;
        Sun, 10 May 2020 14:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     George Brown <321.george@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
References: <CAFKec1W0-OOQYypP-3VC=dJnuNDrykdQ2xibc=u4D=Zo6if-+Q@mail.gmail.com>
        <xmqqd07cvl9b.fsf@gitster.c.googlers.com>
        <CAFKec1Wj_uK-moVfin3XrTEmmBaAzaJKsh1f8q-3+RBs2-3Jdg@mail.gmail.com>
        <xmqq8si0vfp3.fsf@gitster.c.googlers.com>
        <CAFKec1UGKbaV7wC78i8+uSEizjGkj2bDSfOeucvJORhORvc5KA@mail.gmail.com>
        <xmqqwo5ju47t.fsf@gitster.c.googlers.com>
        <CAFKec1Wy1iT8Z=gNDBn++XLxzGWr0UUiu3AKMU-qaR+jj2yoKQ@mail.gmail.com>
Date:   Sun, 10 May 2020 11:12:15 -0700
In-Reply-To: <CAFKec1Wy1iT8Z=gNDBn++XLxzGWr0UUiu3AKMU-qaR+jj2yoKQ@mail.gmail.com>
        (George Brown's message of "Sun, 10 May 2020 18:33:12 +0100")
Message-ID: <xmqqo8qvu0ao.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C80CAE5A-92E9-11EA-9761-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

George Brown <321.george@gmail.com> writes:

>> As long as such a regression for existing users use is impossible, I
>> think the patch is probably OK, but doing a hardcoded "cat" smells
>> like a very bad hack, compared to a solution on the program's side
>> that *wants* to read the prepared file to arrange that to happen
>> (e.g. via setting the GIT_EDITOR environment to "cat" within that
>> program).
>
> I think this change only enhances "git jump".
>
>> In any case, I am not a "git jump" user, so...
>
> I looked into this as other Vim users were talking about it and wanted
> this behavior.

That's already irrelevant in the course of this discussion, no?

We have already established that you wrote in good faith to improve
the use experience by vim users, and nobody in this exchange doubts
that this change would help vim users.  

I am worried about the change hurting non-vim users, but no amount
of "me too" from vim users who care only about their vim experience
would allay that.
