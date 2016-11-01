Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B663C20229
	for <e@80x24.org>; Tue,  1 Nov 2016 21:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932155AbcKAV0K (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 17:26:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63410 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752446AbcKAV0K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 17:26:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE2454B574;
        Tue,  1 Nov 2016 17:26:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2KZyssHm+eu5RQV0M7vXzxsBlEs=; b=VAC4We
        w5nOzBo7Z53AjCN+kbdEB9xNJslsHzxaZNAO0tJkDFoAvFOyPRKEIPDWG0oBsYLV
        +KpQigfLONGmpvW9n8XgZxv74Wv6hS504ej6beSAs34nzDllpEga3ECNIrKTv1qg
        dh+FAyhvXmddOJ5aFjAQ7gzW86lT9UOdCFxac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ceQFMWjYOQXiZ5Js/Cz7Lwwc26UNxa2l
        JWileFA4X8Zw2UuYQm0JJlMJ+nfh5ijPVcTRli+zY5AyPHYmd8SKvsVMvBL3NWHV
        Mx4Ga2Vk99Kdmecs9mEA7n1QmK7b/sgc3HDpigR+glQHML4i9IrJIcqEzVWzKBuh
        n/1FHedPlEk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A56CC4B573;
        Tue,  1 Nov 2016 17:26:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1EBE04B572;
        Tue,  1 Nov 2016 17:26:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH v2 1/5] trailer: be stricter in parsing separators
References: <cover.1478028700.git.jonathantanmy@google.com>
        <cover.1477698917.git.jonathantanmy@google.com>
        <cover.1478028700.git.jonathantanmy@google.com>
        <c7db0aafb543845382e1835e3704273d3596e6bb.1478028700.git.jonathantanmy@google.com>
        <xmqqvaw7ndow.fsf@gitster.mtv.corp.google.com>
        <xmqqr36vndgn.fsf@gitster.mtv.corp.google.com>
        <0b3e70fe-5e1f-7aaa-4c3d-88f30cb15008@google.com>
Date:   Tue, 01 Nov 2016 14:26:06 -0700
In-Reply-To: <0b3e70fe-5e1f-7aaa-4c3d-88f30cb15008@google.com> (Jonathan Tan's
        message of "Tue, 1 Nov 2016 13:53:47 -0700")
Message-ID: <xmqq4m3qopsh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD8D3982-A079-11E6-BD18-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>>> Hmph.  The optional whitespace is to allow for what kind of line?
>>>
>>> It is not for "Signed off by:" that is a misspelt "Signed-off-by:";
>>> it may not hurt but I do not think of a case that would be useful
>>> offhand.
>
> This is to allow trailers of the form "Fix #42" (mentioned in the
> git-interpret-trailers documentation and also in the test).

That piece of information belongs to the in-code comment for the
function, I would think.  The comment that describes what it does
(i.e. "token with optional spaces and separator") can be read from
the code easily, but the reason why the code implements that
behaviour cannot.

Thanks.
