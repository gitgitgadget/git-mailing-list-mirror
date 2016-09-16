Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 160A2207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 22:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753932AbcIPWzz (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 18:55:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53423 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752835AbcIPWzz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 18:55:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DDBDD3F470;
        Fri, 16 Sep 2016 18:55:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BJYj079hV5EQgCvbUeerPEHcNrE=; b=kzFrPo
        giZC0fP3XXerOrFsM+oa3vybHD6hkdXqr1zVSQiNmKMwwEHoQiKHgWo9UvqcI5Mt
        7NqSNb8/dO7HlFz3+fyudDf9ZSjththd7qG8E9W+XWeC1SL3VD4ABYS/iJ5xduBr
        aguaXyDCvDrjszS5xfU70MgxnXydtx7dd5+q4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hITNXamHInw76hgbtsHlFnhtOooCcRZ7
        a1eIWKItwE2WB80nelVpqv0+11sBm4gWH9NKPdHXNL+cA2bOB+9LMuxu61z5T22/
        JTAY0Q64nY/U8N1MuQvnc15LSLEmTMdfCMfhwXvKmg9e9v1SHH7atVLMz+7WQrUO
        v7Ku21ucmz4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D60963F46E;
        Fri, 16 Sep 2016 18:55:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 588A13F46D;
        Fri, 16 Sep 2016 18:55:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC/PATCH 2/3] mailinfo: correct malformed test example
References: <cover.1474047135.git.jonathantanmy@google.com>
        <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net>
        <cover.1474047135.git.jonathantanmy@google.com>
        <5dbb0b0f64906fd18c217908cd2c04e74d80fa68.1474047135.git.jonathantanmy@google.com>
        <xmqqk2ebk5zh.fsf@gitster.mtv.corp.google.com>
        <2bfc2fc7-f16b-6d51-7353-54d38353464a@google.com>
Date:   Fri, 16 Sep 2016 15:55:51 -0700
In-Reply-To: <2bfc2fc7-f16b-6d51-7353-54d38353464a@google.com> (Jonathan Tan's
        message of "Fri, 16 Sep 2016 15:42:48 -0700")
Message-ID: <xmqqbmznihe0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B865FB44-7C60-11E6-BC49-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On 09/16/2016 12:19 PM, Junio C Hamano wrote:
>> Jonathan Tan <jonathantanmy@google.com> writes:
>>
>>> An existing sample message (0015) in the tests for mailinfo contains an
>>> indented line immediately after an in-body header (without any
>>> intervening blank line).
>>
>> This comes from d25e5159 ("git am/mailinfo: Don't look at in-body
>> headers when rebasing", 2009-11-20), where we want to make sure that
>> a "From: bogosity" that isn't meant to be an in-body header is not
>> identified as such, even when it is immediately followed by a
>> non-blank line.  "From: bogosity" is for msg0015 but the same
>> applies to the header-looking block for msg0008.
>>
>> Adding a blank line there will defeat the whole point of the test,
>> which is to make sure we don't do anything funky when --no-inbody-headers
>> is asked for, no?
>
> Before I revise the patch set...I think that the point of 0015 would
> be handled by 0008 (after this patch is applied), but if you prefer
> that 0015 retain its purpose, I can unindent the bullet list in 0015
> instead of adding the extra line (and then dropping all 0008
> changes). Would that be better? (0015 needs to be changed somehow,
> because its indented line would be interpreted as a continuation line
> after RFC/PATCH 3/3 is applied.)

Hmph, these:

 t/t5100/info0008--no-inbody-headers  | 5 +++++
 t/t5100/msg0008--no-inbody-headers   | 6 ++++++
 t/t5100/msg0015--no-inbody-headers   | 1 +

have --no-inbody-headers in their names; wouldn't that an indication
that they are expected output when mailinfo is run while in-body
header feature disabled?

I would have expected that it would make more sense to make no
change to sample.mbox and have updated expectation to outputs in the
case where in-body header feature is enabled.

To make sure this new feature will not break in the future, we would
want a brand new message with a folded in-body header added to the
sample.mbox, and see how it is parsed by mailinfo with in-body
header feature enabled (and disabled).

