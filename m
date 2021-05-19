Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3259C433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 00:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C247F61209
	for <git@archiver.kernel.org>; Wed, 19 May 2021 00:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbhESA1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 20:27:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60117 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhESA1T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 20:27:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E9BC13DB5B;
        Tue, 18 May 2021 20:26:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Pog1jRgTgdBu
        asrUax6YnNnH69xUeSXTx2k10fzeW48=; b=iP2z3hFyIByKXbDckn2ucLXcKuQ4
        RufXmMoDJf26P63BjyZuSEubMXGmOXGnMniTU1B2W+znu+Drc8bI9iP1Kww46+mz
        8ukHFTaJ2W3rsfZ2nquNZma4i8X23YtkQwORFhWKdCMemEMvRj6+rQhLc/8bZr3b
        OtqOU6ULPdxQU4U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 76FDD13DB5A;
        Tue, 18 May 2021 20:26:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BD4B113DB59;
        Tue, 18 May 2021 20:25:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        karthik nayak <karthik.188@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Options like hash-object --literally and cat-file
 --allow-unknown-type
References: <87r1i4qf4h.fsf@evledraar.gmail.com> <xmqqtun0139q.fsf@gitster.g>
        <87o8d7rhwi.fsf@evledraar.gmail.com>
Date:   Wed, 19 May 2021 09:25:55 +0900
In-Reply-To: <87o8d7rhwi.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 18 May 2021 20:42:26 +0200")
Message-ID: <xmqqpmxn1sdo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C7FD719A-B838-11EB-BB7E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> But I am not sure if that warrants switching of the default.
>
> Hopefully either this thread or a re-roll of that series will convince
> you, is this something you'd like to see on list in the next few days o=
r
> is it better to hold off until after the RC period?

You sent me a message, said that you wanted to change "cat-file" and
that you wanted my opinion on it, I gave a response, and in response
to that, you just repeated that you still want to change it, and I
did not see any new justification with it in the message I am
responding to, so sorry, but I fail to see where that "hopefully"
comes from.

The way I see it, if there is no practical difference, leaving the
existing behaviour of "cat-file" the same would be the most prudent
thing to do, especially when the primary goal of the topic is not
about improving "cat-file".  This is merely a fallout from the work
to improve lower layers so that "fsck" can work better with objects
with unexpected types, no?

I suspect that this is one of the reasons your topics take way too
more time than they should to mature: biting too much at one time.

Surely it will be about the same effort for you to change the
default, while updating the lower layer that results in making it
easier to have either default.  However, having to argue for and
justify the change of default of a command unrelated to the main
focus of the topic would make your series longer, and adds one more
thing on the plate of reviewers and future readers of the series
that they have to reason about.  If you keep the topic more focused
to "fsck" and the improvement of the lower layer to support it, you
may still need to update the callers that share the same lower layer
("cat-file" in this case) but you would reduce the burden of
reviewers if you can label the change as "this adjust another caller
to the updated lower layer, but no end-user visible change in its
behaviour", as there is one fewer thing for them to have to think.

> I think it's a much better approach to just implicitly supply a
> OBJECT_INFO_ALLOW_UNKNOWN_TYPE at a high level (you just want the total
> disk use, who cares if there's one bad object there), as opposed to
> teaching rev-list and others about --allow-unknown-type.

I actually was hoping that the update to the lower layer functions
would be to stop dying when they see an unknown type (instead they
can leave a bit of information in object_info to signal that the
object is bogus---perhaps the *typep having a value outside the four
real types may be a good enough implementation for that signal) and
leave the policy decision to the callers.  That is, there is no
option bit OBJECT_INFO_ALLOW_UNKNOWN_TYPE that is passed from the
caller to the lower layer; the caller can decide what to do with a
bogus object themselves, "cat-file" retains the current "we'd die
unless allow-unknown is passed" default to reduce the impact from
the entire series to reduce cognitive load from reviewers to make it
easier to review the series, and if you really feel like doing the
"while at it, cat-file requiring --allow does not make sense; if the
user wants the raw inflated content, just let them have it", do so
outside the series after the dust settles.

I dunno.  I may be agreeing with your "it's a much better approach
to just implicitly supply allow-unknown-type at a higher level".

