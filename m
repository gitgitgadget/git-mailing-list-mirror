Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 761B920986
	for <e@80x24.org>; Tue,  4 Oct 2016 18:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754084AbcJDS2S (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 14:28:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53196 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752596AbcJDS2R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 14:28:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77853416B9;
        Tue,  4 Oct 2016 14:28:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PovASOG3EReUghKcdmQJtWclpK0=; b=cbjLpP
        vXpTfw6gyh9X1bTl9Vmm/poOXYLN9iMHWieU8jofqipzLCW0ybnPCwExVk66bGP0
        /pjuUCgLR4+sKaa+uLtD+NFHa3IcQ6xnO5WyAU380kwxo0ycM1tsIqQDWtIXcJ82
        pJrYlvfwAVldOQVolC8z9azi97vp2nFdiBygg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lqcSXjSWb/2dls5CpOuqhFLtGMongNtl
        urJFyM6f0Ukzv87AzizWF84u9Fo0bmYB9YQ15ck7bOkaLXaR+UT7Kb7Wr/ABOB2j
        marYhX7BpIeDAsrRf43Y1zog4196w/PTSKFsb51qIKSpA4tof7K/WoQgZ3W8nxsu
        AonWh6A79Oo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E514416B8;
        Tue,  4 Oct 2016 14:28:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E69CC416B7;
        Tue,  4 Oct 2016 14:28:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 0/2] place cherry pick line below commit title
References: <cover.1475176070.git.jonathantanmy@google.com>
        <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
        <11e41a94-df8c-494a-584b-e2bc8da2de3a@google.com>
        <xmqq8tu99o75.fsf@gitster.mtv.corp.google.com>
        <xmqqtwcx8669.fsf@gitster.mtv.corp.google.com>
        <e03fdabd-6690-5244-5f79-1715b0364845@google.com>
        <xmqqbmz16y42.fsf@gitster.mtv.corp.google.com>
        <d3df0636-1975-1d08-2f34-384984c72e5d@google.com>
        <xmqq8tu55bel.fsf@gitster.mtv.corp.google.com>
        <84f28caa-2e4b-1231-1a76-3b7e765c0b61@google.com>
        <xmqqwphouivf.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 04 Oct 2016 11:28:13 -0700
In-Reply-To: <xmqqwphouivf.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 04 Oct 2016 10:25:08 -0700")
Message-ID: <xmqq37kcufya.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50DD9604-8A60-11E6-A590-9DAC7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> A block of lines that appear as the last paragraph in a commit
> message is a trailer block if and only if certain number or
> percentage of lines are non-garbage lines according to the above
> definition.
> ...
> I wonder if we can share a new helper function to do the detection
> (and classification) of a trailer block and parsing the logical
> lines out of a commit log message.  The function signature could be
> as simple as taking a single <const char *> (or a strbuf) that holds
> a commit log message, and splitting it out into something like:
>
>     struct {
> 	const char *whole;
> 	const char *end_of_message_proper;
> 	struct {
> 		const char *token;
> 		const char *contents;
> 	} *trailer;
> 	int alloc_trailers, nr_trailers;
>     };
>
> where 
> ...

An addendum.  We may also want to be prepared to accept an input
that has some garbage lines _after_ the trailer block, if we can
clearly identify them as such.  For example, we could change the
definition of "the last paragraph" as "the block of lines that
do not have any empty (or blank) line, that appear either at the end
of the input, or immediately before three-dash lines", to allow

    commit title
    
    explanation of the change

    Signed-off-by: Some Body <some@body.xz>
    [some other things]
    Acked-by: Some Other Person <some@other.xz>

    ---
     additional comment

which (unfortunately) is a rather common pattern for people who plan
to send the commit over e-mail.

If we add a new field "const char *beginning_of_tail_garbage" next
to "end_of_message_proper" that points at the blank line before the
three-dash line in the above example, the parser should be able to
break such an input into a parsed form, allow the trailer[] array to
be manipulated and reproduce a commit log message.

